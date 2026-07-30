# Stripe Sigma schema reference

`262` tables, `4168` columns.

> **This is the STRIPE SIGMA schema, not the Stripe REST API schema.** Sigma
> table and column names diverge from the REST API's object fields. A REST
> API reference will produce incorrect Sigma SQL.
>
> **Read this first.** Column lists are complete only where noted, and this
> reference is not guaranteed complete or current — Stripe can change the
> Sigma schema at any time. Stripe publishes the authoritative column list
> solely inside the Dashboard schema browser, so this file combines what
> Stripe documents publicly with curated and independently verified detail.
> Each column carries a confidence level:

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

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `card_updates` | bigint |  | verified |  |
| `day` | double |  | verified |  |
| `dynamic_validations` | bigint |  | verified |  |

</details>

### `analytics_acceptance_itemized`

Itemized acceptance analytics used by Stripe's authorization rate reporting.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per acceptance analytics record.

<details><summary>Columns (40, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `amount_in_usd` | bigint |  | verified |  |
| `block_reason` | varchar |  | verified |  |
| `buyer_country` | varchar |  | verified |  |
| `card_bank` | varchar |  | verified |  |
| `card_bin` | varchar |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `charge_country` | varchar |  | verified |  |
| `charge_id` | varchar | foreign | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `customer_id` | varchar |  | verified |  |
| `failure_reason` | varchar |  | verified |  |
| `final_charge_id` | varchar |  | verified |  |
| `gateway_conversation_avs_outcome` | varchar |  | verified |  |
| `gateway_conversation_cvc_outcome` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `interaction_type` | varchar |  | verified |  |
| `invoice_id` | varchar | foreign | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `is_final_attempt` | boolean |  | verified |  |
| `is_link` | boolean |  | verified |  |
| `locality_zone` | varchar |  | verified |  |
| `mcc` | varchar |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `payment_intent_id` | varchar | foreign | verified |  |
| `payment_method_type` | varchar |  | verified |  |
| `payment_processor` | varchar |  | verified |  |
| `retry_status` | varchar |  | verified |  |
| `three_d_s_challenge_type` | varchar |  | verified |  |
| `three_d_s_is_in_sca_scope` | boolean |  | verified |  |
| `three_d_s_outcome` | varchar |  | verified |  |
| `three_d_s_outcome_type` | varchar |  | verified |  |
| `three_d_s_reason` | varchar |  | verified |  |
| `three_d_s_sca_exemption_type` | varchar |  | verified |  |
| `three_d_s_used` | boolean |  | verified |  |
| `used_network_tokens` | boolean |  | verified |  |

</details>

**Joins**

- `analytics_acceptance_itemized.charge_id` → `charges.id`
- `analytics_acceptance_itemized.invoice_id` → `invoices.id`
- `analytics_acceptance_itemized.payment_intent_id` → `payment_intents.id`

### `authentication_report_attempts`

Individual 3D Secure authentication attempts, including the resulting charge outcome.

**Freshness:** 100h  
**Source:** derived  
**Grain:** One row per authentication attempt. An intent can have several.  
**Primary key:** `attempt_id`

<details><summary>Columns (25, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `attempt_id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `authentication_flow` | varchar |  | verified |  |
| `card_bin_country` | varchar |  | verified |  |
| `charge_id` | varchar | foreign | verified |  |
| `charge_outcome` | varchar |  | verified | What happened to the charge afterwards, e.g. authorized. |
| `charge_outcome_reason` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the attempt occurred (UTC). |
| `currency` | varchar |  | verified |  |
| `device_type` | varchar |  | verified |  |
| `final_attempt_id` | varchar |  | verified |  |
| `intent_id` | varchar | foreign | verified | PaymentIntent or SetupIntent the attempt belongs to. |
| `intent_type` | varchar |  | verified |  |
| `is_authenticated_by_digital_wallet` | boolean |  | verified |  |
| `is_final_attempt` | boolean |  | verified | Whether this was the last attempt for the intent. Filter on this to avoid double counting. |
| `is_in_sca_scope` | boolean |  | verified |  |
| `is_threeds_triggered` | boolean |  | verified |  |
| `merchant_country` | varchar |  | verified |  |
| `protocol_version` | varchar |  | verified |  |
| `sca_exemption_mechanism` | varchar |  | verified |  |
| `sca_exemption_requested` | varchar |  | verified |  |
| `sca_exemption_status` | varchar |  | verified |  |
| `threeds_outcome_result` | varchar |  | verified | Result of the 3DS challenge, e.g. authenticated. |
| `threeds_outcome_result_reason` | varchar |  | verified |  |
| `threeds_reason` | varchar |  | verified |  |

</details>

**Joins**

- `authentication_report_attempts.intent_id` → `payment_intents.id`
- `authentication_report_attempts.charge_id` → `charges.id`

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
**Primary key:** `id`

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `aggregated_value` | double |  | verified | Aggregated usage value for the window. |
| `customer_id` | varchar | foreign | verified | Customer the usage belongs to. |
| `end_time` | timestamp |  | verified | Exclusive end of the summary window. |
| `livemode` | boolean |  | verified |  |
| `meter_id` | varchar | foreign | verified | Meter being summarized. |
| `segment_hash` | varchar |  | verified |  |
| `start_time` | timestamp |  | verified | Inclusive start of the summary window. |
| `value_grouping_window` | varchar |  | verified | Granularity of the window, e.g. 'hourly' or 'daily'. |

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

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the invalid event. |
| `created` | timestamp |  | verified | When the invalid event was received (UTC). |
| `error_code` | varchar |  | verified | Machine-readable validation error code. |
| `error_message` | varchar |  | verified | Human-readable validation error. |
| `event_name` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `meter_id` | varchar | foreign | verified |  |
| `received` | timestamp |  | verified |  |

</details>

> The original event payload is in billing_meter_invalid_events_payload, joined on event_id.

### `billing_meter_invalid_events_payload` _(not in Stripe's published table list)_

Key/value payload of each invalid meter event.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per (invalid event, payload key).  
**Primary key:** `key`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `event_id` | varchar | foreign | verified | The invalid event this payload entry belongs to. |
| `key` | varchar | primary | verified | Payload key, e.g. stripe_customer_id. |
| `value` | varchar |  | verified | Payload value for that key. |

</details>

**Joins**

- `billing_meter_invalid_events_payload.event_id` → `billing_meter_invalid_events.id`

### `billing_meters` _(not in Stripe's published table list)_

Usage-based billing meters that aggregate metered events.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per meter.  
**Primary key:** `id`

<details><summary>Columns (13, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed mtr_. |
| `created` | timestamp |  | verified |  |
| `customer_mapping_event_payload_key` | varchar |  | verified |  |
| `customer_mapping_type` | varchar |  | verified |  |
| `deactivated` | timestamp |  | verified |  |
| `default_aggregation_formula` | varchar |  | verified | How events are aggregated, e.g. sum or count. |
| `display_name` | varchar |  | verified | Human-readable meter name. |
| `event_name` | varchar |  | verified | Name of the event this meter listens for. |
| `event_time_window` | varchar |  | verified |  |
| `livemode` | boolean |  | verified | False for sandbox/test data. |
| `status` | varchar |  | verified | Meter status. Note the documented example filters on the uppercase value 'ACTIVE'. Values: `ACTIVE`, `INACTIVE`. |
| `updated` | timestamp |  | verified |  |
| `value_settings_event_payload_key` | varchar |  | verified |  |

</details>

> status is uppercase in this table ('ACTIVE'), unlike most Sigma enum columns which are lowercase.

### `coupons`

Discount definitions that can be applied to customers, subscriptions or invoices.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per coupon.  
**Primary key:** `id`

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Coupon identifier — often a human-chosen string rather than a generated id. |
| `amount_off` | bigint |  | verified | Fixed discount in minor currency units. Mutually exclusive with percent_off. |
| `applies_to_products` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the coupon was created (UTC). |
| `currency` | varchar |  | verified | Currency of amount_off. |
| `duration` | varchar |  | verified | How long the discount applies. Values: `once`, `repeating`, `forever`. |
| `duration_in_months` | bigint |  | verified | Number of months the discount applies when duration is repeating. |
| `max_redemptions` | bigint |  | verified | Maximum number of times the coupon can be redeemed. |
| `name` | varchar |  | verified | Display name of the coupon. |
| `percent_off` | double |  | verified | Percentage discount. Mutually exclusive with amount_off. |
| `redeem_by` | timestamp |  | verified |  |
| `times_redeemed` | bigint |  | verified | Number of times the coupon has been redeemed. |
| `valid` | boolean |  | verified | Whether the coupon can still be applied. |

</details>

### `coupons_currency_options`

Per-currency overrides for multi-currency coupons.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (coupon, currency).  
**Primary key:** `coupon_id, currency`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `coupon_id` | varchar | primary | verified | Coupon being overridden. |
| `currency` | varchar | primary | verified | Currency this option applies to. |
| `amount_off` | bigint |  | verified | Fixed discount in that currency's minor units. |
| `batch_timestamp` | timestamp |  | verified |  |

</details>

**Joins**

- `coupons_currency_options.coupon_id` → `coupons.id`

### `coupons_metadata`

Metadata key/value pairs set on coupons. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `coupon_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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
**Primary key:** `credit_note_id, id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_note_id` | varchar | primary | verified | Parent credit note. |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified | Discount amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `discount` | varchar |  | verified |  |

</details>

**Joins**

- `credit_note_discount_amounts.credit_note_id` → `credit_notes.id`

### `credit_note_line_item_discount_amounts`

Discount amounts applied to individual credit note line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note line item, discount).  
**Primary key:** `credit_note_id, credit_note_line_item_id, id`

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_note_id` | varchar | primary | verified |  |
| `credit_note_line_item_id` | varchar | primary | verified | Credit note line item discounted. |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified | Discount amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `discount` | varchar |  | verified |  |

</details>

### `credit_note_line_item_tax_amounts`

Tax amounts applied to individual credit note line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note line item, tax rate).  
**Primary key:** `id`

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_note_line_item_id` | varchar | foreign | verified | Credit note line item taxed. |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified | Tax amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `inclusive` | boolean |  | verified |  |
| `tax_rate_id` | varchar | foreign | verified | Tax rate applied. |

</details>

**Joins**

- `credit_note_line_item_tax_amounts.credit_note_line_item_id` → `credit_note_line_items.id`
- `credit_note_line_item_tax_amounts.tax_rate_id` → `tax_rates.id`

### `credit_note_line_items`

Line items on a credit note.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per credit note line item.  
**Primary key:** `id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the line item. |
| `amount` | bigint |  | verified | Line amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `credit_note_id` | varchar | foreign | verified | Parent credit note. |
| `description` | varchar |  | verified |  |
| `discount_amount` | bigint |  | verified |  |
| `invoice_line_item` | varchar |  | verified |  |
| `quantity` | bigint |  | verified |  |
| `type` | varchar |  | verified |  |
| `unit_amount` | bigint |  | verified |  |
| `unit_amount_decimal` | varchar |  | verified |  |

</details>

**Joins**

- `credit_note_line_items.credit_note_id` → `credit_notes.id`

### `credit_note_tax_amounts`

Tax amounts applied at the credit note level.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (credit note, tax rate).  
**Primary key:** `id`

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_note_id` | varchar | foreign | verified | Parent credit note. |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified | Tax amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `inclusive` | boolean |  | verified |  |
| `tax_rate_id` | varchar | foreign | verified | Tax rate applied. |

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

<details><summary>Columns (22, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed cn_. |
| `amount` | bigint |  | verified | Credited amount in minor currency units. |
| `amount_shipping` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the credit note was issued (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `customer_balance_transaction_id` | varchar | foreign | verified |  |
| `customer_id` | varchar | foreign | verified | Customer receiving the credit. |
| `effective_at` | timestamp |  | verified |  |
| `invoice_id` | varchar | foreign | verified | Invoice being credited. |
| `memo` | varchar |  | verified |  |
| `number` | varchar |  | verified |  |
| `out_of_band_amount` | bigint |  | verified |  |
| `reason` | varchar |  | verified | Why the credit note was issued. Values: `duplicate`, `fraudulent`, `order_change`, `product_unsatisfactory`. |
| `refund_id` | varchar | foreign | verified |  |
| `shipping_cost_amount_subtotal` | bigint |  | verified |  |
| `shipping_cost_amount_tax` | bigint |  | verified |  |
| `shipping_cost_amount_total` | bigint |  | verified |  |
| `shipping_cost_shipping_rate_id` | varchar |  | verified |  |
| `status` | varchar |  | verified | Credit note status. Values: `issued`, `void`. |
| `type` | varchar |  | verified |  |
| `voided_at` | timestamp |  | verified |  |

</details>

**Joins**

- `credit_notes.invoice_id` → `invoices.id`
- `credit_notes.customer_id` → `customers.id`
- `credit_notes.customer_balance_transaction_id` → `customer_balance_transactions.id`
- `credit_notes.refund_id` → `refunds.id`

### `credit_notes_metadata`

Metadata key/value pairs set on credit_notes. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_note_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (12, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed di_. |
| `batch_timestamp` | timestamp |  | verified |  |
| `checkout_session_id` | varchar | foreign | verified |  |
| `coupon_id` | varchar | foreign | verified | Coupon that was applied. |
| `created` | timestamp |  | verified |  |
| `customer_id` | varchar | foreign | verified | Customer the discount applies to. |
| `end` | bigint |  | verified | When the discount stops applying. `end` is a reserved word in Trino — quote it as "end". |
| `invoice_id` | varchar | foreign | verified | Invoice the discount applies to. |
| `invoice_item_id` | varchar | foreign | verified |  |
| `promotion_code_id` | varchar | foreign | verified | Promotion code used, if the discount came from one. |
| `subscription_id` | varchar | foreign | verified | Subscription the discount applies to. |
| `subscription_item_id` | varchar | foreign | verified |  |

</details>

**Joins**

- `discounts.coupon_id` → `coupons.id`
- `discounts.checkout_session_id` → `checkout_sessions.id`
- `discounts.customer_id` → `customers.id`
- `discounts.invoice_id` → `invoices.id`
- `discounts.invoice_item_id` → `invoice_items.id`
- `discounts.promotion_code_id` → `promotion_codes.id`
- `discounts.subscription_id` → `subscriptions.id`
- `discounts.subscription_item_id` → `subscription_items.id`

> Reach discounts from subscriptions by unnesting the comma-separated subscriptions.discounts column.

### `invoice_custom_fields`

Custom key/value fields rendered on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice, custom field).  
**Primary key:** `invoice_id, name`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | primary | verified | Invoice the field appears on. |
| `name` | varchar | primary | verified | Field label. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | Field value. |

</details>

**Joins**

- `invoice_custom_fields.invoice_id` → `invoices.id`

### `invoice_customer_tax_ids`

Customer tax identifiers captured on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice, tax id).  
**Primary key:** `invoice_id, value`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | primary | verified | Invoice the tax id appears on. |
| `value` | varchar | primary | verified | The tax identifier itself. |
| `batch_timestamp` | timestamp |  | verified |  |
| `type` | varchar |  | verified | Tax id type, e.g. eu_vat, us_ein. |

</details>

### `invoice_items`

One-off charges or credits queued onto a customer's next invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per invoice item.  
**Primary key:** `id`

<details><summary>Columns (22, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed ii_. |
| `amount` | bigint |  | verified | Amount in minor currency units. Negative for credits. |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | verified | Customer the item will be billed to. |
| `date` | timestamp |  | verified |  |
| `description` | varchar |  | verified | Customer-facing description. |
| `discountable` | boolean |  | verified |  |
| `discounts` | varchar |  | verified |  |
| `invoice_id` | varchar | foreign | verified | Invoice the item landed on, once invoiced. |
| `net_amount` | bigint |  | verified |  |
| `period_end` | timestamp |  | verified |  |
| `period_start` | timestamp |  | verified |  |
| `plan_id` | varchar | foreign | verified |  |
| `price_id` | varchar | foreign | verified |  |
| `proration` | boolean |  | verified | Whether the item is a proration adjustment. |
| `quantity` | bigint |  | verified |  |
| `quantity_decimal` | varchar |  | verified |  |
| `subscription_id` | varchar | foreign | verified | Subscription the item relates to, if any. |
| `subscription_item` | varchar |  | verified |  |
| `unit_amount` | bigint |  | verified |  |
| `unit_amount_decimal` | varchar |  | verified |  |

</details>

**Joins**

- `invoice_items.customer_id` → `customers.id`
- `invoice_items.invoice_id` → `invoices.id`
- `invoice_items.plan_id` → `plans.id`
- `invoice_items.price_id` → `prices.id`
- `invoice_items.subscription_id` → `subscriptions.id`

### `invoice_items_metadata`

Metadata key/value pairs set on invoice_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_item_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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
**Primary key:** `id, invoice_id, invoice_line_item_id`

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `invoice_id` | varchar | primary | verified | Parent invoice. |
| `invoice_line_item_id` | varchar | primary | verified | Invoice line item discounted. |
| `amount` | bigint |  | verified | Discount amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `discount` | varchar |  | verified |  |

</details>

**Joins**

- `invoice_line_item_discount_amounts.invoice_id` → `invoices.id`

> Sum amount grouped by invoice_id to get total discount per invoice.

### `invoice_line_item_tax_amounts`

Tax amounts applied to individual invoice line items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice line item, tax rate).  
**Primary key:** `id, invoice_id, invoice_line_item_id`

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `invoice_id` | varchar | primary | verified | Parent invoice. |
| `invoice_line_item_id` | varchar | primary | verified | Invoice line item taxed. |
| `amount` | bigint |  | verified | Tax amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `filing_amount` | bigint |  | verified |  |
| `inclusive` | boolean |  | verified |  |
| `tax_rate` | varchar |  | verified |  |
| `taxable_amount` | bigint |  | verified |  |

</details>

### `invoice_line_items`

Individual line items on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per invoice line item.  
**Primary key:** `id`

<details><summary>Columns (25, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | foreign | verified | Parent invoice. |
| `amount` | bigint |  | verified | The amount, in cents. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. |
| `discountable` | boolean |  | verified | If true, discounts will apply to this line item. Always false for prorations. |
| `id` | varchar | primary | verified | The globally unique id for this invoice line item. |
| `invoice_item_id` | varchar | foreign | verified | The ID of the invoice item associated with this line item if any. |
| `line_item_parent_id` | varchar |  | verified | The parent object id derived from parent details for this line item. |
| `line_item_parent_type` | varchar |  | verified | The type of parent that generated this line item. Mirrors parent.type from the API. |
| `period_end` | timestamp |  | verified | The end of the period, which must be greater than or equal to the start. This value is inclusive. |
| `period_start` | timestamp |  | verified | The start of the period. This value is inclusive. |
| `plan_id` | varchar | foreign | verified | Unique identifier for the object. |
| `price_id` | varchar | foreign | verified | Unique identifier for the object. |
| `proration` | boolean |  | verified | Whether this is a proration. |
| `proration_details_credited_items_invoice` | varchar |  | verified | Invoice containing the credited invoice line items |
| `proration_details_credited_items_invoice_line_items` | varchar |  | verified | Credited invoice line items |
| `quantity` | bigint |  | verified | Quantity of units for the invoice line item in integer format, with any decimal precision truncated. For the line item's full-precision decimal quantity, use quantity_decimal. This field will be deprecated in favor of quantity_decimal in a future version. If the line item is a proration or subscription, the quantity of the subscription that the proration was computed for. |
| `quantity_decimal` | varchar |  | verified | Non-negative decimal with at most 12 decimal places. The quantity of units for the line item. |
| `source_id` | varchar | foreign | verified | Unique identifier for the object. |
| `source_type` | varchar |  | verified | A string identifying the type of the source of this line item, either an invoiceitem or a subscription. Values: `subscription`, `invoice_item`. |
| `subscription` | varchar |  | verified |  |
| `subscription_item_id` | varchar | foreign | verified | The subscription item that generated this line item. Left empty if the line item is not an explicit result of a subscription. |
| `total_discount` | bigint |  | verified | The sum total of the top- and item-level discounts applied to this line item. |
| `total_exclusive_tax` | bigint |  | verified | The sum total of the exclusive taxes applied to this line item. |

</details>

**Joins**

- `invoice_line_items.invoice_id` → `invoices.id`
- `invoice_line_items.invoice_item_id` → `invoice_items.id`
- `invoice_line_items.plan_id` → `plans.id`
- `invoice_line_items.price_id` → `prices.id`
- `invoice_line_items.source_id` → `sources.id`
- `invoice_line_items.subscription_item_id` → `subscription_items.id`

> source_id is polymorphic — always filter on source_type before joining it to subscriptions or invoice_items.

### `invoice_payments`

Payment attempts against an invoice, linking invoices to the charges or payment intents that settled them.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per payment applied to an invoice.  
**Primary key:** `id`

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount_overpaid` | bigint |  | verified |  |
| `amount_paid` | bigint |  | verified | Amount applied, in minor currency units. |
| `amount_requested` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `invoice` | varchar |  | verified |  |
| `is_default` | boolean |  | verified |  |
| `payment_id` | varchar |  | verified |  |
| `payment_intent` | varchar |  | verified |  |
| `payment_type` | varchar |  | verified |  |
| `status` | varchar |  | verified | Payment status. |
| `status_transitions_canceled_at` | timestamp |  | verified |  |
| `status_transitions_paid_at` | timestamp |  | verified |  |

</details>

> Use this rather than invoices.charge_id when an invoice can be settled by multiple payments.

### `invoice_shipping_cost_taxes`

Tax applied to shipping costs on an invoice.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (invoice, shipping tax rate).  
**Primary key:** `id, invoice_id`

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `invoice_id` | varchar | primary | verified | Parent invoice. |
| `amount` | bigint |  | verified | Tax amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `filing_amount` | bigint |  | verified |  |
| `inclusive` | boolean |  | verified |  |
| `tax_rate` | varchar |  | verified |  |
| `taxable_amount` | bigint |  | verified |  |

</details>

### `invoices`

One row per Invoice object. Each subscription generates invoices on a recurring basis covering the subscription amount plus any invoice items.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per invoice, including drafts and voided invoices.  
**Primary key:** `id`

<details><summary>Columns (98, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount_due` | bigint |  | verified | Final amount due at this time for this invoice. If the invoice's total is smaller than the minimum charge amount, for example, or if there is account credit that can be applied to the invoice, the amount_due may be 0. If there is a positive starting_balance for the invoice (the customer owes money), the amount_due will also take that into account. The charge that gets generated for the invoice will be for the amount specified in amount_due. |
| `amount_paid` | bigint |  | verified | The amount, in cents, that was paid. |
| `amount_remaining` | bigint |  | verified | The difference between amount_due and amount_paid, in cents. |
| `amount_shipping` | bigint |  | verified | This is the sum of all the shipping amounts. |
| `application_fee` | bigint |  | verified |  |
| `application_id` | varchar |  | verified | ID of the Connect Application that created the invoice. |
| `attempt_count` | bigint |  | verified | Number of payment attempts made for this invoice, from the perspective of the payment retry schedule. Any payment attempt counts as the first attempt, and subsequently only automatic retries increment the attempt count. In other words, manual payment attempts after the first attempt do not affect the retry schedule. If a failure is returned with a non-retryable return code, the invoice can no longer be retried unless a new payment method is obtained. Retries will continue to be scheduled, and attempt_count will continue to increment, but retries will only be executed if a new payment method is obtained. |
| `attempted` | boolean |  | verified | Whether an attempt has been made to pay the invoice. An invoice is not attempted until 1 hour after the invoice.created webhook, for example, so you might not want to display that invoice as unpaid to your users. |
| `auto_advance` | boolean |  | verified | Controls whether Stripe performs automatic collection of the invoice. If false, the invoice's state doesn't automatically advance without an explicit action. |
| `automatic_tax_enabled` | boolean |  | verified | Whether Stripe automatically computes tax on this invoice. Note that incompatible invoice items (invoice items with manually specified tax rates, negative amounts, or tax_behavior=unspecified) cannot be added to automatic tax invoices. |
| `automatic_tax_provider` | varchar |  | verified | The tax provider powering automatic tax. |
| `automatic_tax_status` | varchar |  | verified | The status of the most recent automated tax calculation for this invoice. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `billing_reason` | varchar |  | verified | Indicates the reason why the invoice was created.

manual: Unrelated to a subscription, for example, created via the invoice editor.
subscription: No longer in use. Applies to subscriptions from before May 2018 where no distinction was made between updates, cycles, and thresholds.
subscription_create: A new subscription was created.
subscription_cycle: A subscription advanced into a new period.
subscription_threshold: A subscription reached a billing threshold.
subscription_update: A subscription was updated.
upcoming: Reserved for upcoming invoices created through the Create Preview Invoice API or when an invoice.upcoming event is generated for an upcoming invoice on a subscription. Values: `subscription_cycle`, `subscription_create`, `subscription_update`, `subscription`, `manual`, `upcoming`, `subscription_threshold`. |
| `charge_id` | varchar | foreign | verified | ID of the latest charge generated for this invoice, if any. |
| `collection_method` | varchar |  | verified | How payment is collected. Values: `charge_automatically`, `send_invoice`. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `customer_address_city` | varchar |  | verified | City, district, suburb, town, or village. |
| `customer_address_country` | varchar |  | verified | Two-letter country code (ISO 3166-1 alpha-2). |
| `customer_address_line1` | varchar |  | verified | Address line 1, such as the street, PO Box, or company name. |
| `customer_address_line2` | varchar |  | verified | Address line 2, such as the apartment, suite, unit, or building. |
| `customer_address_postal_code` | varchar |  | verified | ZIP or postal code. |
| `customer_address_state` | varchar |  | verified | State, county, province, or region (ISO 3166-2). |
| `customer_description` | varchar |  | verified |  |
| `customer_email` | varchar |  | verified | The customer's email. Until the invoice is finalized, this field will equal customer.email. Once the invoice is finalized, this field will no longer be updated. |
| `customer_id` | varchar | foreign | verified | The ID of the customer to bill. |
| `customer_name` | varchar |  | verified | The customer's name. Until the invoice is finalized, this field will equal customer.name. Once the invoice is finalized, this field will no longer be updated. |
| `customer_phone` | varchar |  | verified | The customer's phone number. Until the invoice is finalized, this field will equal customer.phone. Once the invoice is finalized, this field will no longer be updated. |
| `customer_shipping_address_city` | varchar |  | verified | City, district, suburb, town, or village. |
| `customer_shipping_address_country` | varchar |  | verified | Two-letter country code (ISO 3166-1 alpha-2). |
| `customer_shipping_address_line1` | varchar |  | verified | Address line 1, such as the street, PO Box, or company name. |
| `customer_shipping_address_line2` | varchar |  | verified | Address line 2, such as the apartment, suite, unit, or building. |
| `customer_shipping_address_postal_code` | varchar |  | verified | ZIP or postal code. |
| `customer_shipping_address_state` | varchar |  | verified | State, county, province, or region (ISO 3166-2). |
| `customer_shipping_name` | varchar |  | verified | Customer name. |
| `customer_shipping_phone` | varchar |  | verified | Customer phone (including extension). |
| `customer_tax_exempt` | varchar |  | verified | The customer's tax exempt status. Until the invoice is finalized, this field will equal customer.tax_exempt. Once the invoice is finalized, this field will no longer be updated. |
| `date` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `default_payment_method_id` | varchar | foreign | verified | ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription's default payment method, if any, or to the default payment method in the customer's invoice settings. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. Referenced as 'memo' in the Dashboard. |
| `discount_checkout_session` | varchar |  | verified | The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Not present for subscription mode. |
| `discount_coupon_id` | varchar | foreign | verified | Unique identifier for the object. |
| `discount_customer_id` | varchar | foreign | verified | The ID of the customer associated with this discount. |
| `discount_end` | timestamp |  | verified | If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null. |
| `discount_invoice` | varchar |  | verified | The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice. |
| `discount_invoice_item` | varchar |  | verified | The invoice item id (or invoice line item id for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item. |
| `discount_promotion_code_id` | varchar |  | verified | The promotion code applied to create this discount. |
| `discount_schedule_id` | varchar | foreign | verified | The subscription schedule that this coupon is applied to, if it is applied to a particular subscription schedule. |
| `discount_start` | timestamp |  | verified | Date that the coupon was applied. |
| `discount_subscription` | varchar |  | verified | The subscription that this coupon is applied to, if it is applied to a particular subscription. |
| `discount_subscription_item` | varchar |  | verified | The subscription item that this coupon is applied to, if it is applied to a particular subscription item. |
| `discounts` | varchar |  | verified | The discounts applied to the invoice. Line item discounts are applied before invoice discounts. Use expand[]=discounts to expand each discount. |
| `due_date` | timestamp |  | verified | The date on which payment for this invoice is due. This value will be null for invoices where collection_method=charge_automatically. |
| `effective_at` | timestamp |  | verified | The date when this invoice is in effect. Same as finalized_at unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the invoice PDF and receipt. |
| `ending_balance` | bigint |  | verified |  |
| `footer` | varchar |  | verified | Footer displayed on the invoice. |
| `next_payment_attempt` | timestamp |  | verified | The time at which payment will next be attempted. This value will be null for invoices where collection_method=send_invoice. |
| `number` | varchar |  | verified | A unique, identifying string that appears on emails sent to the customer for this invoice. This starts with the customer's unique invoice_prefix if it is specified. |
| `on_behalf_of_id` | varchar | foreign | verified | The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the Invoices with Connect documentation for details. |
| `paid` | boolean |  | verified | Whether payment was successfully collected for this invoice. An invoice can be paid (most commonly) with a charge or with credit from the customer's account balance. |
| `paid_out_of_band` | boolean |  | verified | Returns true if the invoice was manually marked paid, returns false if the invoice hasn't been paid yet or was paid on Stripe. |
| `parent_id` | varchar |  | verified | The ID of the parent that generated the invoice. |
| `parent_type` | varchar |  | verified | The parent type of the invoice. Possible values: billing_cadence, subscription, quote, schedule. Values: `billing_cadence`, `subscription`, `quote`, `schedule`. |
| `period_end` | timestamp |  | verified | The latest timestamp at which invoice items can be associated with this invoice. Use the line item period to get the service period for each price. |
| `period_start` | timestamp |  | verified | The earliest timestamp at which invoice items can be associated with this invoice. Use the line item period to get the service period for each price. |
| `post_payment_credit_notes_amount` | bigint |  | verified | Total amount of all post-payment credit notes issued for this invoice. |
| `pre_payment_credit_notes_amount` | bigint |  | verified | Total amount of all pre-payment credit notes issued for this invoice. |
| `quote_id` | varchar | foreign | verified | The quote this invoice was generated from. |
| `receipt_number` | varchar |  | verified | This is the transaction number that appears on email receipts sent for this invoice. |
| `shipping_cost_amount_subtotal` | bigint |  | verified | Total shipping cost before any taxes are applied. |
| `shipping_cost_amount_tax` | bigint |  | verified | Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0. |
| `shipping_cost_amount_total` | bigint |  | verified | Total shipping cost after taxes are applied. |
| `shipping_cost_shipping_rate_id` | varchar |  | verified | The ID of the ShippingRate for this invoice. |
| `shipping_details_address_city` | varchar |  | verified | City, district, suburb, town, or village. |
| `shipping_details_address_country` | varchar |  | verified | Two-letter country code (ISO 3166-1 alpha-2). |
| `shipping_details_address_line1` | varchar |  | verified | Address line 1, such as the street, PO Box, or company name. |
| `shipping_details_address_line2` | varchar |  | verified | Address line 2, such as the apartment, suite, unit, or building. |
| `shipping_details_address_postal_code` | varchar |  | verified | ZIP or postal code. |
| `shipping_details_address_state` | varchar |  | verified | State, county, province, or region (ISO 3166-2). |
| `shipping_details_name` | varchar |  | verified | Recipient name. |
| `shipping_details_phone` | varchar |  | verified | Recipient phone (including extension). |
| `starting_balance` | bigint |  | verified | Starting customer balance before the invoice is finalized. If the invoice has not been finalized yet, this will be the current customer balance. |
| `statement_descriptor` | varchar |  | verified | Extra information about an invoice for the customer's credit card statement. |
| `status` | varchar |  | verified | The status of the invoice, one of draft, open, paid, uncollectible, or void. Learn more Values: `draft`, `open`, `paid`, `uncollectible`, `void`. |
| `status_transitions_finalized_at` | timestamp |  | verified | The time that the invoice draft was finalized. |
| `status_transitions_marked_uncollectible_at` | timestamp |  | verified | The time that the invoice was marked uncollectible. |
| `status_transitions_paid_at` | timestamp |  | verified | The time that the invoice was paid. |
| `status_transitions_voided_at` | timestamp |  | verified | The time that the invoice was voided. |
| `subscription_id` | varchar | foreign | verified | The subscription that this invoice was prepared for, if any. |
| `subscription_proration_date` | timestamp |  | verified | Only set for upcoming invoices that preview prorations. The time used to calculate prorations. |
| `subtotal` | bigint |  | verified | Total of all subscriptions, invoice items, and prorations on the invoice before any invoice level discount or exclusive tax is applied. Item discounts are already incorporated |
| `tax` | bigint |  | verified | The amount of tax on this invoice. This is the sum of all the tax amounts on this invoice. |
| `tax_percent` | double |  | verified | This percentage of the subtotal has been added to the total amount of the invoice, including invoice line items and discounts. This field is inherited from the subscription's tax_percent field, but can be changed before the invoice is paid. This field defaults to null. |
| `total` | bigint |  | verified | Total after discounts and taxes. |
| `transfer_data_amount` | bigint |  | verified | The amount in cents that will be transferred to the destination account when the invoice is paid. By default, the entire amount is transferred to the destination. |
| `transfer_data_destination_id` | varchar | foreign | verified | The account where funds from the payment will be transferred to upon payment success. |
| `webhooks_delivered_at` | timestamp |  | verified | Invoices are automatically paid or sent 1 hour after webhooks are delivered, or until all webhook delivery attempts have been exhausted. This field tracks the time when webhooks for this invoice were successfully delivered. If the invoice had no webhooks to deliver, this will be set while the invoice is being created. |

</details>

**Joins**

- `invoices.customer_id` → `customers.id`
- `invoices.subscription_id` → `subscriptions.id`
- `invoices.charge_id` → `charges.id`
- `invoices.quote_id` → `quotes.id`

> period_start/period_end describe the service period, which often differs from created. Use the right one for revenue reporting.

### `invoices_metadata`

Metadata key/value pairs set on invoices. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `invoice_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (17, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed plan_. |
| `aggregate_usage` | varchar |  | verified |  |
| `amount` | bigint |  | verified | Amount per interval in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_scheme` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the plan was created (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `interval` | varchar |  | verified | Billing interval. `interval` is a reserved word in Trino — quote it as "interval". Values: `day`, `week`, `month`, `year`. |
| `interval_count` | bigint |  | verified |  |
| `nickname` | varchar |  | verified |  |
| `product_id` | varchar | foreign | verified | Product the plan bills for. |
| `tiers_mode` | varchar |  | verified |  |
| `transform_usage_divide_by` | bigint |  | verified |  |
| `transform_usage_round` | varchar |  | verified |  |
| `trial_period_days` | bigint |  | verified |  |
| `unit_amount_decimal` | varchar |  | verified |  |
| `usage_type` | varchar |  | verified |  |

</details>

**Joins**

- `plans.product_id` → `products.id`

> Prefer prices for new work. `interval` must be quoted in Trino.

### `plans_metadata`

Metadata key/value pairs set on plans. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, plan_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `plan_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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
**Primary key:** `price_id, upto`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `price_id` | varchar | primary | verified | Price these tiers belong to. |
| `upto` | varchar | primary | verified | Upper bound of the tier in units. Null represents the unbounded final tier. |
| `amount` | bigint |  | verified | Per-unit amount for this tier, in minor currency units. |
| `amount_decimal` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `flat_amount` | bigint |  | verified | Flat fee charged for this tier, in minor currency units. |
| `flat_amount_decimal` | varchar |  | verified |  |

</details>

**Joins**

- `price_tiers.price_id` → `prices.id`

### `prices`

How much and how often to charge for a product.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per price.  
**Primary key:** `id`

<details><summary>Columns (25, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | The ID of the price object. |
| `active` | boolean |  | verified | Whether the price can be used for new purchases. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `billing_scheme` | varchar |  | verified | Describes how to compute the price per period. Either per_unit or tiered. per_unit indicates that the fixed amount (specified in unit_amount or unit_amount_decimal) will be charged per unit in quantity (for prices with usage_type=licensed), or per unit of total usage (for prices with usage_type=metered). tiered indicates that the unit pricing will be computed using a tiering strategy as defined using the tiers and tiers_mode attributes. Values: `per_unit`, `tiered`. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `custom_unit_amount_default` | bigint |  | verified | The starting unit amount which can be updated by the customer. |
| `custom_unit_amount_maximum` | bigint |  | verified | The maximum unit amount the customer can specify for this item. |
| `custom_unit_amount_minimum` | bigint |  | verified | The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount. |
| `lookup_key` | varchar |  | verified | A lookup key used to retrieve prices dynamically from a static string. This may be up to 200 characters. |
| `nickname` | varchar |  | verified | A brief description of the price, hidden from customers. |
| `product_id` | varchar | foreign | verified | The ID of the product this price is associated with. |
| `recurring_aggregate_usage` | varchar |  | verified | Specifies a usage aggregation strategy for prices of usage_type=metered. Defaults to sum. |
| `recurring_interval` | varchar |  | verified | The frequency at which a subscription is billed. One of day, week, month or year. Values: `day`, `week`, `month`, `year`. |
| `recurring_interval_count` | bigint |  | verified | The number of intervals (specified in the interval attribute) between subscription billings. For example, interval=month and interval_count=3 bills every 3 months. |
| `recurring_meter_id` | varchar | foreign | verified | The meter tracking the usage of a metered price |
| `recurring_trial_period_days` | bigint |  | verified | Default number of trial days when subscribing a customer to this price using trial_from_plan=true. |
| `recurring_usage_type` | varchar |  | verified | Configures how the quantity per period should be determined. Can be either metered or licensed. licensed automatically bills the quantity set when adding it to a subscription. metered aggregates the total usage based on usage records. Defaults to licensed. Values: `licensed`, `metered`. |
| `tax_behavior` | varchar |  | verified | Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified. Once specified as either inclusive or exclusive, it cannot be changed. Values: `inclusive`, `exclusive`, `unspecified`. |
| `tiers_mode` | varchar |  | verified | Defines if the tiering price should be graduated or volume based. In volume-based tiering, the maximum quantity within a period determines the per unit price. In graduated tiering, pricing can change as the quantity grows. Values: `graduated`, `volume`. |
| `transform_quantity_divide_by` | bigint |  | verified | Divide usage by this number. |
| `transform_quantity_round` | varchar |  | verified | After division, either round the result up or down. |
| `type` | varchar |  | verified | One of one_time or recurring depending on whether the price is for a one-time purchase or a recurring (subscription) purchase. Values: `one_time`, `recurring`. |
| `unit_amount` | bigint |  | verified | The unit amount in cents to be charged, represented as a whole integer if possible. Only set if billing_scheme=per_unit. |
| `unit_amount_decimal` | varchar |  | verified | The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places. Only set if billing_scheme=per_unit. |

</details>

**Joins**

- `prices.product_id` → `products.id`

> When billing_scheme is 'tiered', unit_amount is null and the real pricing lives in price_tiers.

### `prices_currency_options`

Per-currency overrides for multi-currency prices.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (price, currency).  
**Primary key:** `currency, price_id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `currency` | varchar | primary | verified | Currency this option applies to. |
| `price_id` | varchar | primary | verified | Price being overridden. |
| `batch_timestamp` | timestamp |  | verified |  |
| `unit_amount` | bigint |  | verified | Amount in that currency's minor units. |
| `unit_amount_decimal` | varchar |  | verified |  |

</details>

**Joins**

- `prices_currency_options.price_id` → `prices.id`

### `prices_metadata`

Metadata key/value pairs set on prices. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, price_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `price_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (13, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `active` | boolean |  | verified | Whether the product is currently available for purchase. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `caption` | varchar |  | verified |  |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `deactivate_on` | varchar |  | verified |  |
| `description` | varchar |  | verified | The product's description, meant to be displayable to the customer. Use this field to optionally store a long form explanation of the product being sold for your own rendering purposes. |
| `name` | varchar |  | verified | The product's name, meant to be displayable to the customer. |
| `shippable` | boolean |  | verified | Whether this product is shipped (i.e., physical goods). |
| `statement_descriptor` | varchar |  | verified | Extra information about a product which will appear on your customer's credit card statement. In the case that multiple products are billed at once, the first statement descriptor will be used. Only used for subscription payments. |
| `type` | varchar |  | verified | The type of the product. The product is either of type good, which is eligible for use with Orders and SKUs, or service, which is eligible for use with Subscriptions and Plans. |
| `unit_label` | varchar |  | verified | A label that represents units of this product. When set, this will be included in customers' receipts, invoices, Checkout, and the customer portal. |
| `url` | varchar |  | verified | A URL of a publicly-accessible webpage for this product. |

</details>

### `products_metadata`

Metadata key/value pairs set on products. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `product_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (13, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed promo_. |
| `active` | boolean |  | verified | Whether the code can still be redeemed. |
| `batch_timestamp` | timestamp |  | verified |  |
| `code` | varchar |  | verified | The code customers type in, e.g. SPRING25. |
| `coupon_id` | varchar | foreign | verified | Coupon this code applies. |
| `created` | timestamp |  | verified | When the promotion code was created (UTC). |
| `customer_id` | varchar | foreign | verified | Customer the code is restricted to, if any. |
| `expires_at` | bigint |  | verified | When the code expires. |
| `max_redemptions` | bigint |  | verified | Redemption limit for the code. |
| `restrictions_first_time_transaction` | boolean |  | verified |  |
| `restrictions_minium_amount` | bigint |  | verified |  |
| `restrictions_minium_amount_currency` | varchar |  | verified |  |
| `times_redeemed` | bigint |  | verified | Number of times the code has been redeemed. |

</details>

**Joins**

- `promotion_codes.coupon_id` → `coupons.id`
- `promotion_codes.customer_id` → `customers.id`

### `quotes`

Sales quotes that can be accepted to create an invoice or subscription.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per quote.  
**Primary key:** `id`

<details><summary>Columns (39, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed qt_. |
| `accepted_at` | timestamp |  | verified |  |
| `amount_subtotal` | bigint |  | verified |  |
| `amount_total` | bigint |  | verified | Quote total in minor currency units. |
| `application_fee_amount` | bigint |  | verified |  |
| `application_fee_percent` | bigint |  | verified |  |
| `automatic_tax_enabled` | boolean |  | verified |  |
| `automatic_tax_status` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `cloned_from` | varchar |  | verified |  |
| `collection_method` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the quote was created (UTC). |
| `currency` | varchar |  | verified |  |
| `customer_id` | varchar | foreign | verified | Customer the quote is for. |
| `default_tax_rates` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `expires_at` | timestamp |  | verified |  |
| `finalized_at` | timestamp |  | verified |  |
| `footer` | varchar |  | verified |  |
| `header` | varchar |  | verified |  |
| `invoice_id` | varchar | foreign | verified | Invoice created on acceptance. |
| `invoice_settings_days_until_due` | double |  | verified |  |
| `is_revision` | boolean |  | verified |  |
| `line_item_group` | varchar |  | verified |  |
| `number` | varchar |  | verified |  |
| `on_behalf_of_id` | varchar | foreign | verified |  |
| `recurring_line_item_group` | varchar |  | verified |  |
| `status` | varchar |  | verified | Quote status. Values: `draft`, `open`, `accepted`, `canceled`. |
| `subscription_data_billing_mode_type` | varchar |  | verified |  |
| `subscription_data_description` | varchar |  | verified |  |
| `subscription_data_effective_date` | bigint |  | verified |  |
| `subscription_data_proration_discounts` | varchar |  | verified |  |
| `subscription_data_trial_period_days` | bigint |  | verified |  |
| `subscription_id` | varchar | foreign | verified | Subscription created on acceptance. |
| `transfer_data_amount` | bigint |  | verified |  |
| `transfer_data_destination_amount_percent` | double |  | verified |  |
| `transfer_data_destination_id` | varchar | foreign | verified |  |
| `upcoming_line_item_group` | varchar |  | verified |  |

</details>

**Joins**

- `quotes.customer_id` → `customers.id`
- `quotes.invoice_id` → `invoices.id`
- `quotes.subscription_id` → `subscriptions.id`

### `recoveries`

Smart Retries and dunning outcomes — revenue recovered after a failed subscription payment.

**Freshness:** 48h  
**Source:** derived  
**Grain:** One row per recovery attempt or recovered invoice.  
**Primary key:** `id`

<details><summary>Columns (18, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount_due` | bigint |  | verified |  |
| `amount_paid` | bigint |  | verified |  |
| `attempt_count` | bigint |  | verified |  |
| `initial_failed_amount` | bigint |  | verified |  |
| `initial_payment_decline_reason` | varchar |  | verified |  |
| `initial_payment_failed_at` | timestamp |  | verified |  |
| `next_payment_attempt` | timestamp |  | verified |  |
| `on_behalf_of_id` | varchar | foreign | verified |  |
| `paid_at` | timestamp |  | verified |  |
| `recovered_amount` | bigint |  | verified |  |
| `recovered_at` | timestamp |  | verified |  |
| `recovery_method` | varchar |  | verified |  |
| `reporting_currency` | varchar |  | verified |  |
| `retries_exhausted` | boolean |  | verified |  |
| `retry_attempt_count` | bigint |  | verified |  |
| `source_id` | varchar |  | verified |  |
| `source_type` | varchar |  | verified |  |

</details>

> The table to use for involuntary churn and dunning effectiveness reporting.

### `subscription_item_change_events`

Pre-computed MRR movement events. Stripe's recommended basis for MRR, churn and expansion reporting — far more reliable than deriving movements from subscription status changes.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per change to a subscription item that moves MRR.  
**Primary key:** `event_timestamp, event_type`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `event_timestamp` | varchar | primary | verified | Time at which the subscription item change event occurred in UTC. |
| `event_type` | varchar | primary | verified | The type of event that caused the change. |
| `subscription_item_id` | varchar | foreign | verified | Subscription item related to this subscription item change event. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `customer_id` | varchar | foreign | verified | Customer related to this subscription item change event. |
| `local_event_timestamp` | timestamp |  | verified | Time at which the subscription item change event occurred in the merchant’s timezone. |
| `mrr_change` | bigint |  | verified | The amount that MRR changed in the currency (in minor currency units) on the day of the `local_event_timestamp``. |
| `price_id` | varchar | foreign | verified | Price related to this subscription item change event. |
| `product_id` | varchar | foreign | verified | Product related to this subscription item change event. |
| `quantity_change` | bigint |  | verified | The amount that quantity changed on the day of the `local_event_timestamp``. |
| `subscription_id` | varchar | foreign | verified | Subscription related to this subscription item change event. |

</details>

**Joins**

- `subscription_item_change_events.subscription_item_id` → `subscription_items.id`
- `subscription_item_change_events.customer_id` → `customers.id`
- `subscription_item_change_events.price_id` → `prices.id`
- `subscription_item_change_events.product_id` → `products.id`
- `subscription_item_change_events.subscription_id` → `subscriptions.id`

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
**Primary key:** `event_timestamp, event_type`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `event_timestamp` | varchar | primary | verified |  |
| `event_type` | varchar | primary | verified | Kind of change that occurred. |
| `subscription_item_id` | varchar | foreign | verified | Subscription item that changed. |
| `currency` | varchar |  | verified | Currency of mrr_change. |
| `customer_id` | varchar | foreign | verified | Customer whose MRR changed. |
| `local_event_timestamp` | timestamp |  | verified | When the change took effect, in your account's local time. |
| `mrr_change` | bigint |  | verified | Signed change in monthly recurring revenue, in minor currency units. |
| `price_id` | varchar | foreign | verified | Price on the changed item. |
| `product_id` | varchar | foreign | verified | Product on the changed item. |
| `quantity_change` | bigint |  | verified | Signed change in quantity. |
| `subscription_id` | varchar | foreign | verified | Subscription that changed. |

</details>

**Joins**

- `subscription_item_change_events_v2_beta.subscription_item_id` → `subscription_items.id`
- `subscription_item_change_events_v2_beta.customer_id` → `customers.id`
- `subscription_item_change_events_v2_beta.price_id` → `prices.id`
- `subscription_item_change_events_v2_beta.product_id` → `products.id`
- `subscription_item_change_events_v2_beta.subscription_id` → `subscriptions.id`

> Preview table — Stripe may change it. Prefer subscription_item_change_events unless you need the fresher data.

### `subscription_items`

Individual priced items on a subscription. A subscription with multiple products has one row per product here.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per subscription item.  
**Primary key:** `id`

<details><summary>Columns (28, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `subscription_id` | varchar | foreign | verified | Parent subscription. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `billing_thresholds_usage_gte` | bigint |  | verified | Usage threshold that triggers the subscription to create an invoice |
| `created` | bigint |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `discounts` | varchar |  | verified | The discounts applied to the subscription item. Subscription item discounts are applied before subscription discounts. Use expand[]=discounts to expand each discount. |
| `item_current_period_end` | timestamp |  | verified | The end time of this subscription item's current billing period. |
| `item_current_period_start` | timestamp |  | verified | The start time of this subscription item's current billing period. |
| `plan_amount` | bigint |  | verified | The unit amount in cents to be charged, represented as a whole integer if possible. Only set if billing_scheme=per_unit. |
| `plan_created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `plan_currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `plan_id` | varchar |  | verified | Unique identifier for the object. |
| `plan_interval` | varchar |  | verified | The frequency at which a subscription is billed. One of day, week, month or year. Values: `day`, `week`, `month`, `year`. |
| `plan_interval_count` | bigint |  | verified | The number of intervals (specified in the interval attribute) between subscription billings. For example, interval=month and interval_count=3 bills every 3 months. |
| `plan_nickname` | varchar |  | verified | A brief description of the plan, hidden from customers. |
| `plan_product_id` | varchar | foreign | verified | The product whose pricing this plan determines. |
| `plan_trial_period_days` | bigint |  | verified | Default number of trial days when subscribing a customer to this plan using trial_from_plan=true. |
| `price_created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `price_currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `price_id` | varchar | foreign | verified | Unique identifier for the object. |
| `price_nickname` | varchar |  | verified | A brief description of the price, hidden from customers. |
| `price_product_id` | varchar | foreign | verified | The ID of the product this price is associated with. |
| `price_recurring_interval` | varchar |  | verified | The frequency at which a subscription is billed. One of day, week, month or year. Values: `day`, `week`, `month`, `year`. |
| `price_recurring_interval_count` | bigint |  | verified | The number of intervals (specified in the interval attribute) between subscription billings. For example, interval=month and interval_count=3 bills every 3 months. |
| `price_recurring_trial_period_days` | bigint |  | verified | Default number of trial days when subscribing a customer to this price using trial_from_plan=true. |
| `price_unit_amount` | bigint |  | verified | The unit amount in cents to be charged, represented as a whole integer if possible. Only set if billing_scheme=per_unit. |
| `quantity` | bigint |  | verified | The quantity of the plan to which the customer should be subscribed. |
| `subscription` | varchar |  | verified | The subscription this subscription_item belongs to. |

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
**Primary key:** `key, subscription_id, subscription_item_id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `subscription_id` | varchar | primary | verified |  |
| `subscription_item_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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
**Primary key:** `phase_id, price, schedule_id`

<details><summary>Columns (10, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `phase_id` | varchar | primary | verified |  |
| `price` | varchar | primary | verified |  |
| `schedule_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `period_end_timestamp` | bigint |  | verified |  |
| `period_end_type` | varchar |  | verified |  |
| `period_start_timestamp` | bigint |  | verified |  |
| `period_start_type` | varchar |  | verified |  |
| `quantity` | bigint |  | verified |  |

</details>

### `subscription_schedule_phase_configuration_items`

Priced items configured within a subscription schedule phase.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per item in a phase.  
**Primary key:** `phase_id, price, schedule_id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `phase_id` | varchar | primary | verified |  |
| `price` | varchar | primary | verified |  |
| `schedule_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_thresholds_usage_gte` | bigint |  | verified |  |
| `quantity` | bigint |  | verified | Quantity configured for the phase. |
| `trial_offer_id` | varchar | foreign | verified |  |

</details>

### `subscription_schedule_phases`

Individual phases of a subscription schedule.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per phase.  
**Primary key:** `id`

<details><summary>Columns (21, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the phase. |
| `application_fee_percent` | double |  | verified |  |
| `automatic_tax_enabled` | boolean |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_cycle_anchor` | varchar |  | verified |  |
| `billing_thresholds_amount_gte` | bigint |  | verified |  |
| `billing_thresholds_reset_billing_cycle_anchor` | boolean |  | verified |  |
| `collection_method` | varchar |  | verified |  |
| `coupon_id` | varchar | foreign | verified |  |
| `currency` | varchar |  | verified |  |
| `default_payment_method` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `end_date` | timestamp |  | verified | When the phase ends. |
| `invoice_settings_days_until_due` | double |  | verified |  |
| `on_behalf_of` | varchar |  | verified |  |
| `proration_behavior` | varchar |  | verified |  |
| `schedule_id` | varchar |  | verified |  |
| `start_date` | timestamp |  | verified | When the phase begins. |
| `transfer_data_amount_percent` | double |  | verified |  |
| `transfer_data_destination` | varchar |  | verified |  |
| `trial_end` | bigint |  | verified |  |

</details>

**Joins**

- `subscription_schedule_phases.coupon_id` → `coupons.id`

### `subscription_schedule_phases_metadata`

Metadata key/value pairs set on subscription_schedule_phases. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, phase_id, schedule_id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `phase_id` | varchar | primary | verified |  |
| `schedule_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select subscription_schedule_phas_id, map_agg(key, value) as md from subscription_schedule_phases_metadata group by 1

### `subscription_schedules`

Planned sequences of subscription phases, used for scheduled price or term changes.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per schedule.  
**Primary key:** `id`

<details><summary>Columns (26, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed sub_sched_. |
| `application_id` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_mode_type` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `completed_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the schedule was created (UTC). |
| `customer` | varchar |  | verified |  |
| `default_settings_application_fee_percent` | double |  | verified |  |
| `default_settings_automatic_tax_enabled` | boolean |  | verified |  |
| `default_settings_billing_cycle_anchor` | varchar |  | verified |  |
| `default_settings_collection_method` | varchar |  | verified |  |
| `default_settings_default_payment_method` | varchar |  | verified |  |
| `default_settings_default_source` | varchar |  | verified |  |
| `default_settings_description` | varchar |  | verified |  |
| `default_settings_invoice_settings_days_until_due` | double |  | verified |  |
| `default_settings_on_behalf_of` | varchar |  | verified |  |
| `default_settings_transfer_data_amount_percent` | double |  | verified |  |
| `default_settings_transfer_data_destination` | varchar |  | verified |  |
| `end_behavior` | varchar |  | verified |  |
| `proration_discounts` | varchar |  | verified |  |
| `released_at` | timestamp |  | verified |  |
| `released_subscription` | varchar |  | verified |  |
| `renewal_interval` | varchar |  | verified |  |
| `renewal_interval_length` | bigint |  | verified |  |
| `subscription` | varchar |  | verified |  |

</details>

### `subscription_schedules_metadata`

Metadata key/value pairs set on subscription_schedules. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, schedule_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `schedule_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select subscription_schedule_id, map_agg(key, value) as md from subscription_schedules_metadata group by 1

### `subscriptions`

One row per Subscription object. The primary Billing table alongside invoices.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per subscription, including canceled ones.  
**Primary key:** `id`

<details><summary>Columns (93, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `application_fee_percent` | double |  | verified | A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account. |
| `application_id` | varchar |  | verified | ID of the Connect Application that created the subscription. |
| `automatic_tax_enabled` | boolean |  | verified | Whether Stripe automatically computes tax on this subscription. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `billing` | varchar |  | verified | Either charge_automatically, or send_invoice. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions and mark the subscription as active. Values: `charge_automatically`, `send_invoice`. |
| `billing_cycle_anchor` | timestamp |  | verified | The reference point that aligns future billing cycle dates. It sets the day of week for week intervals, the day of month for month and year intervals, and the month of year for year intervals. The timestamp is in UTC format. |
| `billing_mode_type` | varchar |  | verified | Controls how prorations and invoices for subscriptions are calculated and orchestrated. |
| `billing_mode_updated_at` | timestamp |  | verified | Details on when the current billing_mode was adopted. |
| `billing_thresholds_amount_gte` | bigint |  | verified | Monetary threshold that triggers the subscription to create an invoice |
| `billing_thresholds_reset_billing_cycle_anchor` | boolean |  | verified | Indicates if the billing_cycle_anchor should be reset when a threshold is reached. If true, billing_cycle_anchor will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged. This value may not be true if the subscription contains items with plans that have aggregate_usage=last_ever. |
| `cancel_at` | timestamp |  | verified | A date in the future at which the subscription will automatically get canceled |
| `cancel_at_period_end` | boolean |  | verified | Whether this subscription will (if status=active) or did (if status=canceled) cancel at the end of the current billing period. |
| `canceled_at` | timestamp |  | verified | If the subscription has been canceled, the date of that cancellation. If the subscription was canceled with cancel_at_period_end, canceled_at will reflect the time of the most recent update request, not the end of the subscription period when the subscription is automatically moved to a canceled state. |
| `cancellation_details_comment` | varchar |  | verified | Additional comments about why the user canceled the subscription, if the subscription was canceled explicitly by the user. |
| `cancellation_details_feedback` | varchar |  | verified | The customer submitted reason for why they canceled, if the subscription was canceled explicitly by the user. |
| `cancellation_details_reason` | varchar |  | verified | Why this subscription was canceled. |
| `cancellation_reason` | varchar |  | verified | One of the preconfigured cancellation reasons selected by the customer. |
| `cancellation_reason_text` | varchar |  | verified | The customer provided reason for cancelling the subscription. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `current_period_end` | timestamp |  | verified | End of the current period that the subscription has been invoiced for. At the end of this period, a new invoice will be created. This field is deprecated starting on the 2025-03-31.basil version, please use current_period_end on the items[] field instead |
| `current_period_start` | timestamp |  | verified | Start of the current period that the subscription has been invoiced for. This field is deprecated starting on the 2025-03-31.basil version, please use current_period_start on the items[] field instead |
| `customer_id` | varchar | foreign | verified | ID of the customer who owns the subscription. |
| `days_until_due` | bigint |  | verified | Number of days a customer has to pay invoices generated by this subscription. This value will be null for subscriptions where collection_method=charge_automatically. |
| `default_payment_method_id` | varchar | foreign | verified | ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. This takes precedence over default_source. If neither are set, invoices will use the customer's invoice_settings.default_payment_method or default_source. |
| `default_source_id` | varchar | foreign | verified | ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If default_payment_method is also set, default_payment_method will take precedence. If neither are set, invoices will use the customer's invoice_settings.default_payment_method or default_source. |
| `description` | varchar |  | verified | The subscription's description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces and certain local payment methods UIs. |
| `discount_checkout_session` | varchar |  | verified | The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Not present for subscription mode. |
| `discount_coupon_id` | varchar | foreign | verified | Unique identifier for the object. |
| `discount_customer_id` | varchar | foreign | verified | The ID of the customer associated with this discount. |
| `discount_end` | timestamp |  | verified | If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null. |
| `discount_invoice` | varchar |  | verified | The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice. |
| `discount_invoice_item` | varchar |  | verified | The invoice item id (or invoice line item id for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item. |
| `discount_promotion_code_id` | varchar |  | verified | The promotion code applied to create this discount. |
| `discount_schedule_id` | varchar | foreign | verified | The subscription schedule that this coupon is applied to, if it is applied to a particular subscription schedule. |
| `discount_start` | timestamp |  | verified | Date that the coupon was applied. |
| `discount_subscription` | varchar |  | verified | The subscription that this coupon is applied to, if it is applied to a particular subscription. |
| `discount_subscription_item` | varchar |  | verified | The subscription item that this coupon is applied to, if it is applied to a particular subscription item. |
| `discounts` | varchar |  | verified | The discounts applied to the subscription. Subscription item discounts are applied before subscription discounts. Use expand[]=discounts to expand each discount. |
| `ended_at` | timestamp |  | verified | If the subscription has ended, the date the subscription ended. |
| `latest_invoice_id` | varchar | foreign | verified | The most recent invoice this subscription has generated over its lifecycle (for example, when it cycles or is updated). |
| `managed_payments_enabled` | boolean |  | verified | Whether Managed Payments is enabled for this subscription. |
| `next_pending_invoice_item_invoice` | timestamp |  | verified | Specifies the approximate timestamp on which any pending invoice items will be billed according to the schedule provided at pending_invoice_item_interval. |
| `on_behalf_of_id` | varchar | foreign | verified | The account (if any) the charge was made on behalf of for charges associated with this subscription. See the Connect documentation for details. |
| `pause_collection_behavior` | varchar |  | verified | The payment collection behavior for this subscription while paused. |
| `pause_collection_resumes_at` | timestamp |  | verified | The time after which the subscription will resume collecting payments. |
| `payment_settings_payment_method_options_acss_debit_mandate_options_transaction_type` | varchar |  | verified | Transaction type of the mandate. |
| `payment_settings_payment_method_options_acss_debit_verification_method` | varchar |  | verified | Bank account verification method. The default value is automatic. |
| `payment_settings_payment_method_options_bancontact_preferred_language` | varchar |  | verified | Preferred language of the Bancontact authorization page that the customer is redirected to. |
| `payment_settings_payment_method_options_card_mandate_options_amount` | bigint |  | verified | Amount to be charged for future payments, specified in the presentment currency. |
| `payment_settings_payment_method_options_card_mandate_options_amount_type` | varchar |  | verified | One of fixed or maximum. If fixed, the amount param refers to the exact amount to be charged in future payments. If maximum, the amount charged can be up to the value passed for the amount param. Values: `fixed`, `maximum`. |
| `payment_settings_payment_method_options_card_mandate_options_description` | varchar |  | verified | A description of the mandate or subscription that is meant to be displayed to the customer. |
| `payment_settings_payment_method_options_card_network` | varchar |  | verified | Selected network to process this Subscription on. Depends on the available networks of the card attached to the Subscription. Can be only set confirm-time. |
| `payment_settings_payment_method_options_card_request_three_d_secure` | varchar |  | verified | We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine. |
| `payment_settings_payment_method_options_customer_balance_bank_transfer_eu_bank_transfer_country` | varchar |  | verified | The desired country code of the bank account information. Permitted values include: DE, FR, IE, or NL. |
| `payment_settings_payment_method_options_customer_balance_bank_transfer_id_bank_transfer_bank` | varchar |  | verified | The bank where the account is held. |
| `payment_settings_payment_method_options_customer_balance_bank_transfer_type` | varchar |  | verified | The bank transfer type that can be used for funding. Permitted values include: eu_bank_transfer, gb_bank_transfer, jp_bank_transfer, mx_bank_transfer, or us_bank_transfer. |
| `payment_settings_payment_method_options_customer_balance_funding_type` | varchar |  | verified | The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: bank_transfer. |
| `payment_settings_payment_method_options_us_bank_account_verification_method` | varchar |  | verified | Bank account verification method. The default value is automatic. |
| `payment_settings_save_default_payment_method` | varchar |  | verified | Configure whether Stripe updates subscription.default_payment_method when payment succeeds. Defaults to off. |
| `pending_invoice_item_interval` | varchar |  | verified | Specifies invoicing frequency. Either day, week, month or year. Values: `day`, `week`, `month`, `year`. |
| `pending_invoice_item_interval_count` | bigint |  | verified | The number of intervals between invoices. For example, interval=month and interval_count=3 bills every 3 months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks). |
| `pending_setup_intent_id` | varchar | foreign | verified | You can use this SetupIntent to collect user authentication when creating a subscription without immediate payment or updating a subscription's payment method, allowing you to optimize for off-session payments. Learn more in the SCA Migration Guide. |
| `pending_update_billing_cycle_anchor` | timestamp |  | verified | If the update is applied, determines the date of the first full invoice, and, for plans with month or year intervals, the day of the month for subsequent invoices. The timestamp is in UTC format. |
| `pending_update_discount_checkout_session` | varchar |  | verified | The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Not present for subscription mode. |
| `pending_update_discount_coupon_id` | varchar | foreign | verified | Unique identifier for the object. |
| `pending_update_discount_customer_id` | varchar | foreign | verified | The ID of the customer associated with this discount. |
| `pending_update_discount_end` | timestamp |  | verified | If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null. |
| `pending_update_discount_invoice` | varchar |  | verified | The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice. |
| `pending_update_discount_invoice_item` | varchar |  | verified | The invoice item id (or invoice line item id for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item. |
| `pending_update_discount_promotion_code_id` | varchar |  | verified | The promotion code applied to create this discount. |
| `pending_update_discount_schedule_id` | varchar | foreign | verified | The subscription schedule that this coupon is applied to, if it is applied to a particular subscription schedule. |
| `pending_update_discount_start` | timestamp |  | verified | Date that the coupon was applied. |
| `pending_update_discount_subscription` | varchar |  | verified | The subscription that this coupon is applied to, if it is applied to a particular subscription. |
| `pending_update_discount_subscription_item` | varchar |  | verified | The subscription item that this coupon is applied to, if it is applied to a particular subscription item. |
| `pending_update_expires_at` | timestamp |  | verified | The point after which the changes reflected by this update will be discarded and no longer applied. |
| `pending_update_trial_end` | timestamp |  | verified | Unix timestamp representing the end of the trial period the customer will get before being charged for the first time, if the update is applied. |
| `pending_update_trial_from_plan` | boolean |  | verified | Indicates if a plan's trial_period_days should be applied to the subscription. Setting trial_end per subscription is preferred, and this defaults to false. Setting this flag to true together with trial_end is not allowed. See Using trial periods on subscriptions to learn more. |
| `plan_id` | varchar | foreign | verified | Reference to the plan the customer is subscribed to. Only set if the subscription contains a single plan. |
| `price_id` | varchar | foreign | verified | Reference to the price the customer is subscribed to. Only set if the subscription contains a single price. |
| `proration_discounts` | varchar |  | verified | Controls how invoices and invoice items display proration amounts and discount amounts. itemized means that amounts are gross and discount amounts are accurate; included means that amounts are net and discount amounts are zero. This field is only populated for billing_mode=flexible subscriptions. |
| `quantity` | bigint |  | verified | The quantity of the plan to which the customer is subscribed. For example, if your plan is $10/user/month, and your customer has 5 users, you could pass 5 as the quantity to have the customer charged $50 (5 x $10) monthly. Only set if the subscription contains a single plan. |
| `schedule_id` | varchar | foreign | verified | The schedule attached to the subscription |
| `start` | timestamp |  | verified | This keeps track of how long the current plan configuration is active. May be different from start_date. The value of start is updated anytime that trial_end is updated (either to now or a different value that was previously set) even if no trial is being ended. |
| `start_date` | timestamp |  | verified | The backdated start date or initial created date. |
| `status` | varchar |  | verified | Possible values are incomplete, incomplete_expired, trialing, active, past_due, canceled, unpaid, or paused.

For collection_method=charge_automatically a subscription moves into incomplete if the initial payment attempt fails. A subscription in this status can only have metadata and default_source updated. Once the first invoice is paid, the subscription moves into an active status. If the first invoice is not paid within 23 hours, the subscription transitions to incomplete_expired. This is a terminal status, the open invoice will be voided and no further invoices will be generated.

A subscription that is currently in a trial period is trialing and moves to active when the trial period is over.

A subscription can only enter a paused status when a trial ends without a payment method. A paused subscription doesn't generate invoices and can be resumed after your customer adds their payment method. The paused status is different from pausing collection, which still generates invoices and leaves the subscription's status unchanged.

If subscription collection_method=charge_automatically, it becomes past_due when payment is required but cannot be paid (due to failed payment or awaiting additional user actions). Once Stripe has exhausted all payment retry attempts, the subscription will become canceled or unpaid (depending on your subscriptions settings).

If subscription collection_method=send_invoice it becomes past_due when its invoice is not paid by the due date, and canceled or unpaid if it is still not paid by an additional deadline after that. Note that when a subscription has a status of unpaid, no subsequent invoices will be attempted (invoices will be created, but then immediately automatically closed). After receiving updated payment information from a customer, you may choose to reopen and pay their closed invoices. Values: `incomplete`, `incomplete_expired`, `trialing`, `active`, `past_due`, `canceled`, `unpaid`, `paused`. |
| `status_details` | varchar |  | verified | Details on the subscription status. JSON object present when status is paused. Contains paused.transitioned_at (Unix timestamp), paused.type, and paused.subscription.type. |
| `tax_percent` | double |  | verified | If provided, each invoice created by this subscription will apply the tax rate, increasing the amount billed to the customer. |
| `transfer_data_amount_percent` | double |  | verified | A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the destination account. By default, the entire amount is transferred to the destination. |
| `transfer_data_destination_id` | varchar | foreign | verified | The account where funds from the payment will be transferred to upon payment success. |
| `trial_end` | timestamp |  | verified | If the subscription has a trial, the end of that trial. |
| `trial_settings_end_behavior_missing_payment_method` | varchar |  | verified | Indicates how the subscription should change when the trial ends if the user did not provide a payment method. |
| `trial_start` | timestamp |  | verified | If the subscription has a trial, the beginning of that trial. |

</details>

**Joins**

- `subscriptions.customer_id` → `customers.id`
- `subscriptions.price_id` → `prices.id`
- `subscriptions.plan_id` → `plans.id`

> discounts is a comma-separated string, not an array. Unnest it: cross join unnest(split(discounts, ',')) as t(discount_id).

> For MRR and churn, use subscription_item_change_events rather than deriving from status transitions.

### `subscriptions_metadata`

Metadata key/value pairs set on subscriptions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `subscription_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed txr_. |
| `active` | boolean |  | verified | Whether the rate can still be applied. |
| `batch_timestamp` | timestamp |  | verified |  |
| `country` | varchar |  | verified | Two-letter ISO country the rate applies to. |
| `created` | timestamp |  | verified | When the rate was created (UTC). |
| `description` | varchar |  | verified |  |
| `display_name` | varchar |  | verified | Name shown to customers, e.g. VAT. |
| `effective_percentage` | double |  | verified |  |
| `inclusive` | boolean |  | verified | Whether the rate is included in the price. |
| `jurisdiction` | varchar |  | verified | Jurisdiction label for the rate. |
| `jurisdiction_level` | varchar |  | verified |  |
| `percentage` | double |  | verified | Rate as a percentage. |
| `state` | varchar |  | verified |  |
| `tax_type` | varchar |  | verified |  |

</details>

### `tax_rates_metadata`

Metadata key/value pairs set on tax_rates. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `tax_rate_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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
**Primary key:** `id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `quantity` | bigint |  | verified | Reported usage quantity. |
| `subscription_item` | varchar |  | verified |  |
| `timestamp` | timestamp |  | verified | When the usage occurred. |

</details>

## capital

### `financing_balances`

Outstanding Stripe Capital loan balances over time.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per balance snapshot.  
**Primary key:** `id`

<details><summary>Columns (10, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `account_id` | varchar | foreign | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `effective_date_utc` | timestamp |  | verified |  |
| `financing_offer` | varchar |  | verified |  |
| `overdue_payment_amount` | bigint |  | verified |  |
| `pending_payment_amount` | bigint |  | verified |  |
| `premium_outstanding_amount` | bigint |  | verified |  |
| `principal_outstanding_amount` | bigint |  | verified |  |

</details>

**Joins**

- `financing_balances.account_id` → `accounts.id`

### `financing_offers`

Stripe Capital financing offers extended to you or your connected accounts.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per financing offer.  
**Primary key:** `id`

<details><summary>Columns (39, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the offer. |
| `accepted_advance_amount` | bigint |  | verified |  |
| `accepted_at` | timestamp |  | verified |  |
| `accepted_premium_amount` | bigint |  | verified |  |
| `accepted_terms_repayment_interval_configuration_duration_days` | bigint |  | verified |  |
| `accepted_terms_repayment_interval_configuration_maximum_amount` | bigint |  | verified |  |
| `accepted_terms_repayment_interval_configuration_minimum_amount` | bigint |  | verified |  |
| `accepted_terms_target_payback_days` | bigint |  | verified |  |
| `accepted_withhold_rate` | double |  | verified |  |
| `account_id` | varchar | foreign | verified | Account the offer was made to. |
| `batch_timestamp` | timestamp |  | verified |  |
| `campaign_type` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `charged_off_at` | timestamp |  | verified |  |
| `created_at` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `expires_at` | timestamp |  | verified |  |
| `financing_application_status_transitions_accepted_at` | timestamp |  | verified |  |
| `financing_application_status_transitions_initiated_at` | timestamp |  | verified |  |
| `financing_type` | varchar |  | verified |  |
| `fully_repaid_at` | timestamp |  | verified |  |
| `is_first_time_offer` | boolean |  | verified |  |
| `max_advance_amount` | bigint |  | verified |  |
| `max_premium_amount` | bigint |  | verified |  |
| `max_withhold_rate` | double |  | verified |  |
| `metadata` | varchar |  | verified |  |
| `offered_terms_repayment_interval_configuration_duration_days` | bigint |  | verified |  |
| `offered_terms_repayment_interval_configuration_maximum_amount` | bigint |  | verified |  |
| `offered_terms_repayment_interval_configuration_minimum_amount` | bigint |  | verified |  |
| `offered_terms_target_payback_days` | bigint |  | verified |  |
| `paid_out_at` | timestamp |  | verified |  |
| `previous_financing_fee_discount_amount` | bigint |  | verified |  |
| `previous_financing_fee_discount_rate` | double |  | verified |  |
| `product_type` | varchar |  | verified |  |
| `rejected_at` | timestamp |  | verified |  |
| `replacement_for` | varchar |  | verified |  |
| `replacement_type` | varchar |  | verified |  |
| `revshare_earned_amount` | bigint |  | verified |  |
| `state` | varchar |  | verified |  |

</details>

**Joins**

- `financing_offers.account_id` → `accounts.id`

### `financing_transactions`

Repayments and drawdowns against Stripe Capital financing.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per financing transaction.  
**Primary key:** `id`

<details><summary>Columns (15, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the transaction. |
| `advance_amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `description` | varchar |  | verified |  |
| `effective_time` | timestamp |  | verified |  |
| `fee_amount` | bigint |  | verified |  |
| `financing_offer` | varchar |  | verified |  |
| `legacy_balance_transaction_source` | varchar |  | verified |  |
| `linked_withholdable_object_id` | varchar |  | verified |  |
| `linked_withholdable_object_type` | varchar |  | verified |  |
| `reason` | varchar |  | verified |  |
| `reversed_transaction` | varchar |  | verified |  |
| `total_amount` | bigint |  | verified |  |
| `transaction_type` | varchar |  | verified |  |

</details>

## checkout

### `checkout_custom_fields`

Values customers entered into custom fields you configured on a Checkout session.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (session, custom field).  
**Primary key:** `checkout_session_id, id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `checkout_session_id` | varchar | primary | verified | Session the field belongs to. |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `key` | varchar |  | verified | Custom field key. |
| `optional` | boolean |  | verified |  |
| `type` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

**Joins**

- `checkout_custom_fields.checkout_session_id` → `checkout_sessions.id`

### `checkout_line_items`

Line items on a Checkout session.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per line item on a session.  
**Primary key:** `id`

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the line item. |
| `batch_timestamp` | timestamp |  | verified |  |
| `checkout_session_id` | varchar | foreign | verified | Parent Checkout session. |
| `created` | timestamp |  | verified |  |
| `description` | varchar |  | verified |  |
| `price_id` | varchar | foreign | verified | Price on the line item. |
| `product_id` | varchar | foreign | verified |  |
| `quantity` | bigint |  | verified | Quantity purchased. |

</details>

**Joins**

- `checkout_line_items.checkout_session_id` → `checkout_sessions.id`
- `checkout_line_items.price_id` → `prices.id`
- `checkout_line_items.product_id` → `products.id`

### `checkout_sessions`

Stripe Checkout sessions, including abandoned ones. The table to use for hosted-checkout conversion analysis.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per Checkout session.  
**Primary key:** `id`

<details><summary>Columns (18, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `client_reference_id` | varchar |  | verified | The client reference id of the payment page |
| `consent_promotions` | varchar |  | verified | The value of promotions consent. If opt_in, the customer consents to receiving promotional communications from the merchant about this Checkout Session |
| `consent_terms_of_service` | varchar |  | verified | The value of terms of service consent. If accepted, the customer in this Checkout Session has agreed to the merchant’s terms of service. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. |
| `customer_id` | varchar | foreign | verified | The ID of the customer for this Session. |
| `invoice_id` | varchar | foreign | verified | ID of the invoice created by the Checkout Session, if it exists. |
| `managed_payments_enabled` | boolean |  | verified | Whether Managed Payments is enabled for this checkout session. |
| `mode` | varchar |  | verified | The mode of the Checkout Session. One of payment, setup, or subscription Values: `payment`, `setup`, `subscription`. |
| `payment_intent_id` | varchar | foreign | verified | The PaymentIntent ID associated with this Checkout session |
| `payment_link_id` | varchar | foreign | verified | The payment link ID associated with this Checkout session |
| `shipping_cost_amount_subtotal` | bigint |  | verified | Total shipping cost before any discounts or taxes are applied, in minor units |
| `shipping_cost_amount_tax` | bigint |  | verified | Total tax amount applied due to shipping costs, in minor units. If no tax was applied, defaults to 0 |
| `shipping_cost_amount_total` | bigint |  | verified | Total shipping cost after discounts and taxes are applied, in minor units |
| `status` | varchar |  | verified | The status of the Checkout Session, either complete or expired. Values: `complete`, `expired`. |
| `subscription_id` | varchar | foreign | verified | The ID of the subscription for Checkout Sessions in subscription mode |

</details>

**Joins**

- `checkout_sessions.customer_id` → `customers.id`
- `checkout_sessions.payment_intent_id` → `payment_intents.id`
- `checkout_sessions.payment_link_id` → `payment_links.id`
- `checkout_sessions.invoice_id` → `invoices.id`
- `checkout_sessions.subscription_id` → `subscriptions.id`

> status = 'expired' identifies abandoned checkouts — the denominator for conversion rate.

### `payment_links`

Reusable shareable links that open a Checkout session.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per payment link.  
**Primary key:** `id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed plink_. |
| `active` | boolean |  | verified | Whether the link still accepts payments. |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the link was created (UTC). |

</details>

## connect

### `accounts`

Your own account and, for Connect platforms, your connected accounts.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per account.  
**Primary key:** `id`

<details><summary>Columns (149, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed acct_. |
| `batch_timestamp` | timestamp |  | verified |  |
| `business_name` | varchar |  | verified | Business name on the account. |
| `business_profile_mcc` | varchar |  | verified |  |
| `business_url` | varchar |  | verified |  |
| `capabilities_acss_debit_payments` | varchar |  | verified |  |
| `capabilities_affirm_payments` | varchar |  | verified |  |
| `capabilities_afterpay_clearpay_payments` | varchar |  | verified |  |
| `capabilities_amazon_pay_payments` | varchar |  | verified |  |
| `capabilities_au_becs_debit_payments` | varchar |  | verified |  |
| `capabilities_bacs_debit_payments` | varchar |  | verified |  |
| `capabilities_bancontact_payments` | varchar |  | verified |  |
| `capabilities_bank_transfer_payments` | varchar |  | verified |  |
| `capabilities_blik_payments` | varchar |  | verified |  |
| `capabilities_boleto_payments` | varchar |  | verified |  |
| `capabilities_card_issuing` | varchar |  | verified |  |
| `capabilities_card_payments` | varchar |  | verified |  |
| `capabilities_cartes_bancaires_payments` | varchar |  | verified |  |
| `capabilities_cashapp_payments` | varchar |  | verified |  |
| `capabilities_eps_payments` | varchar |  | verified |  |
| `capabilities_fpx_payments` | varchar |  | verified |  |
| `capabilities_giropay_payments` | varchar |  | verified |  |
| `capabilities_grabpay_payments` | varchar |  | verified |  |
| `capabilities_ideal_payments` | varchar |  | verified |  |
| `capabilities_india_international_payments` | varchar |  | verified |  |
| `capabilities_jcb_payments` | varchar |  | verified |  |
| `capabilities_klarna_payments` | varchar |  | verified |  |
| `capabilities_konbini_payments` | varchar |  | verified |  |
| `capabilities_legacy_payments` | varchar |  | verified |  |
| `capabilities_link_payments` | varchar |  | verified |  |
| `capabilities_mobilepay_payments` | varchar |  | verified |  |
| `capabilities_multibanco_payments` | varchar |  | verified |  |
| `capabilities_oxxo_payments` | varchar |  | verified |  |
| `capabilities_p24_payments` | varchar |  | verified |  |
| `capabilities_paynow_payments` | varchar |  | verified |  |
| `capabilities_promptpay_payments` | varchar |  | verified |  |
| `capabilities_revolut_pay_payments` | varchar |  | verified |  |
| `capabilities_sepa_debit_payments` | varchar |  | verified |  |
| `capabilities_sofort_payments` | varchar |  | verified |  |
| `capabilities_swish_payments` | varchar |  | verified |  |
| `capabilities_tax_reporting_us_1099_k` | varchar |  | verified |  |
| `capabilities_tax_reporting_us_1099_misc` | varchar |  | verified |  |
| `capabilities_transfers` | varchar |  | verified |  |
| `capabilities_twint_payments` | varchar |  | verified |  |
| `capabilities_us_bank_account_ach_payments` | varchar |  | verified |  |
| `capabilities_zip_payments` | varchar |  | verified |  |
| `charges_enabled` | boolean |  | verified | Whether the account can create charges. |
| `controller_fees_payer` | varchar |  | verified |  |
| `controller_losses_payments` | varchar |  | verified |  |
| `controller_requirement_collection` | varchar |  | verified |  |
| `controller_stripe_dashboard_type` | varchar |  | verified |  |
| `country` | varchar |  | verified | Two-letter ISO country of the account. |
| `created` | timestamp |  | verified | When the account was created (UTC). |
| `debit_negative_balances` | boolean |  | verified |  |
| `decline_charge_on_avs_failure` | boolean |  | verified |  |
| `decline_charge_on_cvc_failure` | boolean |  | verified |  |
| `default_currency` | varchar |  | verified | Account's default currency. Commonly used as the reporting currency when converting multi-currency figures. |
| `details_submitted` | boolean |  | verified |  |
| `display_name` | varchar |  | verified |  |
| `email` | varchar |  | verified | Account email address. |
| `future_requirements_current_deadline` | timestamp |  | verified |  |
| `future_requirements_currently_due` | varchar |  | verified |  |
| `future_requirements_eventually_due` | varchar |  | verified |  |
| `future_requirements_past_due` | varchar |  | verified |  |
| `future_requirements_pending_verification` | varchar |  | verified |  |
| `legal_entity_address_city` | varchar |  | verified |  |
| `legal_entity_address_country` | varchar |  | verified |  |
| `legal_entity_address_kana_city` | varchar |  | verified |  |
| `legal_entity_address_kana_country` | varchar |  | verified |  |
| `legal_entity_address_kana_line1` | varchar |  | verified |  |
| `legal_entity_address_kana_line2` | varchar |  | verified |  |
| `legal_entity_address_kana_postal_code` | varchar |  | verified |  |
| `legal_entity_address_kana_state` | varchar |  | verified |  |
| `legal_entity_address_kanji_city` | varchar |  | verified |  |
| `legal_entity_address_kanji_country` | varchar |  | verified |  |
| `legal_entity_address_kanji_line1` | varchar |  | verified |  |
| `legal_entity_address_kanji_line2` | varchar |  | verified |  |
| `legal_entity_address_kanji_postal_code` | varchar |  | verified |  |
| `legal_entity_address_kanji_state` | varchar |  | verified |  |
| `legal_entity_address_line1` | varchar |  | verified |  |
| `legal_entity_address_line2` | varchar |  | verified |  |
| `legal_entity_address_postal_code` | varchar |  | verified |  |
| `legal_entity_address_state` | varchar |  | verified |  |
| `legal_entity_business_name` | varchar |  | verified |  |
| `legal_entity_business_name_kana` | varchar |  | verified |  |
| `legal_entity_business_name_kanji` | varchar |  | verified |  |
| `legal_entity_business_tax_id_provided` | boolean |  | verified |  |
| `legal_entity_business_vat_id_provided` | boolean |  | verified |  |
| `legal_entity_dob_day` | bigint |  | verified |  |
| `legal_entity_dob_month` | bigint |  | verified |  |
| `legal_entity_dob_year` | bigint |  | verified |  |
| `legal_entity_first_name` | varchar |  | verified |  |
| `legal_entity_first_name_kana` | varchar |  | verified |  |
| `legal_entity_first_name_kanji` | varchar |  | verified |  |
| `legal_entity_gender` | varchar |  | verified |  |
| `legal_entity_last_name` | varchar |  | verified |  |
| `legal_entity_last_name_kana` | varchar |  | verified |  |
| `legal_entity_last_name_kanji` | varchar |  | verified |  |
| `legal_entity_maiden_name` | varchar |  | verified |  |
| `legal_entity_personal_address_city` | varchar |  | verified |  |
| `legal_entity_personal_address_country` | varchar |  | verified |  |
| `legal_entity_personal_address_kana_city` | varchar |  | verified |  |
| `legal_entity_personal_address_kana_country` | varchar |  | verified |  |
| `legal_entity_personal_address_kana_line1` | varchar |  | verified |  |
| `legal_entity_personal_address_kana_line2` | varchar |  | verified |  |
| `legal_entity_personal_address_kana_postal_code` | varchar |  | verified |  |
| `legal_entity_personal_address_kana_state` | varchar |  | verified |  |
| `legal_entity_personal_address_kanji_city` | varchar |  | verified |  |
| `legal_entity_personal_address_kanji_country` | varchar |  | verified |  |
| `legal_entity_personal_address_kanji_line1` | varchar |  | verified |  |
| `legal_entity_personal_address_kanji_line2` | varchar |  | verified |  |
| `legal_entity_personal_address_kanji_postal_code` | varchar |  | verified |  |
| `legal_entity_personal_address_kanji_state` | varchar |  | verified |  |
| `legal_entity_personal_address_line1` | varchar |  | verified |  |
| `legal_entity_personal_address_line2` | varchar |  | verified |  |
| `legal_entity_personal_address_postal_code` | varchar |  | verified |  |
| `legal_entity_personal_address_state` | varchar |  | verified |  |
| `legal_entity_personal_id_number_provided` | boolean |  | verified |  |
| `legal_entity_phone_number` | varchar |  | verified |  |
| `legal_entity_ssn_last_4_provided` | boolean |  | verified |  |
| `legal_entity_tax_id_registrar` | varchar |  | verified |  |
| `legal_entity_type` | varchar |  | verified |  |
| `legal_entity_verification_details` | varchar |  | verified |  |
| `legal_entity_verification_details_code` | varchar |  | verified |  |
| `legal_entity_verification_document_id` | varchar |  | verified |  |
| `legal_entity_verification_status` | varchar |  | verified |  |
| `payout_schedule_delay_days` | bigint |  | verified |  |
| `payout_schedule_interval` | varchar |  | verified |  |
| `payout_schedule_monthly_anchor` | bigint |  | verified |  |
| `payout_schedule_weekly_anchor` | varchar |  | verified |  |
| `payout_statement_descriptor` | varchar |  | verified |  |
| `payouts_enabled` | boolean |  | verified | Whether the account can receive payouts. |
| `product_description` | varchar |  | verified |  |
| `requirements_current_deadline` | timestamp |  | verified |  |
| `requirements_currently_due` | varchar |  | verified |  |
| `requirements_eventually_due` | varchar |  | verified |  |
| `requirements_past_due` | varchar |  | verified |  |
| `requirements_pending_verification` | varchar |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `support_email` | varchar |  | verified |  |
| `support_phone` | varchar |  | verified |  |
| `timezone` | varchar |  | verified |  |
| `tos_acceptance_date` | timestamp |  | verified |  |
| `tos_acceptance_ip` | varchar |  | verified |  |
| `tos_acceptance_user_agent` | varchar |  | verified |  |
| `type` | varchar |  | verified | Connect account type. Values: `standard`, `express`, `custom`, `none`. |
| `verification_disabled_reason` | varchar |  | verified |  |
| `verification_due_by` | timestamp |  | verified |  |
| `verification_fields_needed` | varchar |  | verified |  |

</details>

> Connect platforms also have a connected_accounts table with richer onboarding and requirements detail.

### `accounts_metadata`

Metadata key/value pairs set on accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed fr_. |
| `amount` | bigint |  | verified | Refunded amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | verified | Balance transaction recording the refund. |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the refund was created (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `fee_id` | varchar | foreign | verified | Application fee being refunded. |

</details>

**Joins**

- `application_fee_refunds.fee_id` → `application_fees.id`
- `application_fee_refunds.balance_transaction_id` → `balance_transactions.id`

### `application_fee_refunds_metadata`

Metadata key/value pairs set on application_fee_refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `application_fee_refund_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed fee_. |
| `account_id` | varchar | foreign | verified | Connected account the fee was collected from. |
| `amount` | bigint |  | verified | Fee amount in minor currency units. |
| `amount_refunded` | bigint |  | verified |  |
| `application_id` | varchar |  | verified |  |
| `balance_transaction_id` | varchar | foreign | verified | Balance transaction recording the fee. |
| `batch_timestamp` | timestamp |  | verified |  |
| `charge_id` | varchar | foreign | verified | Charge that generated the fee. |
| `created` | timestamp |  | verified | When the fee was created (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `fee_source_id` | varchar |  | verified |  |
| `fee_source_type` | varchar |  | verified |  |
| `originating_transaction_id` | varchar | foreign | verified |  |
| `refunded` | boolean |  | verified | Whether the fee was fully refunded. |

</details>

**Joins**

- `application_fees.charge_id` → `charges.id`
- `application_fees.balance_transaction_id` → `balance_transactions.id`
- `application_fees.account_id` → `accounts.id`

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
| `outcome_rule_id` | varchar | foreign | documented | Radar rule that produced the outcome. Joins to radar_rules.rule_id. |
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

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the session. |
| `batch_timestamp` | timestamp |  | verified |  |
| `consumer_permissible_transaction_amount_tier` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the session was created (UTC). |
| `destination_amount` | double |  | verified |  |
| `destination_currency` | varchar |  | verified |  |
| `error_reason` | varchar |  | verified |  |
| `kyc_level` | varchar |  | verified |  |
| `network` | varchar |  | verified |  |
| `provided_wallet_address` | varchar |  | verified |  |
| `source_amount` | double |  | verified |  |
| `source_currency` | varchar |  | verified |  |
| `state` | varchar |  | verified |  |
| `updated` | timestamp |  | verified |  |

</details>

## customers

### `customer_balance_transactions`

Changes to a customer's account credit balance.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per customer balance transaction.  
**Primary key:** `id`

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed cbtxn_. |
| `account_id` | varchar |  | verified |  |
| `amount` | bigint |  | verified | Signed change in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `checkout_session_id` | varchar | foreign | verified |  |
| `created` | timestamp |  | verified | When the transaction occurred (UTC). |
| `credit_note_id` | varchar | foreign | verified |  |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `customer_id` | varchar | foreign | verified | Customer whose balance changed. |
| `description` | varchar |  | verified |  |
| `ending_balance` | bigint |  | verified |  |
| `invoice_id` | varchar | foreign | verified | Invoice the change relates to, if any. |
| `merchant_balance_adjustment_id` | varchar |  | verified |  |
| `previous` | varchar |  | verified |  |
| `source_id` | varchar |  | verified |  |
| `type` | varchar |  | verified | Kind of balance change. |

</details>

**Joins**

- `customer_balance_transactions.customer_id` → `customers.id`
- `customer_balance_transactions.checkout_session_id` → `checkout_sessions.id`
- `customer_balance_transactions.credit_note_id` → `credit_notes.id`
- `customer_balance_transactions.invoice_id` → `invoices.id`

### `customer_balance_transactions_metadata`

Metadata key/value pairs set on customer_balance_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `customer_balance_transaction_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `customer_balance_transaction_id` | varchar | primary | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (15, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the transaction. |
| `amount` | double |  | verified |  |
| `amount_currency` | varchar |  | verified |  |
| `applied_to_payment_intent` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the transaction occurred (UTC). |
| `customer` | varchar |  | verified |  |
| `ending_balance` | double |  | verified |  |
| `ending_balance_currency` | varchar |  | verified |  |
| `funded_reference` | varchar |  | verified |  |
| `linked_model_id` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `refund_from` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |
| `unapplied_from_payment_intent` | varchar |  | verified |  |

</details>

### `customer_tax_ids`

Tax identifiers stored against a customer.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (customer, tax id).  
**Primary key:** `id`

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed txi_. |
| `batch_timestamp` | timestamp |  | verified |  |
| `country` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `customer` | varchar |  | verified |  |
| `owner_account` | varchar |  | verified |  |
| `owner_application` | varchar |  | verified |  |
| `owner_customer` | varchar |  | verified |  |
| `owner_type` | varchar |  | verified |  |
| `type` | varchar |  | verified | Tax id type, e.g. eu_vat, us_ein. |
| `value` | varchar |  | verified | The tax identifier itself. |
| `verification_status` | varchar |  | verified |  |
| `verification_verified_address` | varchar |  | verified |  |
| `verification_verified_name` | varchar |  | verified |  |

</details>

### `customers`

One row per Customer object.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per customer, including deleted ones.  
**Primary key:** `id`

<details><summary>Columns (50, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `account_balance` | bigint |  | verified | This field has been renamed to balance and will be removed in a future API version. |
| `address_city` | varchar |  | verified | City, district, suburb, town, or village. |
| `address_country` | varchar |  | verified | Two-letter country code (ISO 3166-1 alpha-2). |
| `address_line1` | varchar |  | verified | Address line 1, such as the street, PO Box, or company name. |
| `address_line2` | varchar |  | verified | Address line 2, such as the apartment, suite, unit, or building. |
| `address_postal_code` | varchar |  | verified | ZIP or postal code. |
| `address_state` | varchar |  | verified | State, county, province, or region (ISO 3166-2). |
| `balance` | bigint |  | verified | The current balance, if any, that's stored on the customer. If negative, the customer has credit to apply to their next invoice. If positive, the customer has an amount owed that's added to their next invoice. The balance only considers amounts that Stripe hasn't successfully applied to any invoice. It doesn't reflect unpaid invoices. This balance is only taken into account after invoices finalize. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `business_name` | varchar |  | verified | The customer's business name. |
| `business_vat_id` | varchar |  | verified |  |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `customer_account_id` | varchar |  | verified | The ID of a related account that has the customer configuration. This ID can be used in any v1 API that accepts a customer_account parameter. |
| `default_source_id` | varchar | foreign | verified | ID of the default payment source for the customer.

If you use payment methods created through the PaymentMethods API, see the invoice_settings.default_payment_method field instead. |
| `deleted` | boolean |  | verified |  |
| `delinquent` | boolean |  | verified | Tracks the most recent state change on any invoice belonging to the customer. Paying an invoice or marking it uncollectible via the API will set this field to false. An automatic payment failure or passing the invoice.due_date will set this field to true.

If an invoice becomes uncollectible by dunning, delinquent doesn't reset to false.

If you care whether the customer has paid their most recent subscription invoice, use subscription.status instead. Paying or marking uncollectible any customer invoice regardless of whether it is the latest invoice for a subscription will always set this field to false. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. |
| `discount_checkout_session` | varchar |  | verified | The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Not present for subscription mode. |
| `discount_coupon_id` | varchar | foreign | verified | Unique identifier for the object. |
| `discount_customer_id` | varchar | foreign | verified | The ID of the customer associated with this discount. |
| `discount_end` | timestamp |  | verified | If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null. |
| `discount_invoice` | varchar |  | verified | The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice. |
| `discount_invoice_item` | varchar |  | verified | The invoice item id (or invoice line item id for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item. |
| `discount_promotion_code_id` | varchar |  | verified | The promotion code applied to create this discount. |
| `discount_schedule_id` | varchar | foreign | verified | The subscription schedule that this coupon is applied to, if it is applied to a particular subscription schedule. |
| `discount_start` | timestamp |  | verified | Date that the coupon was applied. |
| `discount_subscription` | varchar |  | verified | The subscription that this coupon is applied to, if it is applied to a particular subscription. |
| `discount_subscription_item` | varchar |  | verified | The subscription item that this coupon is applied to, if it is applied to a particular subscription item. |
| `email` | varchar |  | verified | The customer's email address. |
| `individual_name` | varchar |  | verified | The customer's individual name. |
| `invoice_credit_balance` | varchar |  | verified | The current multi-currency balances, if any, that's stored on the customer. If positive in a currency, the customer has a credit to apply to their next invoice denominated in that currency. If negative, the customer has an amount owed that's added to their next invoice denominated in that currency. These balances don't apply to unpaid invoices. They solely track amounts that Stripe hasn't successfully applied to any invoice. Stripe only applies a balance in a specific currency to an invoice after that invoice (which is in the same currency) finalizes. |
| `invoice_settings_default_payment_method_id` | varchar | foreign | verified | ID of a payment method that's attached to the customer, to be used as the customer's default payment method for subscriptions and invoices. |
| `name` | varchar |  | verified | The customer's full name or business name. |
| `phone` | varchar |  | verified | The customer's phone number. |
| `preferred_locales` | varchar |  | verified | The customer's preferred locales (languages), ordered by preference. |
| `shipping_address_city` | varchar |  | verified | City, district, suburb, town, or village. |
| `shipping_address_country` | varchar |  | verified | Two-letter country code (ISO 3166-1 alpha-2). |
| `shipping_address_line1` | varchar |  | verified | Address line 1, such as the street, PO Box, or company name. |
| `shipping_address_line2` | varchar |  | verified | Address line 2, such as the apartment, suite, unit, or building. |
| `shipping_address_postal_code` | varchar |  | verified | ZIP or postal code. |
| `shipping_address_state` | varchar |  | verified | State, county, province, or region (ISO 3166-2). |
| `shipping_name` | varchar |  | verified | Customer name. |
| `shipping_phone` | varchar |  | verified | Customer phone (including extension). |
| `sources_data_id` | varchar |  | verified | Unique identifier for the object. |
| `tax_exempt` | varchar |  | verified | Describes the customer's tax exemption status, which is none, exempt, or reverse. When set to reverse, invoice and receipt PDFs include the following text: "Reverse charge". |
| `tax_info_tax_id` | varchar |  | verified | The customer's tax ID number. |
| `tax_info_type` | varchar |  | verified | The type of ID number. |
| `tax_ip_address` | varchar |  | verified | A recent IP address of the customer used for tax reporting and tax location inference. |

</details>

> Deleted customers are retained here, so filter on is_deleted for active-customer counts.

### `customers_metadata`

Metadata key/value pairs set on customers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `customer_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (35, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed iauth_. |
| `amount` | bigint |  | verified | Authorized amount in minor currency units. |
| `approved` | boolean |  | verified | Whether the authorization was approved. |
| `authorization_method` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `card_id` | varchar | foreign | verified | Card used for the purchase. |
| `created` | timestamp |  | verified | When the authorization was requested (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `fraud_disputability_likelihood` | varchar |  | verified |  |
| `merchant_amount` | bigint |  | verified |  |
| `merchant_currency` | varchar |  | verified |  |
| `merchant_data_category` | varchar |  | verified |  |
| `merchant_data_category_code` | varchar |  | verified |  |
| `merchant_data_city` | varchar |  | verified |  |
| `merchant_data_country` | varchar |  | verified |  |
| `merchant_data_name` | varchar |  | verified |  |
| `merchant_data_network_id` | varchar |  | verified |  |
| `merchant_data_postal_code` | varchar |  | verified |  |
| `merchant_data_state` | varchar |  | verified |  |
| `network_data_acquiring_institution_id` | varchar |  | verified |  |
| `risk_assessment_card_testing_risk_invalid_account_number_decline_rate_past_hour` | bigint |  | verified |  |
| `risk_assessment_card_testing_risk_invalid_credentials_decline_rate_past_hour` | bigint |  | verified |  |
| `risk_assessment_card_testing_risk_level` | varchar |  | verified |  |
| `risk_assessment_fraud_risk_level` | varchar |  | verified |  |
| `risk_assessment_fraud_risk_score` | double |  | verified |  |
| `risk_assessment_merchant_dispute_risk_dispute_rate` | bigint |  | verified |  |
| `risk_assessment_merchant_dispute_risk_level` | varchar |  | verified |  |
| `status` | varchar |  | verified | Authorization status. Values: `pending`, `closed`, `reversed`, `expired`. |
| `type` | varchar |  | verified |  |
| `verification_data_address_line1_check` | varchar |  | verified |  |
| `verification_data_address_postal_code_check` | varchar |  | verified |  |
| `verification_data_cvc_check` | varchar |  | verified |  |
| `verification_data_expiry_check` | varchar |  | verified |  |
| `verification_data_postal_code` | varchar |  | verified |  |
| `wallet` | varchar |  | verified |  |

</details>

**Joins**

- `issuing_authorizations.card_id` → `issuing_cards.id`

> The API's request_history field is not available in Sigma.

### `issuing_authorizations_metadata`

Metadata key/value pairs set on issuing_authorizations. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_authorization_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (24, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed ich_. |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_address_city` | varchar |  | verified |  |
| `billing_address_country` | varchar |  | verified |  |
| `billing_address_line1` | varchar |  | verified |  |
| `billing_address_line2` | varchar |  | verified |  |
| `billing_address_postal_code` | varchar |  | verified |  |
| `billing_address_state` | varchar |  | verified |  |
| `company_tax_id_provided` | boolean |  | verified |  |
| `created` | timestamp |  | verified | When the cardholder was created (UTC). |
| `email` | varchar |  | verified | Cardholder email address. |
| `individual_dob_day` | bigint |  | verified |  |
| `individual_dob_month` | bigint |  | verified |  |
| `individual_dob_year` | bigint |  | verified |  |
| `individual_first_name` | varchar |  | verified |  |
| `individual_last_name` | varchar |  | verified |  |
| `individual_verification_document_back_id` | varchar |  | verified |  |
| `individual_verification_document_front_id` | varchar |  | verified |  |
| `name` | varchar |  | verified | Cardholder name. |
| `phone_number` | varchar |  | verified | Cardholder phone number. |
| `requirements_disabled_reason` | varchar |  | verified |  |
| `requirements_past_due` | varchar |  | verified |  |
| `status` | varchar |  | verified | Cardholder status. Values: `active`, `inactive`, `blocked`. |
| `type` | varchar |  | verified | Cardholder type. Values: `individual`, `company`. |

</details>

> Documented examples show a 'business_entity' value for type alongside 'individual'; the API uses 'company'. Verify against your own data before filtering.

### `issuing_cardholders_metadata`

Metadata key/value pairs set on issuing_cardholders. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_cardholder_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (46, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed ic_. |
| `allowed_authorization_period_ends_at` | timestamp |  | verified |  |
| `allowed_authorization_period_starts_at` | timestamp |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `brand` | varchar |  | verified | Card brand. |
| `cancellation_reason` | varchar |  | verified |  |
| `cardholder_id` | varchar | foreign | verified | Cardholder the card belongs to. |
| `created` | timestamp |  | verified | When the card was created (UTC). |
| `currency` | varchar |  | verified | Currency the card transacts in. |
| `exp_month` | bigint |  | verified | Expiry month. |
| `exp_year` | bigint |  | verified | Expiry year. |
| `last4` | varchar |  | verified | Last four digits of the card number. |
| `latest_fraud_warning_started_at` | timestamp |  | verified |  |
| `latest_fraud_warning_type` | varchar |  | verified |  |
| `lifecycle_controls_cancel_after_payment_count` | bigint |  | verified |  |
| `mcc_groups_allowed_categories` | varchar |  | verified |  |
| `mcc_groups_blocked_categories` | varchar |  | verified |  |
| `personalization_design_id` | varchar | foreign | verified |  |
| `program_id` | varchar | foreign | verified |  |
| `replaced_by_id` | varchar | foreign | verified |  |
| `replacement_for_id` | varchar | foreign | verified |  |
| `shipping_address_city` | varchar |  | verified |  |
| `shipping_address_country` | varchar |  | verified |  |
| `shipping_address_line1` | varchar |  | verified |  |
| `shipping_address_line2` | varchar |  | verified |  |
| `shipping_address_postal_code` | varchar |  | verified |  |
| `shipping_address_state` | varchar |  | verified |  |
| `shipping_address_validation_mode` | varchar |  | verified |  |
| `shipping_address_validation_normalized_address_city` | varchar |  | verified |  |
| `shipping_address_validation_normalized_address_country` | varchar |  | verified |  |
| `shipping_address_validation_normalized_address_line1` | varchar |  | verified |  |
| `shipping_address_validation_normalized_address_line2` | varchar |  | verified |  |
| `shipping_address_validation_normalized_address_postal_code` | varchar |  | verified |  |
| `shipping_address_validation_normalized_address_state` | varchar |  | verified |  |
| `shipping_address_validation_result` | varchar |  | verified |  |
| `shipping_carrier` | varchar |  | verified |  |
| `shipping_eta` | timestamp |  | verified |  |
| `shipping_name` | varchar |  | verified |  |
| `shipping_service` | varchar |  | verified |  |
| `shipping_status` | varchar |  | verified |  |
| `shipping_tracking_number` | varchar |  | verified |  |
| `shipping_tracking_url` | varchar |  | verified |  |
| `shipping_type` | varchar |  | verified |  |
| `spending_limits` | varchar |  | verified |  |
| `status` | varchar |  | verified | Card status. Values: `active`, `inactive`, `canceled`. |
| `type` | varchar |  | verified | Card form factor. Values: `physical`, `virtual`. |

</details>

**Joins**

- `issuing_cards.cardholder_id` → `issuing_cardholders.id`

> The API's spending_controls field is not available in Sigma.

### `issuing_cards_metadata`

Metadata key/value pairs set on issuing_cards. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_card_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (30, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed idp_. |
| `amount` | double |  | verified | Disputed amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `card` | varchar |  | verified |  |
| `cardholder` | varchar |  | verified |  |
| `created` | double |  | verified | When the dispute was created (UTC). |
| `currency` | varchar |  | verified |  |
| `evidence_additional_documentation` | varchar |  | verified |  |
| `evidence_canceled_at` | bigint |  | verified |  |
| `evidence_cancellation_policy_provided` | boolean |  | verified |  |
| `evidence_cancellation_reason` | varchar |  | verified |  |
| `evidence_card_statement` | varchar |  | verified |  |
| `evidence_cash_receipt` | varchar |  | verified |  |
| `evidence_check_image` | varchar |  | verified |  |
| `evidence_expected_at` | bigint |  | verified |  |
| `evidence_explanation` | varchar |  | verified |  |
| `evidence_original_transaction` | varchar |  | verified |  |
| `evidence_product_description` | varchar |  | verified |  |
| `evidence_product_type` | varchar |  | verified |  |
| `evidence_received_at` | bigint |  | verified |  |
| `evidence_return_description` | varchar |  | verified |  |
| `evidence_return_status` | varchar |  | verified |  |
| `evidence_returned_at` | bigint |  | verified |  |
| `internal_reason` | varchar |  | verified |  |
| `loss_reason` | varchar |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `reason` | varchar |  | verified | Reason for the dispute. |
| `status` | varchar |  | verified | Dispute status. |
| `transaction` | varchar |  | verified |  |
| `updated` | double |  | verified |  |

</details>

### `issuing_network_tokens`

Network tokens provisioned for issued cards, such as those created when a card is added to a mobile wallet.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per network token.  
**Primary key:** `id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the token. |
| `batch_timestamp` | timestamp |  | verified |  |
| `card` | varchar |  | verified |  |
| `created` | double |  | verified | When the token was provisioned (UTC). |
| `device_fingerprint` | varchar |  | verified |  |
| `last4` | varchar |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `network` | varchar |  | verified |  |
| `network_updated_at` | double |  | verified |  |
| `status` | varchar |  | verified | Token status. |
| `wallet_provider` | varchar |  | verified |  |

</details>

### `issuing_transactions`

Uses of an issued card that actually moved funds, such as completed purchases and refunds.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per issuing transaction.  
**Primary key:** `id`

<details><summary>Columns (40, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed ipi_. |
| `amount` | bigint |  | verified | Amount in minor currency units. Negative for captures (money leaving your account). |
| `authorization_id` | varchar | foreign | verified | Authorization this transaction settles. Empty for force captures and some refunds. |
| `balance_transaction_id` | varchar | foreign | verified | Balance transaction recording the effect on your balance, including fees. |
| `batch_timestamp` | timestamp |  | verified |  |
| `card_id` | varchar | foreign | verified | Card involved in the transaction. |
| `cardholder_id` | varchar | foreign | verified | Cardholder involved in the transaction. |
| `created` | timestamp |  | verified | When the transaction occurred (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `interchange_amount_decimal` | varchar |  | verified |  |
| `interchange_enhanced_data_interchange_amount_decimal` | varchar |  | verified |  |
| `interchange_enhanced_data_interchange_received_on` | timestamp |  | verified |  |
| `merchant_amount` | bigint |  | verified |  |
| `merchant_currency` | varchar |  | verified |  |
| `merchant_data_category` | varchar |  | verified |  |
| `merchant_data_category_code` | varchar |  | verified |  |
| `merchant_data_city` | varchar |  | verified |  |
| `merchant_data_country` | varchar |  | verified |  |
| `merchant_data_name` | varchar |  | verified |  |
| `merchant_data_network_id` | varchar |  | verified |  |
| `merchant_data_postal_code` | varchar |  | verified |  |
| `merchant_data_state` | varchar |  | verified |  |
| `network_data_authorization_code` | varchar |  | verified |  |
| `network_data_processing_date` | varchar |  | verified |  |
| `network_data_transaction_id` | varchar |  | verified |  |
| `purchase_details_flight_departure_at` | bigint |  | verified |  |
| `purchase_details_flight_passenger_name` | varchar |  | verified |  |
| `purchase_details_flight_refundable` | boolean |  | verified |  |
| `purchase_details_flight_travel_agency` | varchar |  | verified |  |
| `purchase_details_fuel_type` | varchar |  | verified |  |
| `purchase_details_fuel_unit` | varchar |  | verified |  |
| `purchase_details_fuel_unit_cost` | bigint |  | verified |  |
| `purchase_details_fuel_unit_cost_decimal` | varchar |  | verified |  |
| `purchase_details_fuel_volume` | bigint |  | verified |  |
| `purchase_details_fuel_volume_decimal` | varchar |  | verified |  |
| `purchase_details_lodging_check_in_at` | bigint |  | verified |  |
| `purchase_details_lodging_nights` | bigint |  | verified |  |
| `purchase_details_reference` | varchar |  | verified |  |
| `token_id` | varchar | foreign | verified |  |
| `type` | varchar |  | verified | Transaction type. Values: `capture`, `refund`. |

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
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_transaction_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (31, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `amount_in_usd` | bigint |  | verified |  |
| `attributable_optimization` | varchar |  | verified |  |
| `blocked_reason` | varchar |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `charge_id` | varchar | foreign | verified |  |
| `cof` | boolean |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `decline_reason` | varchar |  | verified |  |
| `final_charge_id` | varchar | foreign | verified |  |
| `gateway_conversation_avs_outcome` | varchar |  | verified |  |
| `gateway_conversation_cvc_outcome` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `invoice_id` | varchar | foreign | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `is_final_attempt` | boolean |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `payment_intent_id` | varchar | foreign | verified |  |
| `tds_flow_type` | varchar |  | verified |  |
| `tds_is_in_sca_scope` | boolean |  | verified |  |
| `tds_outcome` | varchar |  | verified |  |
| `tds_outcome_type` | varchar |  | verified |  |
| `tds_reason` | varchar |  | verified |  |
| `tds_sca_exemption_type` | varchar |  | verified |  |
| `tds_triggered` | boolean |  | verified |  |
| `transaction_initiator` | varchar |  | verified |  |
| `used_network_tokens` | boolean |  | verified |  |

</details>

**Joins**

- `acceptance_reporting_v3_itemized.charge_id` → `charges.id`
- `acceptance_reporting_v3_itemized.invoice_id` → `invoices.id`
- `acceptance_reporting_v3_itemized.payment_intent_id` → `payment_intents.id`

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
**Primary key:** `billing_amount, card_id`

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `balance_transaction_id` | varchar | foreign | verified |  |
| `billing_amount` | varchar | primary | verified |  |
| `card_id` | varchar | primary | verified |  |
| `balance_transaction_created_at` | timestamp |  | verified |  |
| `billing_currency` | varchar |  | verified |  |
| `customer_id` | varchar | foreign | verified |  |
| `event_type` | varchar |  | verified |  |
| `fixed_per_item_amount` | double |  | verified |  |
| `fixed_per_item_count` | bigint |  | verified |  |
| `fx_rate` | double |  | verified |  |
| `incurred_at` | timestamp |  | verified |  |
| `previous_card_id` | varchar |  | verified |  |
| `subtotal_amount` | double |  | verified |  |
| `tax_amount` | double |  | verified |  |
| `tax_rate` | double |  | verified |  |
| `total_amount` | double |  | verified |  |

</details>

**Joins**

- `cau_fees.balance_transaction_id` → `balance_transactions.id`
- `cau_fees.customer_id` → `customers.id`

### `charge_groups`

Groupings that link related charges, such as a retried payment and its original attempt.

**Freshness:** 72h  
**Source:** derived  
**Grain:** One row per (group, charge).

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `charge_id` | varchar | foreign | verified |  |
| `amount_in_usd` | bigint |  | verified |  |
| `created` | timestamp |  | verified |  |
| `final_charge_id` | varchar | foreign | verified |  |

</details>

**Joins**

- `charge_groups.charge_id` → `charges.id`

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

<details><summary>Columns (28, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar | foreign | verified | The connected account (acct_...) this row belongs to. |
| `activity_end_time` | timestamp |  | verified |  |
| `activity_start_time` | timestamp |  | verified |  |
| `amount` | double |  | verified | Fee incurred for this activity, expressed in MAJOR units of the currency. Excludes the tax amount. |
| `balance_transaction_created` | timestamp |  | verified | Time (in UTC) at which the balance transaction affected your Stripe balance. |
| `balance_transaction_description` | varchar |  | verified | The description of the balance transaction containing the fee. |
| `balance_transaction_id` | varchar | foreign | verified | The ID of the balance transaction that debited the fee from your balance. |
| `connected_account_id` | varchar |  | verified |  |
| `credit_note_number` | varchar |  | verified |  |
| `currency` | varchar |  | verified | Three-letter ISO code for the currency in which amount and tax are defined. |
| `feature_description` | varchar |  | verified |  |
| `feature_name` | varchar |  | verified |  |
| `fee_category` | varchar |  | verified |  |
| `fee_description` | varchar |  | verified |  |
| `fee_transaction_created` | timestamp |  | verified |  |
| `fee_transaction_id` | varchar |  | verified |  |
| `incurred_at` | timestamp |  | verified | Time (in UTC) at which the fee was incurred, by the date of its originating event. |
| `incurred_by` | varchar |  | verified | The ID of the object that incurred this fee, if any. Use incurred_by_type to determine the type of this object. |
| `incurred_by_type` | varchar |  | verified | The object type which incurred_by references. Matches the object field in the API (Charge, Refund, Invoice, etc). |
| `invoice_number` | varchar |  | verified |  |
| `platform_id` | varchar | foreign | verified |  |
| `pricing_tier` | bigint |  | verified |  |
| `product` | varchar |  | verified |  |
| `product_feature_description` | varchar |  | verified | The product or feature associated with the fee. |
| `settled_at` | timestamp |  | verified |  |
| `settled_via` | varchar |  | verified |  |
| `suite` | varchar |  | verified |  |
| `tax` | double |  | verified | Tax component of the fees paid, expressed in MAJOR units of the currency. |

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
**Primary key:** `activity_at_time_bucket, bt_count, bt_effective_at_interval_start, currency, gross, net, payout_is_auto, reporting_category`

<details><summary>Columns (12, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `activity_at_time_bucket` | varchar | primary | verified |  |
| `auto_payout_id` | varchar | foreign | verified |  |
| `bt_count` | varchar | primary | verified |  |
| `bt_effective_at_interval_start` | varchar | primary | verified |  |
| `currency` | varchar | primary | verified |  |
| `gross` | varchar | primary | verified |  |
| `net` | varchar | primary | verified |  |
| `payout_is_auto` | varchar | primary | verified |  |
| `reporting_category` | varchar | primary | verified |  |
| `account` | varchar | foreign | verified | The connected account (acct_...) this row belongs to. |
| `auto_payout_effective_at_interval_start` | timestamp |  | verified |  |
| `fee` | double |  | verified |  |

</details>

**Joins**

- `connected_account_summarized_balance_transactions.account` → `accounts.id`

### `exchange_rates_from_usd`

Daily currency conversion rates expressed relative to USD. Needed to sum multi-currency amounts into one reporting currency.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per date.  
**Primary key:** `date`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `date` | varchar | primary | verified | Date, as a midnight timestamp. |
| `buy_currency_exchange_rates` | varchar |  | verified | Buy currencies (to) and approximate mid-market exchange rates for the day, in JSON format. Excludes any Stripe fees that apply to currency conversions. Currencies are three-letter ISO currency codes in lowercase. See supported currencies. |
| `sell_currency` | varchar |  | verified | Sell currency (from), as a three-letter ISO currency code in lowercase. Always usd for this table. |

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

<details><summary>Columns (27, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `activity_end_time` | timestamp |  | verified | For fees calculated from activity spanning a period of time, this will be the activity's ending date (in UTC). |
| `activity_start_time` | timestamp |  | verified | For fees calculated from activity spanning a period of time, this will be the activity's starting date (in UTC). |
| `amount` | double |  | verified | Amount of this activity, expressed in major units of the currency. |
| `balance_transaction_created` | timestamp |  | verified | Time (in UTC) at which the balance transaction affected your Stripe balance. |
| `balance_transaction_description` | varchar |  | verified | [Deprecated] The description of the balance transaction containing the fee. Use the fee_description field to get more details on the fee. |
| `balance_transaction_id` | varchar | foreign | verified | The ID of the balance transaction containing the fee. |
| `connected_account_id` | varchar | foreign | verified | Connected Account ID |
| `credit_note_number` | varchar |  | verified | The number of the credit note issued in case of fee adjustments against invoices. This field will be null for non-adjustment fees. |
| `currency` | varchar |  | verified | Three-letter ISO code for the currency in which the amount is defined. |
| `feature_description` | varchar |  | verified | One line description of the product feature |
| `feature_name` | varchar |  | verified | The product feature the fee belongs to. For instance, Radar for Fraud Teams - transaction fee. |
| `fee_category` | varchar |  | verified | [Deprecated] Fee category where product feature description maps to. This field is no longer maintained and could have incomplete data. Use the product and suite fields instead. |
| `fee_description` | varchar |  | verified | One line fee description. Use this in place of balance_transaction_description |
| `fee_transaction_created` | timestamp |  | verified | Time (in UTC) at which the fee transaction affected your Stripe/Credit balance. |
| `fee_transaction_id` | varchar |  | verified | The id of the fee transaction containing the fee. |
| `incurred_at` | timestamp |  | verified | Time (in UTC) at which the fee was incurred, by the date of its originating event. |
| `incurred_by` | varchar |  | verified | The ID of the object that incurred this fee, if any. Use the incurred_by_type field to determine the type of this object. |
| `incurred_by_type` | varchar |  | verified | The object type which the incurred_by references. Matches the object field in the API (charge, refund, invoice, etc). |
| `invoice_number` | varchar |  | verified | The number of the invoice which was sent to invoice the Fees. This field will be null for non-invoiced fees. |
| `platform_id` | varchar |  | verified | Platform account ID |
| `pricing_tier` | bigint |  | verified | The pricing tier at which this fee was assessed. |
| `product` | varchar |  | verified | The product area the fee belongs to. For instance, Radar. |
| `product_feature_description` | varchar |  | verified | [Deprecated] The product and feature description of the fee. This field is no longer maintained and could have incomplete data. Use the feature_name field instead. |
| `settled_at` | timestamp |  | verified | The column gives information on when these fees were settled. In case of Invoices, this is the invoice sent date. |
| `settled_via` | varchar |  | verified | This column gives information on how a particular fee was settled. Possible Values are credit, balance, v2_balance, invoice and multiple. Values: `credit`, `balance`, `v2_balance`, `invoice`, `multiple`. |
| `suite` | varchar |  | verified | The product suite the fee belongs to. For instance, Payments. |
| `tax` | double |  | verified | Tax of this activity, expressed in major units of the currency. |

</details>

**Joins**

- `itemized_fees.balance_transaction_id` → `balance_transactions.id`
- `itemized_fees.connected_account_id` → `connected_accounts.id`

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
**Primary key:** `id`

<details><summary>Columns (36, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `accounting_period_date` | timestamp |  | verified |  |
| `adjustment_id` | varchar |  | verified |  |
| `amount` | double |  | verified |  |
| `booked_date` | timestamp |  | verified |  |
| `charge_id` | varchar | foreign | verified |  |
| `credit` | varchar |  | verified |  |
| `credit_account_type` | varchar |  | verified |  |
| `credit_gl_code` | varchar |  | verified |  |
| `credit_note_id` | varchar | foreign | verified |  |
| `currency` | varchar |  | verified |  |
| `customer_balance_transaction_id` | varchar | foreign | verified |  |
| `customer_id` | varchar | foreign | verified |  |
| `debit` | varchar |  | verified |  |
| `debit_account_type` | varchar |  | verified |  |
| `debit_gl_code` | varchar |  | verified |  |
| `dispute_id` | varchar | foreign | verified |  |
| `event_type` | varchar |  | verified |  |
| `external_transaction_source` | varchar |  | verified |  |
| `invoice_id` | varchar | foreign | verified |  |
| `invoice_item_id` | varchar | foreign | verified |  |
| `is_accounting_period_open` | boolean |  | verified |  |
| `line_item_id` | varchar | foreign | verified |  |
| `livemode` | boolean |  | verified |  |
| `manual_journal_entry_model_id` | varchar |  | verified |  |
| `original_accounting_period_date` | timestamp |  | verified |  |
| `plan_type` | varchar |  | verified |  |
| `presentment_amount` | double |  | verified |  |
| `presentment_currency` | varchar |  | verified |  |
| `price_id` | varchar | foreign | verified |  |
| `product_id` | varchar | foreign | verified |  |
| `product_type` | varchar |  | verified |  |
| `refund_id` | varchar | foreign | verified |  |
| `subscription_id` | varchar | foreign | verified |  |
| `subscription_item_id` | varchar | foreign | verified |  |
| `subscription_type` | varchar |  | verified |  |

</details>

**Joins**

- `revenue_recognition_debits_and_credits.charge_id` → `charges.id`
- `revenue_recognition_debits_and_credits.credit_note_id` → `credit_notes.id`
- `revenue_recognition_debits_and_credits.customer_balance_transaction_id` → `customer_balance_transactions.id`
- `revenue_recognition_debits_and_credits.customer_id` → `customers.id`
- `revenue_recognition_debits_and_credits.dispute_id` → `disputes.id`
- `revenue_recognition_debits_and_credits.invoice_id` → `invoices.id`
- `revenue_recognition_debits_and_credits.invoice_item_id` → `invoice_items.id`
- `revenue_recognition_debits_and_credits.price_id` → `prices.id`
- `revenue_recognition_debits_and_credits.product_id` → `products.id`
- `revenue_recognition_debits_and_credits.refund_id` → `refunds.id`
- `revenue_recognition_debits_and_credits.subscription_id` → `subscriptions.id`
- `revenue_recognition_debits_and_credits.subscription_item_id` → `subscription_items.id`

> Pairs with Stripe's Revenue Recognition reports; see docs.stripe.com/revenue-recognition/reports/sigma-and-sdp.

### `summarized_balance_transactions`

Pre-aggregated balance transaction totals, grouped by period and reporting category. Much cheaper than aggregating balance_transactions yourself.

**Freshness:** 12h  
**Source:** derived  
**Grain:** One row per (period, currency, reporting category).  
**Primary key:** `activity_at_time_bucket, bt_count, bt_effective_at_interval_start, currency, gross, net, payout_is_auto, reporting_category`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `activity_at_time_bucket` | varchar | primary | verified |  |
| `auto_payout_id` | varchar | foreign | verified |  |
| `bt_count` | varchar | primary | verified |  |
| `bt_effective_at_interval_start` | varchar | primary | verified |  |
| `currency` | varchar | primary | verified |  |
| `gross` | varchar | primary | verified |  |
| `net` | varchar | primary | verified |  |
| `payout_is_auto` | varchar | primary | verified |  |
| `reporting_category` | varchar | primary | verified |  |
| `auto_payout_effective_at_interval_start` | timestamp |  | verified |  |
| `fee` | double |  | verified |  |

</details>

> Use this for high-level financial summaries; drop to balance_transactions only when you need row-level detail.

## payments

### `balance_transaction_fee_details`

Line-item breakdown of the fee column on balance_transactions.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per fee component of a balance transaction. A balance transaction can have several.  
**Primary key:** `id`

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `balance_transaction_id` | varchar | foreign | verified | The balance transaction this fee component belongs to. |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified | Amount of the fee, in cents. |
| `application` | varchar |  | verified | ID of the Connect application that earned the fee. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. |
| `type` | varchar |  | verified | Type of the fee, one of: application_fee, payment_method_passthrough_fee, stripe_fee, tax, or withheld_tax. Values: `application_fee`, `payment_method_passthrough_fee`, `stripe_fee`, `tax`, `withheld_tax`. |

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

<details><summary>Columns (15, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount` | bigint |  | verified | Gross amount of this transaction (in cents). A positive value represents funds charged to another party, and a negative value represents funds sent to another party. |
| `automatic_transfer_id` | varchar | foreign | verified | ID of the automatically created transfer associated with this balance transaction (only set if your account is on an automatic payout schedule). |
| `available_on` | timestamp |  | verified | The date that the transaction's net funds become available in the Stripe balance. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. |
| `exchange_rate` | double |  | verified | This field is populated for Balance Transactions created beyond January 26th, 2026.

If applicable, the exchange rate used on this Balance Transaction. Divide the amount of the transaction by this rate to determine the amount in the original currency. For example, consider a Balance Transaction that has an amount of 1234 and an exchange_rate of 1.234. The original amount would then be equal to 1234 / 1.234 = 1000. |
| `fee` | bigint |  | verified | Fees (in cents) paid for this transaction. Represented as a positive integer when assessed. |
| `net` | bigint |  | verified | Net impact to a Stripe balance (in cents). A positive value represents incrementing a Stripe balance, and a negative value decrementing a Stripe balance. You can calculate the net impact of a transaction on a balance by amount - fee |
| `reporting_category` | varchar |  | verified | A new categorization of balance transactions, meant to improve on the current type field. Learn more. Please let us know what would be most helpful using the Feedback link at the bottom of this page. |
| `source_id` | varchar | foreign | verified | This transaction relates to the Stripe object. |
| `status` | varchar |  | verified | The transaction's net funds status in the Stripe balance, which are either available or pending. Values: `available`, `pending`. |
| `type` | varchar |  | verified | Transaction type: tax_fund, adjustment, advance, advance_funding, anticipation_repayment, application_fee, application_fee_refund, charge, climate_order_purchase, climate_order_refund, connect_collection_transfer, contribution, inbound_transfer, inbound_transfer_reversal, issuing_authorization_hold, issuing_authorization_release, issuing_dispute, issuing_transaction, obligation_outbound, obligation_reversal_inbound, payment, payment_failure_refund, payment_network_reserve_hold, payment_network_reserve_release, payment_refund, payment_reversal, payment_unreconciled, payout, payout_cancel, payout_failure, payout_minimum_balance_hold, payout_minimum_balance_release, refund, refund_failure, reserve_transaction, reserved_funds, reserve_hold, reserve_release, stripe_fee, stripe_fx_fee, stripe_balance_payment_debit, stripe_balance_payment_debit_reversal, tax_fee, topup, topup_reversal, transfer, transfer_cancel, transfer_failure, transfer_refund, or fee_credit_funding. Learn more about balance transaction types and what they represent. To classify transactions for accounting purposes, consider reporting_category instead. Values: `charge`, `refund`, `adjustment`, `application_fee`, `application_fee_refund`, `transfer`, `payment`, `payout`, `payout_cancel`, `payout_failure`, `stripe_fee`, `network_cost`. |

</details>

**Joins**

- `balance_transactions.automatic_transfer_id` → `transfers.id`
- `balance_transactions.source_id` → `sources.id`

> Prefer this table over charges/refunds for anything accounting-related; it is the only table that nets out fees consistently.

> source_id is polymorphic and has no single FK target. Join conditionally on type.

> A charge and its refund are separate rows; refunding never mutates the original row.

### `charges`

One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance_transactions instead.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per charge, including failed charges.  
**Primary key:** `id`

<details><summary>Columns (79, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount` | bigint |  | verified | Amount intended to be collected by this payment. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99). |
| `amount_refunded` | bigint |  | verified | Amount in cents refunded (can be less than the amount attribute on the charge if a partial refund was issued). |
| `application_fee_id` | varchar | foreign | verified | The application fee (if any) for the charge. See the Connect documentation for details. |
| `application_id` | varchar |  | verified | ID of the Connect application that created the charge. |
| `balance_transaction_id` | varchar | foreign | verified | ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes). |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `calculated_statement_descriptor` | varchar |  | verified | The full statement descriptor that is passed to card networks, and that is displayed on your customers' credit card and bank statements. Allows you to see what the statement descriptor looks like after the static and dynamic portions are combined. This value only exists for card payments. |
| `captured` | boolean |  | verified | If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured. |
| `captured_at` | timestamp |  | verified | When the charge was captured. Null if never captured. Note the API exposes this as a boolean `captured`. |
| `card_address_city` | varchar |  | verified | City/District/Suburb/Town/Village. |
| `card_address_country` | varchar |  | verified | Billing address country, if provided when creating card. |
| `card_address_line1` | varchar |  | verified | Address line 1 (Street address/PO Box/Company name). |
| `card_address_line1_check` | varchar |  | verified | If address_line1 was provided, results of the check: pass, fail, unavailable, or unchecked. |
| `card_address_line2` | varchar |  | verified | Address line 2 (Apartment/Suite/Unit/Building). |
| `card_address_state` | varchar |  | verified | State/County/Province/Region. |
| `card_address_zip` | varchar |  | verified | ZIP or postal code. |
| `card_address_zip_check` | varchar |  | verified | If address_zip was provided, results of the check: pass, fail, unavailable, or unchecked. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_brand` | varchar |  | verified | Card brand. Can be American Express, Cartes Bancaires, Diners Club, Discover, Eftpos Australia, Girocard, JCB, MasterCard, UnionPay, Visa, or Unknown. Values: `American Express`, `Cartes Bancaires`, `Diners Club`, `Discover`, `Eftpos Australia`, `Girocard`, `JCB`, `MasterCard`, `UnionPay`, `Visa`, `Unknown`. |
| `card_country` | varchar |  | verified | Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected. |
| `card_currency` | varchar |  | verified |  |
| `card_customer_id` | varchar | foreign | verified | The customer that this card belongs to. This attribute will not be in the card object if the card belongs to an account or recipient instead. |
| `card_cvc_check` | varchar |  | verified | If a CVC was provided, results of the check: pass, fail, unavailable, or unchecked. A result of unchecked indicates that CVC was provided but hasn't been checked yet. Checks are typically performed when attaching a card to a Customer object, or when creating a charge. For more details, see Check if a card is valid without a charge. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_default_for_currency` | boolean |  | verified | Only applicable on payout external account card belonging to merchant (not as payment source customer card in charge). |
| `card_dynamic_last4` | varchar |  | verified | (For tokenized numbers only.) The last four digits of the device account number. |
| `card_exp_month` | bigint |  | verified | Two-digit number representing the card's expiration month. |
| `card_exp_year` | bigint |  | verified | Four-digit number representing the card's expiration year. |
| `card_fingerprint` | varchar |  | verified | Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.

As of May 1, 2021, card fingerprint in India for Connect changed to allow two fingerprints for the same card---one for India and one for the rest of the world. |
| `card_funding` | varchar |  | verified | Card funding type. Can be credit, debit, prepaid, or unknown. Values: `credit`, `debit`, `prepaid`, `unknown`. |
| `card_id` | varchar | foreign | verified | Unique identifier for the object. |
| `card_last4` | varchar |  | verified | The last four digits of the card. |
| `card_name` | varchar |  | verified | Cardholder name. |
| `card_network` | varchar |  | verified | Identifies which network this charge was processed on. Can be amex, cartes_bancaires, diners, discover, eftpos_au, interac, jcb, link, mastercard, unionpay, visa, or unknown. Values: `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `interac`, `jcb`, `link`, `mastercard`, `unionpay`, `visa`, `unknown`. |
| `card_recipient_id` | varchar |  | verified |  |
| `card_token_type` | varchar |  | verified | If the card number is tokenized, this is the token type. For Apple Pay it can be dpan, mpan. For Google Pay Gateway integration it can be pan, dpan, ecommerce_token, pan_with_3ds. For Google Pay legacy integration it can be fpan, dpan_or_ecommerce_token. Values: `dpan`, `mpan`. |
| `card_tokenization_method` | varchar |  | verified | If the card number is tokenized, this is the method that was used. Can be android_pay (includes Google Pay), apple_pay, masterpass, visa_checkout, or null. Values: `android_pay`, `apple_pay`, `masterpass`, `visa_checkout`. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `customer_id` | varchar | foreign | verified | ID of the customer this charge is for if one exists. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. |
| `destination_id` | varchar | foreign | verified | Connected account funds were routed to. Joins to accounts.id / connected_accounts.id. |
| `dispute_id` | varchar | foreign | verified | Dispute against this charge, if any. |
| `failure_code` | varchar |  | verified | Error code explaining reason for charge failure if available (see the errors section for a list of codes). |
| `failure_message` | varchar |  | verified | Message to user further explaining reason for charge failure if available. |
| `invoice_id` | varchar | foreign | verified | ID of the invoice this charge is for if one exists. |
| `on_behalf_of_id` | varchar | foreign | verified | The account (if any) the charge was made on behalf of without triggering an automatic transfer. See the Connect documentation for details. |
| `order_id` | varchar |  | verified |  |
| `outcome_advice_code` | varchar |  | verified | An enumerated value providing a more detailed explanation on how to proceed with an error. |
| `outcome_network_advice_code` | varchar |  | verified | For charges declined by the network, a 2 digit code which indicates the advice returned by the network on how to proceed with an error. |
| `outcome_network_decline_code` | varchar |  | verified | For charges declined by the network, an alphanumeric code which indicates the reason the charge failed. |
| `outcome_network_status` | varchar |  | verified | Possible values are approved_by_network, declined_by_network, not_sent_to_network, and reversed_after_approval. The value reversed_after_approval indicates the payment was blocked by Stripe after bank authorization, and may temporarily appear as "pending" on a cardholder's statement. Values: `approved_by_network`, `declined_by_network`, `not_sent_to_network`, `reversed_after_approval`. |
| `outcome_reason` | varchar |  | verified | An enumerated value providing a more detailed explanation of the outcome's type. Charges blocked by Radar's default block rule have the value highest_risk_level. Charges placed in review by Radar's default review rule have the value elevated_risk_level. Charges blocked because the payment is unlikely to be authorized have the value low_probability_of_authorization. Charges authorized, blocked, or placed in review by custom rules have the value rule. See understanding declines for more details. |
| `outcome_risk_level` | varchar |  | verified | Bucketed risk level. Values: `normal`, `elevated`, `highest`, `not_assessed`, `unknown`. |
| `outcome_risk_score` | bigint |  | verified | Radar risk score from 0 to 100. Higher is riskier. |
| `outcome_rule_id` | varchar | foreign | verified | The ID of the Radar rule that matched the payment, if applicable. |
| `outcome_seller_message` | varchar |  | verified | A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not your customer. |
| `outcome_type` | varchar |  | verified | Possible values are authorized, manual_review, issuer_declined, blocked, and invalid. See understanding declines and Radar reviews for details. Values: `authorized`, `manual_review`, `issuer_declined`, `blocked`, `invalid`. |
| `paid` | boolean |  | verified | true if the charge succeeded, or was successfully authorized for later capture. |
| `payment_intent` | varchar |  | verified | ID of the PaymentIntent associated with this charge, if one exists. |
| `payment_method_id` | varchar | foreign | verified | ID of the payment method used in this charge. |
| `payment_method_type` | varchar |  | verified | The type of transaction-specific details of the payment method used in the payment. See PaymentMethod.type for the full list of possible types. An additional hash is included on payment_method_details with a name matching this value. It contains information specific to the payment method. |
| `presentment_amount` | bigint |  | verified | Amount intended to be collected by this payment, denominated in presentment_currency. |
| `presentment_currency` | varchar |  | verified | Currency presented to the customer during payment. |
| `receipt_email` | varchar |  | verified | This is the email address that the receipt for this charge was sent to. |
| `receipt_number` | varchar |  | verified | This is the transaction number that appears on email receipts sent for this charge. This attribute will be null until a receipt has been sent. |
| `refunded` | boolean |  | verified | Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false. |
| `shipping_address_city` | varchar |  | verified | City, district, suburb, town, or village. |
| `shipping_address_country` | varchar |  | verified | Two-letter country code (ISO 3166-1 alpha-2). |
| `shipping_address_line1` | varchar |  | verified | Address line 1, such as the street, PO Box, or company name. |
| `shipping_address_line2` | varchar |  | verified | Address line 2, such as the apartment, suite, unit, or building. |
| `shipping_address_postal_code` | varchar |  | verified | ZIP or postal code. |
| `shipping_address_state` | varchar |  | verified | State, county, province, or region (ISO 3166-2). |
| `source_id` | varchar | foreign | verified |  |
| `source_transfer_id` | varchar | foreign | verified | The transfer ID which created this charge. Only present if the charge came from another Stripe account. See the Connect documentation for details. |
| `statement_descriptor` | varchar |  | verified | For a non-card charge, text that appears on the customer's statement as the statement descriptor. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see the Statement Descriptor docs.

For a card charge, this value is ignored unless you don't specify a statement_descriptor_suffix, in which case this value is used as the suffix. |
| `statement_descriptor_suffix` | varchar |  | verified | Provides information about a card charge. Concatenated to the account's statement descriptor prefix to form the complete statement descriptor that appears on the customer's statement. If the account has no prefix value, the suffix is concatenated to the account's statement descriptor. |
| `status` | varchar |  | verified | The status of the payment is either succeeded, pending, or failed. Values: `succeeded`, `pending`, `failed`. |
| `transfer_group` | varchar |  | verified | A string that identifies this transaction as part of a group. See the Connect documentation for details. |
| `transfer_id` | varchar | foreign | verified | ID of the transfer to the destination account (only applicable if the charge was created using the destination parameter). |

</details>

**Joins**

- `charges.customer_id` → `customers.id`
- `charges.invoice_id` → `invoices.id`
- `charges.balance_transaction_id` → `balance_transactions.id`
- `charges.transfer_id` → `transfers.id`
- `charges.destination_id` → `connected_accounts.id`
- `charges.payment_method_id` → `payment_methods.id`
- `charges.application_fee_id` → `application_fees.id`
- `charges.dispute_id` → `disputes.id`
- `charges.source_id` → `sources.id`

> card_brand values are display-cased (Visa, MasterCard), not the API's lowercase (visa, mastercard). Filter accordingly.

> Extra card detail beyond the flattened card_* columns lives in payment_method_details, joined on charge_id.

> A partial capture produces both a charge for the full authorized amount and a refund with reason 'partial_capture'. Exclude those refunds when measuring true refund rates.

### `charges_metadata`

Metadata key/value pairs set on charges. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `charge_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (80, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the payment record. |
| `account` | varchar | foreign | verified | The connected account (acct_...) this row belongs to. |
| `amount_authorized_currency` | varchar |  | verified |  |
| `amount_authorized_value` | bigint |  | verified |  |
| `amount_canceled_currency` | varchar |  | verified |  |
| `amount_canceled_value` | bigint |  | verified |  |
| `amount_currency` | varchar |  | verified |  |
| `amount_disputed_currency` | varchar |  | verified |  |
| `amount_disputed_value` | bigint |  | verified |  |
| `amount_failed_currency` | varchar |  | verified |  |
| `amount_failed_value` | bigint |  | verified |  |
| `amount_guaranteed_currency` | varchar |  | verified |  |
| `amount_guaranteed_value` | bigint |  | verified |  |
| `amount_refunded_currency` | varchar |  | verified |  |
| `amount_refunded_value` | bigint |  | verified |  |
| `amount_requested_currency` | varchar |  | verified |  |
| `amount_requested_value` | bigint |  | verified |  |
| `amount_value` | bigint |  | verified |  |
| `application` | varchar |  | verified |  |
| `capture_method` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the record was created (UTC). |
| `customer_details_customer` | varchar | foreign | verified |  |
| `customer_details_email` | varchar |  | verified |  |
| `customer_details_name` | varchar |  | verified |  |
| `customer_details_phone` | varchar |  | verified |  |
| `customer_presence` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `initiated_at` | timestamp |  | verified |  |
| `latest_occurred_at` | timestamp |  | verified |  |
| `latest_payment_attempt_record` | varchar |  | verified |  |
| `money_services_transaction_type` | varchar |  | verified |  |
| `payment_method_details_billing_address_city` | varchar |  | verified |  |
| `payment_method_details_billing_address_country` | varchar |  | verified |  |
| `payment_method_details_billing_address_line1` | varchar |  | verified |  |
| `payment_method_details_billing_address_line2` | varchar |  | verified |  |
| `payment_method_details_billing_address_postal_code` | varchar |  | verified |  |
| `payment_method_details_billing_address_state` | varchar |  | verified |  |
| `payment_method_details_billing_email` | varchar |  | verified |  |
| `payment_method_details_billing_name` | varchar |  | verified |  |
| `payment_method_details_billing_phone` | varchar |  | verified |  |
| `payment_method_details_card_brand` | varchar |  | verified |  |
| `payment_method_details_card_capture_before` | timestamp |  | verified |  |
| `payment_method_details_card_country` | varchar |  | verified |  |
| `payment_method_details_card_exp_month` | bigint |  | verified |  |
| `payment_method_details_card_exp_year` | bigint |  | verified |  |
| `payment_method_details_card_fingerprint` | varchar |  | verified |  |
| `payment_method_details_card_funding` | varchar |  | verified |  |
| `payment_method_details_card_last4` | varchar |  | verified |  |
| `payment_method_details_card_moto` | boolean |  | verified |  |
| `payment_method_details_card_network` | varchar |  | verified |  |
| `payment_method_details_card_network_transaction_id` | varchar |  | verified |  |
| `payment_method_details_card_payment_account_reference` | varchar |  | verified |  |
| `payment_method_details_card_wallet_dynamic_last4` | varchar |  | verified |  |
| `payment_method_details_card_wallet_type` | varchar |  | verified |  |
| `payment_method_details_custom_display_name` | varchar |  | verified |  |
| `payment_method_details_custom_type` | varchar |  | verified |  |
| `payment_method_details_payment_method` | varchar | foreign | verified |  |
| `payment_method_details_shared_payment_granted_token` | varchar |  | verified |  |
| `payment_method_details_shop_pay_external_source_id` | varchar |  | verified |  |
| `payment_method_details_type` | varchar |  | verified |  |
| `processor_adyen_merchant_account` | varchar |  | verified |  |
| `processor_adyen_psp_reference` | varchar |  | verified |  |
| `processor_braintree_merchant_account_id` | varchar |  | verified |  |
| `processor_braintree_transaction_id` | varchar |  | verified |  |
| `processor_custom_payment_reference` | varchar |  | verified |  |
| `processor_stripe_charge` | varchar | foreign | verified |  |
| `processor_type` | varchar |  | verified |  |
| `processor_worldpay_merchant_code` | varchar |  | verified |  |
| `processor_worldpay_order_code` | varchar |  | verified |  |
| `reported_by` | varchar |  | verified |  |
| `setup_future_usage` | varchar |  | verified |  |
| `shipping_address_city` | varchar |  | verified |  |
| `shipping_address_country` | varchar |  | verified |  |
| `shipping_address_line1` | varchar |  | verified |  |
| `shipping_address_line2` | varchar |  | verified |  |
| `shipping_address_postal_code` | varchar |  | verified |  |
| `shipping_address_state` | varchar |  | verified |  |
| `shipping_name` | varchar |  | verified |  |
| `shipping_phone` | varchar |  | verified |  |
| `updated` | timestamp |  | verified |  |

</details>

**Joins**

- `connected_account_payment_records.account` → `accounts.id`

### `connected_account_payment_records_metadata`

Metadata key/value pairs set on connected_account_payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 6h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `payment_record_id` | varchar | foreign | verified |  |
| `account` | varchar | foreign | verified | The connected account (acct_...) this row belongs to. |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

**Joins**

- `connected_account_payment_records_metadata.account` → `accounts.id`
- `connected_account_payment_records_metadata.payment_record_id` → `payment_records.id`

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select connected_account_payment_record_id, map_agg(key, value) as md from connected_account_payment_records_metadata group by 1

### `disputes`

One row per Dispute (chargeback), including any evidence you submitted.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per dispute. A single charge can have more than one dispute, so count distinct dispute ids.  
**Primary key:** `id`

<details><summary>Columns (44, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount` | bigint |  | verified | Disputed amount. Usually the amount of the charge, but it can differ (usually because of currency fluctuation or because only part of the order is disputed). |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `charge_id` | varchar | foreign | verified | ID of the charge that's disputed. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `evidence_access_activity_log` | varchar |  | verified | Any server or activity logs showing proof that the customer accessed or downloaded the purchased digital product. This information should include IP addresses, corresponding timestamps, and any detailed recorded activity. |
| `evidence_billing_address` | varchar |  | verified | The billing address provided by the customer. |
| `evidence_cancellation_policy_disclosure` | varchar |  | verified | An explanation of how and when the customer was shown your refund policy prior to purchase. |
| `evidence_cancellation_policy_id` | varchar |  | verified | (ID of a file upload) Your subscription cancellation policy, as shown to the customer. |
| `evidence_cancellation_rebuttal` | varchar |  | verified | A justification for why the customer's subscription was not canceled. |
| `evidence_customer_communication_id` | varchar |  | verified | (ID of a file upload) Any communication with the customer that you feel is relevant to your case. Examples include emails proving that the customer received the product or service, or demonstrating their use of or satisfaction with the product or service. |
| `evidence_customer_email_address` | varchar |  | verified | The email address of the customer. |
| `evidence_customer_name` | varchar |  | verified | The name of the customer. |
| `evidence_customer_purchase_ip` | varchar |  | verified | The IP address that the customer used when making the purchase. |
| `evidence_customer_signature_id` | varchar |  | verified | (ID of a file upload) A relevant document or contract showing the customer's signature. |
| `evidence_details_due_by` | timestamp |  | verified | Date by which evidence must be submitted in order to successfully challenge dispute. Will be 0 if the customer's bank or credit card company doesn't allow a response for this particular dispute. |
| `evidence_details_has_evidence` | boolean |  | verified | Whether evidence has been staged for this dispute. |
| `evidence_details_past_due` | boolean |  | verified | Whether the last evidence submission was submitted past the due date. Defaults to false if no evidence submissions have occurred. If true, then delivery of the latest evidence is not guaranteed. |
| `evidence_details_submission_count` | bigint |  | verified | The number of times evidence has been submitted. Typically, you may only submit evidence once. |
| `evidence_details_submitted_at` | timestamp |  | verified |  |
| `evidence_duplicate_charge_documentation_id` | varchar |  | verified | (ID of a file upload) Documentation for the prior charge that can uniquely identify the charge, such as a receipt, shipping label, work order, etc. This document should be paired with a similar document from the disputed payment that proves the two payments are separate. |
| `evidence_duplicate_charge_id` | varchar | foreign | verified | The Stripe ID for the prior charge which appears to be a duplicate of the disputed charge. |
| `evidence_product_description` | varchar |  | verified | A description of the product or service that was sold. |
| `evidence_receipt_id` | varchar |  | verified | (ID of a file upload) Any receipt or message sent to the customer notifying them of the charge. |
| `evidence_refund_policy_disclosure` | varchar |  | verified | Documentation demonstrating that the customer was shown your refund policy prior to purchase. |
| `evidence_refund_policy_id` | varchar |  | verified | (ID of a file upload) Your refund policy, as shown to the customer. |
| `evidence_refund_refusal_explanation` | varchar |  | verified | A justification for why the customer is not entitled to a refund. |
| `evidence_service_date` | varchar |  | verified | The date on which the customer received or began receiving the purchased service, in a clear human-readable format. |
| `evidence_service_documentation_id` | varchar |  | verified | (ID of a file upload) Documentation showing proof that a service was provided to the customer. This could include a copy of a signed contract, work order, or other form of written agreement. |
| `evidence_shipping_address` | varchar |  | verified | The address to which a physical product was shipped. You should try to include as complete address information as possible. |
| `evidence_shipping_carrier` | varchar |  | verified | The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc. If multiple carriers were used for this purchase, please separate them with commas. |
| `evidence_shipping_date` | varchar |  | verified | The date on which a physical product began its route to the shipping address, in a clear human-readable format. |
| `evidence_shipping_documentation_id` | varchar |  | verified | (ID of a file upload) Documentation showing proof that a product was shipped to the customer at the same address the customer provided to you. This could include a copy of the shipment receipt, shipping label, etc. It should show the customer's full shipping address, if possible. |
| `evidence_shipping_tracking_number` | varchar |  | verified | The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas. |
| `evidence_uncategorized_file_id` | varchar |  | verified | (ID of a file upload) Any additional evidence or statements. |
| `evidence_uncategorized_text` | varchar |  | verified | Any additional evidence or statements. |
| `is_charge_refundable` | boolean |  | verified | If true, it's still possible to refund the disputed payment. After the payment has been fully refunded, no further funds are withdrawn from your Stripe account as a result of this dispute. |
| `network_details_type` | varchar |  | verified | The network type for this dispute. There will be a corresponding hash of details keyed by the value of this field. |
| `network_details_visa_rapid_dispute_resolution` | boolean |  | verified | Whether this dispute was resolved via Visa's Rapid Dispute Resolution process. |
| `network_reason_code` | varchar |  | verified | Network-dependent reason code for the dispute. |
| `partner_processed_at` | timestamp |  | verified | The timestamp when the partner processed the dispute. |
| `reason` | varchar |  | verified | Reason given by cardholder for dispute. Possible values are bank_cannot_process, check_returned, credit_not_processed, customer_initiated, debit_not_authorized, duplicate, fraudulent, general, incorrect_account_details, insufficient_funds, noncompliant, product_not_received, product_unacceptable, subscription_canceled, or unrecognized. Learn more about dispute reasons. Values: `bank_cannot_process`, `check_returned`, `credit_not_processed`, `customer_initiated`, `debit_not_authorized`, `duplicate`, `fraudulent`, `general`, `incorrect_account_details`, `insufficient_funds`, `noncompliant`, `product_not_received`, `product_unacceptable`, `subscription_canceled`, `unrecognized`. |
| `status` | varchar |  | verified | The current status of a dispute. Possible values include:warning_needs_response, warning_under_review, warning_closed, needs_response, under_review, won, lost, or prevented. Values: `warning_needs_response`, `warning_under_review`, `warning_closed`, `needs_response`, `under_review`, `won`, `lost`, `prevented`. |

</details>

**Joins**

- `disputes.charge_id` → `charges.id`

> Exclude status = 'prevented' when computing chargeback ratios the way card networks measure them.

> Dispute data lags: recent months undercount because disputes arrive weeks after the charge.

### `disputes_enhanced_eligibility`

Eligibility of each dispute for enhanced evidence programs such as Visa Compelling Evidence 3.0.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per dispute.  
**Primary key:** `id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | double |  | verified |  |
| `mastercard_compliance_status` | varchar |  | verified |  |
| `visa_compelling_evidence_3_required_actions` | varchar |  | verified |  |
| `visa_compelling_evidence_3_status` | varchar |  | verified |  |
| `visa_compliance_status` | varchar |  | verified |  |

</details>

### `disputes_metadata`

Metadata key/value pairs set on disputes. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `dispute_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (40, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount` | bigint |  | verified | Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99). |
| `amount_capturable` | bigint |  | verified | Amount that can be captured from this PaymentIntent. |
| `amount_details_discount_amount` | bigint |  | verified | The total discount applied on the transaction represented in the smallest currency unit. An integer greater than 0.

This field is mutually exclusive with the amount_details[line_items][#][discount_amount] field. |
| `amount_details_shipping_amount` | bigint |  | verified | If a physical good is being shipped, the cost of shipping represented in the smallest currency unit. An integer greater than or equal to 0. |
| `amount_details_shipping_from_postal_code` | varchar |  | verified | If a physical good is being shipped, the postal code of where it is being shipped from. At most 10 alphanumeric characters long, hyphens and spaces are allowed. |
| `amount_details_shipping_to_postal_code` | varchar |  | verified | If a physical good is being shipped, the postal code of where it is being shipped to. At most 10 alphanumeric characters long, hyphens and spaces are allowed. |
| `amount_details_surcharge_amount` | bigint |  | verified | Portion of the amount that corresponds to a surcharge. |
| `amount_details_tax_total_tax_amount` | bigint |  | verified | The total amount of tax on the transaction represented in the smallest currency unit. Required for L2 rates. An integer greater than or equal to 0.

This field is mutually exclusive with the amount_details[line_items][#][tax][total_tax_amount] field. |
| `amount_details_tip_amount` | bigint |  | verified | Portion of the amount that corresponds to a tip. |
| `application_fee_amount` | bigint |  | verified | The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account. The amount of the application fee collected will be capped at the total amount captured. For more information, see the PaymentIntents use case for connected accounts. |
| `application_id` | varchar |  | verified | ID of the Connect application that created the PaymentIntent. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `canceled_at` | timestamp |  | verified | Populated when status is canceled, this is the time at which the PaymentIntent was canceled. Measured in seconds since the Unix epoch. |
| `cancellation_reason` | varchar |  | verified | Reason for cancellation of this PaymentIntent, either user-provided (duplicate, fraudulent, requested_by_customer, or abandoned) or generated by Stripe internally (failed_invoice, void_invoice, automatic, or expired). |
| `capture_method` | varchar |  | verified | Controls when the funds will be captured from the customer's account. Values: `automatic`, `automatic_async`, `manual`. |
| `card_request_three_d_secure` | varchar |  | verified | We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. If not provided, this value defaults to automatic. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine. |
| `confirmation_method` | varchar |  | verified | Describes whether we can confirm this PaymentIntent automatically, or if it requires customer action to confirm the payment. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `customer_id` | varchar | foreign | verified | ID of the Customer this PaymentIntent belongs to, if one exists.

Payment methods attached to other Customers cannot be used with this PaymentIntent.

If setup_future_usage is set and this PaymentIntent's payment method is not card_present, then the payment method attaches to the Customer after the PaymentIntent has been confirmed and any required actions from the user are complete. If the payment method is card_present and isn't a digital wallet, then a generated_card payment method representing the card is created and attached to the Customer instead. |
| `description` | varchar |  | verified | An arbitrary string attached to the object. Often useful for displaying to users. |
| `invoice_id` | varchar | foreign | verified | ID of the invoice that created this PaymentIntent, if it exists. |
| `last_payment_error_charge` | varchar |  | verified | For card errors, the ID of the failed charge. |
| `last_payment_error_source` | varchar |  | verified | The source object for errors returned on a request involving a source. |
| `last_payment_error_type` | varchar |  | verified | The type of error returned. One of api_error, card_error, idempotency_error, or invalid_request_error |
| `managed_payments_enabled` | boolean |  | verified | Whether Managed Payments is enabled for this payment intent. |
| `on_behalf_of_id` | varchar |  | verified | You can specify the settlement merchant as the connected account using the on_behalf_of attribute on the charge. See the PaymentIntents use case for connected accounts for details. |
| `payment_details_customer_reference` | varchar |  | verified | A unique value to identify the customer. This field is available only for card payments.

This field is truncated to 25 alphanumeric characters, excluding spaces, before being sent to card networks. |
| `payment_details_order_reference` | varchar |  | verified | A unique value assigned by the business to identify the transaction. Required for L2 and L3 rates.

For Cards, this field is truncated to 25 alphanumeric characters, excluding spaces, before being sent to card networks. For Klarna, this field is truncated to 255 characters and is visible to customers when they view the order in the Klarna app. |
| `payment_method_id` | varchar | foreign | verified | ID of the payment method used in this PaymentIntent. |
| `payment_method_types` | varchar |  | verified | The list of payment method types (e.g. card) that this PaymentIntent is allowed to use. A comprehensive list of valid payment method types can be found here. |
| `presentment_amount` | bigint |  | verified | Amount intended to be collected by this payment, denominated in presentment_currency. |
| `presentment_currency` | varchar |  | verified | Currency presented to the customer during payment. |
| `receipt_email` | varchar |  | verified | Email address that the receipt for the resulting payment will be sent to. If receipt_email is specified for a payment in live mode, a receipt will be sent regardless of your email settings. |
| `review_id` | varchar | foreign | verified | ID of the review associated with this PaymentIntent, if any. |
| `setup_future_usage` | varchar |  | verified | Indicates that you intend to make future payments with this PaymentIntent's payment method.

If you provide a Customer with the PaymentIntent, you can use this parameter to attach the payment method to the Customer after the PaymentIntent is confirmed and the customer completes any required actions. If you don't provide a Customer, you can still attach the payment method to a Customer after the transaction completes.

If the payment method is card_present and isn't a digital wallet, Stripe creates and attaches a generated_card payment method representing the card to the Customer instead.

When processing card payments, Stripe uses setup_future_usage to help you comply with regional legislation and network rules, such as SCA. |
| `statement_descriptor` | varchar |  | verified | Text that appears on the customer's statement as the statement descriptor for a non-card charge. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see the Statement Descriptor docs.

Setting this value for a card charge returns an error. For card charges, set the statement_descriptor_suffix instead. |
| `statement_descriptor_suffix` | varchar |  | verified | Provides information about a card charge. Concatenated to the account's statement descriptor prefix to form the complete statement descriptor that appears on the customer's statement. |
| `status` | varchar |  | verified | Status of this PaymentIntent, one of requires_payment_method, requires_confirmation, requires_action, processing, requires_capture, canceled, or succeeded. Read more about each PaymentIntent status. Values: `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `requires_capture`, `canceled`, `succeeded`. |

</details>

**Joins**

- `payment_intents.customer_id` → `customers.id`
- `payment_intents.invoice_id` → `invoices.id`
- `payment_intents.payment_method_id` → `payment_methods.id`

> Use this table to measure checkout conversion and drop-off; charges only contains attempts that reached the network.

### `payment_intents_metadata`

Metadata key/value pairs set on payment_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, payment_intent_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `payment_intent_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (140, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `charge_id` | varchar | primary | verified | The charge these details describe. |
| `ach_debit_account_holder_type` | varchar |  | verified | Type of entity that holds the account. This can be either individual or company. |
| `ach_debit_bank_name` | varchar |  | verified | Name of the bank associated with the bank account. |
| `ach_debit_country` | varchar |  | verified | Two-letter ISO code representing the country the bank account is located in. |
| `ach_debit_fingerprint` | varchar |  | verified | Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same. |
| `ach_debit_last4` | varchar |  | verified | Last four digits of the bank account number. |
| `ach_debit_routing_number` | varchar |  | verified | Routing transit number of the bank account. |
| `acss_debit_fingerprint` | varchar |  | verified |  |
| `acss_debit_institution_number` | varchar |  | verified | Institution number of the bank account |
| `acss_debit_last4` | varchar |  | verified |  |
| `acss_debit_mandate_id` | varchar |  | verified |  |
| `acss_debit_transit_number` | varchar |  | verified | Transit number of the bank account. |
| `alipay_fingerprint` | varchar |  | verified | Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same. |
| `alipay_transaction_id` | varchar |  | verified | Transaction ID of this particular Alipay transaction. |
| `au_becs_debit_bsb_number` | varchar |  | verified | Bank-State-Branch number of the bank account. |
| `au_becs_debit_fingerprint` | varchar |  | verified | Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same. |
| `au_becs_debit_last4` | varchar |  | verified | Last four digits of the bank account number. |
| `au_becs_debit_mandate_id` | varchar |  | verified | ID of the mandate used to make this payment. |
| `bacs_debit_fingerprint` | varchar |  | verified | Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same. |
| `bacs_debit_last4` | varchar |  | verified | Last four digits of the bank account number. |
| `bacs_debit_mandate_id` | varchar |  | verified | ID of the mandate used to make this payment. |
| `bacs_debit_sort_code` | varchar |  | verified | Sort code of the bank account. (e.g., 10-20-30) |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `bizum_buyer_id` | varchar |  | verified | A unique identifier for the buyer as determined by the local payment processor. |
| `bizum_transaction_id` | varchar |  | verified | The Bizum transaction ID associated with this payment. |
| `boleto_expires_at` | bigint |  | verified | Boleto Expiration Timestamp (UTC) |
| `boleto_number` | varchar |  | verified | Boleto Number |
| `card_3ds_authenticated` | boolean |  | verified | Whether or not authentication was performed. 3D Secure will succeed without authentication when the card is not enrolled. |
| `card_3ds_succeeded` | boolean |  | verified | Whether or not 3D Secure succeeded. |
| `card_3ds_version` | varchar |  | verified | The version of 3D Secure that was used |
| `card_address_line1_check` | varchar |  | verified | If a address line1 was provided, results of the check, one of pass, fail, unavailable, or unchecked. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_address_postal_code_check` | varchar |  | verified | If a address postal code was provided, results of the check, one of pass, fail, unavailable, or unchecked. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_amount_authorized` | bigint |  | verified | The authorized amount |
| `card_authorization_code` | varchar |  | verified | Authorization code on the charge. |
| `card_brand` | varchar |  | verified | Card brand. Can be amex, cartes_bancaires, diners, discover, eftpos_au, jcb, link, mastercard, unionpay, visa or unknown. Values: `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa`, `unknown`. |
| `card_brand_product` | varchar |  | verified | The product code that identifies the specific program or product associated with a card. |
| `card_country` | varchar |  | verified | Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected. |
| `card_cvc_check` | varchar |  | verified | If a CVC was provided, results of the check, one of pass, fail, unavailable, or unchecked. Values: `pass`, `fail`, `unavailable`, `unchecked`. |
| `card_exp_month` | bigint |  | verified | Two-digit number representing the card's expiration month. |
| `card_exp_year` | bigint |  | verified | Four-digit number representing the card's expiration year. |
| `card_fingerprint` | varchar |  | verified | Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.

As of May 1, 2021, card fingerprint in India for Connect changed to allow two fingerprints for the same card---one for India and one for the rest of the world. |
| `card_funding` | varchar |  | verified | Card funding type. Can be credit, debit, prepaid, or unknown. Values: `credit`, `debit`, `prepaid`, `unknown`. |
| `card_generated_card` | varchar |  | verified | ID of a card PaymentMethod generated from the card_present PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod. |
| `card_iin` | varchar |  | verified | Issuer identification number of the card. |
| `card_installments_plan_count` | bigint |  | verified | For fixed_count installment plans, this is the number of installment payments your customer will make to their credit card. |
| `card_installments_plan_interval` | varchar |  | verified | For fixed_count installment plans, this is the interval between installment payments your customer will make to their credit card. One of month. |
| `card_installments_plan_type` | varchar |  | verified | Type of installment plan, one of fixed_count, bonus, or revolving. Values: `fixed_count`, `bonus`, `revolving`. |
| `card_last4` | varchar |  | verified | The last four digits of the card. |
| `card_mandate` | varchar |  | verified | ID of the mandate used to make this payment or created by it. |
| `card_moto` | boolean |  | verified | True if this payment was marked as MOTO and out of scope for SCA. |
| `card_network` | varchar |  | verified | Identifies which network this charge was processed on. Can be amex, cartes_bancaires, diners, discover, eftpos_au, interac, jcb, link, mastercard, unionpay, visa, or unknown. Values: `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `interac`, `jcb`, `link`, `mastercard`, `unionpay`, `visa`, `unknown`. |
| `card_network_token_used` | boolean |  | verified | Indicates if Stripe used a network token, either user provided or Stripe managed when processing the transaction |
| `card_network_transaction_id` | varchar |  | verified | This is used by the financial networks to identify a transaction. Visa calls this the Transaction ID, Mastercard calls this the Trace ID, and American Express calls this the Acquirer Reference Data. This value will be present if it is returned by the financial network in the authorization response, and null otherwise. |
| `card_present_dynamic_currency_conversion_cardholder_rate` | double |  | verified | Exchange rate received by the cardholder, including markup. |
| `card_present_dynamic_currency_conversion_markup_percent` | double |  | verified | Markup percentage added to the transaction_fx_rate to get the cardholder_rate. |
| `card_present_dynamic_currency_conversion_original_amount` | bigint |  | verified | Amount in the original currency before conversion, expressed in minor units. |
| `card_present_dynamic_currency_conversion_original_currency` | varchar |  | verified | Original currency before conversion. |
| `card_present_dynamic_currency_conversion_status` | varchar |  | verified | Whether dynamic currency conversion was performed on this transaction. This can be either enabled or disabled. |
| `card_present_dynamic_currency_conversion_transaction_fx_rate` | double |  | verified | Exchange rate applied to the transaction, excluding markup. |
| `card_read_method` | varchar |  | verified | How card details were read in this transaction. |
| `card_regulated_status` | varchar |  | verified | Status of a card based on the card issuer. |
| `card_transaction_link_id` | varchar |  | verified | Transaction Link ID (TLID) is a unique identifier for a transaction. This is used by some card networks, such as Mastercard, for transaction linking, in addition to Network Transaction IDs. This value will be present if it is returned by the financial network in the authorization response, and null otherwise. |
| `card_wallet_apple_pay_type` | varchar |  | verified | Apple Pay type. Can be apple_pay, apple_pay_later or unknown. Values: `apple_pay`, `apple_pay_later`, `unknown`. |
| `card_wallet_type` | varchar |  | verified | The type of the card wallet |
| `cashapp_buyer_id` | varchar |  | verified | A unique and immutable identifier assigned by Cash App to every buyer. |
| `cashapp_cashtag` | varchar |  | verified | A public identifier for buyers using Cash App. |
| `cashapp_transaction_id` | varchar |  | verified | A unique and immutable identifier of payments assigned by Cash App |
| `customer_balance_bank_transfer_type` | varchar |  | verified |  |
| `customer_balance_funding_type` | varchar |  | verified |  |
| `eps_bank` | varchar |  | verified |  |
| `eps_verified_name` | varchar |  | verified |  |
| `fpx_account_holder_type` | varchar |  | verified |  |
| `fpx_bank` | varchar |  | verified |  |
| `fpx_transaction_id` | varchar |  | verified |  |
| `giropay_bank_code` | varchar |  | verified |  |
| `giropay_bank_name` | varchar |  | verified |  |
| `giropay_bic` | varchar |  | verified |  |
| `giropay_verified_name` | varchar |  | verified |  |
| `ideal_bank` | varchar |  | verified |  |
| `ideal_bic` | varchar |  | verified |  |
| `ideal_generated_sepa_debit_id` | varchar |  | verified |  |
| `ideal_generated_sepa_debit_mandate_id` | varchar |  | verified |  |
| `ideal_iban_last4` | varchar |  | verified |  |
| `ideal_transaction_id` | varchar |  | verified |  |
| `ideal_verified_name` | varchar |  | verified |  |
| `klarna_payer_details_address_country` | varchar |  | verified |  |
| `klarna_payment_method_category` | varchar |  | verified |  |
| `klarna_preferred_locale` | varchar |  | verified |  |
| `konbini_store_chain` | varchar |  | verified |  |
| `link_country` | varchar |  | verified |  |
| `multibanco_entity` | varchar |  | verified |  |
| `multibanco_reference` | varchar |  | verified |  |
| `naver_buyer_id` | varchar |  | verified |  |
| `naver_transaction_id` | varchar |  | verified |  |
| `nz_bank_account_account_holder_name` | varchar |  | verified |  |
| `nz_bank_account_bank_code` | varchar |  | verified |  |
| `nz_bank_account_bank_name` | varchar |  | verified |  |
| `nz_bank_account_branch_code` | varchar |  | verified |  |
| `nz_bank_account_last4` | varchar |  | verified |  |
| `nz_bank_account_suffix` | varchar |  | verified |  |
| `oxxo_number` | varchar |  | verified |  |
| `p24_bank` | varchar |  | verified |  |
| `p24_reference` | varchar |  | verified |  |
| `p24_verified_name` | varchar |  | verified |  |
| `paynow_transaction_id` | varchar |  | verified |  |
| `payto_account_number` | varchar |  | verified |  |
| `payto_bsb_number` | varchar |  | verified |  |
| `payto_last4` | varchar |  | verified |  |
| `payto_mandate` | varchar |  | verified |  |
| `payto_pay_id` | varchar |  | verified |  |
| `pix_bank_transaction_id` | varchar |  | verified |  |
| `pix_fingerprint` | varchar |  | verified |  |
| `promptpay_transaction_id` | varchar |  | verified |  |
| `sepa_debit_bank_code` | varchar |  | verified |  |
| `sepa_debit_branch_code` | varchar |  | verified |  |
| `sepa_debit_country` | varchar |  | verified |  |
| `sepa_debit_fingerprint` | varchar |  | verified | Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same. |
| `sepa_debit_last4` | varchar |  | verified | Last four digits of the bank account number. |
| `sepa_debit_mandate_id` | varchar |  | verified | ID of the mandate used to make this payment. |
| `sofort_bank_code` | varchar |  | verified |  |
| `sofort_bank_name` | varchar |  | verified |  |
| `sofort_bic` | varchar |  | verified |  |
| `sofort_country` | varchar |  | verified |  |
| `sofort_iban_last4` | varchar |  | verified |  |
| `sofort_preferred_language` | varchar |  | verified |  |
| `sofort_verified_name` | varchar |  | verified |  |
| `swish_fingerprint` | varchar |  | verified |  |
| `swish_payment_reference` | varchar |  | verified |  |
| `swish_verified_phone_last4` | varchar |  | verified |  |
| `terminal_location_id` | varchar |  | verified |  |
| `terminal_reader_id` | varchar |  | verified |  |
| `type` | varchar |  | verified | Payment method family, e.g. card, us_bank_account. |
| `us_bank_account_account_holder_type` | varchar |  | verified |  |
| `us_bank_account_account_type` | varchar |  | verified |  |
| `us_bank_account_bank_name` | varchar |  | verified |  |
| `us_bank_account_fingerprint` | varchar |  | verified |  |
| `us_bank_account_last4` | varchar |  | verified |  |
| `us_bank_account_mandate_id` | varchar |  | verified |  |
| `us_bank_account_payment_reference` | varchar |  | verified |  |
| `us_bank_account_routing_number` | varchar |  | verified |  |

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

<details><summary>Columns (87, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed pm_. |
| `acss_debit_fingerprint` | varchar |  | verified |  |
| `acss_debit_institution_number` | varchar |  | verified |  |
| `acss_debit_last4` | varchar |  | verified |  |
| `acss_debit_transit_number` | varchar |  | verified |  |
| `au_becs_debit_bsb_number` | varchar |  | verified |  |
| `au_becs_debit_fingerprint` | varchar |  | verified |  |
| `au_becs_debit_last4` | varchar |  | verified |  |
| `bacs_debit_fingerprint` | varchar |  | verified |  |
| `bacs_debit_last4` | varchar |  | verified |  |
| `bacs_debit_sort_code` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_details_address_city` | varchar |  | verified |  |
| `billing_details_address_country` | varchar |  | verified |  |
| `billing_details_address_line1` | varchar |  | verified |  |
| `billing_details_address_line2` | varchar |  | verified |  |
| `billing_details_address_postal_code` | varchar |  | verified |  |
| `billing_details_address_state` | varchar |  | verified |  |
| `billing_details_email` | varchar |  | verified |  |
| `billing_details_name` | varchar |  | verified |  |
| `billing_details_phone` | varchar |  | verified |  |
| `bizum_buyer_id` | varchar |  | verified |  |
| `boleto_tax_id` | varchar |  | verified |  |
| `card_address_line1_check` | varchar |  | verified |  |
| `card_address_postal_code_check` | varchar |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_brand_product` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_cvc_check` | varchar |  | verified |  |
| `card_exp_month` | bigint |  | verified |  |
| `card_exp_year` | bigint |  | verified |  |
| `card_fingerprint` | varchar |  | verified |  |
| `card_funding` | varchar |  | verified |  |
| `card_generated_from_charge_id` | varchar |  | verified |  |
| `card_iin` | varchar |  | verified |  |
| `card_last4` | varchar |  | verified |  |
| `card_regulated_status` | varchar |  | verified |  |
| `card_three_d_secure_supported` | boolean |  | verified |  |
| `card_wallet_apple_pay_type` | varchar |  | verified |  |
| `card_wallet_type` | varchar |  | verified |  |
| `cashapp_buyer_id` | varchar |  | verified |  |
| `cashapp_cashtag` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the payment method was created (UTC). |
| `custom_type` | varchar |  | verified |  |
| `customer_id` | varchar | foreign | verified | Customer the method is attached to. |
| `eps_bank` | varchar |  | verified |  |
| `fpx_account_holder_type` | varchar |  | verified |  |
| `fpx_bank` | varchar |  | verified |  |
| `ideal_bank` | varchar |  | verified |  |
| `ideal_bic` | varchar |  | verified |  |
| `klarna_dob_day` | bigint |  | verified |  |
| `klarna_dob_month` | bigint |  | verified |  |
| `klarna_dob_year` | bigint |  | verified |  |
| `link_email` | varchar |  | verified |  |
| `naver_buyer_id` | varchar |  | verified |  |
| `naver_funding` | varchar |  | verified |  |
| `nz_bank_account_account_holder_name` | varchar |  | verified |  |
| `nz_bank_account_bank_code` | varchar |  | verified |  |
| `nz_bank_account_bank_name` | varchar |  | verified |  |
| `nz_bank_account_branch_code` | varchar |  | verified |  |
| `nz_bank_account_last4` | varchar |  | verified |  |
| `nz_bank_account_suffix` | varchar |  | verified |  |
| `p24_bank` | varchar |  | verified |  |
| `paypal_country` | varchar |  | verified |  |
| `paypal_payer_email` | varchar |  | verified |  |
| `paypal_payer_id` | varchar |  | verified |  |
| `payto_account_number` | varchar |  | verified |  |
| `payto_bsb_number` | varchar |  | verified |  |
| `payto_last4` | varchar |  | verified |  |
| `payto_pay_id` | varchar |  | verified |  |
| `pix_fingerprint` | varchar |  | verified |  |
| `sepa_debit_bank_code` | varchar |  | verified |  |
| `sepa_debit_branch_code` | varchar |  | verified |  |
| `sepa_debit_country` | varchar |  | verified |  |
| `sepa_debit_fingerprint` | varchar |  | verified |  |
| `sepa_debit_generated_from_charge_id` | varchar |  | verified |  |
| `sepa_debit_generated_from_setup_attempt_id` | varchar |  | verified |  |
| `sepa_debit_last4` | varchar |  | verified |  |
| `sofort_country` | varchar |  | verified |  |
| `type` | varchar |  | verified | Payment method family, e.g. card, us_bank_account, sepa_debit. |
| `upi_vpa` | varchar |  | verified |  |
| `us_bank_account_account_holder_type` | varchar |  | verified |  |
| `us_bank_account_account_type` | varchar |  | verified |  |
| `us_bank_account_fingerprint` | varchar |  | verified |  |
| `us_bank_account_last4` | varchar |  | verified |  |
| `us_bank_account_linked_account` | varchar |  | verified |  |
| `us_bank_account_routing_number` | varchar |  | verified |  |

</details>

**Joins**

- `payment_methods.customer_id` → `customers.id`

### `payment_methods_metadata`

Metadata key/value pairs set on payment_methods. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, payment_method_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `payment_method_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (79, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the payment record. |
| `amount_authorized_currency` | varchar |  | verified |  |
| `amount_authorized_value` | bigint |  | verified |  |
| `amount_canceled_currency` | varchar |  | verified |  |
| `amount_canceled_value` | bigint |  | verified |  |
| `amount_currency` | varchar |  | verified |  |
| `amount_disputed_currency` | varchar |  | verified |  |
| `amount_disputed_value` | bigint |  | verified |  |
| `amount_failed_currency` | varchar |  | verified |  |
| `amount_failed_value` | bigint |  | verified |  |
| `amount_guaranteed_currency` | varchar |  | verified |  |
| `amount_guaranteed_value` | bigint |  | verified |  |
| `amount_refunded_currency` | varchar |  | verified |  |
| `amount_refunded_value` | bigint |  | verified |  |
| `amount_requested_currency` | varchar |  | verified |  |
| `amount_requested_value` | bigint |  | verified |  |
| `amount_value` | bigint |  | verified |  |
| `application` | varchar |  | verified |  |
| `capture_method` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the record was created (UTC). |
| `customer_details_customer` | varchar | foreign | verified |  |
| `customer_details_email` | varchar |  | verified |  |
| `customer_details_name` | varchar |  | verified |  |
| `customer_details_phone` | varchar |  | verified |  |
| `customer_presence` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `initiated_at` | timestamp |  | verified |  |
| `latest_occurred_at` | timestamp |  | verified |  |
| `latest_payment_attempt_record` | varchar |  | verified |  |
| `money_services_transaction_type` | varchar |  | verified |  |
| `payment_method_details_billing_address_city` | varchar |  | verified |  |
| `payment_method_details_billing_address_country` | varchar |  | verified |  |
| `payment_method_details_billing_address_line1` | varchar |  | verified |  |
| `payment_method_details_billing_address_line2` | varchar |  | verified |  |
| `payment_method_details_billing_address_postal_code` | varchar |  | verified |  |
| `payment_method_details_billing_address_state` | varchar |  | verified |  |
| `payment_method_details_billing_email` | varchar |  | verified |  |
| `payment_method_details_billing_name` | varchar |  | verified |  |
| `payment_method_details_billing_phone` | varchar |  | verified |  |
| `payment_method_details_card_brand` | varchar |  | verified |  |
| `payment_method_details_card_capture_before` | timestamp |  | verified |  |
| `payment_method_details_card_country` | varchar |  | verified |  |
| `payment_method_details_card_exp_month` | bigint |  | verified |  |
| `payment_method_details_card_exp_year` | bigint |  | verified |  |
| `payment_method_details_card_fingerprint` | varchar |  | verified |  |
| `payment_method_details_card_funding` | varchar |  | verified |  |
| `payment_method_details_card_last4` | varchar |  | verified |  |
| `payment_method_details_card_moto` | boolean |  | verified |  |
| `payment_method_details_card_network` | varchar |  | verified |  |
| `payment_method_details_card_network_transaction_id` | varchar |  | verified |  |
| `payment_method_details_card_payment_account_reference` | varchar |  | verified |  |
| `payment_method_details_card_wallet_dynamic_last4` | varchar |  | verified |  |
| `payment_method_details_card_wallet_type` | varchar |  | verified |  |
| `payment_method_details_custom_display_name` | varchar |  | verified |  |
| `payment_method_details_custom_type` | varchar |  | verified |  |
| `payment_method_details_payment_method` | varchar | foreign | verified |  |
| `payment_method_details_shared_payment_granted_token` | varchar |  | verified |  |
| `payment_method_details_shop_pay_external_source_id` | varchar |  | verified |  |
| `payment_method_details_type` | varchar |  | verified |  |
| `processor_adyen_merchant_account` | varchar |  | verified |  |
| `processor_adyen_psp_reference` | varchar |  | verified |  |
| `processor_braintree_merchant_account_id` | varchar |  | verified |  |
| `processor_braintree_transaction_id` | varchar |  | verified |  |
| `processor_custom_payment_reference` | varchar |  | verified |  |
| `processor_stripe_charge` | varchar | foreign | verified |  |
| `processor_type` | varchar |  | verified |  |
| `processor_worldpay_merchant_code` | varchar |  | verified |  |
| `processor_worldpay_order_code` | varchar |  | verified |  |
| `reported_by` | varchar |  | verified |  |
| `setup_future_usage` | varchar |  | verified |  |
| `shipping_address_city` | varchar |  | verified |  |
| `shipping_address_country` | varchar |  | verified |  |
| `shipping_address_line1` | varchar |  | verified |  |
| `shipping_address_line2` | varchar |  | verified |  |
| `shipping_address_postal_code` | varchar |  | verified |  |
| `shipping_address_state` | varchar |  | verified |  |
| `shipping_name` | varchar |  | verified |  |
| `shipping_phone` | varchar |  | verified |  |
| `updated` | timestamp |  | verified |  |

</details>

### `payment_records_metadata`

Metadata key/value pairs set on payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 6h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `payment_record_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (10, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed prv_. |
| `batch_timestamp` | timestamp |  | verified |  |
| `charge_id` | varchar | foreign | verified | Charge under review. |
| `created` | timestamp |  | verified | When the review was opened (UTC). |
| `early_fraud_warning_id` | varchar | foreign | verified |  |
| `open` | boolean |  | verified |  |
| `payment_intent_id` | varchar | foreign | verified | PaymentIntent under review. |
| `reason` | varchar |  | verified | Why the payment was flagged. |
| `recommended_refund_confidence_level` | varchar |  | verified |  |
| `recommended_refund_created_at` | timestamp |  | verified |  |

</details>

**Joins**

- `payment_reviews.charge_id` → `charges.id`
- `payment_reviews.early_fraud_warning_id` → `early_fraud_warnings.id`
- `payment_reviews.payment_intent_id` → `payment_intents.id`

### `refunds`

One row per Refund object. Refunds are separate objects from charges; refunding a charge creates a row here and a matching balance transaction.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per refund. A charge may have many partial refunds.  
**Primary key:** `id`

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount` | bigint |  | verified | Amount, in cents. |
| `balance_transaction_id` | varchar | foreign | verified | Balance transaction that describes the impact on your account balance. |
| `batch_timestamp` | timestamp |  | verified | The time in epoch format at which updates to the object were processed through the Stripe Data Pipeline. If the object hasn't changed, the time remains unchanged. This field isn't available in Sigma. It's only available for core API tables, including Connect versions, exported through the Stripe Data Pipeline. |
| `charge_id` | varchar | foreign | verified | ID of the charge that's refunded. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `failure_balance_transaction_id` | varchar | foreign | verified | After the refund fails, this balance transaction describes the adjustment made on your account balance that reverses the initial balance transaction. |
| `failure_reason` | varchar |  | verified | Provides the reason for the refund failure. Possible values are: lost_or_stolen_card, expired_or_canceled_card, charge_for_pending_refund_disputed, insufficient_funds, declined, merchant_request, or unknown. |
| `reason` | varchar |  | verified | Reason for the refund, which is either user-provided (duplicate, fraudulent, or requested_by_customer) or generated by Stripe internally (expired_uncaptured_charge). Values: `duplicate`, `fraudulent`, `requested_by_customer`, `partial_capture`, `expired_uncaptured_charge`. |
| `receipt_number` | varchar |  | verified | This is the transaction number that appears on email receipts sent for this refund. |
| `refund_description` | varchar |  | verified | An arbitrary string attached to the object. You can use this for displaying to users (available on non-card refunds only). |
| `refund_payment_intent` | varchar |  | verified | ID of the PaymentIntent that's refunded. |
| `refund_transfer_reversal_id` | varchar | foreign | verified | This refers to the transfer reversal object if the accompanying transfer reverses. This is only applicable if the charge was created using the destination parameter. |
| `source_transfer_reversal_id` | varchar | foreign | verified | The transfer reversal that's associated with the refund. Only present if the charge came from another Stripe account. |
| `status` | varchar |  | verified | Status of the refund. This can be pending, requires_action, succeeded, failed, or canceled. Learn more about failed refunds. Values: `pending`, `requires_action`, `succeeded`, `failed`, `canceled`. |

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
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `refund_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the decision. |
| `action` | varchar |  | verified | Action the rule took, e.g. request_credentials. |
| `batch_timestamp` | timestamp |  | verified |  |
| `charge_id` | varchar | foreign | verified | Charge the decision applied to, if any. |
| `created` | timestamp |  | verified | When the rule was evaluated (UTC). |
| `payment_intent_id` | varchar | foreign | verified | PaymentIntent the decision applied to. |
| `rule_id` | varchar | foreign | verified | Rule that produced the decision. |
| `rule_override_by_allow_rule` | boolean |  | verified |  |
| `setup_intent_id` | varchar | foreign | verified | SetupIntent the decision applied to, if any. |

</details>

**Joins**

- `rule_decisions.rule_id` → `radar_rules.rule_id`
- `rule_decisions.payment_intent_id` → `payment_intents.id`
- `rule_decisions.charge_id` → `charges.id`
- `rule_decisions.setup_intent_id` → `setup_intents.id`

### `setup_attempts`

Individual attempts to confirm a SetupIntent, including failures.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per setup attempt. A SetupIntent can have several.  
**Primary key:** `id`

<details><summary>Columns (21, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the attempt. |
| `application_id` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the attempt occurred (UTC). |
| `customer_id` | varchar | foreign | verified |  |
| `flow_directions` | varchar |  | verified |  |
| `on_behalf_of_id` | varchar | foreign | verified |  |
| `payment_method_id` | varchar | foreign | verified |  |
| `setup_error_advice_code` | varchar |  | verified |  |
| `setup_error_code` | varchar |  | verified |  |
| `setup_error_decline_code` | varchar |  | verified |  |
| `setup_error_doc_url` | varchar |  | verified |  |
| `setup_error_message` | varchar |  | verified |  |
| `setup_error_network_advice_code` | varchar |  | verified |  |
| `setup_error_network_decline_code` | varchar |  | verified |  |
| `setup_error_param` | varchar |  | verified |  |
| `setup_error_payment_method_id` | varchar | foreign | verified |  |
| `setup_error_type` | varchar |  | verified |  |
| `setup_intent_id` | varchar | foreign | verified | SetupIntent being confirmed. |
| `status` | varchar |  | verified | Outcome of the attempt. |
| `usage` | varchar |  | verified |  |

</details>

**Joins**

- `setup_attempts.setup_intent_id` → `setup_intents.id`
- `setup_attempts.customer_id` → `customers.id`
- `setup_attempts.payment_method_id` → `payment_methods.id`

### `setup_intents`

Attempts to save a payment method for future use without charging it immediately.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per SetupIntent.  
**Primary key:** `id`

<details><summary>Columns (28, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed seti_. |
| `application_id` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `cancellation_reason` | varchar |  | verified |  |
| `card_request_three_d_secure` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the intent was created (UTC). |
| `customer_id` | varchar | foreign | verified | Customer the method is being saved for. |
| `description` | varchar |  | verified |  |
| `flow_directions` | varchar |  | verified |  |
| `last_setup_error_advice_code` | varchar |  | verified |  |
| `last_setup_error_code` | varchar |  | verified |  |
| `last_setup_error_decline_code` | varchar |  | verified |  |
| `last_setup_error_doc_url` | varchar |  | verified |  |
| `last_setup_error_message` | varchar |  | verified |  |
| `last_setup_error_network_advice_code` | varchar |  | verified |  |
| `last_setup_error_network_decline_code` | varchar |  | verified |  |
| `last_setup_error_param` | varchar |  | verified |  |
| `last_setup_error_payment_method_id` | varchar | foreign | verified |  |
| `last_setup_error_type` | varchar |  | verified |  |
| `latest_attempt_id` | varchar | foreign | verified |  |
| `managed_payments_enabled` | boolean |  | verified |  |
| `mandate_id` | varchar | foreign | verified |  |
| `on_behalf_of_id` | varchar | foreign | verified |  |
| `payment_method_id` | varchar | foreign | verified | Payment method being set up. |
| `payment_method_types` | varchar |  | verified |  |
| `single_use_mandate_id` | varchar | foreign | verified |  |
| `status` | varchar |  | verified | Intent status. Values: `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `canceled`, `succeeded`. |
| `usage` | varchar |  | verified |  |

</details>

**Joins**

- `setup_intents.customer_id` → `customers.id`
- `setup_intents.mandate_id` → `mandates.id`
- `setup_intents.payment_method_id` → `payment_methods.id`

### `setup_intents_metadata`

Metadata key/value pairs set on setup_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, setup_intent_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `setup_intent_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (38, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed src_ (or card_ for legacy cards). |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `client_secret` | varchar |  | verified |  |
| `code_verification_attempts_remaining` | bigint |  | verified |  |
| `code_verification_status` | varchar |  | verified |  |
| `created` | timestamp |  | verified | When the source was created (UTC). |
| `currency` | varchar |  | verified |  |
| `flow` | varchar |  | verified |  |
| `owner_address_city` | varchar |  | verified |  |
| `owner_address_country` | varchar |  | verified |  |
| `owner_address_line1` | varchar |  | verified |  |
| `owner_address_line2` | varchar |  | verified |  |
| `owner_address_postal_code` | varchar |  | verified |  |
| `owner_address_state` | varchar |  | verified |  |
| `owner_email` | varchar |  | verified |  |
| `owner_name` | varchar |  | verified |  |
| `owner_phone` | varchar |  | verified |  |
| `owner_verified_address_city` | varchar |  | verified |  |
| `owner_verified_address_country` | varchar |  | verified |  |
| `owner_verified_address_line1` | varchar |  | verified |  |
| `owner_verified_address_line2` | varchar |  | verified |  |
| `owner_verified_address_postal_code` | varchar |  | verified |  |
| `owner_verified_address_state` | varchar |  | verified |  |
| `owner_verified_email` | varchar |  | verified |  |
| `owner_verified_name` | varchar |  | verified |  |
| `owner_verified_phone` | varchar |  | verified |  |
| `receiver_address` | varchar |  | verified |  |
| `receiver_amount_charged` | bigint |  | verified |  |
| `receiver_amount_received` | bigint |  | verified |  |
| `receiver_amount_returned` | bigint |  | verified |  |
| `redirect_failure_reason` | varchar |  | verified |  |
| `redirect_return_url` | varchar |  | verified |  |
| `redirect_status` | varchar |  | verified |  |
| `redirect_url` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `type` | varchar |  | verified | Source type. |
| `usage` | varchar |  | verified |  |

</details>

> Prefer payment_methods for anything built after the Sources API was deprecated.

### `sources_metadata`

Metadata key/value pairs set on sources. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 3h  
**Source:** api_backed  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `source_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed issfr_. |
| `actionable` | boolean |  | verified | Whether you can still act (for example refund) to avoid a chargeback. |
| `batch_timestamp` | timestamp |  | verified |  |
| `charge_id` | varchar | foreign | verified | Charge the warning is about. |
| `created` | timestamp |  | verified | When the warning was received (UTC). |
| `fraud_type` | varchar |  | verified | Type of fraud reported by the network. |

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
**Primary key:** `rule_id`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `rule_id` | varchar | primary | verified | Rule identifier. Built-in rules use fixed string ids such as allow_if_in_allowlist. |
| `action` | varchar |  | verified | What the rule does. Values: `block`, `review`, `allow`, `request_credentials`. |
| `predicate` | varchar |  | verified | The rule expression as written in Radar. |

</details>

> Join to rule_decisions on rule_id to find every payment a rule affected — broader than charges.outcome_rule_id, which misses 3DS rules on PaymentIntents and SetupIntents.

## tax

### `tax_codes` _(not in Stripe's published table list)_

Product categories Stripe Tax uses to determine tax treatment. Contains all generally available tax codes, not just ones you use.

**Freshness:** unpublished  
**Source:** api_backed  
**Grain:** One row per tax code.  
**Primary key:** `id`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Tax code identifier, prefixed txcd_. |
| `description` | varchar |  | verified | Longer explanation of what the code covers. |
| `name` | varchar |  | verified | Short name, e.g. 'General - Tangible Goods'. |

</details>

### `tax_transaction_jurisdiction_details`

Per-jurisdiction breakdown of the tax liability for a tax transaction item.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (tax transaction item, jurisdiction).  
**Primary key:** `tax_transaction_item_id`

<details><summary>Columns (22, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `tax_transaction_id` | varchar | foreign | verified | Parent tax transaction. |
| `tax_transaction_item_id` | varchar | primary | verified | The line item or shipping cost this jurisdiction detail applies to. |
| `amount_non_taxable` | bigint |  | verified | Portion of the item amount that is non-taxable in this jurisdiction, in minor units. |
| `amount_tax` | bigint |  | verified | Tax owed to this jurisdiction, in minor units. Summing across jurisdictions equals the item's amount_tax. |
| `amount_taxable` | bigint |  | verified | Portion of the item amount that is taxable in this jurisdiction, in minor units. |
| `currency` | varchar |  | verified | Integration currency for the amount_* columns. |
| `filing_amount_non_taxable` | bigint |  | verified | amount_non_taxable expressed in the filing currency. |
| `filing_amount_tax` | bigint |  | verified | amount_tax expressed in the filing currency. |
| `filing_amount_taxable` | bigint |  | verified | amount_taxable expressed in the filing currency. |
| `filing_currency` | varchar |  | verified | Currency the tax authority requires for filing. |
| `filing_exchange_rate` | double |  | verified |  |
| `jurisdiction_country` | varchar |  | verified | Two-letter ISO country of the jurisdiction. |
| `jurisdiction_id` | varchar |  | verified |  |
| `jurisdiction_level` | varchar |  | verified | Level of the jurisdiction. Values: `country`, `state`, `county`, `city`, `district`. |
| `jurisdiction_name` | varchar |  | verified | Name of the jurisdiction, e.g. California. |
| `jurisdiction_state` | varchar |  | verified | State/province code of the jurisdiction. |
| `tax_rate_percentage` | double |  | verified | Rate applied by this jurisdiction, as a percentage. |
| `tax_transaction_item_type` | varchar |  | verified | Whether the item is a line item or a shipping cost. |
| `tax_type` | varchar |  | verified | Type of tax, e.g. sales_tax, vat, gst. |
| `tax_type_display_name` | varchar |  | verified |  |
| `taxability` | varchar |  | verified | Taxability determination for the jurisdiction. |
| `taxability_reason` | varchar |  | verified | Why the item was taxed this way, e.g. standard_rated, not_subject_to_tax. |

</details>

**Joins**

- `tax_transaction_jurisdiction_details.tax_transaction_id` → `tax_transactions.id`

> Summing amount_taxable or amount_non_taxable across jurisdictions does NOT equal the item's amount — jurisdictions overlap. Only amount_tax sums correctly.

> US country-level rows are always non-taxable; exclude them to match Stripe's itemized tax export.

### `tax_transaction_line_items`

Line items contributing to the sale of goods for a tax transaction.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per tax line item.  
**Primary key:** `id`

<details><summary>Columns (30, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the tax transaction line item. |
| `amount` | bigint |  | verified | The amount in the smallest currency unit. This includes taxes when tax_behavior is inclusive. |
| `amount_tax` | bigint |  | verified | The amount of tax calculated for the tax transaction line item, in the smallest currency unit. |
| `currency` | varchar |  | verified | The three-letter ISO code for the currency in which amount is defined. This is the integration currency, which can differ from both the settlement currency and the tax authority's local filing currency. |
| `determined_destination_address_city` | varchar |  | verified | The city, district, suburb, town, or village of the customer's address as determined by Stripe Tax using available customer details. |
| `determined_destination_address_country` | varchar |  | verified | The country of the customer's address as determined by Stripe Tax using available customer details. This is a two-letter ISO 3166-1 alpha-2 code. |
| `determined_destination_address_line1` | varchar |  | verified | The line 1 of the customer's address as determined by Stripe Tax using available customer details. |
| `determined_destination_address_line2` | varchar |  | verified | The line 2 of the customer's address as determined by Stripe Tax using available customer details. |
| `determined_destination_address_postal_code` | varchar |  | verified | The ZIP or postal code of the customer's address as determined by Stripe Tax using available customer details. |
| `determined_destination_address_state` | varchar |  | verified | The state, county, province, or region of the customer's address as determined by Stripe Tax using available customer details. This is a ISO 3166-2 code without the country prefix. |
| `determined_origin_address_city` | varchar |  | verified | The city, district, suburb, town, or village of the tax transaction's origin address as determined by Stripe Tax. |
| `determined_origin_address_country` | varchar |  | verified | The country of the tax transaction's origin address as determined by Stripe Tax. This is a two-letter ISO 3166-1 alpha-2 code. |
| `determined_origin_address_line1` | varchar |  | verified | The line 1 of the tax transaction's origin address as determined by Stripe Tax. |
| `determined_origin_address_line2` | varchar |  | verified | The line 2 of the tax transaction's origin address as determined by Stripe Tax. |
| `determined_origin_address_postal_code` | varchar |  | verified | The ZIP or postal code of the tax transaction's origin address as determined by Stripe Tax. |
| `determined_origin_address_state` | varchar |  | verified | The state, county, province, or region of the tax transaction's origin address as determined by Stripe Tax. This is a ISO 3166-2 code without the country prefix. |
| `determined_tax_location_address_city` | varchar |  | verified | The city, district, suburb, town, or village of the tax location address as determined by Stripe Tax. |
| `determined_tax_location_address_country` | varchar |  | verified | The country of the tax location address as determined by Stripe Tax. This is a two-letter ISO 3166-1 alpha-2 code. |
| `determined_tax_location_address_line1` | varchar |  | verified | The line 1 of the tax location address as determined by Stripe Tax. |
| `determined_tax_location_address_line2` | varchar |  | verified | The line 2 of the tax location address as determined by Stripe Tax. |
| `determined_tax_location_address_postal_code` | varchar |  | verified | The ZIP or postal code of the tax location address as determined by Stripe Tax. |
| `determined_tax_location_address_state` | varchar |  | verified | The state, county, province, or region of the tax location address as determined by Stripe Tax. This is a ISO 3166-2 code without the country prefix. |
| `product_id` | varchar | foreign | verified | The ID of the product associated with the tax transaction line item. This will only be set when the tax transaction source_type is external. |
| `quantity_decimal` | varchar |  | verified | The number of units being purchased or reversed when the tax transaction type is reversal. This value is represented as a decimal string. |
| `reference` | varchar |  | verified | A custom identifier for the tax transaction line item. This will only be set when the tax transaction source_type is external. |
| `reversal_original_tax_transaction_line_item_id` | varchar | foreign | verified | The ID of the original tax transaction line item that was reversed when the tax transaction type is reversal. |
| `source_line_item_id` | varchar | foreign | verified | The ID of the line item associated with the tax transaction line item (for example, an invoice line item ID when the tax transaction source_type is invoice). This will be equal to reference when tax_transactions source_type is external. |
| `tax_behavior` | varchar |  | verified | Indicates whether amount includes taxes. Taxes are included in amount when tax_behavior is inclusive and excluded from amount when tax_behavior is exclusive. Possible values are inclusive and exclusive. Values: `inclusive`, `exclusive`. |
| `tax_code` | varchar | foreign | verified | The product tax code associated with the tax transaction line item. |
| `tax_transaction_id` | varchar | foreign | verified | The ID of the tax transaction associated with the tax transaction line item. |

</details>

**Joins**

- `tax_transaction_line_items.tax_transaction_id` → `tax_transactions.id`
- `tax_transaction_line_items.tax_code` → `tax_codes.id`
- `tax_transaction_line_items.product_id` → `products.id`

> Net sales excluding tax = case when tax_behavior = 'inclusive' then amount - amount_tax else amount end.

### `tax_transaction_line_items_metadata`

Metadata key/value pairs set on tax_transaction_line_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `tax_transaction_line_item_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (26, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier. |
| `amount` | bigint |  | verified | Gross shipping amount in minor units. |
| `amount_tax` | bigint |  | verified | Tax liability on shipping, in minor units. |
| `currency` | varchar |  | verified | Integration currency for the amounts. |
| `determined_destination_address_city` | varchar |  | verified |  |
| `determined_destination_address_country` | varchar |  | verified |  |
| `determined_destination_address_line1` | varchar |  | verified |  |
| `determined_destination_address_line2` | varchar |  | verified |  |
| `determined_destination_address_postal_code` | varchar |  | verified |  |
| `determined_destination_address_state` | varchar |  | verified |  |
| `determined_origin_address_city` | varchar |  | verified |  |
| `determined_origin_address_country` | varchar |  | verified |  |
| `determined_origin_address_line1` | varchar |  | verified |  |
| `determined_origin_address_line2` | varchar |  | verified |  |
| `determined_origin_address_postal_code` | varchar |  | verified |  |
| `determined_origin_address_state` | varchar |  | verified |  |
| `determined_tax_location_address_city` | varchar |  | verified |  |
| `determined_tax_location_address_country` | varchar |  | verified |  |
| `determined_tax_location_address_line1` | varchar |  | verified |  |
| `determined_tax_location_address_line2` | varchar |  | verified |  |
| `determined_tax_location_address_postal_code` | varchar |  | verified |  |
| `determined_tax_location_address_state` | varchar |  | verified |  |
| `shipping_rate_id` | varchar |  | verified |  |
| `tax_behavior` | varchar |  | verified | Whether amount includes tax. Values: `inclusive`, `exclusive`. |
| `tax_code` | varchar | foreign | verified | Tax code applied to shipping. |
| `tax_transaction_id` | varchar | foreign | verified | Parent tax transaction. |

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

<details><summary>Columns (20, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the tax transaction. |
| `created` | timestamp |  | verified | The time at which the tax transaction was created. Measured in seconds since the Unix epoch. |
| `customer_details_address_city` | varchar |  | verified | The city, district, suburb, town, or village of the customer's address at the time the tax transaction was recorded. |
| `customer_details_address_country` | varchar |  | verified | The country of the customer's address at the time the tax transaction was recorded. This is a two-letter ISO 3166-1 alpha-2 code when source_type is external, otherwise it's freeform. |
| `customer_details_address_line1` | varchar |  | verified | The line 1 of the customer's address at the time the tax transaction was recorded (for example, street, PO Box, or company name). |
| `customer_details_address_line2` | varchar |  | verified | The line 2 of the customer's address at the time the tax transaction was recorded (for example, apartment, suite, unit, or building). |
| `customer_details_address_postal_code` | varchar |  | verified | The ZIP or postal code of the customer's address at the time the tax transaction was recorded. |
| `customer_details_address_source` | varchar |  | verified | The type of customer address applicable to the tax transaction. Possible values are billing and shipping. Values: `billing`, `shipping`. |
| `customer_details_address_state` | varchar |  | verified | The state, county, province, or region of the customer's address at the time the tax transaction was recorded. This value is freeform. |
| `customer_details_ip_address` | varchar |  | verified | The customer's IP address. This will be either an IPv4 or IPv6 address. |
| `customer_details_taxability_override` | varchar |  | verified | The taxability override used for taxation. Possible values are customer_exempt, reverse_charge and none. Values: `customer_exempt`, `reverse_charge`. |
| `customer_id` | varchar | foreign | verified | The ID of the customer associated with the tax transaction. |
| `posted_at` | timestamp |  | verified | The time at which the tax liability is assumed or reduced. Measured in seconds since the Unix epoch. |
| `provider` | varchar |  | verified | The origin of the tax transaction. This will be stripe for Stripe transactions or the platform specified in an import for third-party transactions. |
| `reference` | varchar |  | verified | A custom identifier for the tax transaction. This will only be set when source_type is external. |
| `reversal_original_tax_transaction_id` | varchar | foreign | verified | The ID of original tax transaction that was reversed when type is reversal. |
| `source_id` | varchar | foreign | verified | The ID of the object that triggered the creation of the tax transaction. This will be equal to reference when source_type is external. |
| `source_type` | varchar |  | verified | The type of object that triggered the creation of the tax transaction. Possible values are checkout, credit_note, external, invoice, payment_intent and refund. Values: `checkout`, `credit_note`, `external`, `invoice`, `payment_intent`, `refund`. |
| `tax_date` | timestamp |  | verified | The time at which effective tax rules and rates were applied to the tax transaction. Measured in seconds since the Unix epoch. |
| `type` | varchar |  | verified | The type of tax transaction. The transaction reverses an earlier transaction when type is reversal. Possible values are transaction and reversal. Values: `transaction`, `reversal`. |

</details>

**Joins**

- `tax_transactions.customer_id` → `customers.id`
- `tax_transactions.source_id` → `sources.id`

> Join to invoices or checkout_sessions on source_id, filtering by source_type first.

### `tax_transactions_metadata`

Metadata key/value pairs set on tax_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `tax_transaction_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (45, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the form. |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `payee_account_id` | varchar |  | verified |  |
| `payee_type` | varchar |  | verified |  |
| `type` | varchar |  | verified | Form type, e.g. 1099-K, 1099-MISC. |
| `us_1099_k_april_volume` | bigint |  | verified |  |
| `us_1099_k_august_volume` | bigint |  | verified |  |
| `us_1099_k_card_not_present_volume` | bigint |  | verified |  |
| `us_1099_k_december_volume` | bigint |  | verified |  |
| `us_1099_k_february_volume` | bigint |  | verified |  |
| `us_1099_k_federal_income_tax_withheld` | bigint |  | verified |  |
| `us_1099_k_january_volume` | bigint |  | verified |  |
| `us_1099_k_july_volume` | bigint |  | verified |  |
| `us_1099_k_june_volume` | bigint |  | verified |  |
| `us_1099_k_march_volume` | bigint |  | verified |  |
| `us_1099_k_may_volume` | bigint |  | verified |  |
| `us_1099_k_november_volume` | bigint |  | verified |  |
| `us_1099_k_october_volume` | bigint |  | verified |  |
| `us_1099_k_reporting_year` | bigint |  | verified |  |
| `us_1099_k_september_volume` | bigint |  | verified |  |
| `us_1099_k_state_income_tax_withheld` | bigint |  | verified |  |
| `us_1099_k_transactions_count` | bigint |  | verified |  |
| `us_1099_misc_crop_insurance_proceeds` | bigint |  | verified |  |
| `us_1099_misc_excess_golden_parachute_payments` | bigint |  | verified |  |
| `us_1099_misc_federal_income_tax_withheld` | bigint |  | verified |  |
| `us_1099_misc_fish_purchased_for_resale` | bigint |  | verified |  |
| `us_1099_misc_fishing_boat_proceeds` | bigint |  | verified |  |
| `us_1099_misc_medical_and_health_care_payments` | bigint |  | verified |  |
| `us_1099_misc_non_qualified_deferred_compensation` | bigint |  | verified |  |
| `us_1099_misc_other_income` | bigint |  | verified |  |
| `us_1099_misc_payments_in_lieu_of_dividends_or_interest` | bigint |  | verified |  |
| `us_1099_misc_payments_to_attorney` | bigint |  | verified |  |
| `us_1099_misc_rents` | bigint |  | verified |  |
| `us_1099_misc_reporting_year` | bigint |  | verified |  |
| `us_1099_misc_royalties` | bigint |  | verified |  |
| `us_1099_misc_section_409a_deferrals` | bigint |  | verified |  |
| `us_1099_misc_state_income` | bigint |  | verified |  |
| `us_1099_misc_state_tax_withheld` | bigint |  | verified |  |
| `us_1099_nec_federal_income_tax_withheld` | bigint |  | verified |  |
| `us_1099_nec_nonemployee_compensation` | bigint |  | verified |  |
| `us_1099_nec_reporting_year` | bigint |  | verified |  |
| `us_1099_nec_state_income` | bigint |  | verified |  |
| `us_1099_nec_state_income_tax_withheld` | bigint |  | verified |  |

</details>

## terminal

### `terminal_hardware_order_items`

Line items on a Terminal hardware order.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per item on an order.  
**Primary key:** `terminal_hardware_order_id, terminal_hardware_sku_id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `terminal_hardware_order_id` | varchar | primary | verified | Parent hardware order. |
| `terminal_hardware_sku_id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified | Line amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `quantity` | bigint |  | verified | Quantity ordered. |
| `terminal_hardware_sku_amount` | bigint |  | verified |  |
| `terminal_hardware_sku_country` | varchar |  | verified |  |
| `terminal_hardware_sku_currency` | varchar |  | verified |  |
| `terminal_hardware_sku_product_id` | varchar |  | verified |  |
| `terminal_hardware_sku_product_type` | varchar |  | verified |  |

</details>

**Joins**

- `terminal_hardware_order_items.terminal_hardware_order_id` → `terminal_hardware_orders.id`

### `terminal_hardware_order_metadata`

Metadata key/value pairs set on terminal_hardware_orders. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, terminal_hardware_order_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `terminal_hardware_order_id` | varchar | primary | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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
**Primary key:** `carrier, terminal_hardware_order_id, tracking_number`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `carrier` | varchar | primary | verified | Shipping carrier. |
| `terminal_hardware_order_id` | varchar | primary | verified | Parent hardware order. |
| `tracking_number` | varchar | primary | verified | Carrier tracking number. |
| `batch_timestamp` | timestamp |  | verified |  |

</details>

### `terminal_hardware_order_tax_amounts`

Tax applied to a Terminal hardware order.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (order, tax component).  
**Primary key:** `rate_display_name, rate_jurisdiction, terminal_hardware_order_id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `rate_display_name` | varchar | primary | verified |  |
| `rate_jurisdiction` | varchar | primary | verified |  |
| `terminal_hardware_order_id` | varchar | primary | verified | Parent hardware order. |
| `amount` | bigint |  | verified | Tax amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `inclusive` | boolean |  | verified |  |
| `rate_percentage` | double |  | verified |  |

</details>

### `terminal_hardware_orders`

Orders you placed for Terminal reader hardware.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per hardware order.  
**Primary key:** `id`

<details><summary>Columns (24, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the order. |
| `amount` | bigint |  | verified | Order total in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the order was placed (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `livemode` | boolean |  | verified |  |
| `payment_type` | varchar |  | verified |  |
| `po_number` | varchar |  | verified |  |
| `shipping_address_city` | varchar |  | verified |  |
| `shipping_address_country` | varchar |  | verified |  |
| `shipping_address_line1` | varchar |  | verified |  |
| `shipping_address_line2` | varchar |  | verified |  |
| `shipping_address_postal_code` | varchar |  | verified |  |
| `shipping_address_state` | varchar |  | verified |  |
| `shipping_amount` | bigint |  | verified |  |
| `shipping_company` | varchar |  | verified |  |
| `shipping_currency` | varchar |  | verified |  |
| `shipping_email` | varchar |  | verified |  |
| `shipping_method_name` | varchar |  | verified |  |
| `shipping_name` | varchar |  | verified |  |
| `shipping_phone` | varchar |  | verified |  |
| `status` | varchar |  | verified | Order status. |
| `tax` | bigint |  | verified |  |
| `updated` | timestamp |  | verified |  |

</details>

### `terminal_locations`

Physical locations where you operate Terminal card readers.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per location.  
**Primary key:** `id`

<details><summary>Columns (28, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `address_city` | varchar |  | verified | City of the location. |
| `address_country` | varchar |  | verified | Two-letter ISO country of the location. |
| `address_kana_city` | varchar |  | verified |  |
| `address_kana_country` | varchar |  | verified |  |
| `address_kana_line1` | varchar |  | verified |  |
| `address_kana_line2` | varchar |  | verified |  |
| `address_kana_postal_code` | varchar |  | verified |  |
| `address_kana_state` | varchar |  | verified |  |
| `address_kana_town` | varchar |  | verified |  |
| `address_kanji_city` | varchar |  | verified |  |
| `address_kanji_country` | varchar |  | verified |  |
| `address_kanji_line1` | varchar |  | verified |  |
| `address_kanji_line2` | varchar |  | verified |  |
| `address_kanji_postal_code` | varchar |  | verified |  |
| `address_kanji_state` | varchar |  | verified |  |
| `address_kanji_town` | varchar |  | verified |  |
| `address_line1` | varchar |  | verified |  |
| `address_line2` | varchar |  | verified |  |
| `address_postal_code` | varchar |  | verified |  |
| `address_state` | varchar |  | verified |  |
| `id` | varchar | primary | verified | Unique identifier, prefixed tml_. |
| `livemode` | boolean |  | verified |  |
| `metadata` | varchar |  | verified |  |
| `name` | varchar |  | verified |  |
| `name_kana` | varchar |  | verified |  |
| `name_kanji` | varchar |  | verified |  |
| `phone` | varchar |  | verified |  |
| `zone_id` | varchar |  | verified |  |

</details>

### `terminal_readers`

Terminal card reader devices registered to your account.

**Freshness:** 120h  
**Source:** derived  
**Grain:** One row per reader.  
**Primary key:** `id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `device_type` | varchar |  | verified | Reader hardware model. |
| `id` | varchar | primary | verified | Unique identifier, prefixed tmr_. |
| `label` | varchar |  | verified | Reader label. |
| `livemode` | boolean |  | verified |  |
| `location_id` | varchar | foreign | verified | Location the reader is assigned to. |
| `metadata` | varchar |  | verified |  |
| `serial_number` | varchar |  | verified |  |

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

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed trr_. |
| `amount` | bigint |  | verified | Reversed amount in minor currency units. |
| `balance_transaction_id` | varchar | foreign | verified | Balance transaction recording the reversal. |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the reversal was created (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `destination_payment_refund_id` | varchar | foreign | verified |  |
| `source_refund_id` | varchar | foreign | verified |  |
| `transfer_id` | varchar | foreign | verified | Transfer being reversed. |

</details>

**Joins**

- `transfer_reversals.transfer_id` → `transfers.id`
- `transfer_reversals.balance_transaction_id` → `balance_transactions.id`

### `transfer_reversals_metadata`

Metadata key/value pairs set on transfer_reversals. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `transfer_reversal_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (30, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the object. |
| `amount` | bigint |  | verified | Amount (in cents) to be transferred to your bank account. |
| `amount_reversed` | bigint |  | verified | Amount in cents reversed (can be less than the amount attribute on the transfer if a partial reversal was issued). This field applies to Connect transfer reversals only and differs from the reversed_by and original_payout fields, which link payout reversals. |
| `application_fee_amount` | bigint |  | verified | The amount of the application fee (if any) requested for the payout. |
| `application_fee_id` | varchar | foreign | verified | The application fee (if any). See the Connect documentation for details. |
| `automatic` | boolean |  | verified | Returns true if the payout was created by an automated payout schedule, and false if it was requested manually. |
| `balance_transaction_id` | varchar | foreign | verified | Balance transaction that describes the impact of this transfer on your account balance. |
| `batch_timestamp` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `created` | timestamp |  | verified | Time at which the object was created. Measured in seconds since the Unix epoch. |
| `currency` | varchar |  | verified | Three-letter ISO currency code, in lowercase. Must be a supported currency. |
| `date` | timestamp |  | verified | Date the transfer is scheduled to arrive in the bank. This factors in delays like weekends or bank holidays. |
| `description` | varchar |  | verified | Free-text description. |
| `destination_id` | varchar | foreign | verified | ID of the bank account, card, or Stripe account the transfer was sent to. |
| `destination_payment_id` | varchar | foreign | verified | If the destination is a Stripe account, this will be the ID of the payment that the destination account received for the transfer. |
| `failure_code` | varchar |  | verified | Error code explaining reason for transfer failure if available. See Types of transfer failures for a list of failure codes. |
| `failure_message` | varchar |  | verified | Message to user further explaining reason for transfer failure if available. |
| `kind` | varchar |  | verified |  |
| `original_payout` | varchar |  | verified | If the payout reverses another, this is the ID of the original payout. This field links a reversing payout back to the payout it reversed and differs from the reversed Boolean and amount_reversed fields, which apply to Connect transfer reversals only. |
| `payout_method` | varchar |  | verified | ID of the v2 FinancialAccount the funds were sent to. |
| `reversed` | boolean |  | verified | Whether the transfer has been fully reversed. If the transfer is only partially reversed, this attribute will still be false. This field applies to Connect transfer reversals only and differs from the reversed_by and original_payout fields, which link payout reversals. |
| `reversed_by` | varchar |  | verified | If the payout reverses, this is the ID of the payout that reverses this payout. This field links payout reversals to their originals and differs from the reversed Boolean and amount_reversed fields, which apply to Connect transfer reversals only. |
| `source_transaction_id` | varchar | foreign | verified | ID of the charge (or other transaction) that was used to fund the transfer. If null, the transfer was funded from the available balance. |
| `source_type` | varchar |  | verified | The source balance this transfer came from. One of card, fpx, or bank_account. Values: `card`, `fpx`, `bank_account`. |
| `statement_descriptor` | varchar |  | verified | Extra information about a transfer to be displayed on the user's bank statement. |
| `status` | varchar |  | verified | Payout status. Values: `paid`, `pending`, `in_transit`, `canceled`, `failed`. |
| `trace_id` | varchar |  | verified |  |
| `trace_id_status` | varchar |  | verified |  |
| `transfer_group` | varchar |  | verified | A string that identifies this transaction as part of a group. See the Connect documentation for details. |
| `transfer_instruction` | varchar |  | verified |  |
| `type` | varchar |  | verified | Can be card, bank_account, or stripe_account. Values: `card`, `bank_account`, `stripe_account`. |

</details>

**Joins**

- `transfers.application_fee_id` → `application_fees.id`
- `transfers.balance_transaction_id` → `balance_transactions.id`

> Reconcile a payout to its components with: balance_transactions.automatic_transfer_id = transfers.id.

> Manual payouts cannot be reconciled to specific balance transactions — the amount is arbitrary.

### `transfers_metadata`

Metadata key/value pairs set on transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `transfer_id` | varchar | foreign | verified | References the id column of the parent object table. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

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

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier, prefixed fa_. |
| `batch_timestamp` | timestamp |  | verified |  |
| `country` | varchar |  | verified | Two-letter ISO country of the account. |
| `created` | timestamp |  | verified | When the account was created (UTC). |
| `status` | varchar |  | verified | Account status. Values: `open`, `closed`. |
| `status_details_closed_reasons` | varchar |  | verified |  |

</details>

### `treasury_financial_accounts_metadata`

Metadata key/value pairs set on treasury_financial_accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `financial_account_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `financial_account_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_financial_account_id, map_agg(key, value) as md from treasury_financial_accounts_metadata group by 1

### `treasury_inbound_transfers`

Money pulled into a Treasury financial account from an external bank account.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per inbound transfer.  
**Primary key:** `id`

<details><summary>Columns (19, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the transfer. |
| `amount` | bigint |  | verified | Amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `cancelable` | boolean |  | verified |  |
| `created` | timestamp |  | verified | When the transfer was created (UTC). |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failure_details_code` | varchar |  | verified |  |
| `financial_account_id` | varchar | foreign | verified | Destination financial account. |
| `linked_flows_received_debit_id` | varchar | foreign | verified |  |
| `origin_payment_method_details_us_bank_account_network` | varchar |  | verified |  |
| `origin_payment_method_id` | varchar | foreign | verified |  |
| `returned` | boolean |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified | Transfer status. |
| `status_transitions_canceled_at` | timestamp |  | verified |  |
| `status_transitions_failed_at` | timestamp |  | verified |  |
| `status_transitions_succeeded_at` | timestamp |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

### `treasury_inbound_transfers_metadata`

Metadata key/value pairs set on treasury_inbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `inbound_transfer_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `inbound_transfer_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_inbound_transfer_id, map_agg(key, value) as md from treasury_inbound_transfers_metadata group by 1

### `treasury_outbound_payments`

Money sent from a Treasury financial account to a third party.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per outbound payment.  
**Primary key:** `id`

<details><summary>Columns (28, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the payment. |
| `amount` | bigint |  | verified | Amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `cancelable` | boolean |  | verified |  |
| `created` | timestamp |  | verified | When the payment was created (UTC). |
| `currency` | varchar |  | verified |  |
| `customer_id` | varchar | foreign | verified |  |
| `description` | varchar |  | verified |  |
| `destination_payment_method_details_financial_account_id` | varchar | foreign | verified |  |
| `destination_payment_method_details_type` | varchar |  | verified |  |
| `destination_payment_method_details_us_bank_account_network` | varchar |  | verified |  |
| `destination_payment_method_id` | varchar | foreign | verified |  |
| `end_user_details_ip_address` | varchar |  | verified |  |
| `end_user_details_present` | boolean |  | verified |  |
| `expected_arrival_date` | timestamp |  | verified |  |
| `financial_account_id` | varchar | foreign | verified | Source financial account. |
| `returned_details_code` | varchar |  | verified |  |
| `returned_details_transaction_id` | varchar | foreign | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified | Payment status. |
| `status_transitions_canceled_at` | timestamp |  | verified |  |
| `status_transitions_failed_at` | timestamp |  | verified |  |
| `status_transitions_posted_at` | timestamp |  | verified |  |
| `status_transitions_returned_at` | timestamp |  | verified |  |
| `tracking_details_ach_trace_id` | varchar |  | verified |  |
| `tracking_details_us_domestic_wire_imad` | varchar |  | verified |  |
| `tracking_details_us_domestic_wire_omad` | varchar |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

**Joins**

- `treasury_outbound_payments.customer_id` → `customers.id`

### `treasury_outbound_payments_metadata`

Metadata key/value pairs set on treasury_outbound_payments. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, outbound_payment_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `outbound_payment_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_outbound_payment_id, map_agg(key, value) as md from treasury_outbound_payments_metadata group by 1

### `treasury_outbound_transfers`

Money sent from a Treasury financial account to an external bank account you own.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per outbound transfer.  
**Primary key:** `id`

<details><summary>Columns (25, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the transfer. |
| `amount` | bigint |  | verified | Amount in minor currency units. |
| `batch_timestamp` | timestamp |  | verified |  |
| `cancelable` | boolean |  | verified |  |
| `created` | timestamp |  | verified | When the transfer was created (UTC). |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `destination_payment_method_details_type` | varchar |  | verified |  |
| `destination_payment_method_details_us_bank_account_ach_submission` | varchar |  | verified |  |
| `destination_payment_method_details_us_bank_account_network` | varchar |  | verified |  |
| `destination_payment_method_id` | varchar | foreign | verified |  |
| `expected_arrival_date` | timestamp |  | verified |  |
| `financial_account_id` | varchar | foreign | verified | Source financial account. |
| `returned_details_code` | varchar |  | verified |  |
| `returned_details_transaction_id` | varchar | foreign | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified | Transfer status. |
| `status_transitions_canceled_at` | timestamp |  | verified |  |
| `status_transitions_failed_at` | timestamp |  | verified |  |
| `status_transitions_posted_at` | timestamp |  | verified |  |
| `status_transitions_returned_at` | timestamp |  | verified |  |
| `tracking_details_ach_trace_id` | varchar |  | verified |  |
| `tracking_details_us_domestic_wire_imad` | varchar |  | verified |  |
| `tracking_details_us_domestic_wire_omad` | varchar |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

### `treasury_outbound_transfers_metadata`

Metadata key/value pairs set on treasury_outbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per (object, metadata key) pair. Objects with no metadata have no rows.  
**Primary key:** `key, outbound_transfer_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified | The metadata key set on the object. |
| `outbound_transfer_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified | The metadata value for that key. Always a string, even when it holds a number or boolean. |

</details>

> Values are always strings, even when they hold numbers or booleans.

> Pivot to columns with: select treasury_outbound_transfer_id, map_agg(key, value) as md from treasury_outbound_transfers_metadata group by 1

### `treasury_transaction_entries`

Individual ledger entries making up a Treasury transaction.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per entry.  
**Primary key:** `id`

<details><summary>Columns (13, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the entry. |
| `balance_impact_cash` | bigint |  | verified |  |
| `balance_impact_inbound_pending` | bigint |  | verified |  |
| `balance_impact_outbound_pending` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `financial_account_id` | varchar | foreign | verified |  |
| `flow_id` | varchar |  | verified |  |
| `flow_type` | varchar |  | verified |  |
| `transaction_id` | varchar | foreign | verified | Parent Treasury transaction. |
| `type` | varchar |  | verified |  |

</details>

**Joins**

- `treasury_transaction_entries.transaction_id` → `treasury_transactions.id`

### `treasury_transactions`

Ledger of all money movement on Treasury financial accounts.

**Freshness:** 24h  
**Source:** derived  
**Grain:** One row per Treasury transaction.  
**Primary key:** `id`

<details><summary>Columns (15, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified | Unique identifier for the transaction. |
| `amount` | bigint |  | verified | Signed amount in minor currency units. |
| `balance_impact_cash` | bigint |  | verified |  |
| `balance_impact_inbound_pending` | bigint |  | verified |  |
| `balance_impact_outbound_pending` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified | When the transaction occurred (UTC). |
| `currency` | varchar |  | verified | Three-letter ISO currency code, lowercase. |
| `description` | varchar |  | verified |  |
| `financial_account_id` | varchar | foreign | verified | Financial account affected. |
| `flow_id` | varchar |  | verified |  |
| `flow_type` | varchar |  | verified |  |
| `status` | varchar |  | verified | Transaction status. |
| `status_transitions_posted_at` | timestamp |  | verified |  |
| `status_transitions_void_at` | timestamp |  | verified |  |

</details>

**Joins**

- `treasury_transactions.financial_account_id` → `treasury_financial_accounts.id`

## unclassified

### `acceptance_reporting_preaggregated_deduplicated_v2` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (20, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `attributable_optimization` | varchar |  | verified |  |
| `blocked_by_default_high_risk_rule_count` | bigint |  | verified |  |
| `blocked_by_radar_rule_count` | bigint |  | verified |  |
| `blocked_by_stripe_count` | bigint |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `created_day` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `outcome_reason` | varchar |  | verified |  |
| `outcome_rule_id` | varchar |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `transaction_amount` | bigint |  | verified |  |
| `transaction_amount_in_usd` | bigint |  | verified |  |
| `transaction_count` | bigint |  | verified |  |

</details>

### `acceptance_reporting_preaggregated_deduplicated_v3` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (23, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `attributable_optimization` | varchar |  | verified |  |
| `blocked_by_default_high_risk_rule_count` | bigint |  | verified |  |
| `blocked_by_radar_rule_count` | bigint |  | verified |  |
| `blocked_by_stripe_count` | bigint |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `cof` | boolean |  | verified |  |
| `created_day` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `nsf_count` | bigint |  | verified |  |
| `outcome_reason` | varchar |  | verified |  |
| `outcome_rule_id` | varchar |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `transaction_amount` | bigint |  | verified |  |
| `transaction_amount_in_usd` | bigint |  | verified |  |
| `transaction_count` | bigint |  | verified |  |
| `used_network_tokens` | boolean |  | verified |  |

</details>

### `acceptance_reporting_preaggregated_v2` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (20, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `attributable_optimization` | varchar |  | verified |  |
| `blocked_by_default_high_risk_rule_count` | bigint |  | verified |  |
| `blocked_by_radar_rule_count` | bigint |  | verified |  |
| `blocked_by_stripe_count` | bigint |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `created_day` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `outcome_reason` | varchar |  | verified |  |
| `outcome_rule_id` | varchar |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `transaction_amount` | bigint |  | verified |  |
| `transaction_amount_in_usd` | bigint |  | verified |  |
| `transaction_count` | bigint |  | verified |  |

</details>

### `acceptance_reporting_preaggregated_v3` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (23, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `attributable_optimization` | varchar |  | verified |  |
| `blocked_by_default_high_risk_rule_count` | bigint |  | verified |  |
| `blocked_by_radar_rule_count` | bigint |  | verified |  |
| `blocked_by_stripe_count` | bigint |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `cof` | boolean |  | verified |  |
| `created_day` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `nsf_count` | bigint |  | verified |  |
| `outcome_reason` | varchar |  | verified |  |
| `outcome_rule_id` | varchar |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `transaction_amount` | bigint |  | verified |  |
| `transaction_amount_in_usd` | bigint |  | verified |  |
| `transaction_count` | bigint |  | verified |  |
| `used_network_tokens` | boolean |  | verified |  |

</details>

### `account_capabilities_v2` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (43, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account_id` | varchar | foreign | verified |  |
| `acss_debit_payments` | varchar |  | verified |  |
| `affirm_payments` | varchar |  | verified |  |
| `afterpay_clearpay_payments` | varchar |  | verified |  |
| `amazon_pay_payments` | varchar |  | verified |  |
| `au_becs_debit_payments` | varchar |  | verified |  |
| `bacs_debit_payments` | varchar |  | verified |  |
| `bancontact_payments` | varchar |  | verified |  |
| `bank_transfer_payments` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `blik_payments` | varchar |  | verified |  |
| `boleto_payments` | varchar |  | verified |  |
| `card_issuing` | varchar |  | verified |  |
| `card_payments` | varchar |  | verified |  |
| `cartes_bancaires_payments` | varchar |  | verified |  |
| `cashapp_payments` | varchar |  | verified |  |
| `eps_payments` | varchar |  | verified |  |
| `fpx_payments` | varchar |  | verified |  |
| `giropay_payments` | varchar |  | verified |  |
| `grabpay_payments` | varchar |  | verified |  |
| `ideal_payments` | varchar |  | verified |  |
| `india_international_payments` | varchar |  | verified |  |
| `jcb_payments` | varchar |  | verified |  |
| `klarna_payments` | varchar |  | verified |  |
| `konbini_payments` | varchar |  | verified |  |
| `legacy_payments` | varchar |  | verified |  |
| `link_payments` | varchar |  | verified |  |
| `mobilepay_payments` | varchar |  | verified |  |
| `multibanco_payments` | varchar |  | verified |  |
| `oxxo_payments` | varchar |  | verified |  |
| `p24_payments` | varchar |  | verified |  |
| `paynow_payments` | varchar |  | verified |  |
| `promptpay_payments` | varchar |  | verified |  |
| `revolut_pay_payments` | varchar |  | verified |  |
| `sepa_debit_payments` | varchar |  | verified |  |
| `sofort_payments` | varchar |  | verified |  |
| `swish_payments` | varchar |  | verified |  |
| `tax_reporting_us_1099_k` | varchar |  | verified |  |
| `tax_reporting_us_1099_misc` | varchar |  | verified |  |
| `transfers` | varchar |  | verified |  |
| `twint_payments` | varchar |  | verified |  |
| `us_bank_account_ach_payments` | varchar |  | verified |  |
| `zip_payments` | varchar |  | verified |  |

</details>

**Joins**

- `account_capabilities_v2.account_id` → `accounts.id`

### `analytics_acceptance_summarized` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (35, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `_viewing_merchant` | varchar |  | verified |  |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `block_reason` | varchar |  | verified |  |
| `buyer_country` | varchar |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `created_hour` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `failure_reason` | varchar |  | verified |  |
| `gateway_conversation_avs_outcome` | varchar |  | verified |  |
| `gateway_conversation_cvc_outcome` | varchar |  | verified |  |
| `interaction_type` | varchar |  | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `is_final_attempt` | boolean |  | verified |  |
| `is_link` | boolean |  | verified |  |
| `locality_zone` | varchar |  | verified |  |
| `outcome_type` | varchar |  | verified |  |
| `payment_amount` | bigint |  | verified |  |
| `payment_amount_in_usd` | bigint |  | verified |  |
| `payment_count` | bigint |  | verified |  |
| `payment_method_type` | varchar |  | verified |  |
| `payment_processor` | varchar |  | verified |  |
| `retry_status` | varchar |  | verified |  |
| `three_d_s_challenge_type` | varchar |  | verified |  |
| `three_d_s_is_in_sca_scope` | boolean |  | verified |  |
| `three_d_s_outcome` | varchar |  | verified |  |
| `three_d_s_outcome_type` | varchar |  | verified |  |
| `three_d_s_reason` | varchar |  | verified |  |
| `three_d_s_sca_exemption_type` | varchar |  | verified |  |
| `three_d_s_used` | boolean |  | verified |  |
| `used_network_tokens` | boolean |  | verified |  |

</details>

### `balance_transactions_product_enrichment` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `balance_transaction_id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `balance_transaction_id` | varchar | primary | verified |  |
| `product_ids` | varchar |  | verified |  |
| `product_names` | varchar |  | verified |  |
| `reporting_category` | varchar |  | verified |  |
| `source_id` | varchar |  | verified |  |

</details>

### `billing_credit_balance_transactions` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `bill_item_id` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credit_amount_type` | varchar |  | verified |  |
| `credit_grant_id` | varchar | foreign | verified |  |
| `credit_monetary_amount_currency` | varchar |  | verified |  |
| `credit_monetary_amount_value` | bigint |  | verified |  |
| `credit_type` | varchar |  | verified |  |
| `debit_amount_type` | varchar |  | verified |  |
| `debit_monetary_amount_currency` | varchar |  | verified |  |
| `debit_monetary_amount_value` | bigint |  | verified |  |
| `debit_type` | varchar |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `invoice_id` | varchar |  | verified |  |
| `invoice_line_item_id` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `billing_credit_grant_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_grant_id` | varchar | foreign | verified |  |
| `key` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `billing_credit_grants` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount_type` | varchar |  | verified |  |
| `applicability_config_scope_price_type` | varchar |  | verified |  |
| `category` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `custom_pricing_unit_id` | varchar |  | verified |  |
| `custom_pricing_unit_value` | varchar |  | verified |  |
| `customer_id` | varchar |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `expires_at` | timestamp |  | verified |  |
| `monetary_amount_currency` | varchar |  | verified |  |
| `monetary_amount_value` | bigint |  | verified |  |
| `name` | varchar |  | verified |  |
| `service_action_id` | varchar |  | verified |  |
| `updated` | timestamp |  | verified |  |
| `voided_at` | timestamp |  | verified |  |

</details>

### `billing_meter_dimensions` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `dimension_payload_key`

<details><summary>Columns (2, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `dimension_payload_key` | varchar | primary | verified |  |
| `meter_id` | varchar | foreign | verified |  |

</details>

### `billing_meter_event_summary_segments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `dimension_key`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `dimension_key` | varchar | primary | verified |  |
| `event_summary_id` | varchar | foreign | verified |  |
| `dimension_value` | varchar |  | verified |  |

</details>

### `billing_schedule_applies_tos` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `billing_schedule_key, parent_id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `billing_schedule_key` | varchar | primary | verified |  |
| `parent_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `price_id` | varchar | foreign | verified |  |
| `type` | varchar |  | verified |  |

</details>

**Joins**

- `billing_schedule_applies_tos.price_id` → `prices.id`

### `billing_schedules` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `key, parent_id`

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified |  |
| `parent_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `bill_until_computed_timestamp` | timestamp |  | verified |  |
| `bill_until_duration_interval` | varchar |  | verified |  |
| `bill_until_duration_interval_count` | bigint |  | verified |  |
| `bill_until_timestamp` | timestamp |  | verified |  |
| `bill_until_type` | varchar |  | verified |  |

</details>

### `captures` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `balance_transaction_id` | varchar | foreign | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `charge_id` | varchar | foreign | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |

</details>

**Joins**

- `captures.balance_transaction_id` → `balance_transactions.id`
- `captures.charge_id` → `charges.id`

### `cardsauth_eight_digit_bins` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `_viewing_compartment` | varchar |  | verified |  |
| `_viewing_merchant` | varchar |  | verified |  |
| `account_funding_source` | varchar |  | verified |  |
| `card_bin` | varchar |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `country` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `issuer_name` | varchar |  | verified |  |
| `locality_zone` | varchar |  | verified |  |

</details>

### `checkout_sessions_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `checkout_session_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `checkout_session_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `connected_account_money_management_adjustments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `amount` | bigint |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |

</details>

### `connected_account_money_management_financial_accounts` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `country` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `display_name` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `connected_account_money_management_financial_accounts_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `key` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `connected_account_money_management_financial_addresses` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (20, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credentials_bank_name` | varchar |  | verified |  |
| `credentials_bic` | varchar |  | verified |  |
| `credentials_clabe` | varchar |  | verified |  |
| `credentials_country` | varchar |  | verified |  |
| `credentials_crypto_address` | varchar |  | verified |  |
| `credentials_crypto_memo` | varchar |  | verified |  |
| `credentials_crypto_network` | varchar |  | verified |  |
| `credentials_institution_number` | varchar |  | verified |  |
| `credentials_last4` | varchar |  | verified |  |
| `credentials_routing_number` | varchar |  | verified |  |
| `credentials_sort_code` | varchar |  | verified |  |
| `credentials_transit_number` | varchar |  | verified |  |
| `credentials_type` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `settlement_currency` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |

</details>

### `connected_account_money_management_inbound_transfers` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (12, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credited_amount` | bigint |  | verified |  |
| `credited_currency` | varchar |  | verified |  |
| `debited_amount` | bigint |  | verified |  |
| `debited_currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `from_payment_method_id` | varchar |  | verified |  |
| `from_payment_method_type` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `to_financial_account_id` | varchar |  | verified |  |

</details>

### `connected_account_money_management_inbound_transfers_history` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `bank_debit_failure_reason` | varchar |  | verified |  |
| `bank_debit_return_reason` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `id` | varchar |  | verified |  |
| `inbound_transfer_id` | varchar |  | verified |  |
| `level` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `connected_account_money_management_outbound_payments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (24, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `ach_submission` | varchar |  | verified |  |
| `ach_transaction_purpose` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credited_amount` | bigint |  | verified |  |
| `credited_currency` | varchar |  | verified |  |
| `debited_amount` | bigint |  | verified |  |
| `debited_currency` | varchar |  | verified |  |
| `delivery_options_bank_account` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `expected_arrival_date` | timestamp |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `from_financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `payout_method_options_bank_account_preferred_networks` | varchar |  | verified |  |
| `posted_at` | timestamp |  | verified |  |
| `returned_at` | timestamp |  | verified |  |
| `returned_reason` | varchar |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `to_payout_method_id` | varchar |  | verified |  |
| `to_recipient_id` | varchar |  | verified |  |

</details>

### `connected_account_money_management_outbound_payments_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `key` | varchar |  | verified |  |
| `outbound_payment_id` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `connected_account_money_management_outbound_transfers` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (21, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credited_amount` | bigint |  | verified |  |
| `credited_currency` | varchar |  | verified |  |
| `debited_amount` | bigint |  | verified |  |
| `debited_currency` | varchar |  | verified |  |
| `delivery_options_bank_account` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `expected_arrival_date` | timestamp |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `from_financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `payout_method_options_bank_account_preferred_networks` | varchar |  | verified |  |
| `posted_at` | timestamp |  | verified |  |
| `returned_at` | timestamp |  | verified |  |
| `returned_reason` | varchar |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `to_payout_method_id` | varchar |  | verified |  |

</details>

### `connected_account_money_management_outbound_transfers_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `key` | varchar |  | verified |  |
| `outbound_transfer_id` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `connected_account_money_management_received_credits` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (30, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `amount` | bigint |  | verified |  |
| `balance_transfer_from_account_id` | varchar |  | verified |  |
| `balance_transfer_id` | varchar |  | verified |  |
| `balance_transfer_type` | varchar |  | verified |  |
| `bank_transfer_account_holder_name` | varchar |  | verified |  |
| `bank_transfer_bank_name` | varchar |  | verified |  |
| `bank_transfer_bic` | varchar |  | verified |  |
| `bank_transfer_financial_address_id` | varchar |  | verified |  |
| `bank_transfer_last4` | varchar |  | verified |  |
| `bank_transfer_network` | varchar |  | verified |  |
| `bank_transfer_origin_type` | varchar |  | verified |  |
| `bank_transfer_routing_number` | varchar |  | verified |  |
| `bank_transfer_sort_code` | varchar |  | verified |  |
| `bank_transfer_statement_descriptor` | varchar |  | verified |  |
| `card_spend_card_id` | varchar |  | verified |  |
| `card_spend_issuing_dispute` | varchar |  | verified |  |
| `card_spend_issuing_refund` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `returned_at` | timestamp |  | verified |  |
| `returned_reason` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `succeeded_at` | timestamp |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `connected_account_money_management_received_debits` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (18, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `amount` | bigint |  | verified |  |
| `bank_transfer_bank_name` | varchar |  | verified |  |
| `bank_transfer_financial_address_id` | varchar |  | verified |  |
| `bank_transfer_network` | varchar |  | verified |  |
| `bank_transfer_routing_number` | varchar |  | verified |  |
| `bank_transfer_statement_descriptor` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `succeeded_at` | timestamp |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `connected_account_money_management_transaction_entries` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `available_balance_impact` | bigint |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `id` | varchar |  | verified |  |
| `inbound_pending_balance_impact` | bigint |  | verified |  |
| `outbound_pending_balance_impact` | bigint |  | verified |  |
| `transaction_id` | varchar |  | verified |  |

</details>

### `connected_account_money_management_transactions` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (17, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account` | varchar |  | verified |  |
| `amount` | bigint |  | verified |  |
| `available_balance_impact` | bigint |  | verified |  |
| `category` | varchar |  | verified |  |
| `counterparty_name` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `flow_id` | varchar |  | verified |  |
| `flow_type` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `inbound_pending_balance_impact` | bigint |  | verified |  |
| `outbound_pending_balance_impact` | bigint |  | verified |  |
| `posted_at` | timestamp |  | verified |  |
| `status` | varchar |  | verified |  |
| `void_at` | timestamp |  | verified |  |

</details>

### `customer_change_events` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `customer_id, event_timestamp, event_type`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `customer_id` | varchar | primary | verified |  |
| `event_timestamp` | varchar | primary | verified |  |
| `event_type` | varchar | primary | verified |  |
| `active_timestamp` | bigint |  | verified |  |
| `currency` | varchar |  | verified |  |
| `local_event_timestamp` | timestamp |  | verified |  |
| `mrr_change` | bigint |  | verified |  |

</details>

### `disputes_reporting_v1_itemized` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (22, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `amount_in_usd` | bigint |  | verified |  |
| `card_brand` | varchar |  | verified |  |
| `card_country` | varchar |  | verified |  |
| `card_input_method` | varchar |  | verified |  |
| `card_type` | varchar |  | verified |  |
| `charge_id` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `dispute_amount` | bigint |  | verified |  |
| `dispute_amount_in_usd` | bigint |  | verified |  |
| `dispute_created_day` | timestamp |  | verified |  |
| `dispute_id` | varchar |  | verified |  |
| `dispute_type` | varchar |  | verified |  |
| `gateway_country` | varchar |  | verified |  |
| `has_early_fraud_warning` | boolean |  | verified |  |
| `is_connected_account` | boolean |  | verified |  |
| `payment_created_day` | timestamp |  | verified |  |
| `representment_product` | varchar |  | verified |  |
| `responded` | boolean |  | verified |  |
| `status` | varchar |  | verified |  |
| `user_facing_reason` | varchar |  | verified |  |

</details>

### `draft_tax_forms` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (30, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `email` | varchar |  | verified |  |
| `filing_requirement` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `payee_account_id` | varchar |  | verified |  |
| `payee_address_line_1` | varchar |  | verified |  |
| `payee_address_line_2` | varchar |  | verified |  |
| `payee_city` | varchar |  | verified |  |
| `payee_country` | varchar |  | verified |  |
| `payee_name_line_1` | varchar |  | verified |  |
| `payee_name_line_2` | varchar |  | verified |  |
| `payee_postal_code` | varchar |  | verified |  |
| `payee_region` | varchar |  | verified |  |
| `payee_tin_type` | varchar |  | verified |  |
| `payee_type` | varchar |  | verified |  |
| `payer_override` | varchar |  | verified |  |
| `postal_delivery` | varchar |  | verified |  |
| `reporting_year` | bigint |  | verified |  |
| `type` | varchar |  | verified |  |
| `us_1099_k_numerical_data_by_calculation_type` | varchar |  | verified |  |
| `us_1099_k_numerical_deltas` | varchar |  | verified |  |
| `us_1099_k_selected_calculation_type` | varchar |  | verified |  |
| `us_1099_misc_numerical_data_by_calculation_type` | varchar |  | verified |  |
| `us_1099_misc_numerical_deltas` | varchar |  | verified |  |
| `us_1099_misc_selected_calculation_type` | varchar |  | verified |  |
| `us_1099_nec_numerical_data_by_calculation_type` | varchar |  | verified |  |
| `us_1099_nec_numerical_deltas` | varchar |  | verified |  |
| `us_1099_nec_selected_calculation_type` | varchar |  | verified |  |

</details>

### `external_account_bank_accounts` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (15, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account_id` | varchar | foreign | verified |  |
| `id` | varchar | primary | verified |  |
| `account_holder_name` | varchar |  | verified |  |
| `account_holder_type` | varchar |  | verified |  |
| `account_type` | varchar |  | verified |  |
| `available_payout_methods` | varchar |  | verified |  |
| `bank_name` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `country` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `default_for_currency` | boolean |  | verified |  |
| `fingerprint` | varchar |  | verified |  |
| `last4` | varchar |  | verified |  |
| `routing_number` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |

</details>

**Joins**

- `external_account_bank_accounts.account_id` → `accounts.id`

### `external_account_cards` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (30, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `account_id` | varchar | foreign | verified |  |
| `id` | varchar | primary | verified |  |
| `address_city` | varchar |  | verified |  |
| `address_country` | varchar |  | verified |  |
| `address_line1` | varchar |  | verified |  |
| `address_line1_check` | varchar |  | verified |  |
| `address_line2` | varchar |  | verified |  |
| `address_state` | varchar |  | verified |  |
| `address_zip` | varchar |  | verified |  |
| `address_zip_check` | varchar |  | verified |  |
| `allow_redisplay` | varchar |  | verified |  |
| `available_payout_methods` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `brand` | varchar |  | verified |  |
| `country` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `customer_id` | varchar | foreign | verified |  |
| `cvc_check` | varchar |  | verified |  |
| `default_for_currency` | boolean |  | verified |  |
| `dynamic_last4` | varchar |  | verified |  |
| `exp_month` | bigint |  | verified |  |
| `exp_year` | bigint |  | verified |  |
| `fingerprint` | varchar |  | verified |  |
| `funding` | varchar |  | verified |  |
| `last4` | varchar |  | verified |  |
| `name` | varchar |  | verified |  |
| `recipient_id` | varchar |  | verified |  |
| `regulated_status` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `tokenization_method` | varchar |  | verified |  |

</details>

**Joins**

- `external_account_cards.account_id` → `accounts.id`
- `external_account_cards.customer_id` → `customers.id`

### `fee_credits_activities` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `credit_id, transaction_id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_id` | varchar | primary | verified |  |
| `transaction_id` | varchar | primary | verified |  |
| `amount_in_minor` | bigint |  | verified |  |
| `attribution_window_end` | timestamp |  | verified |  |
| `attribution_window_start` | timestamp |  | verified |  |
| `billing_account_id` | varchar |  | verified |  |
| `created_at` | timestamp |  | verified |  |
| `credit_name` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `owner_account_id` | varchar |  | verified |  |

</details>

### `iins` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `bank` | varchar |  | verified |  |
| `country_code` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |

</details>

### `invoice_item_discount_amounts` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `invoice_item_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `discount_id` | varchar | foreign | verified |  |
| `invoice_item_id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |

</details>

**Joins**

- `invoice_item_discount_amounts.discount_id` → `discounts.id`

### `issuing_authorizations_request_history` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (15, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_authorization_id` | varchar | foreign | verified |  |
| `amount` | bigint |  | verified |  |
| `amount_details_atm_fee` | bigint |  | verified |  |
| `amount_details_cashback_amount` | bigint |  | verified |  |
| `approved` | boolean |  | verified |  |
| `authorization_code` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `merchant_amount` | bigint |  | verified |  |
| `merchant_currency` | varchar |  | verified |  |
| `network_risk_score` | bigint |  | verified |  |
| `reason` | varchar |  | verified |  |
| `reason_message` | varchar |  | verified |  |
| `requested_at` | timestamp |  | verified |  |

</details>

**Joins**

- `issuing_authorizations_request_history.issuing_authorization_id` → `issuing_authorizations.id`

### `issuing_credit_ledger_adjustments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (9, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `reason` | varchar |  | verified |  |
| `reason_description` | varchar |  | verified |  |

</details>

### `issuing_credit_ledger_entries` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `source_id` | varchar |  | verified |  |
| `source_type` | varchar |  | verified |  |

</details>

### `issuing_credit_policies` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (23, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credit_limit_amount` | bigint |  | verified |  |
| `credit_limit_currency` | varchar |  | verified |  |
| `credit_period_ends_on_days` | varchar |  | verified |  |
| `credit_period_interval` | varchar |  | verified |  |
| `credit_period_interval_count` | bigint |  | verified |  |
| `days_until_due` | bigint |  | verified |  |
| `last_effective_attributes_credit_limit_amount_amount` | bigint |  | verified |  |
| `last_effective_attributes_credit_limit_amount_currency` | varchar |  | verified |  |
| `last_effective_attributes_credit_period_ends_on_days` | varchar |  | verified |  |
| `last_effective_attributes_credit_period_interval` | varchar |  | verified |  |
| `last_effective_attributes_credit_period_interval_count` | bigint |  | verified |  |
| `last_effective_attributes_effective_until` | timestamp |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `status` | varchar |  | verified |  |
| `upcoming_attributes_credit_limit_amount_amount` | bigint |  | verified |  |
| `upcoming_attributes_credit_limit_amount_currency` | varchar |  | verified |  |
| `upcoming_attributes_credit_period_ends_on_days` | varchar |  | verified |  |
| `upcoming_attributes_credit_period_interval` | varchar |  | verified |  |
| `upcoming_attributes_credit_period_interval_count` | bigint |  | verified |  |
| `upcoming_attributes_effective_at` | timestamp |  | verified |  |

</details>

### `issuing_credit_policy_archive` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (24, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credit_limit_amount` | bigint |  | verified |  |
| `credit_limit_currency` | varchar |  | verified |  |
| `credit_period_ends_on_days` | varchar |  | verified |  |
| `credit_period_interval` | varchar |  | verified |  |
| `credit_period_interval_count` | bigint |  | verified |  |
| `credit_policy_id` | varchar |  | verified |  |
| `days_until_due` | bigint |  | verified |  |
| `last_effective_attributes_credit_limit_amount_amount` | bigint |  | verified |  |
| `last_effective_attributes_credit_limit_amount_currency` | varchar |  | verified |  |
| `last_effective_attributes_credit_period_ends_on_days` | varchar |  | verified |  |
| `last_effective_attributes_credit_period_interval` | varchar |  | verified |  |
| `last_effective_attributes_credit_period_interval_count` | bigint |  | verified |  |
| `last_effective_attributes_effective_until` | timestamp |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `status` | varchar |  | verified |  |
| `upcoming_attributes_credit_limit_amount_amount` | bigint |  | verified |  |
| `upcoming_attributes_credit_limit_amount_currency` | varchar |  | verified |  |
| `upcoming_attributes_credit_period_ends_on_days` | varchar |  | verified |  |
| `upcoming_attributes_credit_period_interval` | varchar |  | verified |  |
| `upcoming_attributes_credit_period_interval_count` | bigint |  | verified |  |
| `upcoming_attributes_effective_at` | timestamp |  | verified |  |

</details>

### `issuing_credit_repayments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (21, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `allocation_fees` | bigint |  | verified |  |
| `allocation_interest` | bigint |  | verified |  |
| `allocation_principal` | bigint |  | verified |  |
| `amount` | bigint |  | verified |  |
| `balance_transaction_id` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `connected_account` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credit_statement_descriptor` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `destination` | varchar |  | verified |  |
| `destination_balance_type` | varchar |  | verified |  |
| `failure_balance_transaction_id` | varchar |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `status_transitions_canceled_at` | timestamp |  | verified |  |
| `status_transitions_failed_at` | timestamp |  | verified |  |
| `status_transitions_processing_at` | timestamp |  | verified |  |
| `status_transitions_reversed_at` | timestamp |  | verified |  |
| `status_transitions_succeeded_at` | timestamp |  | verified |  |

</details>

### `issuing_credit_underwriting_records` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (24, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `application_application_method` | varchar |  | verified |  |
| `application_purpose` | varchar |  | verified |  |
| `application_submitted_at` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | double |  | verified |  |
| `created_from` | varchar |  | verified |  |
| `credit_user_email` | varchar |  | verified |  |
| `credit_user_name` | varchar |  | verified |  |
| `decided_at` | bigint |  | verified |  |
| `decision_application_rejected_reason_other_explanation` | varchar |  | verified |  |
| `decision_application_rejected_reasons` | varchar |  | verified |  |
| `decision_credit_limit_approved_amount_amount` | bigint |  | verified |  |
| `decision_credit_limit_approved_amount_currency` | varchar |  | verified |  |
| `decision_credit_limit_decreased_amount_amount` | bigint |  | verified |  |
| `decision_credit_limit_decreased_amount_currency` | varchar |  | verified |  |
| `decision_credit_limit_decreased_reasons` | varchar |  | verified |  |
| `decision_credit_line_closed_reasons` | varchar |  | verified |  |
| `decision_deadline` | bigint |  | verified |  |
| `decision_type` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `regulatory_reporting_file` | varchar |  | verified |  |
| `underwriting_exception_reason` | varchar |  | verified |  |

</details>

### `issuing_credit_underwriting_records_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `credit_underwriting_record_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_underwriting_record_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `issuing_disputes_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `dispute_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `dispute_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `issuing_funding_obligations` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (21, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount_outstanding` | bigint |  | verified |  |
| `amount_paid` | bigint |  | verified |  |
| `amount_paid_from_reserve` | bigint |  | verified |  |
| `amount_total` | bigint |  | verified |  |
| `balance_type` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | double |  | verified |  |
| `credit_period_ends_at` | bigint |  | verified |  |
| `credit_period_starts_at` | bigint |  | verified |  |
| `currency` | varchar |  | verified |  |
| `due_at` | bigint |  | verified |  |
| `finalized_at` | bigint |  | verified |  |
| `grace_period_ends_at` | bigint |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `owed_to` | varchar |  | verified |  |
| `paid_at` | bigint |  | verified |  |
| `status` | varchar |  | verified |  |
| `transaction_period_ends_at` | bigint |  | verified |  |
| `transaction_period_starts_at` | bigint |  | verified |  |

</details>

### `issuing_funding_obligations_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `funding_obligation_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `funding_obligation_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `issuing_personalization_designs` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (17, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `card_logo` | varchar |  | verified |  |
| `carrier_text_footer_body` | varchar |  | verified |  |
| `carrier_text_footer_title` | varchar |  | verified |  |
| `carrier_text_header_body` | varchar |  | verified |  |
| `carrier_text_header_title` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `lookup_key` | varchar |  | verified |  |
| `name` | varchar |  | verified |  |
| `physical_bundle` | varchar |  | verified |  |
| `preferences_is_default` | boolean |  | verified |  |
| `preferences_is_platform_default` | boolean |  | verified |  |
| `rejection_reasons_card_logo` | varchar |  | verified |  |
| `rejection_reasons_carrier_text` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |

</details>

### `issuing_personalization_designs_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `card_design_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `card_design_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `issuing_programs` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `is_default` | boolean |  | verified |  |
| `platform_program_id` | varchar | foreign | verified |  |

</details>

### `issuing_programs_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_program_id` | varchar | foreign | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

**Joins**

- `issuing_programs_metadata.issuing_program_id` → `issuing_programs.id`

### `issuing_transaction_amount_details_tax` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (5, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_transaction_id` | varchar | foreign | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `behavior` | varchar |  | verified |  |
| `jurisdiction` | varchar |  | verified |  |

</details>

**Joins**

- `issuing_transaction_amount_details_tax.issuing_transaction_id` → `issuing_transactions.id`

### `mandates` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (36, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `customer_acceptance_accepted_at` | double |  | verified |  |
| `customer_acceptance_online_ip_address` | varchar |  | verified |  |
| `customer_acceptance_online_user_agent` | varchar |  | verified |  |
| `customer_acceptance_type` | varchar |  | verified |  |
| `on_behalf_of` | varchar |  | verified |  |
| `payment_method` | varchar |  | verified |  |
| `payment_method_details_acss_debit_interval_description` | varchar |  | verified |  |
| `payment_method_details_acss_debit_payment_schedule` | varchar |  | verified |  |
| `payment_method_details_acss_debit_transaction_type` | varchar |  | verified |  |
| `payment_method_details_au_becs_debit_url` | varchar |  | verified |  |
| `payment_method_details_bacs_debit_network_status` | varchar |  | verified |  |
| `payment_method_details_bacs_debit_reference` | varchar |  | verified |  |
| `payment_method_details_bacs_debit_revocation_reason` | varchar |  | verified |  |
| `payment_method_details_bacs_debit_url` | varchar |  | verified |  |
| `payment_method_details_paypal_billing_agreement_id` | varchar |  | verified |  |
| `payment_method_details_payto_amount` | bigint |  | verified |  |
| `payment_method_details_payto_amount_type` | varchar |  | verified |  |
| `payment_method_details_payto_end_date` | varchar |  | verified |  |
| `payment_method_details_payto_payment_schedule` | varchar |  | verified |  |
| `payment_method_details_payto_payments_per_period` | bigint |  | verified |  |
| `payment_method_details_payto_purpose` | varchar |  | verified |  |
| `payment_method_details_payto_start_date` | varchar |  | verified |  |
| `payment_method_details_sepa_debit_reference` | varchar |  | verified |  |
| `payment_method_details_sepa_debit_url` | varchar |  | verified |  |
| `payment_method_details_type` | varchar |  | verified |  |
| `payment_method_details_upi_amount` | bigint |  | verified |  |
| `payment_method_details_upi_amount_type` | varchar |  | verified |  |
| `payment_method_details_upi_description` | varchar |  | verified |  |
| `payment_method_details_upi_end_date` | bigint |  | verified |  |
| `payment_method_details_us_bank_account_collection_method` | varchar |  | verified |  |
| `single_use_amount` | bigint |  | verified |  |
| `single_use_currency` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `metered_items_beta` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `created_at` | bigint |  | verified |  |
| `display_name` | varchar |  | verified |  |
| `invoice_presentation_dimensions` | varchar |  | verified |  |
| `locality_zone` | varchar |  | verified |  |
| `lookup_key` | varchar |  | verified |  |
| `metadata` | varchar |  | verified |  |
| `meter` | varchar |  | verified |  |
| `object` | varchar |  | verified |  |
| `tax_details_tax_code` | varchar |  | verified |  |
| `unit_label` | varchar |  | verified |  |

</details>

### `money_management_adjustments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |

</details>

### `money_management_financial_accounts` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `country` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `display_name` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `money_management_financial_accounts_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `financial_account_id` | varchar |  | verified |  |
| `key` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `money_management_financial_addresses` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (19, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `created` | timestamp |  | verified |  |
| `credentials_bank_name` | varchar |  | verified |  |
| `credentials_bic` | varchar |  | verified |  |
| `credentials_clabe` | varchar |  | verified |  |
| `credentials_country` | varchar |  | verified |  |
| `credentials_crypto_address` | varchar |  | verified |  |
| `credentials_crypto_memo` | varchar |  | verified |  |
| `credentials_crypto_network` | varchar |  | verified |  |
| `credentials_institution_number` | varchar |  | verified |  |
| `credentials_last4` | varchar |  | verified |  |
| `credentials_routing_number` | varchar |  | verified |  |
| `credentials_sort_code` | varchar |  | verified |  |
| `credentials_transit_number` | varchar |  | verified |  |
| `credentials_type` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `settlement_currency` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |

</details>

### `money_management_inbound_transfers` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `created` | timestamp |  | verified |  |
| `credited_amount` | bigint |  | verified |  |
| `credited_currency` | varchar |  | verified |  |
| `debited_amount` | bigint |  | verified |  |
| `debited_currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `from_payment_method_id` | varchar |  | verified |  |
| `from_payment_method_type` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `to_financial_account_id` | varchar |  | verified |  |

</details>

### `money_management_inbound_transfers_history` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `bank_debit_failure_reason` | varchar |  | verified |  |
| `bank_debit_return_reason` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `id` | varchar |  | verified |  |
| `inbound_transfer_id` | varchar |  | verified |  |
| `level` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `money_management_outbound_payments` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (23, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `ach_submission` | varchar |  | verified |  |
| `ach_transaction_purpose` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credited_amount` | bigint |  | verified |  |
| `credited_currency` | varchar |  | verified |  |
| `debited_amount` | bigint |  | verified |  |
| `debited_currency` | varchar |  | verified |  |
| `delivery_options_bank_account` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `expected_arrival_date` | timestamp |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `from_financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `payout_method_options_bank_account_preferred_networks` | varchar |  | verified |  |
| `posted_at` | timestamp |  | verified |  |
| `returned_at` | timestamp |  | verified |  |
| `returned_reason` | varchar |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `to_payout_method_id` | varchar |  | verified |  |
| `to_recipient_id` | varchar |  | verified |  |

</details>

### `money_management_outbound_payments_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | verified |  |
| `outbound_payment_id` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `money_management_outbound_transfers` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (20, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `canceled_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credited_amount` | bigint |  | verified |  |
| `credited_currency` | varchar |  | verified |  |
| `debited_amount` | bigint |  | verified |  |
| `debited_currency` | varchar |  | verified |  |
| `delivery_options_bank_account` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `expected_arrival_date` | timestamp |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `from_financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `payout_method_options_bank_account_preferred_networks` | varchar |  | verified |  |
| `posted_at` | timestamp |  | verified |  |
| `returned_at` | timestamp |  | verified |  |
| `returned_reason` | varchar |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `to_payout_method_id` | varchar |  | verified |  |

</details>

### `money_management_outbound_transfers_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar |  | verified |  |
| `outbound_transfer_id` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `money_management_received_credits` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (29, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `balance_transfer_from_account_id` | varchar |  | verified |  |
| `balance_transfer_id` | varchar |  | verified |  |
| `balance_transfer_type` | varchar |  | verified |  |
| `bank_transfer_account_holder_name` | varchar |  | verified |  |
| `bank_transfer_bank_name` | varchar |  | verified |  |
| `bank_transfer_bic` | varchar |  | verified |  |
| `bank_transfer_financial_address_id` | varchar |  | verified |  |
| `bank_transfer_last4` | varchar |  | verified |  |
| `bank_transfer_network` | varchar |  | verified |  |
| `bank_transfer_origin_type` | varchar |  | verified |  |
| `bank_transfer_routing_number` | varchar |  | verified |  |
| `bank_transfer_sort_code` | varchar |  | verified |  |
| `bank_transfer_statement_descriptor` | varchar |  | verified |  |
| `card_spend_card_id` | varchar |  | verified |  |
| `card_spend_issuing_dispute` | varchar |  | verified |  |
| `card_spend_issuing_refund` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `returned_at` | timestamp |  | verified |  |
| `returned_reason` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `succeeded_at` | timestamp |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `money_management_received_debits` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (17, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `bank_transfer_bank_name` | varchar |  | verified |  |
| `bank_transfer_financial_address_id` | varchar |  | verified |  |
| `bank_transfer_network` | varchar |  | verified |  |
| `bank_transfer_routing_number` | varchar |  | verified |  |
| `bank_transfer_statement_descriptor` | varchar |  | verified |  |
| `canceled_at` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failed_at` | timestamp |  | verified |  |
| `failed_reason` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `succeeded_at` | timestamp |  | verified |  |
| `type` | varchar |  | verified |  |

</details>

### `money_management_transaction_entries` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (8, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `available_balance_impact` | bigint |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `id` | varchar |  | verified |  |
| `inbound_pending_balance_impact` | bigint |  | verified |  |
| `outbound_pending_balance_impact` | bigint |  | verified |  |
| `transaction_id` | varchar |  | verified |  |

</details>

### `money_management_transactions` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `available_balance_impact` | bigint |  | verified |  |
| `category` | varchar |  | verified |  |
| `counterparty_name` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `financial_account_id` | varchar |  | verified |  |
| `flow_id` | varchar |  | verified |  |
| `flow_type` | varchar |  | verified |  |
| `id` | varchar |  | verified |  |
| `inbound_pending_balance_impact` | bigint |  | verified |  |
| `outbound_pending_balance_impact` | bigint |  | verified |  |
| `posted_at` | timestamp |  | verified |  |
| `status` | varchar |  | verified |  |
| `void_at` | timestamp |  | verified |  |

</details>

### `payins_insights_lightning_astro_deduped_aggregated_with_attempts_v2` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `attributable_optimization, blocked_reason, card_brand, card_country, card_input_method, card_type, cof, currency, decline_reason, gateway_conversation_avs_outcome, gateway_conversation_cvc_outcome, is_connected_account, outcome_type, transaction_initiator, used_network_tokens`

<details><summary>Columns (22, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `attributable_optimization` | varchar | primary | verified |  |
| `blocked_reason` | varchar | primary | verified |  |
| `card_brand` | varchar | primary | verified |  |
| `card_country` | varchar | primary | verified |  |
| `card_input_method` | varchar | primary | verified |  |
| `card_type` | varchar | primary | verified |  |
| `cof` | varchar | primary | verified |  |
| `currency` | varchar | primary | verified |  |
| `decline_reason` | varchar | primary | verified |  |
| `gateway_conversation_avs_outcome` | varchar | primary | verified |  |
| `gateway_conversation_cvc_outcome` | varchar | primary | verified |  |
| `is_connected_account` | varchar | primary | verified |  |
| `outcome_type` | varchar | primary | verified |  |
| `transaction_initiator` | varchar | primary | verified |  |
| `used_network_tokens` | varchar | primary | verified |  |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `created_hour` | timestamp |  | verified |  |
| `transaction_amount` | bigint |  | verified |  |
| `transaction_amount_in_usd` | bigint |  | verified |  |
| `transaction_count` | bigint |  | verified |  |

</details>

### `payins_insights_lightning_astro_raw_aggregated_with_attempts_v2` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `attributable_optimization, blocked_reason, card_brand, card_country, card_input_method, card_type, cof, currency, decline_reason, gateway_conversation_avs_outcome, gateway_conversation_cvc_outcome, is_connected_account, outcome_type, transaction_initiator, used_network_tokens`

<details><summary>Columns (22, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `attributable_optimization` | varchar | primary | verified |  |
| `blocked_reason` | varchar | primary | verified |  |
| `card_brand` | varchar | primary | verified |  |
| `card_country` | varchar | primary | verified |  |
| `card_input_method` | varchar | primary | verified |  |
| `card_type` | varchar | primary | verified |  |
| `cof` | varchar | primary | verified |  |
| `currency` | varchar | primary | verified |  |
| `decline_reason` | varchar | primary | verified |  |
| `gateway_conversation_avs_outcome` | varchar | primary | verified |  |
| `gateway_conversation_cvc_outcome` | varchar | primary | verified |  |
| `is_connected_account` | varchar | primary | verified |  |
| `outcome_type` | varchar | primary | verified |  |
| `transaction_initiator` | varchar | primary | verified |  |
| `used_network_tokens` | varchar | primary | verified |  |
| `accepted_amount` | bigint |  | verified |  |
| `accepted_amount_in_usd` | bigint |  | verified |  |
| `accepted_count` | bigint |  | verified |  |
| `created_hour` | timestamp |  | verified |  |
| `transaction_amount` | bigint |  | verified |  |
| `transaction_amount_in_usd` | bigint |  | verified |  |
| `transaction_count` | bigint |  | verified |  |

</details>

### `payment_evaluations` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (17, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `billing_email` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `customer_email` | varchar |  | verified |  |
| `early_fraud_warning_risk_level` | varchar |  | verified |  |
| `early_fraud_warning_score` | double |  | verified |  |
| `fraudulent_dispute_risk_level` | varchar |  | verified |  |
| `fraudulent_dispute_score` | double |  | verified |  |
| `fraudulent_payment_risk_level` | varchar |  | verified |  |
| `fraudulent_payment_score` | double |  | verified |  |
| `payment_method_id` | varchar | foreign | verified |  |
| `recommended_action` | varchar |  | verified |  |
| `risk_recommended_action` | varchar |  | verified |  |
| `risk_score` | bigint |  | verified |  |

</details>

**Joins**

- `payment_evaluations.payment_method_id` → `payment_methods.id`

### `payment_intent_line_items` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id, payment_intent_id`

<details><summary>Columns (17, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `payment_intent_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | double |  | verified |  |
| `discount_amount` | bigint |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `payment_method_options_klarna_image_url` | varchar |  | verified |  |
| `payment_method_options_klarna_product_url` | varchar |  | verified |  |
| `payment_method_options_paypal_category` | varchar |  | verified |  |
| `payment_method_options_paypal_description` | varchar |  | verified |  |
| `payment_method_options_paypal_sold_by` | varchar |  | verified |  |
| `product_code` | varchar |  | verified |  |
| `product_name` | varchar |  | verified |  |
| `quantity` | bigint |  | verified |  |
| `total_tax_amount` | bigint |  | verified |  |
| `unit_cost` | bigint |  | verified |  |

</details>

### `payout_minimum_balance_settings` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |

</details>

### `platform_tax_settings` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `default_form_type` | varchar |  | verified |  |
| `k_default_calculation_type` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `merchant` | varchar |  | verified |  |
| `misc_default_calculation_type` | varchar |  | verified |  |
| `nec_default_calculation_type` | varchar |  | verified |  |
| `reporting_year` | bigint |  | verified |  |
| `year` | bigint |  | verified |  |

</details>

### `purchase_details_receipts` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `issuing_transaction_id` | varchar | foreign | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `description` | varchar |  | verified |  |
| `quantity` | double |  | verified |  |
| `total` | bigint |  | verified |  |
| `unit_cost` | bigint |  | verified |  |

</details>

**Joins**

- `purchase_details_receipts.issuing_transaction_id` → `issuing_transactions.id`

### `quote_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `key, quote_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified |  |
| `quote_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `rate_card_rates_beta` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (14, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `created_at` | bigint |  | verified |  |
| `custom_pricing_unit_amount_custom_pricing_unit_id` | varchar |  | verified |  |
| `custom_pricing_unit_amount_value` | varchar |  | verified |  |
| `locality_zone` | varchar |  | verified |  |
| `metadata` | varchar |  | verified |  |
| `metered_item_id` | varchar |  | verified |  |
| `object` | varchar |  | verified |  |
| `rate_card_id` | varchar |  | verified |  |
| `rate_card_version_id` | varchar |  | verified |  |
| `tiering_mode` | varchar |  | verified |  |
| `transform_quantity_divide_by` | bigint |  | verified |  |
| `transform_quantity_round` | varchar |  | verified |  |
| `unit_amount` | varchar |  | verified |  |

</details>

### `revenue_recognition_exclusions` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `transaction_id`

<details><summary>Columns (3, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `transaction_id` | varchar | primary | verified |  |
| `created_at` | timestamp |  | verified |  |
| `deleted_at` | timestamp |  | verified |  |

</details>

### `revenue_recognition_manual_journal_entries` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (16, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `accounting_period_date` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `credit_account` | varchar |  | verified |  |
| `credit_account_gl_name` | varchar |  | verified |  |
| `debit_account` | varchar |  | verified |  |
| `debit_account_gl_name` | varchar |  | verified |  |
| `deleted_at` | timestamp |  | verified |  |
| `description` | varchar |  | verified |  |
| `email` | varchar |  | verified |  |
| `livemode` | boolean |  | verified |  |
| `presentment_amount` | double |  | verified |  |
| `presentment_currency` | varchar |  | verified |  |
| `settlement_amount` | double |  | verified |  |
| `settlement_currency` | varchar |  | verified |  |
| `transaction_id` | varchar |  | verified |  |

</details>

### `revenue_recognition_month_summary` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (26, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `accounting_period_date` | timestamp |  | verified |  |
| `billing_interval` | varchar |  | verified |  |
| `billing_interval_count` | bigint |  | verified |  |
| `charge_id` | varchar | foreign | verified |  |
| `credit_note_id` | varchar | foreign | verified |  |
| `customer_balance_transaction_id` | varchar | foreign | verified |  |
| `customer_id` | varchar | foreign | verified |  |
| `dispute_id` | varchar | foreign | verified |  |
| `external_transaction_source` | varchar |  | verified |  |
| `invoice_id` | varchar | foreign | verified |  |
| `invoice_item_id` | varchar | foreign | verified |  |
| `line_item_id` | varchar | foreign | verified |  |
| `livemode` | boolean |  | verified |  |
| `locality_zone` | varchar |  | verified |  |
| `month_summary_entry_type` | varchar |  | verified |  |
| `plan_id` | varchar | foreign | verified |  |
| `presentment_currency` | varchar |  | verified |  |
| `presentment_net_amount` | bigint |  | verified |  |
| `product_id` | varchar | foreign | verified |  |
| `refund_id` | varchar | foreign | verified |  |
| `settlement_currency` | varchar |  | verified |  |
| `settlement_net_amount` | bigint |  | verified |  |
| `subscription_id` | varchar | foreign | verified |  |
| `subscription_item_id` | varchar | foreign | verified |  |
| `transaction_type` | varchar |  | verified |  |

</details>

**Joins**

- `revenue_recognition_month_summary.charge_id` → `charges.id`
- `revenue_recognition_month_summary.credit_note_id` → `credit_notes.id`
- `revenue_recognition_month_summary.customer_balance_transaction_id` → `customer_balance_transactions.id`
- `revenue_recognition_month_summary.customer_id` → `customers.id`
- `revenue_recognition_month_summary.dispute_id` → `disputes.id`
- `revenue_recognition_month_summary.invoice_id` → `invoices.id`
- `revenue_recognition_month_summary.invoice_item_id` → `invoice_items.id`
- `revenue_recognition_month_summary.plan_id` → `plans.id`
- `revenue_recognition_month_summary.product_id` → `products.id`
- `revenue_recognition_month_summary.refund_id` → `refunds.id`
- `revenue_recognition_month_summary.subscription_id` → `subscriptions.id`
- `revenue_recognition_month_summary.subscription_item_id` → `subscription_items.id`

### `subscription_schedule_phase_add_invoice_items_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `key, phase_id, price, schedule_id`

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified |  |
| `phase_id` | varchar | primary | verified |  |
| `price` | varchar | primary | verified |  |
| `schedule_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `subscription_schedule_phase_configuration_items_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `key, phase_id, price, schedule_id`

<details><summary>Columns (6, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified |  |
| `phase_id` | varchar | primary | verified |  |
| `price` | varchar | primary | verified |  |
| `schedule_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `subscriptions_paid_usage_beta` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `billable_item_source_id, start_time`

<details><summary>Columns (10, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `billable_item_source_id` | varchar | primary | verified |  |
| `billing_meter_id` | varchar | foreign | verified |  |
| `customer_id` | varchar | foreign | verified |  |
| `start_time` | varchar | primary | verified |  |
| `billable_item_type` | varchar |  | verified |  |
| `currency` | varchar |  | verified |  |
| `gross_amount` | bigint |  | verified |  |
| `price_source_id` | varchar |  | verified |  |
| `price_type` | varchar |  | verified |  |
| `segment` | varchar |  | verified |  |

</details>

**Joins**

- `subscriptions_paid_usage_beta.billing_meter_id` → `billing_meters.id`
- `subscriptions_paid_usage_beta.customer_id` → `customers.id`

### `tax_form_filing_statuses` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `tax_form_id`

<details><summary>Columns (7, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `tax_form_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `effective_at` | timestamp |  | verified |  |
| `jurisdiction_country` | varchar |  | verified |  |
| `jurisdiction_level` | varchar |  | verified |  |
| `jurisdiction_state` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `tax_transaction_customer_tax_ids` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `type`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `tax_transaction_id` | varchar | foreign | verified |  |
| `type` | varchar | primary | verified |  |
| `country` | varchar |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

**Joins**

- `tax_transaction_customer_tax_ids.tax_transaction_id` → `tax_transactions.id`

### `topups` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (13, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `balance_transaction` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failure_code` | varchar |  | verified |  |
| `failure_message` | varchar |  | verified |  |
| `initiated_by` | varchar |  | verified |  |
| `statement_descriptor` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `transfer_group` | varchar |  | verified |  |

</details>

### `topups_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `key, topup_id`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `key` | varchar | primary | verified |  |
| `topup_id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `treasury_credit_reversals` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (11, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `financial_account_id` | varchar | foreign | verified |  |
| `network` | varchar |  | verified |  |
| `received_credit_id` | varchar | foreign | verified |  |
| `status` | varchar |  | verified |  |
| `status_transitions_posted_at` | timestamp |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

### `treasury_credit_reversals_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `credit_reversal_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `credit_reversal_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `treasury_debit_reversals` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (12, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `financial_account_id` | varchar | foreign | verified |  |
| `linked_flows_issuing_dispute_id` | varchar | foreign | verified |  |
| `network` | varchar |  | verified |  |
| `received_debit_id` | varchar | foreign | verified |  |
| `status` | varchar |  | verified |  |
| `status_transitions_completed_at` | timestamp |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

### `treasury_debit_reversals_metadata` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `debit_reversal_id, key`

<details><summary>Columns (4, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `debit_reversal_id` | varchar | primary | verified |  |
| `key` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `value` | varchar |  | verified |  |

</details>

### `treasury_received_credits` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (23, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failure_code` | varchar |  | verified |  |
| `financial_account_id` | varchar | foreign | verified |  |
| `initiating_payment_method_details_financial_account_id` | varchar | foreign | verified |  |
| `initiating_payment_method_details_issuing_card_id` | varchar | foreign | verified |  |
| `initiating_payment_method_details_type` | varchar |  | verified |  |
| `initiating_payment_method_details_us_bank_account_last_4` | varchar |  | verified |  |
| `initiating_payment_method_details_us_bank_account_routing_number` | varchar |  | verified |  |
| `linked_flows_credit_reversal_id` | varchar | foreign | verified |  |
| `linked_flows_issuing_authorization_id` | varchar | foreign | verified |  |
| `linked_flows_issuing_transaction_id` | varchar | foreign | verified |  |
| `linked_flows_source_flow_id` | varchar |  | verified |  |
| `linked_flows_source_flow_type` | varchar |  | verified |  |
| `network` | varchar |  | verified |  |
| `reversal_details_deadline` | timestamp |  | verified |  |
| `reversal_details_restricted_reason` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

### `treasury_received_debits` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (23, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `amount` | bigint |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `created` | timestamp |  | verified |  |
| `currency` | varchar |  | verified |  |
| `description` | varchar |  | verified |  |
| `failure_code` | varchar |  | verified |  |
| `financial_account_id` | varchar | foreign | verified |  |
| `initiating_payment_method_details_financial_account_id` | varchar | foreign | verified |  |
| `initiating_payment_method_details_issuing_card_id` | varchar | foreign | verified |  |
| `initiating_payment_method_details_type` | varchar |  | verified |  |
| `initiating_payment_method_details_us_bank_account_last_4` | varchar |  | verified |  |
| `initiating_payment_method_details_us_bank_account_routing_number` | varchar |  | verified |  |
| `linked_flows_debit_reversal_id` | varchar | foreign | verified |  |
| `linked_flows_inbound_transfer_id` | varchar | foreign | verified |  |
| `linked_flows_issuing_authorization_id` | varchar | foreign | verified |  |
| `linked_flows_issuing_transaction_id` | varchar | foreign | verified |  |
| `linked_flows_payout_id` | varchar | foreign | verified |  |
| `network` | varchar |  | verified |  |
| `reversal_details_deadline` | timestamp |  | verified |  |
| `reversal_details_restricted_reason` | varchar |  | verified |  |
| `status` | varchar |  | verified |  |
| `transaction_id` | varchar | foreign | verified |  |

</details>

### `verification_reports` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (43, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `address_error_code` | varchar |  | verified |  |
| `address_status` | varchar |  | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `client_reference_id` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `document_error_code` | varchar |  | verified |  |
| `document_error_reason` | varchar |  | verified |  |
| `document_files` | varchar |  | verified |  |
| `document_issuing_country` | varchar |  | verified |  |
| `document_status` | varchar |  | verified |  |
| `document_type` | varchar |  | verified |  |
| `email_error_code` | varchar |  | verified |  |
| `email_error_reason` | varchar |  | verified |  |
| `email_status` | varchar |  | verified |  |
| `id_number_error_code` | varchar |  | verified |  |
| `id_number_error_reason` | varchar |  | verified |  |
| `id_number_status` | varchar |  | verified |  |
| `matching_error_code` | varchar |  | verified |  |
| `matching_status` | varchar |  | verified |  |
| `options_document_allowed_types` | varchar |  | verified |  |
| `options_document_require_id_number` | boolean |  | verified |  |
| `options_document_require_live_capture` | boolean |  | verified |  |
| `options_document_require_matching_selfie` | boolean |  | verified |  |
| `options_email_require_verification` | boolean |  | verified |  |
| `options_phone_require_verification` | boolean |  | verified |  |
| `phone_error_code` | varchar |  | verified |  |
| `phone_error_reason` | varchar |  | verified |  |
| `phone_otp_error_code` | varchar |  | verified |  |
| `phone_otp_status` | varchar |  | verified |  |
| `phone_records_error_code` | varchar |  | verified |  |
| `phone_records_status` | varchar |  | verified |  |
| `phone_status` | varchar |  | verified |  |
| `selfie_document_file` | varchar |  | verified |  |
| `selfie_error_code` | varchar |  | verified |  |
| `selfie_error_reason` | varchar |  | verified |  |
| `selfie_file` | varchar |  | verified |  |
| `selfie_status` | varchar |  | verified |  |
| `tax_id_error_code` | varchar |  | verified |  |
| `tax_id_status` | varchar |  | verified |  |
| `type` | varchar |  | verified |  |
| `verification_flow_id` | varchar |  | verified |  |
| `verification_session_id` | varchar | foreign | verified |  |

</details>

**Joins**

- `verification_reports.verification_session_id` → `verification_sessions.id`

### `verification_sessions` _(not in Stripe's published table list)_

**Freshness:** unpublished  
**Source:** api_backed  
**Primary key:** `id`

<details><summary>Columns (27, complete)</summary>

| Column | Type | Key | Confidence | Description |
| --- | --- | --- | --- | --- |
| `id` | varchar | primary | verified |  |
| `batch_timestamp` | timestamp |  | verified |  |
| `client_reference_id` | varchar |  | verified |  |
| `created` | timestamp |  | verified |  |
| `last_verification_report_id` | varchar | foreign | verified |  |
| `options_document_allowed_types` | varchar |  | verified |  |
| `options_document_require_id_number` | boolean |  | verified |  |
| `options_document_require_live_capture` | boolean |  | verified |  |
| `options_document_require_matching_selfie` | boolean |  | verified |  |
| `options_email_require_verification` | boolean |  | verified |  |
| `options_matching_dob` | varchar |  | verified |  |
| `options_matching_name` | varchar |  | verified |  |
| `options_phone_require_verification` | boolean |  | verified |  |
| `provided_details_email` | varchar |  | verified |  |
| `provided_details_phone` | varchar |  | verified |  |
| `redaction_status` | varchar |  | verified |  |
| `related_customer_account_id` | varchar | foreign | verified |  |
| `related_customer_id` | varchar | foreign | verified |  |
| `related_person_account_id` | varchar | foreign | verified |  |
| `related_person_id` | varchar |  | verified |  |
| `started_at` | timestamp |  | verified |  |
| `status` | varchar |  | verified |  |
| `submitted_at` | timestamp |  | verified |  |
| `type` | varchar |  | verified |  |
| `verification_flow_id` | varchar |  | verified |  |
| `verified_at` | timestamp |  | verified |  |
| `visited_at` | timestamp |  | verified |  |

</details>

