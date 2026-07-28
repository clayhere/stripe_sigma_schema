# Stripe Sigma schema — agent context pack

Schema v1.0.0. 164 tables. Load this instead of probing Sigma with exploratory queries.

## Ground rules

- Engine is **Trino v414** (migrated from Presto v334). Read-only ANSI SQL — no DDL or DML.
- Amounts are integers in the currency's smallest unit (cents for USD, yen for JPY). An amount of 1000 with currency usd is 10.00 USD.
  - **Exception:** `itemized_fees`, `connected_account_itemized_fees` — amount and tax on these tables are in MAJOR currency units, not minor units. Do not divide by 100.
- `data_load_time` is a query-scoped constant, not a column: Not a column — a query-scoped constant available in every Sigma query, holding the time through which your account's data is complete. Use it instead of current_date to make scheduled queries deterministic.
- Timestamps are UTC. Convert with `AT TIME ZONE 'America/New_York'` (IANA casing — `AMERICA/NEW_YORK` errors).
- Sigma column names are **not** the API's field names. See 'API vs Sigma' below.
- Confidence marks below: no mark = documented by Stripe, `~` = derived from a documented convention, `?` = unverified. Verify `?` columns before relying on them.

## API vs Sigma naming

- Reference fields gain an _id suffix. _charge.customer -> charges.customer_id; charge.transfer -> charges.transfer_id_
- Nested objects are flattened with underscores. _charge.outcome.risk_score -> charges.outcome_risk_score_
- Some nested prefixes are dropped entirely when unambiguous. _charge.payment_method_details.card.brand -> charges.card_brand_
- Some booleans are exposed as timestamps instead. _charge.captured (boolean) -> charges.captured_at (timestamp)_
- The API `object` discriminator field is not present in Sigma. _charge.object -> (no column)_
- Deeply nested arrays become their own tables rather than columns. _invoice.lines -> invoice_line_items table_

Do not invent a column by translating an API field. Guess, then verify with `select <col> from <table> limit 1`.

## Object id prefixes

`acct_` accounts, `ch_` charges, `cn_` credit_notes, `cs_` checkout_sessions, `cus_` customers, `dp_` disputes, `fa_` treasury_financial_accounts, `iauth_` issuing_authorizations, `ic_` issuing_cards, `ich_` issuing_cardholders, `ii_` invoice_items, `il_` invoice_line_items, `in_` invoices, `ipi_` issuing_transactions, `pi_` payment_intents, `plan_` plans (legacy), `plink_` payment_links, `pm_` payment_methods, `po_` transfers (payouts, on/after 2017-04-06), `price_` prices, `prod_` products, `promo_` promotion_codes, `qt_` quotes, `re_` refunds, `seti_` setup_intents, `si_` subscription_items, `src_` sources, `sub_` subscriptions, `sub_sched_` subscription_schedules, `tax_` tax_transactions, `tax_li_` tax_transaction_line_items, `tr_` transfers (payouts before 2017-04-06, and Connect transfers), `trr_` transfer_reversals, `txcd_` tax_codes, `txn_` balance_transactions

## Table families

- **`*_metadata`** — Every object table with user-settable metadata has a sibling table named <table>_metadata. Each row is one key/value pair, joined back to the parent by a foreign key named <singular_object>_id. Pivot with `select parent_id, map_agg(key, value) as md from <table>_metadata group by 1 -- then md['your_key']`
- **`connected_account_*`** — Connect platforms get a parallel table for connected-account data, named connected_account_<base table>. It carries the same columns as the base table plus an `account` column holding the connected account id.

## Core tables

### balance_transactions
_One row per balance transaction. Rows are never mutated after creation._

`id:varchar`, `amount:bigint`, `automatic_transfer_id:varchar`, `available_on:timestamp?`, `created:timestamp`, `currency:varchar`, `description:varchar?`, `exchange_rate:double?`, `fee:bigint`, `net:bigint`, `reporting_category:varchar`, `source_id:varchar`, `type:varchar [charge|refund|adjustment|application_fee|application_fee_refund|transfer|payment|payout|payout_cancel|payout_failure|stripe_fee|network_cost]`

Joins: automatic_transfer_id → transfers.id

- ⚠ Prefer this table over charges/refunds for anything accounting-related; it is the only table that nets out fees consistently.
- ⚠ source_id is polymorphic and has no single FK target. Join conditionally on type.
- ⚠ A charge and its refund are separate rows; refunding never mutates the original row.

### balance_transaction_fee_details
_One row per fee component of a balance transaction. A balance transaction can have several._

`amount:bigint`, `balance_transaction_id:varchar`, `currency:varchar?`, `description:varchar?`, `type:varchar [stripe_fee|application_fee|tax]`

Joins: balance_transaction_id → balance_transactions.id

- ⚠ Summing amount here reproduces balance_transactions.fee for the same balance transaction.

### charges
_One row per charge, including failed charges._

`id:varchar`, `amount:bigint`, `amount_refunded:bigint?`, `application_fee_id:varchar?`, `balance_transaction_id:varchar?`, `captured_at:timestamp?`, `card_address_zip_check:varchar [pass|fail|unavailable|unchecked]`, `card_brand:varchar`, `card_country:varchar`, `card_cvc_check:varchar [pass|fail|unavailable|unchecked]`, `card_funding:varchar? [credit|debit|prepaid|unknown]`, `card_last4:varchar?`, `created:timestamp`, `currency:varchar`, `customer_id:varchar`, `description:varchar?`, `destination_id:varchar`, `dispute_id:varchar?`, `failure_code:varchar`, `failure_message:varchar`, `invoice_id:varchar?`, `livemode:boolean?`, `outcome_network_status:varchar?`, `outcome_risk_level:varchar? [normal|elevated|highest|not_assessed|unknown]`, `outcome_risk_score:bigint`, `outcome_rule_id:varchar`, `outcome_seller_message:varchar?`, `outcome_type:varchar [authorized|manual_review|issuer_declined|blocked|invalid]`, `paid:boolean`, `payment_intent_id:varchar?`, `payment_method_id:varchar?`, `payment_method_type:varchar?`, `receipt_email:varchar?`, `refunded:boolean?`, `statement_descriptor:varchar?`, `status:varchar [succeeded|pending|failed]`, `transfer_group:varchar?`, `transfer_id:varchar`

Joins: customer_id → customers.id; invoice_id → invoices.id; payment_intent_id → payment_intents.id; balance_transaction_id → balance_transactions.id; transfer_id → transfers.id; destination_id → connected_accounts.id; payment_method_id → payment_methods.id

- ⚠ card_brand values are display-cased (Visa, MasterCard), not the API's lowercase (visa, mastercard). Filter accordingly.
- ⚠ Extra card detail beyond the flattened card_* columns lives in payment_method_details, joined on charge_id.
- ⚠ A partial capture produces both a charge for the full authorized amount and a refund with reason 'partial_capture'. Exclude those refunds when measuring true refund rates.

### refunds
_One row per refund. A charge may have many partial refunds._

`id:varchar`, `amount:bigint?`, `balance_transaction_id:varchar`, `charge_id:varchar`, `created:timestamp?`, `currency:varchar?`, `description:varchar?`, `payment_intent_id:varchar?`, `reason:varchar? [duplicate|fraudulent|requested_by_customer|partial_capture|expired_uncaptured_charge]`, `status:varchar? [pending|succeeded|failed|canceled|requires_action]`

Joins: charge_id → charges.id; balance_transaction_id → balance_transactions.id

- ⚠ reason = 'partial_capture' rows are an artifact of auth-and-capture, not customer refunds. Filter them out of refund-rate metrics.

### disputes
_One row per dispute. A single charge can have more than one dispute, so count distinct dispute ids._

`id:varchar`, `amount:bigint`, `balance_transaction_id:varchar?`, `charge_id:varchar`, `created:timestamp`, `currency:varchar?`, `evidence_due_by:timestamp?`, `is_charge_refundable:boolean?`, `payment_intent_id:varchar?`, `reason:varchar [fraudulent|duplicate|subscription_canceled|product_unacceptable|product_not_received|unrecognized|credit_not_processed|general|incorrect_account_details|insufficient_funds|bank_cannot_process|debit_not_authorized|customer_initiated|check_returned|noncompliant]`, `status:varchar [warning_needs_response|warning_under_review|warning_closed|needs_response|under_review|won|lost|prevented]`

Joins: charge_id → charges.id; balance_transaction_id → balance_transactions.id

- ⚠ Exclude status = 'prevented' when computing chargeback ratios the way card networks measure them.
- ⚠ Dispute data lags: recent months undercount because disputes arrive weeks after the charge.

### customers
_One row per customer, including deleted ones._

`id:varchar`, `address_city:varchar?`, `address_country:varchar?`, `address_postal_code:varchar?`, `balance:bigint?`, `created:timestamp?`, `currency:varchar?`, `default_source_id:varchar?`, `delinquent:boolean?`, `description:varchar?`, `email:varchar`, `is_deleted:boolean?`, `livemode:boolean?`, `name:varchar?`

- ⚠ Deleted customers are retained here, so filter on is_deleted for active-customer counts.

### payment_intents
_One row per PaymentIntent._

`id:varchar?`, `amount:bigint?`, `amount_received:bigint?`, `cancellation_reason:varchar?`, `capture_method:varchar? [automatic|automatic_async|manual]`, `created:timestamp?`, `currency:varchar?`, `customer_id:varchar?`, `description:varchar?`, `invoice_id:varchar?`, `livemode:boolean?`, `payment_method_id:varchar?`, `status:varchar? [requires_payment_method|requires_confirmation|requires_action|processing|requires_capture|canceled|succeeded]`

Joins: customer_id → customers.id; invoice_id → invoices.id

- ⚠ Use this table to measure checkout conversion and drop-off; charges only contains attempts that reached the network.

### payment_method_details
_One row per charge._

`card_3ds_authenticated:boolean?`, `card_3ds_succeeded:boolean`, `card_network:varchar?`, `card_wallet_type:varchar?`, `charge_id:varchar`, `type:varchar?`

Joins: charge_id → charges.id

- ⚠ Left join from charges — not every charge has a row here.

### transfers
_One row per payout or transfer._

`id:varchar`, `amount:bigint`, `automatic:boolean?`, `created:timestamp?`, `currency:varchar?`, `date:timestamp`, `description:varchar?`, `destination_id:varchar`, `failure_code:varchar?`, `status:varchar? [paid|pending|in_transit|canceled|failed]`, `transfer_group:varchar?`

- ⚠ Reconcile a payout to its components with: balance_transactions.automatic_transfer_id = transfers.id.
- ⚠ Manual payouts cannot be reconciled to specific balance transactions — the amount is arbitrary.

### invoices
_One row per invoice, including drafts and voided invoices._

`id:varchar`, `amount_due:bigint`, `amount_paid:bigint?`, `amount_remaining:bigint?`, `attempt_count:bigint?`, `billing_reason:varchar? [subscription_cycle|subscription_create|subscription_update|subscription|manual|upcoming|subscription_threshold]`, `charge_id:varchar`, `collection_method:varchar? [charge_automatically|send_invoice]`, `created:timestamp?`, `currency:varchar`, `customer_id:varchar?`, `due_date:timestamp?`, `livemode:boolean?`, `number:varchar?`, `paid:boolean?`, `payment_intent_id:varchar?`, `period_end:timestamp`, `period_start:timestamp`, `status:varchar? [draft|open|paid|uncollectible|void]`, `subscription_id:varchar`, `subtotal:bigint?`, `tax:bigint?`, `total:bigint`

Joins: customer_id → customers.id; subscription_id → subscriptions.id; charge_id → charges.id

- ⚠ period_start/period_end describe the service period, which often differs from created. Use the right one for revenue reporting.

### invoice_line_items
_One row per invoice line item._

`id:varchar?`, `amount:bigint?`, `currency:varchar?`, `description:varchar?`, `invoice_id:varchar?`, `period_end:timestamp?`, `period_start:timestamp?`, `price_id:varchar?`, `proration:boolean?`, `quantity:bigint?`, `source_id:varchar`, `source_type:varchar [subscription|invoice_item]`, `subscription_id:varchar?`

Joins: invoice_id → invoices.id

- ⚠ source_id is polymorphic — always filter on source_type before joining it to subscriptions or invoice_items.

### subscriptions
_One row per subscription, including canceled ones._

`id:varchar`, `billing_cycle_anchor:timestamp?`, `cancel_at_period_end:boolean?`, `canceled_at:timestamp?`, `collection_method:varchar? [charge_automatically|send_invoice]`, `created:timestamp?`, `current_period_end:timestamp?`, `current_period_start:timestamp?`, `customer_id:varchar`, `default_payment_method_id:varchar?`, `discounts:varchar?`, `ended_at:timestamp?`, `livemode:boolean?`, `plan_id:varchar?`, `price_id:varchar`, `quantity:bigint?`, `start_date:timestamp?`, `status:varchar [trialing|active|past_due|canceled|unpaid|incomplete|incomplete_expired|paused]`, `trial_end:timestamp?`, `trial_start:timestamp?`

Joins: customer_id → customers.id; price_id → prices.id

- ⚠ discounts is a comma-separated string, not an array. Unnest it: cross join unnest(split(discounts, ',')) as t(discount_id).
- ⚠ For MRR and churn, use subscription_item_change_events rather than deriving from status transitions.

### subscription_items
_One row per subscription item._

`id:varchar`, `created:timestamp?`, `price_id:varchar`, `price_product_id:varchar`, `quantity:bigint?`, `subscription_id:varchar`

Joins: subscription_id → subscriptions.id; price_id → prices.id; price_product_id → products.id

- ⚠ price_product_id lets you join straight to products — you don't need to hop through prices.

### products
_One row per product._

`id:varchar`, `active:boolean?`, `created:timestamp?`, `description:varchar?`, `livemode:boolean?`, `name:varchar`, `statement_descriptor:varchar`, `unit_label:varchar?`

### prices
_One row per price._

`id:varchar`, `active:boolean?`, `billing_scheme:varchar? [per_unit|tiered]`, `created:timestamp?`, `currency:varchar`, `livemode:boolean?`, `nickname:varchar?`, `product_id:varchar?`, `recurring_interval:varchar? [day|week|month|year]`, `recurring_interval_count:bigint?`, `recurring_usage_type:varchar? [licensed|metered]`, `tiers_mode:varchar? [graduated|volume]`, `type:varchar? [one_time|recurring]`, `unit_amount:bigint?`

Joins: product_id → products.id

- ⚠ When billing_scheme is 'tiered', unit_amount is null and the real pricing lives in price_tiers.

### subscription_item_change_events
_One row per change to a subscription item that moves MRR._

`currency:varchar`, `customer_id:varchar`, `event_type:varchar`, `local_event_timestamp:timestamp`, `mrr_change:bigint`, `price_id:varchar`, `product_id:varchar`, `quantity_change:bigint`, `subscription_id:varchar`, `subscription_item_id:varchar`

- ⚠ Cumulatively sum mrr_change per customer ordered by local_event_timestamp to reconstruct MRR at any point in time.
- ⚠ subscription_item_change_events_v2_beta has the same columns with 3-hour freshness instead of 24-hour.
- ⚠ Values are per-currency. Convert with exchange_rates_from_usd before summing across currencies.

### itemized_fees
_One row per individual fee._

`activity_end_date:timestamp`, `activity_start_date:timestamp`, `amount:double`, `balance_transaction_created:timestamp`, `balance_transaction_description:varchar`, `balance_transaction_id:varchar`, `currency:varchar`, `incurred_at:timestamp`, `incurred_by:varchar`, `incurred_by_type:varchar`, `product_feature_description:varchar`, `tax:double`

Joins: balance_transaction_id → balance_transactions.id

- ⚠ amount and tax are in MAJOR currency units here, unlike almost every other Sigma table. Do not divide by 100.
- ⚠ Column list is complete as published by Stripe.

### connected_accounts
_One row per connected account._

`id:varchar`, `business_name:varchar`, `country:varchar`, `email:varchar`, `future_requirements_currently_due:varchar`, `future_requirements_eventually_due:varchar?`, `future_requirements_past_due:varchar?`, `future_requirements_pending_verification:varchar?`, `legal_entity_address_city:varchar`, `legal_entity_address_line1:varchar`, `legal_entity_address_postal_code:varchar`, `legal_entity_address_state:varchar`, `legal_entity_dob_day:bigint`, `legal_entity_dob_month:bigint`, `legal_entity_dob_year:bigint`, `legal_entity_first_name:varchar`, `legal_entity_last_name:varchar`, `legal_entity_personal_id_number_provided:boolean`, `legal_entity_ssn_last_4_provided:boolean`, `legal_entity_type:varchar [individual|company]`, `legal_entity_verification_document_id:varchar`, `payouts_enabled:boolean`, `requirements_currently_due:varchar`, `requirements_eventually_due:varchar?`, `requirements_past_due:varchar?`, `requirements_pending_verification:varchar?`, `tos_acceptance_date:timestamp`, `tos_acceptance_ip:varchar`

- ⚠ Requirements columns are comma-separated strings, not arrays. Split them with split(col, ',') to unnest.
- ⚠ This table contains personal data. Handle exports according to your privacy obligations.

### checkout_sessions
_One row per Checkout session._

`id:varchar?`, `amount_total:bigint?`, `created:timestamp?`, `currency:varchar?`, `customer_id:varchar?`, `invoice_id:varchar?`, `mode:varchar? [payment|setup|subscription]`, `payment_intent_id:varchar?`, `payment_link_id:varchar?`, `payment_status:varchar? [paid|unpaid|no_payment_required]`, `status:varchar? [open|complete|expired]`, `subscription_id:varchar?`

Joins: customer_id → customers.id; payment_intent_id → payment_intents.id; payment_link_id → payment_links.id

- ⚠ status = 'expired' identifies abandoned checkouts — the denominator for conversion rate.

### tax_transactions
_One row per tax transaction, one-to-one with its source object._

`id:varchar`, `currency:varchar?`, `customer_id:varchar?`, `livemode:boolean?`, `posted_at:timestamp`, `source_id:varchar`, `source_type:varchar`, `tax_date:timestamp`, `type:varchar? [transaction|reversal]`

- ⚠ Join to invoices or checkout_sessions on source_id, filtering by source_type first.

### tax_transaction_line_items
_One row per tax line item._

`id:varchar`, `amount:bigint`, `amount_tax:bigint`, `currency:varchar`, `quantity_decimal:varchar`, `source_line_item_id:varchar`, `tax_behavior:varchar [inclusive|exclusive]`, `tax_code:varchar`, `tax_transaction_id:varchar`

Joins: tax_transaction_id → tax_transactions.id; tax_code → tax_codes.id

- ⚠ Net sales excluding tax = case when tax_behavior = 'inclusive' then amount - amount_tax else amount end.

### exchange_rates_from_usd
_One row per date._

`buy_currency_exchange_rates:varchar`, `date:date`

- ⚠ This is a JSON string column, not a map. Parse it before use.
- ⚠ To convert an amount from currency A to currency B: amount / rate[A] * rate[B].

## All other tables

**analytics**: `aggregate_optimization_details`, `analytics_acceptance_itemized`, `authentication_report_attempts`, `charge_optimization_details`

**billing**: `billing_meter_event_summaries`, `billing_meter_invalid_events`, `billing_meter_invalid_events_payload`, `billing_meters`, `coupons`, `coupons_currency_options`, `coupons_metadata`, `credit_note_discount_amounts`, `credit_note_line_item_discount_amounts`, `credit_note_line_item_tax_amounts`, `credit_note_line_items`, `credit_note_tax_amounts`, `credit_notes`, `credit_notes_metadata`, `discounts`, `invoice_custom_fields`, `invoice_customer_tax_ids`, `invoice_items`, `invoice_items_metadata`, `invoice_line_item_discount_amounts`, `invoice_line_item_tax_amounts`, `invoice_payments`, `invoice_shipping_cost_taxes`, `invoices_metadata`, `plans`, `plans_metadata`, `price_tiers`, `prices_currency_options`, `prices_metadata`, `products_metadata`, `promotion_codes`, `quotes`, `recoveries`, `subscription_item_change_events_testmode`, `subscription_item_change_events_v2_beta`, `subscription_items_metadata`, `subscription_schedule_phase_add_invoice_items`, `subscription_schedule_phase_configuration_items`, `subscription_schedule_phases`, `subscription_schedule_phases_metadata`, `subscription_schedules`, `subscription_schedules_metadata`, `subscriptions_metadata`, `tax_rates`, `tax_rates_metadata`, `usage_records`

**capital**: `financing_balances`, `financing_offers`, `financing_transactions`

**checkout**: `checkout_custom_fields`, `checkout_line_items`, `payment_links`

**connect**: `accounts`, `accounts_metadata`

**connect-fees**: `application_fee_refunds`, `application_fee_refunds_metadata`, `application_fees`

**connect-issuing**: `connected_account_issuing_authorizations`

**connect-payments**: `connected_account_balance_transactions`, `connected_account_charges`

**cost**: `network_cost_insights_report`

**crypto**: `crypto_onramp_sessions`

**customers**: `customer_balance_transactions`, `customer_balance_transactions_metadata`, `customer_cash_balance_transactions`, `customer_tax_ids`, `customers_metadata`

**issuing**: `issuing_authorizations`, `issuing_authorizations_metadata`, `issuing_cardholders`, `issuing_cardholders_metadata`, `issuing_cards`, `issuing_cards_metadata`, `issuing_disputes`, `issuing_network_tokens`, `issuing_transactions`, `issuing_transactions_metadata`

**other**: `acceptance_reporting_v3_itemized`, `activity_report_itemized`, `cau_fees`, `charge_groups`, `connected_account_activity_report_itemized`, `connected_account_itemized_fees`, `connected_account_itemized_fees_beta`, `connected_account_summarized_balance_transactions`, `icplus_fees`, `itemized_fees_beta`, `revenue_recognition_debits_and_credits`, `summarized_balance_transactions`

**payments**: `charges_metadata`, `connected_account_payment_records`, `connected_account_payment_records_metadata`, `disputes_enhanced_eligibility`, `disputes_metadata`, `payment_intents_metadata`, `payment_methods`, `payment_methods_metadata`, `payment_records`, `payment_records_metadata`, `payment_reviews`, `refunds_metadata`, `rule_decisions`, `setup_attempts`, `setup_intents`, `setup_intents_metadata`, `sources`, `sources_metadata`

**radar**: `card_testing`, `early_fraud_warnings`, `radar_data_integration`, `radar_rule_attributes`, `radar_rules`

**tax**: `tax_codes`, `tax_transaction_jurisdiction_details`, `tax_transaction_line_items_metadata`, `tax_transaction_shipping_costs`, `tax_transactions_metadata`

**tax-reporting**: `tax_forms`

**terminal**: `terminal_hardware_order_items`, `terminal_hardware_order_metadata`, `terminal_hardware_order_shipment_tracking`, `terminal_hardware_order_tax_amounts`, `terminal_hardware_orders`, `terminal_locations`, `terminal_readers`

**transfers**: `transfer_reversals`, `transfer_reversals_metadata`, `transfers_metadata`

**treasury**: `treasury_financial_accounts`, `treasury_financial_accounts_metadata`, `treasury_inbound_transfers`, `treasury_inbound_transfers_metadata`, `treasury_outbound_payments`, `treasury_outbound_payments_metadata`, `treasury_outbound_transfers`, `treasury_outbound_transfers_metadata`, `treasury_transaction_entries`, `treasury_transactions`

Full column detail for these is in `sigma_schema.json` / `SCHEMA.md`.

## Traps that cause wrong answers

1. Use `balance_transactions` for accounting, not `charges` — it is the only table that nets fees consistently across charges, refunds, disputes and payouts.
2. Exclude `refunds.reason = 'partial_capture'` from refund metrics; those are auth-and-capture artifacts, not customer refunds.
3. Exclude `disputes.status = 'prevented'` from chargeback ratios.
4. `charges.card_brand` is display-cased (`Visa`, `MasterCard`), not the API's lowercase.
5. `subscriptions.discounts` and `connected_accounts.requirements_*` are comma-separated strings, not arrays — `split()` and `unnest()` them.
6. `exchange_rates_from_usd.buy_currency_exchange_rates` is a JSON string — `cast(json_parse(...) as map(varchar, double))` before use.
7. Summing `tax_transaction_jurisdiction_details.amount_taxable` across jurisdictions does not equal the item amount; only `amount_tax` sums correctly.
8. Recent-period dispute and fraud data undercounts — those events arrive weeks late.
9. Sort by a unique id alongside your ordering key; Trino top-N and window functions are otherwise non-deterministic on ties.
10. `end`, `interval`, `type`, `value`, `key`, `date` are reserved words — quote them.

