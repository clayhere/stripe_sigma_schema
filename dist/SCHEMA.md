# Stripe Sigma schema reference

`164` tables, `945` documented columns.

> **Read this first.** Column lists are complete only where noted. Stripe publishes
> the authoritative column list solely inside the Dashboard schema browser, so this
> file combines what Stripe documents publicly with curated detail. Each column
> carries a confidence level:

| Confidence | Meaning |
| --- | --- |
| `documented` | Appears in an official Stripe SQL example or published column table. |
| `conventional` | Synthesized from a structural rule Stripe documents (metadata tables, Connect mirrors). |
| `community` | Curated from experience. Plausible, but not proven against a live account. |
| `verified` | Confirmed to exist by querying a real Sigma account. |

---

## analytics

### `aggregate_optimization_details`

Aggregated view of Stripe's payment optimizations (such as Adaptive Acceptance) and their measured impact.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per aggregation window and optimization type.

### `analytics_acceptance_itemized`

Itemized acceptance analytics used by Stripe's authorization rate reporting.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per acceptance analytics record.

### `authentication_report_attempts`

Individual 3D Secure authentication attempts, including the resulting charge outcome.

**Freshness:** 100h  
**Source:** derived  
**Grain:** One row per authentication attempt. An intent can have several.

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `charge_outcome` | varchar |  | documented | What happened to the charge afterwards, e.g. authorized. |
| `created` | timestamp |  | community | When the attempt occurred (UTC). |
| `intent_id` | varchar | foreign | documented | PaymentIntent or SetupIntent the attempt belongs to. |
| `is_final_attempt` | boolean |  | documented | Whether this was the last attempt for the intent. Filter on this to avoid double counting. |
| `threeds_outcome_result` | varchar |  | documented | Result of the 3DS challenge, e.g. authenticated. |

</details>

**Joins**

- `authentication_report_attempts.intent_id` → `payment_intents.id`

### `charge_optimization_details`

Per-charge record of which Stripe payment optimizations were applied and what they recovered.

**Freshness:** 72h  
**Source:** derived  
**Grain:** One row per charge that had an optimization applied.

<details><summary>Columns (1, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `charge_id` | varchar | foreign | community | Charge the optimization applied to. |

</details>

**Joins**

- `charge_optimization_details.charge_id` → `charges.id`

## billing

### `billing_meter_event_summaries` _(not in Stripe's published table list)_

Aggregated meter usage per customer over a time window.

**Freshness:** unpublished  
**Source:** derived  
**Grain:** One row per (meter, customer, window).

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `aggregated_value` | double |  | documented | Aggregated usage value for the window. |
| `customer_id` | varchar | foreign | documented | Customer the usage belongs to. |
| `end_time` | timestamp |  | documented | Exclusive end of the summary window. |
| `meter_id` | varchar | foreign | documented | Meter being summarized. |
| `start_time` | timestamp |  | documented | Inclusive start of the summary window. |
| `value_grouping_window` | varchar |  | documented | Granularity of the window, e.g. 'hourly' or 'daily'. |

</details>

**Joins**

- `billing_meter_event_summaries.meter_id` → `billing_meters.id`
- `billing_meter_event_summaries.customer_id` → `customers.id`

> Always filter on value_grouping_window or you will double count across granularities.

### `billing_meter_invalid_events` _(not in Stripe's published table list)_

Meter events that failed validation and were not counted toward usage.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per invalid event.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier for the invalid event. |
| `created` | timestamp |  | community | When the invalid event was received (UTC). |
| `error_code` | varchar |  | documented | Machine-readable validation error code. |
| `error_message` | varchar |  | documented | Human-readable validation error. |

</details>

> The original event payload is in billing_meter_invalid_events_payload, joined on event_id.

### `billing_meter_invalid_events_payload` _(not in Stripe's published table list)_

Key/value payload of each invalid meter event.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per (invalid event, payload key).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `event_id` | varchar | foreign | documented | The invalid event this payload entry belongs to. |
| `key` | varchar |  | documented | Payload key, e.g. stripe_customer_id. |
| `value` | varchar |  | documented | Payload value for that key. |

</details>

**Joins**

- `billing_meter_invalid_events_payload.event_id` → `billing_meter_invalid_events.id`

### `billing_meters` _(not in Stripe's published table list)_

Usage-based billing meters that aggregate metered events.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per meter.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed mtr_. |
| `default_aggregation_formula` | varchar |  | documented | How events are aggregated, e.g. sum or count. |
| `display_name` | varchar |  | documented | Human-readable meter name. |
| `event_name` | varchar |  | community | Name of the event this meter listens for. |
| `livemode` | boolean |  | documented | False for sandbox/test data. |
| `status` | varchar |  | documented | Meter status. Note the documented example filters on the uppercase value 'ACTIVE'. Values: `ACTIVE`, `INACTIVE`. |

</details>

> status is uppercase in this table ('ACTIVE'), unlike most Sigma enum columns which are lowercase.

### `coupons`

Discount definitions that can be applied to customers, subscriptions or invoices.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per coupon.  
**Primary key:** `id`

<details><summary>Columns (11, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Coupon identifier — often a human-chosen string rather than a generated id. |
| `amount_off` | bigint |  | documented | Fixed discount in minor currency units. Mutually exclusive with percent_off. |
| `created` | timestamp |  | community | When the coupon was created (UTC). |
| `currency` | varchar |  | community | Currency of amount_off. |
| `duration` | varchar |  | community | How long the discount applies. Values: `once`, `repeating`, `forever`. |
| `duration_in_months` | bigint |  | community | Number of months the discount applies when duration is repeating. |
| `max_redemptions` | bigint |  | community | Maximum number of times the coupon can be redeemed. |
| `name` | varchar |  | community | Display name of the coupon. |
| `percent_off` | double |  | documented | Percentage discount. Mutually exclusive with amount_off. |
| `times_redeemed` | bigint |  | community | Number of times the coupon has been redeemed. |
| `valid` | boolean |  | documented | Whether the coupon can still be applied. |

</details>

### `coupons_currency_options`

Per-currency overrides for multi-currency coupons.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (coupon, currency).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount_off` | bigint |  | community | Fixed discount in that currency's minor units. |
| `coupon_id` | varchar | foreign | community | Coupon being overridden. |
| `currency` | varchar |  | community | Currency this option applies to. |

</details>

**Joins**

- `coupons_currency_options.coupon_id` → `coupons.id`

### `coupons_metadata`

Metadata key/value pairs set on coupons. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `coupon_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `coupons_metadata.coupon_id` → `coupons.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select coupon_id, map_agg(key, value) as md from coupons_metadata group by 1

### `credit_note_discount_amounts`

Discount amounts applied at the credit note level.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note, discount).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Discount amount in minor currency units. |
| `credit_note_id` | varchar | foreign | community | Parent credit note. |
| `discount_id` | varchar | foreign | community | Discount applied. |

</details>

**Joins**

- `credit_note_discount_amounts.credit_note_id` → `credit_notes.id`

### `credit_note_line_item_discount_amounts`

Discount amounts applied to individual credit note line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note line item, discount).

<details><summary>Columns (2, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Discount amount in minor currency units. |
| `credit_note_line_item_id` | varchar | foreign | community | Credit note line item discounted. |

</details>

### `credit_note_line_item_tax_amounts`

Tax amounts applied to individual credit note line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note line item, tax rate).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Tax amount in minor currency units. |
| `credit_note_line_item_id` | varchar | foreign | community | Credit note line item taxed. |
| `tax_rate_id` | varchar | foreign | community | Tax rate applied. |

</details>

### `credit_note_line_items`

Line items on a credit note.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per credit note line item.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the line item. |
| `amount` | bigint |  | community | Line amount in minor currency units. |
| `credit_note_id` | varchar | foreign | community | Parent credit note. |
| `invoice_line_item_id` | varchar | foreign | community | Invoice line item being credited. |

</details>

**Joins**

- `credit_note_line_items.credit_note_id` → `credit_notes.id`

### `credit_note_tax_amounts`

Tax amounts applied at the credit note level.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note, tax rate).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Tax amount in minor currency units. |
| `credit_note_id` | varchar | foreign | community | Parent credit note. |
| `tax_rate_id` | varchar | foreign | community | Tax rate applied. |

</details>

**Joins**

- `credit_note_tax_amounts.credit_note_id` → `credit_notes.id`
- `credit_note_tax_amounts.tax_rate_id` → `tax_rates.id`

### `credit_notes`

Post-issuance adjustments to invoices — the correct way to represent refunds and write-offs against a finalized invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per credit note.  
**Primary key:** `id`

<details><summary>Columns (8, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed cn_. |
| `amount` | bigint |  | community | Credited amount in minor currency units. |
| `created` | timestamp |  | community | When the credit note was issued (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer receiving the credit. |
| `invoice_id` | varchar | foreign | community | Invoice being credited. |
| `reason` | varchar |  | community | Why the credit note was issued. Values: `duplicate`, `fraudulent`, `order_change`, `product_unsatisfactory`. |
| `status` | varchar |  | community | Credit note status. Values: `issued`, `void`. |

</details>

**Joins**

- `credit_notes.invoice_id` → `invoices.id`
- `credit_notes.customer_id` → `customers.id`

### `credit_notes_metadata`

Metadata key/value pairs set on credit_notes. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_note_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `credit_notes_metadata.credit_note_id` → `credit_notes.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select credit_note_id, map_agg(key, value) as md from credit_notes_metadata group by 1

### `discounts`

Applications of a coupon or promotion code to a customer, subscription or invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per applied discount.  
**Primary key:** `id`

<details><summary>Columns (8, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed di_. |
| `coupon_id` | varchar | foreign | documented | Coupon that was applied. |
| `customer_id` | varchar | foreign | community | Customer the discount applies to. |
| `end` | timestamp |  | community | When the discount stops applying. `end` is a reserved word in Trino — quote it as "end". |
| `invoice_id` | varchar | foreign | community | Invoice the discount applies to. |
| `promotion_code_id` | varchar | foreign | community | Promotion code used, if the discount came from one. |
| `start` | timestamp |  | community | When the discount became active. |
| `subscription_id` | varchar | foreign | community | Subscription the discount applies to. |

</details>

**Joins**

- `discounts.coupon_id` → `coupons.id`

> Reach discounts from subscriptions by unnesting the comma-separated subscriptions.discounts column.

### `invoice_custom_fields`

Custom key/value fields rendered on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice, custom field).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | foreign | community | Invoice the field appears on. |
| `name` | varchar |  | community | Field label. |
| `value` | varchar |  | community | Field value. |

</details>

**Joins**

- `invoice_custom_fields.invoice_id` → `invoices.id`

### `invoice_customer_tax_ids`

Customer tax identifiers captured on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice, tax id).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | foreign | community | Invoice the tax id appears on. |
| `type` | varchar |  | community | Tax id type, e.g. eu_vat, us_ein. |
| `value` | varchar |  | community | The tax identifier itself. |

</details>

### `invoice_items`

One-off charges or credits queued onto a customer's next invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per invoice item.  
**Primary key:** `id`

<details><summary>Columns (9, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed ii_. |
| `amount` | bigint |  | community | Amount in minor currency units. Negative for credits. |
| `created` | timestamp |  | community | When the item was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer the item will be billed to. |
| `description` | varchar |  | community | Customer-facing description. |
| `invoice_id` | varchar | foreign | community | Invoice the item landed on, once invoiced. |
| `proration` | boolean |  | community | Whether the item is a proration adjustment. |
| `subscription_id` | varchar | foreign | community | Subscription the item relates to, if any. |

</details>

**Joins**

- `invoice_items.customer_id` → `customers.id`
- `invoice_items.invoice_id` → `invoices.id`

### `invoice_items_metadata`

Metadata key/value pairs set on invoice_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_item_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `invoice_items_metadata.invoice_item_id` → `invoice_items.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select invoice_item_id, map_agg(key, value) as md from invoice_items_metadata group by 1

### `invoice_line_item_discount_amounts`

Discount amounts applied to individual invoice line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice line item, discount).

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | documented | Discount amount in minor currency units. |
| `discount_id` | varchar | foreign | community | Discount applied. |
| `invoice_id` | varchar | foreign | documented | Parent invoice. |
| `invoice_line_item_id` | varchar | foreign | community | Invoice line item discounted. |

</details>

**Joins**

- `invoice_line_item_discount_amounts.invoice_id` → `invoices.id`

> Sum amount grouped by invoice_id to get total discount per invoice.

### `invoice_line_item_tax_amounts`

Tax amounts applied to individual invoice line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice line item, tax rate).

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Tax amount in minor currency units. |
| `invoice_id` | varchar | foreign | community | Parent invoice. |
| `invoice_line_item_id` | varchar | foreign | community | Invoice line item taxed. |
| `tax_rate_id` | varchar | foreign | community | Tax rate applied. |

</details>

### `invoice_line_items`

Individual line items on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per invoice line item.  
**Primary key:** `id`

<details><summary>Columns (13, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed il_. |
| `amount` | bigint |  | community | Line amount in minor currency units. |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `description` | varchar |  | community | Customer-facing line description. |
| `invoice_id` | varchar | foreign | community | Parent invoice. |
| `period_end` | timestamp |  | community | End of the service period for this line. |
| `period_start` | timestamp |  | community | Start of the service period for this line. |
| `price_id` | varchar | foreign | community | Price applied to the line. |
| `proration` | boolean |  | community | Whether this line is a proration adjustment. |
| `quantity` | bigint |  | community | Quantity billed on this line. |
| `source_id` | varchar | foreign | documented | Polymorphic id of what generated the line: a subscription (sub_...) or an invoice item (ii_...). Use source_type to disambiguate. |
| `source_type` | varchar |  | documented | Whether the line came from a subscription or an invoice item. Values: `subscription`, `invoice_item`. |
| `subscription_id` | varchar | foreign | community | Subscription the line belongs to, if any. |

</details>

**Joins**

- `invoice_line_items.invoice_id` → `invoices.id`

> source_id is polymorphic — always filter on source_type before joining it to subscriptions or invoice_items.

### `invoice_payments`

Payment attempts against an invoice, linking invoices to the charges or payment intents that settled them.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per payment applied to an invoice.

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount_paid` | bigint |  | community | Amount applied, in minor currency units. |
| `charge_id` | varchar | foreign | community | Charge that paid it. |
| `invoice_id` | varchar | foreign | community | Invoice being paid. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent that paid it. |
| `status` | varchar |  | community | Payment status. |

</details>

**Joins**

- `invoice_payments.invoice_id` → `invoices.id`

> Use this rather than invoices.charge_id when an invoice can be settled by multiple payments.

### `invoice_shipping_cost_taxes`

Tax applied to shipping costs on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice, shipping tax rate).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Tax amount in minor currency units. |
| `invoice_id` | varchar | foreign | community | Parent invoice. |
| `tax_rate_id` | varchar | foreign | community | Tax rate applied. |

</details>

### `invoices`

One row per Invoice object. Each subscription generates invoices on a recurring basis covering the subscription amount plus any invoice items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per invoice, including drafts and voided invoices.  
**Primary key:** `id`

<details><summary>Columns (23, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed in_. |
| `amount_due` | bigint |  | documented | Amount still owed, in minor units. |
| `amount_paid` | bigint |  | community | Amount paid so far, in minor units. |
| `amount_remaining` | bigint |  | community | Amount left to pay, in minor units. |
| `attempt_count` | bigint |  | community | Number of payment attempts made. |
| `billing_reason` | varchar |  | community | Why the invoice was created. Values: `subscription_cycle`, `subscription_create`, `subscription_update`, `subscription`, `manual`, `upcoming`, `subscription_threshold`. |
| `charge_id` | varchar | foreign | documented | Charge that paid the invoice, if any. |
| `collection_method` | varchar |  | community | How payment is collected. Values: `charge_automatically`, `send_invoice`. |
| `created` | timestamp |  | community | When the invoice was created (UTC). |
| `currency` | varchar |  | documented | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer being invoiced. |
| `due_date` | timestamp |  | community | Payment due date for send_invoice collection. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `number` | varchar |  | community | Customer-facing invoice number. |
| `paid` | boolean |  | community | Whether the invoice has been paid. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent used to pay the invoice. |
| `period_end` | timestamp |  | documented | End of the billing period this invoice covers. |
| `period_start` | timestamp |  | documented | Start of the billing period this invoice covers. |
| `status` | varchar |  | community | Invoice status. Values: `draft`, `open`, `paid`, `uncollectible`, `void`. |
| `subscription_id` | varchar | foreign | documented | Subscription that generated the invoice, if any. |
| `subtotal` | bigint |  | community | Total before discounts and tax, in minor units. |
| `tax` | bigint |  | community | Tax amount in minor units. |
| `total` | bigint |  | documented | Final total after discounts and tax, in minor units. |

</details>

**Joins**

- `invoices.customer_id` → `customers.id`
- `invoices.subscription_id` → `subscriptions.id`
- `invoices.charge_id` → `charges.id`

> period_start/period_end describe the service period, which often differs from created. Use the right one for revenue reporting.

### `invoices_metadata`

Metadata key/value pairs set on invoices. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `invoices_metadata.invoice_id` → `invoices.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select invoice_id, map_agg(key, value) as md from invoices_metadata group by 1

### `plans`

Legacy recurring pricing objects, superseded by prices. Retained for older integrations.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per plan.  
**Primary key:** `id`

<details><summary>Columns (7, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed plan_. |
| `active` | boolean |  | community | Whether the plan is still usable. |
| `amount` | bigint |  | community | Amount per interval in minor currency units. |
| `created` | timestamp |  | community | When the plan was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `interval` | varchar |  | community | Billing interval. `interval` is a reserved word in Trino — quote it as "interval". Values: `day`, `week`, `month`, `year`. |
| `product_id` | varchar | foreign | community | Product the plan bills for. |

</details>

> Prefer prices for new work. `interval` must be quoted in Trino.

### `plans_metadata`

Metadata key/value pairs set on plans. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `plan_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `plans_metadata.plan_id` → `plans.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select plan_id, map_agg(key, value) as md from plans_metadata group by 1

### `price_tiers`

Tier definitions for prices using tiered billing.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per tier of a price.

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | documented | Per-unit amount for this tier, in minor currency units. |
| `flat_amount` | bigint |  | community | Flat fee charged for this tier, in minor currency units. |
| `price_id` | varchar | foreign | documented | Price these tiers belong to. |
| `upto` | bigint |  | documented | Upper bound of the tier in units. Null represents the unbounded final tier. |

</details>

**Joins**

- `price_tiers.price_id` → `prices.id`

### `prices`

How much and how often to charge for a product.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per price.  
**Primary key:** `id`

<details><summary>Columns (14, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed price_. |
| `active` | boolean |  | community | Whether the price can be used for new purchases. |
| `billing_scheme` | varchar |  | community | How the price is computed. Values: `per_unit`, `tiered`. |
| `created` | timestamp |  | community | When the price was created (UTC). |
| `currency` | varchar |  | documented | Three-letter ISO currency code, lowercase. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `nickname` | varchar |  | community | Internal label for the price. |
| `product_id` | varchar | foreign | community | Product this price belongs to. |
| `recurring_interval` | varchar |  | community | Billing frequency unit. Values: `day`, `week`, `month`, `year`. |
| `recurring_interval_count` | bigint |  | community | Number of intervals between billings. |
| `recurring_usage_type` | varchar |  | community | Whether usage is metered or a fixed quantity. Values: `licensed`, `metered`. |
| `tiers_mode` | varchar |  | community | How tiers apply when billing_scheme is tiered. Values: `graduated`, `volume`. |
| `type` | varchar |  | community | Whether the price is one-off or recurring. Values: `one_time`, `recurring`. |
| `unit_amount` | bigint |  | community | Amount charged per unit, in minor currency units. Null for tiered pricing. |

</details>

**Joins**

- `prices.product_id` → `products.id`

> When billing_scheme is 'tiered', unit_amount is null and the real pricing lives in price_tiers.

### `prices_currency_options`

Per-currency overrides for multi-currency prices.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (price, currency).

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `currency` | varchar |  | community | Currency this option applies to. |
| `price_id` | varchar | foreign | community | Price being overridden. |
| `unit_amount` | bigint |  | community | Amount in that currency's minor units. |

</details>

**Joins**

- `prices_currency_options.price_id` → `prices.id`

### `prices_metadata`

Metadata key/value pairs set on prices. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `price_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `prices_metadata.price_id` → `prices.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select price_id, map_agg(key, value) as md from prices_metadata group by 1

### `products`

Goods or services you sell.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per product.  
**Primary key:** `id`

<details><summary>Columns (8, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed prod_. |
| `active` | boolean |  | community | Whether the product is currently available. |
| `created` | timestamp |  | community | When the product was created (UTC). |
| `description` | varchar |  | community | Product description. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `name` | varchar |  | documented | Product name shown to customers. |
| `statement_descriptor` | varchar |  | documented | Text shown on the customer's card statement. |
| `unit_label` | varchar |  | community | Label for a single unit, e.g. 'seat'. |

</details>

### `products_metadata`

Metadata key/value pairs set on products. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `product_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `products_metadata.product_id` → `products.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select product_id, map_agg(key, value) as md from products_metadata group by 1

### `promotion_codes`

Customer-facing codes that map to a coupon.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per promotion code.  
**Primary key:** `id`

<details><summary>Columns (9, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed promo_. |
| `active` | boolean |  | community | Whether the code can still be redeemed. |
| `code` | varchar |  | documented | The code customers type in, e.g. SPRING25. |
| `coupon_id` | varchar | foreign | community | Coupon this code applies. |
| `created` | timestamp |  | community | When the promotion code was created (UTC). |
| `customer_id` | varchar | foreign | community | Customer the code is restricted to, if any. |
| `expires_at` | timestamp |  | community | When the code expires. |
| `max_redemptions` | bigint |  | community | Redemption limit for the code. |
| `times_redeemed` | bigint |  | documented | Number of times the code has been redeemed. |

</details>

**Joins**

- `promotion_codes.coupon_id` → `coupons.id`

### `quotes`

Sales quotes that can be accepted to create an invoice or subscription.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per quote.  
**Primary key:** `id`

<details><summary>Columns (7, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed qt_. |
| `amount_total` | bigint |  | community | Quote total in minor currency units. |
| `created` | timestamp |  | community | When the quote was created (UTC). |
| `customer_id` | varchar | foreign | community | Customer the quote is for. |
| `invoice_id` | varchar | foreign | community | Invoice created on acceptance. |
| `status` | varchar |  | community | Quote status. Values: `draft`, `open`, `accepted`, `canceled`. |
| `subscription_id` | varchar | foreign | community | Subscription created on acceptance. |

</details>

**Joins**

- `quotes.customer_id` → `customers.id`

### `recoveries`

Smart Retries and dunning outcomes — revenue recovered after a failed subscription payment.

**Freshness:** 48h  
**Source:** derived  
**Grain:** One row per recovery attempt or recovered invoice.

<details><summary>Columns (2, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `customer_id` | varchar | foreign | community | Customer whose payment was recovered. |
| `invoice_id` | varchar | foreign | community | Invoice that was recovered. |

</details>

> The table to use for involuntary churn and dunning effectiveness reporting.

### `subscription_item_change_events`

Pre-computed MRR movement events. Stripe's recommended basis for MRR, churn and expansion reporting — far more reliable than deriving movements from subscription status changes.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per change to a subscription item that moves MRR.

<details><summary>Columns (10, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `currency` | varchar |  | documented | Currency of mrr_change. |
| `customer_id` | varchar | foreign | documented | Customer whose MRR changed. |
| `event_type` | varchar |  | documented | Kind of change that occurred. |
| `local_event_timestamp` | timestamp |  | documented | When the change took effect, in your account's local time. |
| `mrr_change` | bigint |  | documented | Signed change in monthly recurring revenue, in minor currency units. |
| `price_id` | varchar | foreign | documented | Price on the changed item. |
| `product_id` | varchar | foreign | documented | Product on the changed item. |
| `quantity_change` | bigint |  | documented | Signed change in quantity. |
| `subscription_id` | varchar | foreign | documented | Subscription that changed. |
| `subscription_item_id` | varchar | foreign | documented | Subscription item that changed. |

</details>

> Cumulatively sum mrr_change per customer ordered by local_event_timestamp to reconstruct MRR at any point in time.

> subscription_item_change_events_v2_beta has the same columns with 3-hour freshness instead of 24-hour.

> Values are per-currency. Convert with exchange_rates_from_usd before summing across currencies.

### `subscription_item_change_events_testmode`

Sandbox/test-mode equivalent of subscription_item_change_events.

**Freshness:** 48h  
**Source:** derived  
**Grain:** One row per MRR-moving change to a test-mode subscription item.

<details><summary>Columns (10, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `currency` | varchar |  | documented | Currency of mrr_change. |
| `customer_id` | varchar | foreign | documented | Customer whose MRR changed. |
| `event_type` | varchar |  | documented | Kind of change that occurred. |
| `local_event_timestamp` | timestamp |  | documented | When the change took effect, in your account's local time. |
| `mrr_change` | bigint |  | documented | Signed change in monthly recurring revenue, in minor currency units. |
| `price_id` | varchar | foreign | documented | Price on the changed item. |
| `product_id` | varchar | foreign | documented | Product on the changed item. |
| `quantity_change` | bigint |  | documented | Signed change in quantity. |
| `subscription_id` | varchar | foreign | documented | Subscription that changed. |
| `subscription_item_id` | varchar | foreign | documented | Subscription item that changed. |

</details>

### `subscription_item_change_events_v2_beta` _(preview)_

Public preview rebuild of subscription_item_change_events with 3-hour freshness instead of 24-hour. Same columns.

**Freshness:** 3h  
**Source:** derived  
**Grain:** One row per MRR-moving change to a subscription item.

<details><summary>Columns (10, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `currency` | varchar |  | documented | Currency of mrr_change. |
| `customer_id` | varchar | foreign | documented | Customer whose MRR changed. |
| `event_type` | varchar |  | documented | Kind of change that occurred. |
| `local_event_timestamp` | timestamp |  | documented | When the change took effect, in your account's local time. |
| `mrr_change` | bigint |  | documented | Signed change in monthly recurring revenue, in minor currency units. |
| `price_id` | varchar | foreign | documented | Price on the changed item. |
| `product_id` | varchar | foreign | documented | Product on the changed item. |
| `quantity_change` | bigint |  | documented | Signed change in quantity. |
| `subscription_id` | varchar | foreign | documented | Subscription that changed. |
| `subscription_item_id` | varchar | foreign | documented | Subscription item that changed. |

</details>

> Preview table — Stripe may change it. Prefer subscription_item_change_events unless you need the fresher data.

### `subscription_items`

Individual priced items on a subscription. A subscription with multiple products has one row per product here.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per subscription item.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed si_. |
| `created` | timestamp |  | community | When the item was created (UTC). |
| `price_id` | varchar | foreign | documented | Price applied to this item. |
| `price_product_id` | varchar | foreign | documented | Product behind the price. Denormalized so you can join products without going through prices. |
| `quantity` | bigint |  | community | Quantity of the price on this item. |
| `subscription_id` | varchar | foreign | documented | Parent subscription. |

</details>

**Joins**

- `subscription_items.subscription_id` → `subscriptions.id`
- `subscription_items.price_id` → `prices.id`
- `subscription_items.price_product_id` → `products.id`

> price_product_id lets you join straight to products — you don't need to hop through prices.

### `subscription_items_metadata`

Metadata key/value pairs set on subscription_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `subscription_item_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `subscription_items_metadata.subscription_item_id` → `subscription_items.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select subscription_item_id, map_agg(key, value) as md from subscription_items_metadata group by 1

### `subscription_schedule_phase_add_invoice_items`

One-off invoice items attached to a subscription schedule phase.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per add-invoice-item in a phase.

<details><summary>Columns (2, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `price_id` | varchar | foreign | community | Price of the one-off item. |
| `subscription_schedule_id` | varchar | foreign | community | Parent schedule. |

</details>

### `subscription_schedule_phase_configuration_items`

Priced items configured within a subscription schedule phase.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per item in a phase.

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `price_id` | varchar | foreign | community | Price configured for the phase. |
| `quantity` | bigint |  | community | Quantity configured for the phase. |
| `subscription_schedule_id` | varchar | foreign | community | Parent schedule. |

</details>

### `subscription_schedule_phases`

Individual phases of a subscription schedule.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per phase.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the phase. |
| `end_date` | timestamp |  | community | When the phase ends. |
| `start_date` | timestamp |  | community | When the phase begins. |
| `subscription_schedule_id` | varchar | foreign | community | Parent schedule. |

</details>

**Joins**

- `subscription_schedule_phases.subscription_schedule_id` → `subscription_schedules.id`

### `subscription_schedule_phases_metadata`

Metadata key/value pairs set on subscription_schedule_phases. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `subscription_schedule_phas_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `subscription_schedule_phases_metadata.subscription_schedule_phas_id` → `subscription_schedule_phases.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select subscription_schedule_phas_id, map_agg(key, value) as md from subscription_schedule_phases_metadata group by 1

### `subscription_schedules`

Planned sequences of subscription phases, used for scheduled price or term changes.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per schedule.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed sub_sched_. |
| `created` | timestamp |  | community | When the schedule was created (UTC). |
| `customer_id` | varchar | foreign | community | Customer the schedule belongs to. |
| `status` | varchar |  | community | Schedule status. Values: `not_started`, `active`, `completed`, `released`, `canceled`. |
| `subscription_id` | varchar | foreign | community | Subscription driven by the schedule. |

</details>

**Joins**

- `subscription_schedules.subscription_id` → `subscriptions.id`

### `subscription_schedules_metadata`

Metadata key/value pairs set on subscription_schedules. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `subscription_schedule_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `subscription_schedules_metadata.subscription_schedule_id` → `subscription_schedules.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select subscription_schedule_id, map_agg(key, value) as md from subscription_schedules_metadata group by 1

### `subscriptions`

One row per Subscription object. The primary Billing table alongside invoices.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per subscription, including canceled ones.  
**Primary key:** `id`

<details><summary>Columns (20, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed sub_. |
| `billing_cycle_anchor` | timestamp |  | community | Anchor determining when invoices are generated. |
| `cancel_at_period_end` | boolean |  | community | Whether the subscription will cancel at the end of the current period. |
| `canceled_at` | timestamp |  | community | When cancellation was requested. |
| `collection_method` | varchar |  | community | How the subscription is billed. Values: `charge_automatically`, `send_invoice`. |
| `created` | timestamp |  | community | When the subscription was created (UTC). |
| `current_period_end` | timestamp |  | community | End of the current billing period. |
| `current_period_start` | timestamp |  | community | Start of the current billing period. |
| `customer_id` | varchar | foreign | documented | Customer who owns the subscription. |
| `default_payment_method_id` | varchar | foreign | community | Payment method used to bill the subscription. |
| `discounts` | varchar |  | community | Comma-separated discount ids applied to the subscription. Split and unnest to join to discounts. |
| `ended_at` | timestamp |  | community | When the subscription ended, if it has. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `plan_id` | varchar | foreign | community | Legacy plan identifier, retained for older integrations. |
| `price_id` | varchar | foreign | documented | Price on the subscription. Only meaningful for single-item subscriptions; use subscription_items for multi-item ones. |
| `quantity` | bigint |  | community | Quantity of the subscribed price. |
| `start_date` | timestamp |  | community | When the subscription first started. |
| `status` | varchar |  | documented | Subscription status. Values: `trialing`, `active`, `past_due`, `canceled`, `unpaid`, `incomplete`, `incomplete_expired`, `paused`. |
| `trial_end` | timestamp |  | community | End of the trial period. |
| `trial_start` | timestamp |  | community | Start of the trial period. |

</details>

**Joins**

- `subscriptions.customer_id` → `customers.id`
- `subscriptions.price_id` → `prices.id`

> discounts is a comma-separated string, not an array. Unnest it: cross join unnest(split(discounts, ',')) as t(discount_id).

> For MRR and churn, use subscription_item_change_events rather than deriving from status transitions.

### `subscriptions_metadata`

Metadata key/value pairs set on subscriptions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `subscription_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `subscriptions_metadata.subscription_id` → `subscriptions.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select subscription_id, map_agg(key, value) as md from subscriptions_metadata group by 1

### `tax_rates`

Manually defined tax rates used on invoices and subscriptions. Distinct from Stripe Tax's automatic calculations.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per tax rate.  
**Primary key:** `id`

<details><summary>Columns (8, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed txr_. |
| `active` | boolean |  | community | Whether the rate can still be applied. |
| `country` | varchar |  | community | Two-letter ISO country the rate applies to. |
| `created` | timestamp |  | community | When the rate was created (UTC). |
| `display_name` | varchar |  | community | Name shown to customers, e.g. VAT. |
| `inclusive` | boolean |  | community | Whether the rate is included in the price. |
| `jurisdiction` | varchar |  | community | Jurisdiction label for the rate. |
| `percentage` | double |  | community | Rate as a percentage. |

</details>

### `tax_rates_metadata`

Metadata key/value pairs set on tax_rates. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `tax_rate_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `tax_rates_metadata.tax_rate_id` → `tax_rates.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select tax_rate_id, map_agg(key, value) as md from tax_rates_metadata group by 1

### `usage_records`

Reported usage quantities for metered subscription items. Legacy path; newer integrations use billing meters.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per usage report.

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `quantity` | bigint |  | community | Reported usage quantity. |
| `subscription_item_id` | varchar | foreign | community | Metered subscription item the usage applies to. |
| `timestamp` | timestamp |  | community | When the usage occurred. |

</details>

**Joins**

- `usage_records.subscription_item_id` → `subscription_items.id`

## capital

### `financing_balances`

Outstanding Stripe Capital loan balances over time.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per balance snapshot.

### `financing_offers`

Stripe Capital financing offers extended to you or your connected accounts.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per financing offer.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the offer. |
| `account_id` | varchar | foreign | community | Account the offer was made to. |
| `created` | timestamp |  | community | When the offer was created (UTC). |
| `status` | varchar |  | community | Offer status. |

</details>

### `financing_transactions`

Repayments and drawdowns against Stripe Capital financing.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per financing transaction.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the transaction. |
| `amount` | bigint |  | community | Signed amount in minor currency units. |
| `created` | timestamp |  | community | When the transaction occurred (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `type` | varchar |  | community | Whether this is a drawdown or a repayment. |

</details>

## checkout

### `checkout_custom_fields`

Values customers entered into custom fields you configured on a Checkout session.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (session, custom field).

<details><summary>Columns (2, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `checkout_session_id` | varchar | foreign | community | Session the field belongs to. |
| `key` | varchar |  | community | Custom field key. |

</details>

**Joins**

- `checkout_custom_fields.checkout_session_id` → `checkout_sessions.id`

### `checkout_line_items`

Line items on a Checkout session.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per line item on a session.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the line item. |
| `amount_total` | bigint |  | community | Line total in minor currency units. |
| `checkout_session_id` | varchar | foreign | community | Parent Checkout session. |
| `price_id` | varchar | foreign | community | Price on the line item. |
| `quantity` | bigint |  | community | Quantity purchased. |

</details>

**Joins**

- `checkout_line_items.checkout_session_id` → `checkout_sessions.id`
- `checkout_line_items.price_id` → `prices.id`

### `checkout_sessions`

Stripe Checkout sessions, including abandoned ones. The table to use for hosted-checkout conversion analysis.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per Checkout session.  
**Primary key:** `id`

<details><summary>Columns (12, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed cs_. |
| `amount_total` | bigint |  | community | Total amount in minor currency units. |
| `created` | timestamp |  | community | When the session was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer associated with the session. |
| `invoice_id` | varchar | foreign | community | Invoice created by the session. |
| `mode` | varchar |  | community | What the session was for. Values: `payment`, `setup`, `subscription`. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent created by the session. |
| `payment_link_id` | varchar | foreign | community | Payment link that opened the session. |
| `payment_status` | varchar |  | community | Payment state. Values: `paid`, `unpaid`, `no_payment_required`. |
| `status` | varchar |  | community | Session status. Values: `open`, `complete`, `expired`. |
| `subscription_id` | varchar | foreign | community | Subscription created by the session. |

</details>

**Joins**

- `checkout_sessions.customer_id` → `customers.id`
- `checkout_sessions.payment_intent_id` → `payment_intents.id`
- `checkout_sessions.payment_link_id` → `payment_links.id`

> status = 'expired' identifies abandoned checkouts — the denominator for conversion rate.

### `payment_links`

Reusable shareable links that open a Checkout session.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per payment link.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed plink_. |
| `active` | boolean |  | community | Whether the link still accepts payments. |
| `created` | timestamp |  | community | When the link was created (UTC). |
| `url` | varchar |  | community | Public URL of the payment link. |

</details>

## connect

### `accounts`

Your own account and, for Connect platforms, your connected accounts.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per account.  
**Primary key:** `id`

<details><summary>Columns (9, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed acct_. |
| `business_name` | varchar |  | community | Business name on the account. |
| `charges_enabled` | boolean |  | community | Whether the account can create charges. |
| `country` | varchar |  | community | Two-letter ISO country of the account. |
| `created` | timestamp |  | community | When the account was created (UTC). |
| `default_currency` | varchar |  | community | Account's default currency. Commonly used as the reporting currency when converting multi-currency figures. |
| `email` | varchar |  | community | Account email address. |
| `payouts_enabled` | boolean |  | community | Whether the account can receive payouts. |
| `type` | varchar |  | community | Connect account type. Values: `standard`, `express`, `custom`, `none`. |

</details>

> Connect platforms also have a connected_accounts table with richer onboarding and requirements detail.

### `accounts_metadata`

Metadata key/value pairs set on accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `accounts_metadata.account_id` → `accounts.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select account_id, map_agg(key, value) as md from accounts_metadata group by 1

### `connected_accounts` _(not in Stripe's published table list)_

Connect platform view of connected accounts, including legal entity, onboarding requirements and terms-of-service acceptance.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per connected account.  
**Primary key:** `id`

<details><summary>Columns (28, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed acct_. |
| `business_name` | varchar |  | documented | Business name on the account. |
| `country` | varchar |  | documented | Two-letter ISO country of the account. |
| `email` | varchar |  | documented | Account email address. |
| `future_requirements_currently_due` | varchar |  | documented | Comma-separated future requirements due now. |
| `future_requirements_eventually_due` | varchar |  | community | Comma-separated future requirements eventually due. |
| `future_requirements_past_due` | varchar |  | community | Comma-separated future requirements already overdue. |
| `future_requirements_pending_verification` | varchar |  | community | Comma-separated future requirements awaiting verification. |
| `legal_entity_address_city` | varchar |  | documented | City of the legal entity. |
| `legal_entity_address_line1` | varchar |  | documented | Street address of the legal entity. |
| `legal_entity_address_postal_code` | varchar |  | documented | Postal code of the legal entity. |
| `legal_entity_address_state` | varchar |  | documented | State/province of the legal entity. |
| `legal_entity_dob_day` | bigint |  | documented | Day of birth of the representative. |
| `legal_entity_dob_month` | bigint |  | documented | Month of birth of the representative. |
| `legal_entity_dob_year` | bigint |  | documented | Year of birth of the representative. |
| `legal_entity_first_name` | varchar |  | documented | First name of the legal entity representative. |
| `legal_entity_last_name` | varchar |  | documented | Last name of the legal entity representative. |
| `legal_entity_personal_id_number_provided` | boolean |  | documented | Whether a personal ID number was provided. |
| `legal_entity_ssn_last_4_provided` | boolean |  | documented | Whether the last 4 SSN digits were provided. |
| `legal_entity_type` | varchar |  | documented | Legal entity type. Values: `individual`, `company`. |
| `legal_entity_verification_document_id` | varchar |  | documented | Identifier of the uploaded verification document. |
| `payouts_enabled` | boolean |  | documented | Whether the account can receive payouts. |
| `requirements_currently_due` | varchar |  | documented | Comma-separated requirements due now. Empty string when nothing is due — test with != '' rather than IS NOT NULL. |
| `requirements_eventually_due` | varchar |  | community | Comma-separated requirements that will eventually be due. |
| `requirements_past_due` | varchar |  | community | Comma-separated requirements already overdue. |
| `requirements_pending_verification` | varchar |  | community | Comma-separated requirements awaiting verification. |
| `tos_acceptance_date` | timestamp |  | documented | When the account accepted the Stripe terms of service. |
| `tos_acceptance_ip` | varchar |  | documented | IP address recorded at terms-of-service acceptance. |

</details>

> Requirements columns are comma-separated strings, not arrays. Split them with split(col, ',') to unnest.

> This table contains personal data. Handle exports according to your privacy obligations.

## connect-fees

### `application_fee_refunds`

Refunds of application fees back to connected accounts.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per application fee refund.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed fr_. |
| `amount` | bigint |  | community | Refunded amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | community | Balance transaction recording the refund. |
| `created` | timestamp |  | community | When the refund was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `fee_id` | varchar | foreign | community | Application fee being refunded. |

</details>

**Joins**

- `application_fee_refunds.fee_id` → `application_fees.id`

### `application_fee_refunds_metadata`

Metadata key/value pairs set on application_fee_refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `application_fee_refund_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `application_fee_refunds_metadata.application_fee_refund_id` → `application_fee_refunds.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select application_fee_refund_id, map_agg(key, value) as md from application_fee_refunds_metadata group by 1

### `application_fees`

Fees your Connect platform collected from connected accounts.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per application fee.  
**Primary key:** `id`

<details><summary>Columns (8, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed fee_. |
| `account_id` | varchar | foreign | community | Connected account the fee was collected from. |
| `amount` | bigint |  | community | Fee amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | community | Balance transaction recording the fee. |
| `charge_id` | varchar | foreign | community | Charge that generated the fee. |
| `created` | timestamp |  | community | When the fee was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `refunded` | boolean |  | community | Whether the fee was fully refunded. |

</details>

**Joins**

- `application_fees.charge_id` → `charges.id`
- `application_fees.balance_transaction_id` → `balance_transactions.id`

## connect-issuing

### `connected_account_issuing_authorizations` _(not in Stripe's published table list)_

Connect platform view of issuing_authorizations for connected accounts. Authorization requests created whenever an issued card is used. Includes declined attempts.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per authorization.

<details><summary>Columns (12, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |
| `id` | varchar | primary | documented | Unique identifier, prefixed iauth_. |
| `amount` | bigint |  | documented | Authorized amount in minor currency units. |
| `approved` | boolean |  | documented | Whether the authorization was approved. |
| `card_id` | varchar | foreign | documented | Card used for the purchase. |
| `cardholder_id` | varchar | foreign | community | Cardholder who made the purchase. |
| `created` | timestamp |  | documented | When the authorization was requested (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `merchant_category_code` | varchar |  | community | MCC of the merchant. |
| `merchant_country` | varchar |  | community | Two-letter ISO country of the merchant. |
| `merchant_name` | varchar |  | community | Merchant the card was used at. |
| `status` | varchar |  | community | Authorization status. Values: `pending`, `closed`, `reversed`, `expired`. |

</details>

**Joins**

- `connected_account_issuing_authorizations.account` → `accounts.id`
- `connected_account_issuing_authorizations.card_id` → `issuing_cards.id`
- `connected_account_issuing_authorizations.cardholder_id` → `issuing_cardholders.id`

## connect-payments

### `connected_account_balance_transactions` _(not in Stripe's published table list)_

Connect platform view of balance_transactions for connected accounts. Ledger-style record of every event that moves money into or out of your Stripe balance. The canonical starting point for accounting and reconciliation, because it covers charges, refunds, transfers, payouts, adjustments and fees in one immutable table.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per balance transaction. Rows are never mutated after creation.

<details><summary>Columns (14, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | documented | The connected account (acct_...) this row belongs to. |
| `amount` | bigint |  | documented | Gross amount in minor currency units. Negative for money leaving your balance. |
| `created` | timestamp |  | documented | When the transaction was created (UTC). |
| `currency` | varchar |  | documented | Three-letter ISO currency code, lowercase. |
| `source_id` | varchar | foreign | documented | Polymorphic id of the object that caused this transaction. Resolve the target using the id prefix or the type column: ch_ -> charges, re_ -> refunds, po_/tr_ -> transfers. |
| `type` | varchar |  | documented | Transaction type. Values: `charge`, `refund`, `adjustment`, `application_fee`, `application_fee_refund`, `transfer`, `payment`, `payout`, `payout_cancel`, `payout_failure`, `stripe_fee`, `network_cost`. |
| `id` | varchar | primary | documented | Unique identifier, prefixed txn_. |
| `automatic_transfer_id` | varchar | foreign | documented | The automatic payout this transaction was included in. Joins to transfers.id. |
| `available_on` | timestamp |  | community | When the funds become available in your balance. |
| `description` | varchar |  | community | Free-text description of the transaction. |
| `exchange_rate` | double |  | community | Rate applied when the presentment currency differs from the settlement currency. |
| `fee` | bigint |  | documented | Total fee in minor units. Break it down via balance_transaction_fee_details. |
| `net` | bigint |  | documented | amount minus fee, in minor units. |
| `reporting_category` | varchar |  | documented | Coarser grouping of type, aligned with Stripe's financial reports. Prefer this over type for revenue reporting. |

</details>

**Joins**

- `connected_account_balance_transactions.account` → `accounts.id`
- `connected_account_balance_transactions.automatic_transfer_id` → `transfers.id`

### `connected_account_charges` _(not in Stripe's published table list)_

Connect platform view of charges for connected accounts. One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance_transactions instead.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per charge, including failed charges.

<details><summary>Columns (39, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |
| `id` | varchar | primary | documented | Unique identifier, prefixed ch_. |
| `amount` | bigint |  | documented | Charge amount in minor currency units. |
| `amount_refunded` | bigint |  | community | Amount refunded so far, in minor units. |
| `application_fee_id` | varchar | foreign | community | Application fee collected by the platform, if any. |
| `balance_transaction_id` | varchar | foreign | community | Balance transaction recording this charge's effect on your balance. |
| `captured_at` | timestamp |  | community | When the charge was captured. Null if never captured. Note the API exposes this as a boolean `captured`. |
| `card_address_zip_check` | varchar |  | documented | Postal code verification result. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_brand` | varchar |  | documented | Card brand as displayed, e.g. Visa, MasterCard, American Express. Note the capitalization differs from the API's lowercase values. |
| `card_country` | varchar |  | documented | Two-letter ISO country of the issuing bank. Compare against your own country to measure cross-border volume. |
| `card_cvc_check` | varchar |  | documented | CVC verification result. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_funding` | varchar |  | community | Funding type. Values: `credit`, `debit`, `prepaid`, `unknown`. |
| `card_last4` | varchar |  | community | Last four digits of the card. |
| `created` | timestamp |  | documented | When the charge was created (UTC). |
| `currency` | varchar |  | documented | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | documented | Customer the charge belongs to. Joins to customers.id. |
| `description` | varchar |  | community | Free-text description. |
| `destination_id` | varchar | foreign | documented | Connected account funds were routed to. Joins to accounts.id / connected_accounts.id. |
| `dispute_id` | varchar | foreign | community | Dispute against this charge, if any. |
| `failure_code` | varchar |  | documented | Machine-readable decline code when status is failed, e.g. card_declined. |
| `failure_message` | varchar |  | documented | Human-readable decline reason when status is failed. |
| `invoice_id` | varchar | foreign | community | Invoice that generated this charge, if any. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `outcome_network_status` | varchar |  | community | How the card network responded, e.g. approved_by_network, declined_by_network. |
| `outcome_risk_level` | varchar |  | community | Bucketed risk level. Values: `normal`, `elevated`, `highest`, `not_assessed`, `unknown`. |
| `outcome_risk_score` | bigint |  | documented | Radar risk score from 0 to 100. Higher is riskier. |
| `outcome_rule_id` | varchar | foreign | documented | Radar rule that produced the outcome. Joins to radar_rules.id. |
| `outcome_seller_message` | varchar |  | community | Plain-language explanation of the outcome. |
| `outcome_type` | varchar |  | documented | Radar's verdict. Values: `authorized`, `manual_review`, `issuer_declined`, `blocked`, `invalid`. |
| `paid` | boolean |  | documented | Whether the charge was successfully paid. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent that created this charge, if any. |
| `payment_method_id` | varchar | foreign | community | PaymentMethod used. Joins to payment_methods.id. |
| `payment_method_type` | varchar |  | community | Payment method family used, e.g. card, us_bank_account, sepa_debit. |
| `receipt_email` | varchar |  | community | Email the receipt was sent to. |
| `refunded` | boolean |  | community | Whether the charge was fully refunded. |
| `statement_descriptor` | varchar |  | community | Text shown on the cardholder's statement. |
| `status` | varchar |  | documented | Charge status. Values: `succeeded`, `pending`, `failed`. |
| `transfer_group` | varchar |  | community | String grouping this charge with related transfers. |
| `transfer_id` | varchar | foreign | documented | Connect transfer generated by this charge (destination charges). Joins to transfers.id. |

</details>

**Joins**

- `connected_account_charges.account` → `accounts.id`
- `connected_account_charges.customer_id` → `customers.id`
- `connected_account_charges.invoice_id` → `invoices.id`
- `connected_account_charges.payment_intent_id` → `payment_intents.id`
- `connected_account_charges.balance_transaction_id` → `balance_transactions.id`
- `connected_account_charges.transfer_id` → `transfers.id`
- `connected_account_charges.destination_id` → `connected_accounts.id`
- `connected_account_charges.payment_method_id` → `payment_methods.id`

## cost

### `network_cost_insights_report`

Breakdown of interchange and scheme network costs underlying your processing fees.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per network cost line.

## crypto

### `crypto_onramp_sessions`

Stripe crypto onramp sessions where users bought crypto with fiat.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per onramp session.  
**Primary key:** `id`

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the session. |
| `created` | timestamp |  | community | When the session was created (UTC). |
| `status` | varchar |  | community | Session status. |

</details>

## customers

### `customer_balance_transactions`

Changes to a customer's account credit balance.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per customer balance transaction.  
**Primary key:** `id`

<details><summary>Columns (7, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed cbtxn_. |
| `amount` | bigint |  | community | Signed change in minor currency units. |
| `created` | timestamp |  | community | When the transaction occurred (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer whose balance changed. |
| `invoice_id` | varchar | foreign | community | Invoice the change relates to, if any. |
| `type` | varchar |  | community | Kind of balance change. |

</details>

**Joins**

- `customer_balance_transactions.customer_id` → `customers.id`

### `customer_balance_transactions_metadata`

Metadata key/value pairs set on customer_balance_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `customer_balance_transaction_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `customer_balance_transactions_metadata.customer_balance_transaction_id` → `customer_balance_transactions.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select customer_balance_transaction_id, map_agg(key, value) as md from customer_balance_transactions_metadata group by 1

### `customer_cash_balance_transactions`

Changes to a customer's cash balance held at Stripe, used for bank-transfer funding.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per cash balance transaction.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the transaction. |
| `created` | timestamp |  | community | When the transaction occurred (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer whose cash balance changed. |
| `net_amount` | bigint |  | community | Signed change in minor currency units. |

</details>

**Joins**

- `customer_cash_balance_transactions.customer_id` → `customers.id`

### `customer_tax_ids`

Tax identifiers stored against a customer.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (customer, tax id).  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed txi_. |
| `customer_id` | varchar | foreign | community | Customer the tax id belongs to. |
| `type` | varchar |  | community | Tax id type, e.g. eu_vat, us_ein. |
| `value` | varchar |  | community | The tax identifier itself. |

</details>

**Joins**

- `customer_tax_ids.customer_id` → `customers.id`

### `customers`

One row per Customer object.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per customer, including deleted ones.  
**Primary key:** `id`

<details><summary>Columns (14, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed cus_. |
| `address_city` | varchar |  | community | City from the billing address. |
| `address_country` | varchar |  | community | Two-letter ISO country from the billing address. |
| `address_postal_code` | varchar |  | community | Postal code from the billing address. |
| `balance` | bigint |  | community | Account credit balance in minor units. Negative means credit owed to the customer. |
| `created` | timestamp |  | community | When the customer was created (UTC). |
| `currency` | varchar |  | community | Customer's default currency. |
| `default_source_id` | varchar | foreign | community | Default payment source. |
| `delinquent` | boolean |  | community | Whether the latest invoice attempt failed. |
| `description` | varchar |  | community | Free-text description. |
| `email` | varchar |  | documented | Customer email address. |
| `is_deleted` | boolean |  | community | Whether the customer has been deleted. Deleted customers remain in the table. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `name` | varchar |  | community | Customer full name. |

</details>

> Deleted customers are retained here, so filter on is_deleted for active-customer counts.

### `customers_metadata`

Metadata key/value pairs set on customers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `customer_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `customers_metadata.customer_id` → `customers.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select customer_id, map_agg(key, value) as md from customers_metadata group by 1

## issuing

### `issuing_authorizations`

Authorization requests created whenever an issued card is used. Includes declined attempts.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per authorization.  
**Primary key:** `id`

<details><summary>Columns (11, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed iauth_. |
| `amount` | bigint |  | documented | Authorized amount in minor currency units. |
| `approved` | boolean |  | documented | Whether the authorization was approved. |
| `card_id` | varchar | foreign | documented | Card used for the purchase. |
| `cardholder_id` | varchar | foreign | community | Cardholder who made the purchase. |
| `created` | timestamp |  | documented | When the authorization was requested (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `merchant_category_code` | varchar |  | community | MCC of the merchant. |
| `merchant_country` | varchar |  | community | Two-letter ISO country of the merchant. |
| `merchant_name` | varchar |  | community | Merchant the card was used at. |
| `status` | varchar |  | community | Authorization status. Values: `pending`, `closed`, `reversed`, `expired`. |

</details>

**Joins**

- `issuing_authorizations.card_id` → `issuing_cards.id`
- `issuing_authorizations.cardholder_id` → `issuing_cardholders.id`

> The API's request_history field is not available in Sigma.

### `issuing_authorizations_metadata`

Metadata key/value pairs set on issuing_authorizations. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_authorization_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `issuing_authorizations_metadata.issuing_authorization_id` → `issuing_authorizations.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select issuing_authorization_id, map_agg(key, value) as md from issuing_authorizations_metadata group by 1

### `issuing_cardholders`

People or businesses that hold cards you have issued.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per cardholder.  
**Primary key:** `id`

<details><summary>Columns (7, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed ich_. |
| `created` | timestamp |  | documented | When the cardholder was created (UTC). |
| `email` | varchar |  | documented | Cardholder email address. |
| `name` | varchar |  | community | Cardholder name. |
| `phone_number` | varchar |  | community | Cardholder phone number. |
| `status` | varchar |  | documented | Cardholder status. Values: `active`, `inactive`, `blocked`. |
| `type` | varchar |  | documented | Cardholder type. Values: `individual`, `company`. |

</details>

> Documented examples show a 'business_entity' value for type alongside 'individual'; the API uses 'company'. Verify against your own data before filtering.

### `issuing_cardholders_metadata`

Metadata key/value pairs set on issuing_cardholders. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_cardholder_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `issuing_cardholders_metadata.issuing_cardholder_id` → `issuing_cardholders.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select issuing_cardholder_id, map_agg(key, value) as md from issuing_cardholders_metadata group by 1

### `issuing_cards`

Cards you have issued.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per issued card.  
**Primary key:** `id`

<details><summary>Columns (10, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed ic_. |
| `brand` | varchar |  | community | Card brand. |
| `cardholder_id` | varchar | foreign | community | Cardholder the card belongs to. |
| `created` | timestamp |  | community | When the card was created (UTC). |
| `currency` | varchar |  | community | Currency the card transacts in. |
| `exp_month` | bigint |  | community | Expiry month. |
| `exp_year` | bigint |  | community | Expiry year. |
| `last4` | varchar |  | community | Last four digits of the card number. |
| `status` | varchar |  | community | Card status. Values: `active`, `inactive`, `canceled`. |
| `type` | varchar |  | community | Card form factor. Values: `physical`, `virtual`. |

</details>

**Joins**

- `issuing_cards.cardholder_id` → `issuing_cardholders.id`

> The API's spending_controls field is not available in Sigma.

### `issuing_cards_metadata`

Metadata key/value pairs set on issuing_cards. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_card_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `issuing_cards_metadata.issuing_card_id` → `issuing_cards.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select issuing_card_id, map_agg(key, value) as md from issuing_cards_metadata group by 1

### `issuing_disputes`

Disputes you filed on behalf of cardholders against merchants.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per issuing dispute.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed idp_. |
| `amount` | bigint |  | community | Disputed amount in minor currency units. |
| `created` | timestamp |  | community | When the dispute was created (UTC). |
| `reason` | varchar |  | community | Reason for the dispute. |
| `status` | varchar |  | community | Dispute status. |
| `transaction_id` | varchar | foreign | community | Issuing transaction being disputed. |

</details>

**Joins**

- `issuing_disputes.transaction_id` → `issuing_transactions.id`

### `issuing_network_tokens`

Network tokens provisioned for issued cards, such as those created when a card is added to a mobile wallet.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per network token.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the token. |
| `card_id` | varchar | foreign | community | Card the token represents. |
| `created` | timestamp |  | community | When the token was provisioned (UTC). |
| `status` | varchar |  | community | Token status. |

</details>

**Joins**

- `issuing_network_tokens.card_id` → `issuing_cards.id`

### `issuing_transactions`

Uses of an issued card that actually moved funds, such as completed purchases and refunds.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per issuing transaction.  
**Primary key:** `id`

<details><summary>Columns (10, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed ipi_. |
| `amount` | bigint |  | documented | Amount in minor currency units. Negative for captures (money leaving your account). |
| `authorization_id` | varchar | foreign | documented | Authorization this transaction settles. Empty for force captures and some refunds. |
| `balance_transaction_id` | varchar | foreign | documented | Balance transaction recording the effect on your balance, including fees. |
| `card_id` | varchar | foreign | community | Card involved in the transaction. |
| `cardholder_id` | varchar | foreign | community | Cardholder involved in the transaction. |
| `created` | timestamp |  | documented | When the transaction occurred (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `merchant_name` | varchar |  | community | Merchant the card was used at. |
| `type` | varchar |  | documented | Transaction type. Values: `capture`, `refund`. |

</details>

**Joins**

- `issuing_transactions.authorization_id` → `issuing_authorizations.id`
- `issuing_transactions.balance_transaction_id` → `balance_transactions.id`
- `issuing_transactions.card_id` → `issuing_cards.id`
- `issuing_transactions.cardholder_id` → `issuing_cardholders.id`

> amount is negative for captures, so an over-capture check compares -1 * issuing_transactions.amount against issuing_authorizations.amount.

> authorization_id can be empty — use a left join if you need every transaction.

### `issuing_transactions_metadata`

Metadata key/value pairs set on issuing_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_transaction_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `issuing_transactions_metadata.issuing_transaction_id` → `issuing_transactions.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select issuing_transaction_id, map_agg(key, value) as md from issuing_transactions_metadata group by 1

## other

### `acceptance_reporting_v3_itemized`

Itemized payment acceptance reporting: authorization attempts with decline and retry classification.

**Freshness:** 68h  
**Source:** derived  
**Grain:** One row per acceptance event.

### `activity_report_itemized`

Itemized activity report backing Stripe's Dashboard reporting, one row per balance-affecting event with reporting classifications.

**Freshness:** 80h  
**Source:** derived  
**Grain:** One row per reportable activity item.

> Aligns with Stripe's Reporting exports rather than the raw API objects.

### `cau_fees`

Card Account Updater fees, charged when Stripe automatically refreshes stored card credentials.

**Freshness:** 72h  
**Source:** derived  
**Grain:** One row per CAU fee.

### `charge_groups`

Groupings that link related charges, such as a retried payment and its original attempt.

**Freshness:** 72h  
**Source:** derived  
**Grain:** One row per (group, charge).

### `connected_account_activity_report_itemized`

Connect platform view of activity_report_itemized, per connected account.

**Freshness:** 80h  
**Source:** derived  
**Grain:** One row per reportable activity item, per connected account.

<details><summary>Columns (1, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |

</details>

**Joins**

- `connected_account_activity_report_itemized.account` → `accounts.id`

### `connected_account_itemized_fees`

Connect platform view of itemized_fees, showing fees paid by each connected account.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per fee, per connected account.

<details><summary>Columns (13, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | documented | The connected account (acct_...) this row belongs to. |
| `amount` | double |  | documented | Fee incurred for this activity, expressed in MAJOR units of the currency. Excludes the tax amount. |
| `incurred_at` | timestamp |  | documented | Time (in UTC) at which the fee was incurred, by the date of its originating event. |
| `activity_end_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's ending date (UTC). |
| `activity_start_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's starting date (UTC). |
| `balance_transaction_created` | timestamp |  | documented | Time (in UTC) at which the balance transaction affected your Stripe balance. |
| `balance_transaction_description` | varchar |  | documented | The description of the balance transaction containing the fee. |
| `balance_transaction_id` | varchar | foreign | documented | The ID of the balance transaction that debited the fee from your balance. |
| `currency` | varchar |  | documented | Three-letter ISO code for the currency in which amount and tax are defined. |
| `incurred_by` | varchar |  | documented | The ID of the object that incurred this fee, if any. Use incurred_by_type to determine the type of this object. |
| `incurred_by_type` | varchar |  | documented | The object type which incurred_by references. Matches the object field in the API (Charge, Refund, Invoice, etc). |
| `product_feature_description` | varchar |  | documented | The product or feature associated with the fee. |
| `tax` | double |  | documented | Tax component of the fees paid, expressed in MAJOR units of the currency. |

</details>

**Joins**

- `connected_account_itemized_fees.account` → `accounts.id`
- `connected_account_itemized_fees.balance_transaction_id` → `balance_transactions.id`

> amount and tax are in MAJOR currency units, same as itemized_fees.

### `connected_account_itemized_fees_beta`

Preview version of connected_account_itemized_fees.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per fee, per connected account.

<details><summary>Columns (13, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |
| `activity_end_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's ending date (UTC). |
| `activity_start_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's starting date (UTC). |
| `amount` | double |  | documented | Fee incurred for this activity, expressed in MAJOR units of the currency. Excludes the tax amount. |
| `balance_transaction_created` | timestamp |  | documented | Time (in UTC) at which the balance transaction affected your Stripe balance. |
| `balance_transaction_description` | varchar |  | documented | The description of the balance transaction containing the fee. |
| `balance_transaction_id` | varchar | foreign | documented | The ID of the balance transaction that debited the fee from your balance. |
| `currency` | varchar |  | documented | Three-letter ISO code for the currency in which amount and tax are defined. |
| `incurred_at` | timestamp |  | documented | Time (in UTC) at which the fee was incurred, by the date of its originating event. |
| `incurred_by` | varchar |  | documented | The ID of the object that incurred this fee, if any. Use incurred_by_type to determine the type of this object. |
| `incurred_by_type` | varchar |  | documented | The object type which incurred_by references. Matches the object field in the API (Charge, Refund, Invoice, etc). |
| `product_feature_description` | varchar |  | documented | The product or feature associated with the fee. |
| `tax` | double |  | documented | Tax component of the fees paid, expressed in MAJOR units of the currency. |

</details>

**Joins**

- `connected_account_itemized_fees_beta.account` → `accounts.id`
- `connected_account_itemized_fees_beta.balance_transaction_id` → `balance_transactions.id`

### `connected_account_summarized_balance_transactions`

Connect platform view of summarized_balance_transactions, per connected account.

**Freshness:** 12h  
**Source:** derived  
**Grain:** One row per (connected account, period, currency, reporting category).

<details><summary>Columns (1, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |

</details>

**Joins**

- `connected_account_summarized_balance_transactions.account` → `accounts.id`

### `exchange_rates_from_usd`

Daily currency conversion rates expressed relative to USD. Needed to sum multi-currency amounts into one reporting currency.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per date.  
**Primary key:** `date`

<details><summary>Columns (2, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `buy_currency_exchange_rates` | varchar |  | documented | JSON object mapping currency code to rate per 1 USD. Parse with cast(json_parse(buy_currency_exchange_rates) as map(varchar, double)). |
| `date` | date | primary | documented | Date the rates apply to. |

</details>

> This is a JSON string column, not a map. Parse it before use.

> To convert an amount from currency A to currency B: amount / rate[A] * rate[B].

### `icplus_fees`

Interchange-plus fee breakdown, splitting each fee into interchange, scheme and Stripe components.

**Freshness:** 72h  
**Source:** derived  
**Grain:** One row per fee component tied to a balance transaction.

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `balance_transaction_created_at` | timestamp |  | documented | When the balance transaction hit your balance (UTC). |
| `balance_transaction_id` | varchar | foreign | documented | Balance transaction that debited the fee. |
| `billing_amount` | bigint |  | documented | Fee amount billed. |
| `billing_currency` | varchar |  | documented | Currency of billing_amount. |
| `charge_id` | varchar | foreign | documented | Charge the fee relates to. |

</details>

**Joins**

- `icplus_fees.balance_transaction_id` → `balance_transactions.id`
- `icplus_fees.charge_id` → `charges.id`

> Only populated for accounts on interchange-plus pricing.

### `itemized_fees`

Granular breakdown of every fee charged or deducted from your Stripe balance, one row per fee component.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per individual fee.

<details><summary>Columns (12, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `activity_end_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's ending date (UTC). |
| `activity_start_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's starting date (UTC). |
| `amount` | double |  | documented | Fee incurred for this activity, expressed in MAJOR units of the currency. Excludes the tax amount. |
| `balance_transaction_created` | timestamp |  | documented | Time (in UTC) at which the balance transaction affected your Stripe balance. |
| `balance_transaction_description` | varchar |  | documented | The description of the balance transaction containing the fee. |
| `balance_transaction_id` | varchar | foreign | documented | The ID of the balance transaction that debited the fee from your balance. |
| `currency` | varchar |  | documented | Three-letter ISO code for the currency in which amount and tax are defined. |
| `incurred_at` | timestamp |  | documented | Time (in UTC) at which the fee was incurred, by the date of its originating event. |
| `incurred_by` | varchar |  | documented | The ID of the object that incurred this fee, if any. Use incurred_by_type to determine the type of this object. |
| `incurred_by_type` | varchar |  | documented | The object type which incurred_by references. Matches the object field in the API (Charge, Refund, Invoice, etc). |
| `product_feature_description` | varchar |  | documented | The product or feature associated with the fee. |
| `tax` | double |  | documented | Tax component of the fees paid, expressed in MAJOR units of the currency. |

</details>

**Joins**

- `itemized_fees.balance_transaction_id` → `balance_transactions.id`

> amount and tax are in MAJOR currency units here, unlike almost every other Sigma table. Do not divide by 100.

> Column list is complete as published by Stripe.

### `itemized_fees_beta`

Preview version of itemized_fees.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per fee.

<details><summary>Columns (12, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `activity_end_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's ending date (UTC). |
| `activity_start_date` | timestamp |  | documented | For fees calculated from activity spanning a period of time, the activity's starting date (UTC). |
| `amount` | double |  | documented | Fee incurred for this activity, expressed in MAJOR units of the currency. Excludes the tax amount. |
| `balance_transaction_created` | timestamp |  | documented | Time (in UTC) at which the balance transaction affected your Stripe balance. |
| `balance_transaction_description` | varchar |  | documented | The description of the balance transaction containing the fee. |
| `balance_transaction_id` | varchar | foreign | documented | The ID of the balance transaction that debited the fee from your balance. |
| `currency` | varchar |  | documented | Three-letter ISO code for the currency in which amount and tax are defined. |
| `incurred_at` | timestamp |  | documented | Time (in UTC) at which the fee was incurred, by the date of its originating event. |
| `incurred_by` | varchar |  | documented | The ID of the object that incurred this fee, if any. Use incurred_by_type to determine the type of this object. |
| `incurred_by_type` | varchar |  | documented | The object type which incurred_by references. Matches the object field in the API (Charge, Refund, Invoice, etc). |
| `product_feature_description` | varchar |  | documented | The product or feature associated with the fee. |
| `tax` | double |  | documented | Tax component of the fees paid, expressed in MAJOR units of the currency. |

</details>

**Joins**

- `itemized_fees_beta.balance_transaction_id` → `balance_transactions.id`

### `revenue_recognition_debits_and_credits`

Double-entry debits and credits produced by Stripe Revenue Recognition, for building deferred revenue and recognized revenue schedules.

**Freshness:** 3h  
**Source:** derived  
**Grain:** One row per accounting entry.

> Pairs with Stripe's Revenue Recognition reports; see docs.stripe.com/revenue-recognition/reports/sigma-and-sdp.

### `summarized_balance_transactions`

Pre-aggregated balance transaction totals, grouped by period and reporting category. Much cheaper than aggregating balance_transactions yourself.

**Freshness:** 12h  
**Source:** derived  
**Grain:** One row per (period, currency, reporting category).

> Use this for high-level financial summaries; drop to balance_transactions only when you need row-level detail.

## payments

### `balance_transaction_fee_details`

Line-item breakdown of the fee column on balance_transactions.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per fee component of a balance transaction. A balance transaction can have several.

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | documented | Fee component amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | documented | The balance transaction this fee component belongs to. |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `description` | varchar |  | community | Human-readable description of the fee. |
| `type` | varchar |  | documented | Kind of fee. Values: `stripe_fee`, `application_fee`, `tax`. |

</details>

**Joins**

- `balance_transaction_fee_details.balance_transaction_id` → `balance_transactions.id`

> Summing amount here reproduces balance_transactions.fee for the same balance transaction.

### `balance_transactions`

Ledger-style record of every event that moves money into or out of your Stripe balance. The canonical starting point for accounting and reconciliation, because it covers charges, refunds, transfers, payouts, adjustments and fees in one immutable table.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per balance transaction. Rows are never mutated after creation.  
**Primary key:** `id`

<details><summary>Columns (13, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed txn_. |
| `amount` | bigint |  | documented | Gross amount in minor currency units. Negative for money leaving your balance. |
| `automatic_transfer_id` | varchar | foreign | documented | The automatic payout this transaction was included in. Joins to transfers.id. |
| `available_on` | timestamp |  | community | When the funds become available in your balance. |
| `created` | timestamp |  | documented | When the transaction was created (UTC). |
| `currency` | varchar |  | documented | Three-letter ISO currency code, lowercase. |
| `description` | varchar |  | community | Free-text description of the transaction. |
| `exchange_rate` | double |  | community | Rate applied when the presentment currency differs from the settlement currency. |
| `fee` | bigint |  | documented | Total fee in minor units. Break it down via balance_transaction_fee_details. |
| `net` | bigint |  | documented | amount minus fee, in minor units. |
| `reporting_category` | varchar |  | documented | Coarser grouping of type, aligned with Stripe's financial reports. Prefer this over type for revenue reporting. |
| `source_id` | varchar | foreign | documented | Polymorphic id of the object that caused this transaction. Resolve the target using the id prefix or the type column: ch_ -> charges, re_ -> refunds, po_/tr_ -> transfers. |
| `type` | varchar |  | documented | Transaction type. Values: `charge`, `refund`, `adjustment`, `application_fee`, `application_fee_refund`, `transfer`, `payment`, `payout`, `payout_cancel`, `payout_failure`, `stripe_fee`, `network_cost`. |

</details>

**Joins**

- `balance_transactions.automatic_transfer_id` → `transfers.id`

> Prefer this table over charges/refunds for anything accounting-related; it is the only table that nets out fees consistently.

> source_id is polymorphic and has no single FK target. Join conditionally on type.

> A charge and its refund are separate rows; refunding never mutates the original row.

### `charges`

One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance_transactions instead.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per charge, including failed charges.  
**Primary key:** `id`

<details><summary>Columns (38, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed ch_. |
| `amount` | bigint |  | documented | Charge amount in minor currency units. |
| `amount_refunded` | bigint |  | community | Amount refunded so far, in minor units. |
| `application_fee_id` | varchar | foreign | community | Application fee collected by the platform, if any. |
| `balance_transaction_id` | varchar | foreign | community | Balance transaction recording this charge's effect on your balance. |
| `captured_at` | timestamp |  | community | When the charge was captured. Null if never captured. Note the API exposes this as a boolean `captured`. |
| `card_address_zip_check` | varchar |  | documented | Postal code verification result. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_brand` | varchar |  | documented | Card brand as displayed, e.g. Visa, MasterCard, American Express. Note the capitalization differs from the API's lowercase values. |
| `card_country` | varchar |  | documented | Two-letter ISO country of the issuing bank. Compare against your own country to measure cross-border volume. |
| `card_cvc_check` | varchar |  | documented | CVC verification result. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_funding` | varchar |  | community | Funding type. Values: `credit`, `debit`, `prepaid`, `unknown`. |
| `card_last4` | varchar |  | community | Last four digits of the card. |
| `created` | timestamp |  | documented | When the charge was created (UTC). |
| `currency` | varchar |  | documented | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | documented | Customer the charge belongs to. Joins to customers.id. |
| `description` | varchar |  | community | Free-text description. |
| `destination_id` | varchar | foreign | documented | Connected account funds were routed to. Joins to accounts.id / connected_accounts.id. |
| `dispute_id` | varchar | foreign | community | Dispute against this charge, if any. |
| `failure_code` | varchar |  | documented | Machine-readable decline code when status is failed, e.g. card_declined. |
| `failure_message` | varchar |  | documented | Human-readable decline reason when status is failed. |
| `invoice_id` | varchar | foreign | community | Invoice that generated this charge, if any. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `outcome_network_status` | varchar |  | community | How the card network responded, e.g. approved_by_network, declined_by_network. |
| `outcome_risk_level` | varchar |  | community | Bucketed risk level. Values: `normal`, `elevated`, `highest`, `not_assessed`, `unknown`. |
| `outcome_risk_score` | bigint |  | documented | Radar risk score from 0 to 100. Higher is riskier. |
| `outcome_rule_id` | varchar | foreign | documented | Radar rule that produced the outcome. Joins to radar_rules.id. |
| `outcome_seller_message` | varchar |  | community | Plain-language explanation of the outcome. |
| `outcome_type` | varchar |  | documented | Radar's verdict. Values: `authorized`, `manual_review`, `issuer_declined`, `blocked`, `invalid`. |
| `paid` | boolean |  | documented | Whether the charge was successfully paid. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent that created this charge, if any. |
| `payment_method_id` | varchar | foreign | community | PaymentMethod used. Joins to payment_methods.id. |
| `payment_method_type` | varchar |  | community | Payment method family used, e.g. card, us_bank_account, sepa_debit. |
| `receipt_email` | varchar |  | community | Email the receipt was sent to. |
| `refunded` | boolean |  | community | Whether the charge was fully refunded. |
| `statement_descriptor` | varchar |  | community | Text shown on the cardholder's statement. |
| `status` | varchar |  | documented | Charge status. Values: `succeeded`, `pending`, `failed`. |
| `transfer_group` | varchar |  | community | String grouping this charge with related transfers. |
| `transfer_id` | varchar | foreign | documented | Connect transfer generated by this charge (destination charges). Joins to transfers.id. |

</details>

**Joins**

- `charges.customer_id` → `customers.id`
- `charges.invoice_id` → `invoices.id`
- `charges.payment_intent_id` → `payment_intents.id`
- `charges.balance_transaction_id` → `balance_transactions.id`
- `charges.transfer_id` → `transfers.id`
- `charges.destination_id` → `connected_accounts.id`
- `charges.payment_method_id` → `payment_methods.id`

> card_brand values are display-cased (Visa, MasterCard), not the API's lowercase (visa, mastercard). Filter accordingly.

> Extra card detail beyond the flattened card_* columns lives in payment_method_details, joined on charge_id.

> A partial capture produces both a charge for the full authorized amount and a refund with reason 'partial_capture'. Exclude those refunds when measuring true refund rates.

### `charges_metadata`

Metadata key/value pairs set on charges. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `charge_id` | varchar | foreign | documented | References the id column of the parent object table. |
| `key` | varchar |  | documented | The metadata key set on the object. |
| `value` | varchar |  | documented | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `charges_metadata.charge_id` → `charges.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select charge_id, map_agg(key, value) as md from charges_metadata group by 1

### `connected_account_payment_records`

Connect platform view of payment_records for connected accounts.

**Freshness:** 6h  
**Source:** derived  
**Grain:** One row per payment record, per connected account.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |
| `id` | varchar | primary | community | Unique identifier for the payment record. |
| `amount` | bigint |  | community | Amount in minor currency units. |
| `created` | timestamp |  | community | When the record was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |

</details>

**Joins**

- `connected_account_payment_records.account` → `accounts.id`

### `connected_account_payment_records_metadata`

Metadata key/value pairs set on connected_account_payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 6h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | conventional | The connected account (acct_...) this row belongs to. |
| `connected_account_payment_record_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `connected_account_payment_records_metadata.connected_account_payment_record_id` → `connected_account_payment_records.id`
- `connected_account_payment_records_metadata.account` → `accounts.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select connected_account_payment_record_id, map_agg(key, value) as md from connected_account_payment_records_metadata group by 1

### `disputes`

One row per Dispute (chargeback), including any evidence you submitted.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per dispute. A single charge can have more than one dispute, so count distinct dispute ids.  
**Primary key:** `id`

<details><summary>Columns (11, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed dp_. |
| `amount` | bigint |  | documented | Disputed amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | community | Balance transaction for the disputed funds and dispute fee. |
| `charge_id` | varchar | foreign | documented | Charge being disputed. |
| `created` | timestamp |  | documented | When the dispute was opened (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `evidence_due_by` | timestamp |  | community | Deadline for submitting evidence. |
| `is_charge_refundable` | boolean |  | community | Whether the underlying charge can still be refunded. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent being disputed, if applicable. |
| `reason` | varchar |  | documented | Reason given by the card network. Values: `fraudulent`, `duplicate`, `subscription_canceled`, `product_unacceptable`, `product_not_received`, `unrecognized`, `credit_not_processed`, `general`, `incorrect_account_details`, `insufficient_funds`, `bank_cannot_process`, `debit_not_authorized`, `customer_initiated`, `check_returned`, `noncompliant`. |
| `status` | varchar |  | documented | Dispute status. 'prevented' means Rapid Dispute Resolution stopped it before it became a chargeback. Values: `warning_needs_response`, `warning_under_review`, `warning_closed`, `needs_response`, `under_review`, `won`, `lost`, `prevented`. |

</details>

**Joins**

- `disputes.charge_id` → `charges.id`
- `disputes.balance_transaction_id` → `balance_transactions.id`

> Exclude status = 'prevented' when computing chargeback ratios the way card networks measure them.

> Dispute data lags: recent months undercount because disputes arrive weeks after the charge.

### `disputes_enhanced_eligibility`

Eligibility of each dispute for enhanced evidence programs such as Visa Compelling Evidence 3.0.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per dispute.

<details><summary>Columns (1, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `dispute_id` | varchar | foreign | community | Dispute this eligibility record describes. |

</details>

**Joins**

- `disputes_enhanced_eligibility.dispute_id` → `disputes.id`

### `disputes_metadata`

Metadata key/value pairs set on disputes. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `dispute_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `disputes_metadata.dispute_id` → `disputes.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select dispute_id, map_agg(key, value) as md from disputes_metadata group by 1

### `payment_intents`

One row per PaymentIntent. Represents the full lifecycle of collecting a payment, including attempts that never produced a charge.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per PaymentIntent.  
**Primary key:** `id`

<details><summary>Columns (13, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed pi_. |
| `amount` | bigint |  | community | Intended amount in minor currency units. |
| `amount_received` | bigint |  | community | Amount actually collected, in minor units. |
| `cancellation_reason` | varchar |  | community | Why the intent was canceled, if it was. |
| `capture_method` | varchar |  | community | When to capture funds. Values: `automatic`, `automatic_async`, `manual`. |
| `created` | timestamp |  | community | When the intent was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | community | Customer the intent belongs to. |
| `description` | varchar |  | community | Free-text description. |
| `invoice_id` | varchar | foreign | community | Invoice that created this intent, if any. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `payment_method_id` | varchar | foreign | community | PaymentMethod attached to the intent. |
| `status` | varchar |  | community | Intent status. Values: `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `requires_capture`, `canceled`, `succeeded`. |

</details>

**Joins**

- `payment_intents.customer_id` → `customers.id`
- `payment_intents.invoice_id` → `invoices.id`

> Use this table to measure checkout conversion and drop-off; charges only contains attempts that reached the network.

### `payment_intents_metadata`

Metadata key/value pairs set on payment_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `payment_intent_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `payment_intents_metadata.payment_intent_id` → `payment_intents.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select payment_intent_id, map_agg(key, value) as md from payment_intents_metadata group by 1

### `payment_method_details`

Per-charge payment method detail that does not fit in the flattened card_* columns on charges, including 3D Secure results and wallet information.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per charge.  
**Primary key:** `charge_id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `card_3ds_authenticated` | boolean |  | community | Whether the cardholder completed 3DS authentication. |
| `card_3ds_succeeded` | boolean |  | documented | Whether 3D Secure authentication succeeded for this charge. |
| `card_network` | varchar |  | community | Network that processed the payment. |
| `card_wallet_type` | varchar |  | community | Wallet used, e.g. apple_pay, google_pay. Null when not a wallet payment. |
| `charge_id` | varchar | primary | documented | The charge these details describe. |
| `type` | varchar |  | community | Payment method family, e.g. card, us_bank_account. |

</details>

**Joins**

- `payment_method_details.charge_id` → `charges.id`

> Left join from charges — not every charge has a row here.

### `payment_methods`

Saved payment instruments attached to customers.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per payment method.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed pm_. |
| `created` | timestamp |  | community | When the payment method was created (UTC). |
| `customer_id` | varchar | foreign | community | Customer the method is attached to. |
| `type` | varchar |  | community | Payment method family, e.g. card, us_bank_account, sepa_debit. |

</details>

**Joins**

- `payment_methods.customer_id` → `customers.id`

### `payment_methods_metadata`

Metadata key/value pairs set on payment_methods. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `payment_method_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `payment_methods_metadata.payment_method_id` → `payment_methods.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select payment_method_id, map_agg(key, value) as md from payment_methods_metadata group by 1

### `payment_records`

Unified payment records spanning Stripe and externally processed payments.

**Freshness:** 6h  
**Source:** derived  
**Grain:** One row per payment record.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the payment record. |
| `amount` | bigint |  | community | Amount in minor currency units. |
| `created` | timestamp |  | community | When the record was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |

</details>

### `payment_records_metadata`

Metadata key/value pairs set on payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 6h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `payment_record_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `payment_records_metadata.payment_record_id` → `payment_records.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select payment_record_id, map_agg(key, value) as md from payment_records_metadata group by 1

### `payment_reviews`

Payments flagged by Radar for manual review, and how they were resolved.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per review.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed prv_. |
| `charge_id` | varchar | foreign | community | Charge under review. |
| `closed_reason` | varchar |  | community | How the review was resolved, e.g. approved, refunded, disputed. |
| `created` | timestamp |  | community | When the review was opened (UTC). |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent under review. |
| `reason` | varchar |  | community | Why the payment was flagged. |

</details>

**Joins**

- `payment_reviews.charge_id` → `charges.id`

### `refunds`

One row per Refund object. Refunds are separate objects from charges; refunding a charge creates a row here and a matching balance transaction.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per refund. A charge may have many partial refunds.  
**Primary key:** `id`

<details><summary>Columns (10, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed re_. |
| `amount` | bigint |  | community | Refunded amount in minor currency units (positive here; the balance transaction is negative). |
| `balance_transaction_id` | varchar | foreign | documented | Balance transaction recording this refund. |
| `charge_id` | varchar | foreign | documented | Charge being refunded. |
| `created` | timestamp |  | community | When the refund was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `description` | varchar |  | community | Free-text description. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent being refunded, if applicable. |
| `reason` | varchar |  | community | Why the refund was issued. Values: `duplicate`, `fraudulent`, `requested_by_customer`, `partial_capture`, `expired_uncaptured_charge`. |
| `status` | varchar |  | community | Refund status. Values: `pending`, `succeeded`, `failed`, `canceled`, `requires_action`. |

</details>

**Joins**

- `refunds.charge_id` → `charges.id`
- `refunds.balance_transaction_id` → `balance_transactions.id`

> reason = 'partial_capture' rows are an artifact of auth-and-capture, not customer refunds. Filter them out of refund-rate metrics.

### `refunds_metadata`

Metadata key/value pairs set on refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `refund_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `refunds_metadata.refund_id` → `refunds.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select refund_id, map_agg(key, value) as md from refunds_metadata group by 1

### `rule_decisions`

Every Radar rule evaluation, including 3DS rules triggered on PaymentIntents and SetupIntents.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per rule decision.  
**Primary key:** `id`

<details><summary>Columns (7, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier for the decision. |
| `action` | varchar |  | documented | Action the rule took, e.g. request_credentials. |
| `charge_id` | varchar | foreign | community | Charge the decision applied to, if any. |
| `created` | timestamp |  | documented | When the rule was evaluated (UTC). |
| `payment_intent_id` | varchar | foreign | documented | PaymentIntent the decision applied to. |
| `rule_id` | varchar | foreign | documented | Rule that produced the decision. |
| `setup_intent_id` | varchar | foreign | community | SetupIntent the decision applied to, if any. |

</details>

**Joins**

- `rule_decisions.rule_id` → `radar_rules.id`
- `rule_decisions.payment_intent_id` → `payment_intents.id`

### `setup_attempts`

Individual attempts to confirm a SetupIntent, including failures.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per setup attempt. A SetupIntent can have several.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the attempt. |
| `created` | timestamp |  | community | When the attempt occurred (UTC). |
| `setup_intent_id` | varchar | foreign | community | SetupIntent being confirmed. |
| `status` | varchar |  | community | Outcome of the attempt. |

</details>

**Joins**

- `setup_attempts.setup_intent_id` → `setup_intents.id`

### `setup_intents`

Attempts to save a payment method for future use without charging it immediately.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per SetupIntent.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed seti_. |
| `created` | timestamp |  | community | When the intent was created (UTC). |
| `customer_id` | varchar | foreign | community | Customer the method is being saved for. |
| `payment_method_id` | varchar | foreign | community | Payment method being set up. |
| `status` | varchar |  | community | Intent status. Values: `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `canceled`, `succeeded`. |

</details>

**Joins**

- `setup_intents.customer_id` → `customers.id`

### `setup_intents_metadata`

Metadata key/value pairs set on setup_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `setup_intent_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `setup_intents_metadata.setup_intent_id` → `setup_intents.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select setup_intent_id, map_agg(key, value) as md from setup_intents_metadata group by 1

### `sources`

Legacy payment sources, superseded by payment_methods. Present for older integrations.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per source.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed src_ (or card_ for legacy cards). |
| `created` | timestamp |  | community | When the source was created (UTC). |
| `customer_id` | varchar | foreign | community | Customer the source belongs to. |
| `type` | varchar |  | community | Source type. |

</details>

> Prefer payment_methods for anything built after the Sources API was deprecated.

### `sources_metadata`

Metadata key/value pairs set on sources. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `source_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `sources_metadata.source_id` → `sources.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select source_id, map_agg(key, value) as md from sources_metadata group by 1

## radar

### `card_testing`

Radar signals about suspected card testing activity on your account.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per detected card testing event or aggregate window.

### `early_fraud_warnings` _(not in Stripe's published table list)_

Fraud reports issued by the card network before a formal dispute is filed. Leading indicator for card brand monitoring programs such as Visa VAMP.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per early fraud warning.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed issfr_. |
| `actionable` | boolean |  | community | Whether you can still act (for example refund) to avoid a chargeback. |
| `charge_id` | varchar | foreign | community | Charge the warning is about. |
| `created` | timestamp |  | community | When the warning was received (UTC). |
| `fraud_type` | varchar |  | community | Type of fraud reported by the network. |
| `payment_intent_id` | varchar | foreign | community | PaymentIntent the warning is about, if applicable. |

</details>

**Joins**

- `early_fraud_warnings.charge_id` → `charges.id`

### `radar_data_integration`

Custom data you have sent to Radar for use in rules, joined back to the payments it scored.

**Freshness:** 48h  
**Source:** derived  
**Grain:** One row per submitted data point.

### `radar_rule_attributes`

Snapshot of most Radar rule attribute values as evaluated for a single charge. Useful for backtesting rules against known outcomes.

**Freshness:** 48h  
**Source:** derived  
**Grain:** One row per charge.  
**Primary key:** `transaction_id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `card_3d_secure_support` | varchar |  | documented | Whether the card supports 3D Secure. |
| `cvc_check` | varchar |  | documented | CVC verification result at evaluation time. |
| `is_3d_secure_authenticated` | boolean |  | documented | Whether the payment was authenticated with 3D Secure. |
| `risk_score` | bigint |  | documented | Radar risk score from 0 to 100. |
| `total_charges_per_card_number_all_time` | bigint |  | documented | Lifetime charge count seen for this card number. |
| `transaction_id` | varchar | primary | documented | The charge these attributes were evaluated for. Joins to charges.id and to disputes.charge_id. |

</details>

**Joins**

- `radar_rule_attributes.transaction_id` → `charges.id`

> The full attribute list mirrors Radar's supported rule attributes and is wider than what is listed here.

> Join to disputes on radar_rule_attributes.transaction_id = disputes.charge_id to profile disputed traffic.

### `radar_rules`

Radar for Fraud Teams custom rules, with their action and predicate. Built-in Stripe rules have fixed ids.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per rule.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Rule identifier. Built-in rules use fixed string ids such as allow_if_in_allowlist. |
| `action` | varchar |  | community | What the rule does. Values: `block`, `review`, `allow`, `request_credentials`. |
| `created` | timestamp |  | community | When the rule was created (UTC). |
| `predicate` | varchar |  | community | The rule expression as written in Radar. |

</details>

> Join to rule_decisions on rule_id to find every payment a rule affected — broader than charges.outcome_rule_id, which misses 3DS rules on PaymentIntents and SetupIntents.

## tax

### `tax_codes` _(not in Stripe's published table list)_

Product categories Stripe Tax uses to determine tax treatment. Contains all generally available tax codes, not just ones you use.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per tax code.  
**Primary key:** `id`

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Tax code identifier, prefixed txcd_. |
| `description` | varchar |  | community | Longer explanation of what the code covers. |
| `name` | varchar |  | documented | Short name, e.g. 'General - Tangible Goods'. |

</details>

### `tax_transaction_jurisdiction_details`

Per-jurisdiction breakdown of the tax liability for a tax transaction item.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (tax transaction item, jurisdiction).

<details><summary>Columns (20, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar |  | documented | Identifier of the tax transaction item these details belong to. |
| `amount_non_taxable` | bigint |  | documented | Portion of the item amount that is non-taxable in this jurisdiction, in minor units. |
| `amount_tax` | bigint |  | documented | Tax owed to this jurisdiction, in minor units. Summing across jurisdictions equals the item's amount_tax. |
| `amount_taxable` | bigint |  | documented | Portion of the item amount that is taxable in this jurisdiction, in minor units. |
| `currency` | varchar |  | documented | Integration currency for the amount_* columns. |
| `filing_amount_non_taxable` | bigint |  | documented | amount_non_taxable expressed in the filing currency. |
| `filing_amount_tax` | bigint |  | documented | amount_tax expressed in the filing currency. |
| `filing_amount_taxable` | bigint |  | documented | amount_taxable expressed in the filing currency. |
| `filing_currency` | varchar |  | documented | Currency the tax authority requires for filing. |
| `jurisdiction_country` | varchar |  | documented | Two-letter ISO country of the jurisdiction. |
| `jurisdiction_level` | varchar |  | documented | Level of the jurisdiction. Values: `country`, `state`, `county`, `city`, `district`. |
| `jurisdiction_name` | varchar |  | documented | Name of the jurisdiction, e.g. California. |
| `jurisdiction_state` | varchar |  | documented | State/province code of the jurisdiction. |
| `tax_rate_percentage` | double |  | documented | Rate applied by this jurisdiction, as a percentage. |
| `tax_transaction_id` | varchar | foreign | documented | Parent tax transaction. |
| `tax_transaction_item_id` | varchar | foreign | documented | The line item or shipping cost this jurisdiction detail applies to. |
| `tax_transaction_item_type` | varchar |  | documented | Whether the item is a line item or a shipping cost. |
| `tax_type` | varchar |  | documented | Type of tax, e.g. sales_tax, vat, gst. |
| `taxability` | varchar |  | documented | Taxability determination for the jurisdiction. |
| `taxability_reason` | varchar |  | documented | Why the item was taxed this way, e.g. standard_rated, not_subject_to_tax. |

</details>

> Summing amount_taxable or amount_non_taxable across jurisdictions does NOT equal the item's amount — jurisdictions overlap. Only amount_tax sums correctly.

> US country-level rows are always non-taxable; exclude them to match Stripe's itemized tax export.

### `tax_transaction_line_items`

Line items contributing to the sale of goods for a tax transaction.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per tax line item.  
**Primary key:** `id`

<details><summary>Columns (9, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed tax_li_. |
| `amount` | bigint |  | documented | Gross line amount in minor units. Includes tax when tax_behavior is inclusive, excludes it when exclusive. |
| `amount_tax` | bigint |  | documented | Tax liability for this line, in minor units. |
| `currency` | varchar |  | documented | Integration currency defining amount and amount_tax. Do not sum across currencies. |
| `quantity_decimal` | varchar |  | documented | Quantity billed, as a decimal string. |
| `source_line_item_id` | varchar | foreign | documented | The invoice or checkout line item this corresponds to. |
| `tax_behavior` | varchar |  | documented | Whether amount includes tax. Values: `inclusive`, `exclusive`. |
| `tax_code` | varchar | foreign | documented | Tax code applied. Joins to tax_codes.id. |
| `tax_transaction_id` | varchar | foreign | documented | Parent tax transaction. |

</details>

**Joins**

- `tax_transaction_line_items.tax_transaction_id` → `tax_transactions.id`
- `tax_transaction_line_items.tax_code` → `tax_codes.id`

> Net sales excluding tax = case when tax_behavior = 'inclusive' then amount - amount_tax else amount end.

### `tax_transaction_line_items_metadata`

Metadata key/value pairs set on tax_transaction_line_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `tax_transaction_line_item_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `tax_transaction_line_items_metadata.tax_transaction_line_item_id` → `tax_transaction_line_items.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select tax_transaction_line_item_id, map_agg(key, value) as md from tax_transaction_line_items_metadata group by 1

### `tax_transaction_shipping_costs`

Shipping costs contributing to a tax transaction. Structurally parallel to tax_transaction_line_items.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per shipping cost. A tax transaction has at most one.  
**Primary key:** `id`

<details><summary>Columns (7, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier. |
| `amount` | bigint |  | documented | Gross shipping amount in minor units. |
| `amount_tax` | bigint |  | documented | Tax liability on shipping, in minor units. |
| `currency` | varchar |  | documented | Integration currency for the amounts. |
| `tax_behavior` | varchar |  | documented | Whether amount includes tax. Values: `inclusive`, `exclusive`. |
| `tax_code` | varchar | foreign | documented | Tax code applied to shipping. |
| `tax_transaction_id` | varchar | foreign | documented | Parent tax transaction. |

</details>

**Joins**

- `tax_transaction_shipping_costs.tax_transaction_id` → `tax_transactions.id`
- `tax_transaction_shipping_costs.tax_code` → `tax_codes.id`

> Shipping costs have no source_line_item_id and no quantity — union them with line items using literal placeholders.

### `tax_transactions`

Records of assumed or reduced tax liability. The recommended starting point for tax reporting, and the bridge between tax tables and invoices or checkout sessions.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per tax transaction, one-to-one with its source object.  
**Primary key:** `id`

<details><summary>Columns (9, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier, prefixed tax_. |
| `currency` | varchar |  | community | Integration currency for the transaction's amounts. |
| `customer_id` | varchar | foreign | community | Customer the transaction relates to. |
| `livemode` | boolean |  | community | False for sandbox/test data. |
| `posted_at` | timestamp |  | documented | When the transaction was posted (UTC). |
| `source_id` | varchar | foreign | documented | Polymorphic id of the object that triggered the calculation, e.g. an invoice (in_...) or checkout session (cs_...). |
| `source_type` | varchar |  | documented | Type of the source object, e.g. 'invoice'. |
| `tax_date` | timestamp |  | documented | Date used to determine applicable tax rules. |
| `type` | varchar |  | community | Whether this records a sale or a reversal. Values: `transaction`, `reversal`. |

</details>

> Join to invoices or checkout_sessions on source_id, filtering by source_type first.

### `tax_transactions_metadata`

Metadata key/value pairs set on tax_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `tax_transaction_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `tax_transactions_metadata.tax_transaction_id` → `tax_transactions.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select tax_transaction_id, map_agg(key, value) as md from tax_transactions_metadata group by 1

## tax-reporting

### `tax_forms`

Tax forms (such as 1099s) generated for your connected accounts.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per tax form.  
**Primary key:** `id`

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the form. |
| `account_id` | varchar | foreign | community | Connected account the form was issued for. |
| `type` | varchar |  | community | Form type, e.g. 1099-K, 1099-MISC. |

</details>

## terminal

### `terminal_hardware_order_items`

Line items on a Terminal hardware order.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per item on an order.

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Line amount in minor currency units. |
| `quantity` | bigint |  | community | Quantity ordered. |
| `terminal_hardware_order_id` | varchar | foreign | community | Parent hardware order. |

</details>

**Joins**

- `terminal_hardware_order_items.terminal_hardware_order_id` → `terminal_hardware_orders.id`

### `terminal_hardware_order_metadata`

Metadata key/value pairs set on terminal_hardware_orders. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `terminal_hardware_order_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `terminal_hardware_order_metadata.terminal_hardware_order_id` → `terminal_hardware_orders.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select terminal_hardware_order_id, map_agg(key, value) as md from terminal_hardware_order_metadata group by 1

### `terminal_hardware_order_shipment_tracking`

Shipment tracking information for Terminal hardware orders.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per shipment tracking record.

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `carrier` | varchar |  | community | Shipping carrier. |
| `terminal_hardware_order_id` | varchar | foreign | community | Parent hardware order. |
| `tracking_number` | varchar |  | community | Carrier tracking number. |

</details>

### `terminal_hardware_order_tax_amounts`

Tax applied to a Terminal hardware order.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (order, tax component).

<details><summary>Columns (2, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | community | Tax amount in minor currency units. |
| `terminal_hardware_order_id` | varchar | foreign | community | Parent hardware order. |

</details>

### `terminal_hardware_orders`

Orders you placed for Terminal reader hardware.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per hardware order.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the order. |
| `amount` | bigint |  | community | Order total in minor currency units. |
| `created` | timestamp |  | community | When the order was placed (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `status` | varchar |  | community | Order status. |

</details>

### `terminal_locations`

Physical locations where you operate Terminal card readers.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per location.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed tml_. |
| `address_city` | varchar |  | community | City of the location. |
| `address_country` | varchar |  | community | Two-letter ISO country of the location. |
| `display_name` | varchar |  | community | Location name. |

</details>

### `terminal_readers`

Terminal card reader devices registered to your account.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per reader.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed tmr_. |
| `device_type` | varchar |  | community | Reader hardware model. |
| `label` | varchar |  | community | Reader label. |
| `location_id` | varchar | foreign | community | Location the reader is assigned to. |
| `status` | varchar |  | community | Whether the reader is online or offline. |

</details>

**Joins**

- `terminal_readers.location_id` → `terminal_locations.id`

## transfers

### `transfer_reversals`

Reversals of manually created transfers or payouts. Automatic payouts cannot be reversed.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per reversal.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed trr_. |
| `amount` | bigint |  | community | Reversed amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | community | Balance transaction recording the reversal. |
| `created` | timestamp |  | community | When the reversal was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `transfer_id` | varchar | foreign | community | Transfer being reversed. |

</details>

**Joins**

- `transfer_reversals.transfer_id` → `transfers.id`

### `transfer_reversals_metadata`

Metadata key/value pairs set on transfer_reversals. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `transfer_reversal_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `transfer_reversals_metadata.transfer_reversal_id` → `transfer_reversals.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select transfer_reversal_id, map_agg(key, value) as md from transfer_reversals_metadata group by 1

### `transfers`

Payouts from your Stripe balance to your bank account, and — for Connect platforms — transfers of funds to connected accounts.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per payout or transfer.  
**Primary key:** `id`

<details><summary>Columns (11, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | documented | Unique identifier. Payouts on/after 2017-04-06 use po_; earlier payouts and Connect transfers use tr_. |
| `amount` | bigint |  | documented | Amount in minor currency units. |
| `automatic` | boolean |  | community | Whether this was an automatic payout. Only automatic payouts can be reconciled to specific balance transactions. |
| `created` | timestamp |  | community | When the payout/transfer was created (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `date` | timestamp |  | documented | Scheduled arrival date of the payout in the destination account. |
| `description` | varchar |  | community | Free-text description. |
| `destination_id` | varchar | foreign | documented | Destination bank account, card, or connected account. |
| `failure_code` | varchar |  | community | Reason the payout failed, if it did. |
| `status` | varchar |  | community | Payout status. Values: `paid`, `pending`, `in_transit`, `canceled`, `failed`. |
| `transfer_group` | varchar |  | community | String grouping this transfer with the charges that funded it. |

</details>

> Reconcile a payout to its components with: balance_transactions.automatic_transfer_id = transfers.id.

> Manual payouts cannot be reconciled to specific balance transactions — the amount is arbitrary.

### `transfers_metadata`

Metadata key/value pairs set on transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `transfer_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `transfers_metadata.transfer_id` → `transfers.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select transfer_id, map_agg(key, value) as md from transfers_metadata group by 1

## treasury

### `treasury_financial_accounts`

Treasury financial accounts that store funds for your platform's users.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per financial account.  
**Primary key:** `id`

<details><summary>Columns (4, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier, prefixed fa_. |
| `country` | varchar |  | community | Two-letter ISO country of the account. |
| `created` | timestamp |  | community | When the account was created (UTC). |
| `status` | varchar |  | community | Account status. Values: `open`, `closed`. |

</details>

### `treasury_financial_accounts_metadata`

Metadata key/value pairs set on treasury_financial_accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `treasury_financial_account_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `treasury_financial_accounts_metadata.treasury_financial_account_id` → `treasury_financial_accounts.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_financial_account_id, map_agg(key, value) as md from treasury_financial_accounts_metadata group by 1

### `treasury_inbound_transfers`

Money pulled into a Treasury financial account from an external bank account.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per inbound transfer.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the transfer. |
| `amount` | bigint |  | community | Amount in minor currency units. |
| `created` | timestamp |  | community | When the transfer was created (UTC). |
| `financial_account_id` | varchar | foreign | community | Destination financial account. |
| `status` | varchar |  | community | Transfer status. |

</details>

### `treasury_inbound_transfers_metadata`

Metadata key/value pairs set on treasury_inbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `treasury_inbound_transfer_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `treasury_inbound_transfers_metadata.treasury_inbound_transfer_id` → `treasury_inbound_transfers.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_inbound_transfer_id, map_agg(key, value) as md from treasury_inbound_transfers_metadata group by 1

### `treasury_outbound_payments`

Money sent from a Treasury financial account to a third party.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per outbound payment.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the payment. |
| `amount` | bigint |  | community | Amount in minor currency units. |
| `created` | timestamp |  | community | When the payment was created (UTC). |
| `financial_account_id` | varchar | foreign | community | Source financial account. |
| `status` | varchar |  | community | Payment status. |

</details>

### `treasury_outbound_payments_metadata`

Metadata key/value pairs set on treasury_outbound_payments. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `treasury_outbound_payment_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `treasury_outbound_payments_metadata.treasury_outbound_payment_id` → `treasury_outbound_payments.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_outbound_payment_id, map_agg(key, value) as md from treasury_outbound_payments_metadata group by 1

### `treasury_outbound_transfers`

Money sent from a Treasury financial account to an external bank account you own.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per outbound transfer.  
**Primary key:** `id`

<details><summary>Columns (5, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the transfer. |
| `amount` | bigint |  | community | Amount in minor currency units. |
| `created` | timestamp |  | community | When the transfer was created (UTC). |
| `financial_account_id` | varchar | foreign | community | Source financial account. |
| `status` | varchar |  | community | Transfer status. |

</details>

### `treasury_outbound_transfers_metadata`

Metadata key/value pairs set on treasury_outbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | conventional | The metadata key set on the object. |
| `treasury_outbound_transfer_id` | varchar | foreign | conventional | References the id column of the parent object table. |
| `value` | varchar |  | conventional | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `treasury_outbound_transfers_metadata.treasury_outbound_transfer_id` → `treasury_outbound_transfers.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_outbound_transfer_id, map_agg(key, value) as md from treasury_outbound_transfers_metadata group by 1

### `treasury_transaction_entries`

Individual ledger entries making up a Treasury transaction.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per entry.  
**Primary key:** `id`

<details><summary>Columns (3, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the entry. |
| `amount` | bigint |  | community | Signed amount in minor currency units. |
| `transaction_id` | varchar | foreign | community | Parent Treasury transaction. |

</details>

**Joins**

- `treasury_transaction_entries.transaction_id` → `treasury_transactions.id`

### `treasury_transactions`

Ledger of all money movement on Treasury financial accounts.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per Treasury transaction.  
**Primary key:** `id`

<details><summary>Columns (6, partial - may be missing columns)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | community | Unique identifier for the transaction. |
| `amount` | bigint |  | community | Signed amount in minor currency units. |
| `created` | timestamp |  | community | When the transaction occurred (UTC). |
| `currency` | varchar |  | community | Three-letter ISO currency code, lowercase. |
| `financial_account_id` | varchar | foreign | community | Financial account affected. |
| `status` | varchar |  | community | Transaction status. |

</details>

**Joins**

- `treasury_transactions.financial_account_id` → `treasury_financial_accounts.id`

