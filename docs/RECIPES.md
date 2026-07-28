# Stripe Sigma query recipes

Working patterns for the questions people actually ask. Trino v414 dialect.

Recipes marked **[Stripe]** are adapted from Stripe's official documentation and
use only `documented` columns. Others use `community` columns — verify those
column names against your account before relying on the numbers.

Amounts are in minor currency units unless noted. `itemized_fees` is the exception.

---

## Accounting

### Net revenue by month **[Stripe]**

`balance_transactions` is the only table that nets fees consistently across
charges, refunds, disputes and payouts. Start here, not from `charges`.

```sql
select
  date_trunc('month', created) as month,
  currency,
  reporting_category,
  sum(amount) as gross,
  sum(fee)    as fees,
  sum(net)    as net
from balance_transactions
where created >= data_load_time - interval '12' month
  and created <  data_load_time
group by 1, 2, 3
order by 1 desc, 2, 3
```

`summarized_balance_transactions` is pre-aggregated and much cheaper if you only
need this rollup.

### What made up a payout **[Stripe]**

Only automatic payouts can be reconciled; manual payout amounts are arbitrary.

```sql
select
  t.id as payout_id,
  date_trunc('day', t.date) as arrival_date,
  bt.type,
  count(*) as items,
  sum(bt.net) as net
from transfers t
join balance_transactions bt on bt.automatic_transfer_id = t.id
where t.date >= current_date - interval '30' day
group by 1, 2, 3
order by 2 desc, 3
```

### Fee breakdown for a period **[Stripe]**

```sql
select
  date_trunc('month', incurred_at) as month,
  product_feature_description,
  currency,
  sum(amount) as fees,   -- MAJOR units on this table. Do not divide by 100.
  sum(tax)    as fee_tax
from itemized_fees
where incurred_at >= current_date - interval '6' month
group by 1, 2, 3
order by 1 desc, 4 desc
```

---

## Subscriptions and revenue

### Monthly MRR movement **[Stripe]**

Do not derive MRR from subscription status transitions. Use the pre-computed
change events and cumulatively sum them.

```sql
with movements as (
  select
    date_trunc('month', local_event_timestamp) as month,
    currency,
    sum(mrr_change) as mrr_change,
    sum(case when mrr_change > 0 then mrr_change else 0 end) as expansion,
    sum(case when mrr_change < 0 then mrr_change else 0 end) as contraction
  from subscription_item_change_events
  group by 1, 2
)
select
  month,
  currency,
  mrr_change,
  expansion,
  contraction,
  sum(mrr_change) over (partition by currency order by month) as ending_mrr
from movements
order by month desc, currency
```

Stripe publishes a fuller version — new vs. reactivation vs. churn, with FX
conversion — at <https://docs.stripe.com/data/query-billing-data>.

### Active subscriptions with product names **[Stripe]**

`subscription_items.price_product_id` is denormalized, so you can skip `prices`.

```sql
select
  s.id as subscription_id,
  s.customer_id,
  p.name as product_name,
  si.quantity
from subscriptions s
join subscription_items si on si.subscription_id = s.id
join products p on p.id = si.price_product_id
where s.status = 'active'
order by 1, 2
```

### Discounts on a subscription **[Stripe]**

`subscriptions.discounts` is a comma-separated string, not an array.

```sql
select
  s.id as subscription_id,
  c.id as coupon_id,
  c.percent_off,
  c.amount_off
from subscriptions s
cross join unnest(split(s.discounts, ',')) as t(discount_id)
join discounts d on d.id = t.discount_id
join coupons c on c.id = d.coupon_id
```

---

## Payments and fraud

### Decline reasons

```sql
select
  date_trunc('week', created) as week,
  failure_code,
  count(*) as declines
from charges
where status = 'failed'
  and created >= current_date - interval '90' day
group by 1, 2
order by 1 desc, 3 desc
```

### Dispute rate, measured the way card networks measure it **[Stripe]**

Exclude `prevented` disputes (stopped by Rapid Dispute Resolution) and remember
that recent months undercount — disputes arrive weeks late.

```sql
with monthly as (
  select
    date_trunc('month', c.created) as month,
    count(*) as charges,
    count(distinct case when d.status != 'prevented' then d.id end) as disputes
  from charges c
  left join disputes d on d.charge_id = c.id
  where c.status = 'succeeded'
    and c.created >= current_date - interval '12' month
  group by 1
)
select
  month,
  charges,
  disputes,
  disputes * 100.0 / greatest(1, charges) as dispute_rate_pct
from monthly
order by 1 desc
```

### True refund rate **[Stripe]**

`partial_capture` refunds are auth-and-capture artifacts, not customer refunds.

```sql
select
  date_trunc('month', r.created) as month,
  count(*) as refunds,
  sum(r.amount) as refunded
from refunds r
where r.reason != 'partial_capture'
  and r.created >= current_date - interval '12' month
group by 1
order by 1 desc
```

### 3D Secure outcomes by Radar rule **[Stripe]**

`rule_decisions` covers 3DS rules on PaymentIntents and SetupIntents, which
`charges.outcome_rule_id` misses.

```sql
select
  rd.rule_id,
  count(distinct rd.id) as times_triggered,
  count_if(at.threeds_outcome_result = 'authenticated') * 1.0
    / greatest(1, count(distinct rd.id)) * 100.0 as pct_authenticated
from rule_decisions rd
left join authentication_report_attempts at on at.intent_id = rd.payment_intent_id
where rd.action = 'request_credentials'
  and rd.created >= current_date - interval '30' day
group by 1
order by 2 desc
```

---

## Tax

### Tax liability by month and currency **[Stripe]**

Line items and shipping costs both contribute; union them. Never sum across
currencies without converting.

```sql
with tax_amounts as (
  select tax_transaction_id, amount, amount_tax, tax_behavior, currency
  from tax_transaction_line_items
  union all
  select tax_transaction_id, amount, amount_tax, tax_behavior, currency
  from tax_transaction_shipping_costs
)
select
  date_trunc('month', t.posted_at) as month,
  ta.currency,
  sum(case when ta.tax_behavior = 'inclusive'
           then ta.amount - ta.amount_tax
           else ta.amount end) as sales_excluding_tax,
  sum(ta.amount_tax) as tax
from tax_amounts ta
join tax_transactions t on t.id = ta.tax_transaction_id
group by 1, 2
order by 1 desc, 2
```

Only `amount_tax` sums correctly across jurisdictions in
`tax_transaction_jurisdiction_details`. `amount_taxable` and `amount_non_taxable`
overlap between jurisdiction levels and will overcount if summed.

---

## Techniques

### Read a metadata key as a column **[Stripe]**

```sql
with md as (
  select charge_id, map_agg(key, value) as metadata
  from charges_metadata
  group by 1
)
select
  c.id,
  c.amount,
  md.metadata['order_id'] as order_id
from charges c
left join md on md.charge_id = c.id
where element_at(md.metadata, 'order_id') is not null
```

### Convert multiple currencies into one **[Stripe]**

`buy_currency_exchange_rates` is a JSON string, not a map.

```sql
with rates as (
  select date, currency, rate
  from exchange_rates_from_usd
  cross join unnest(
    cast(json_parse(buy_currency_exchange_rates) as map(varchar, double))
  ) as t(currency, rate)
  where date = (select max(date) from exchange_rates_from_usd)
)
select
  date_trunc('month', c.created) as month,
  sum(c.amount / r.rate / 100.0) as volume_usd
from charges c
join rates r on r.currency = c.currency
where c.status = 'succeeded'
group by 1
order by 1 desc
```

### Deterministic top-N **[Stripe]**

Ties make `limit` and `row_number()` non-deterministic. Always add a unique id
to the sort.

```sql
select * from charges order by created desc, id limit 10
```

### Make a scheduled query reproducible **[Stripe]**

`data_load_time` is a query-scoped constant marking how far your data is complete.
Use it instead of `current_date` so a rerun returns the same window.

```sql
select id, amount, fee, currency
from balance_transactions
where created >= data_load_time - interval '1' month
  and created <  data_load_time
order by created desc
```

### Quote reserved words

`end`, `interval`, `type`, `value`, `key`, `date`, `start`, `period` are reserved
or ambiguous in Trino.

```sql
select d.id, d."end" as discount_end
from discounts d
```
