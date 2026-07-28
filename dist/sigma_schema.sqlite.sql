-- Stripe Sigma schema as SQLite DDL
-- Generated from sigma_schema.json v1.0.0 by tools/emit_artifacts.py
-- Sigma itself is read-only; this DDL exists for tooling, docs and local sandboxes.
-- Columns marked (?) are unverified - see the confidence field in sigma_schema.json.

-- acceptance_reporting_v3_itemized: no column detail published; see sigma_schema.json

-- Your own account and, for Connect platforms, your connected accounts.
CREATE TABLE accounts (
  id                                           TEXT  -- unverified,
  business_name                                TEXT  -- unverified,
  charges_enabled                              INTEGER  -- unverified,
  country                                      TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  default_currency                             TEXT  -- unverified,
  email                                        TEXT  -- unverified,
  payouts_enabled                              INTEGER  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE accounts_metadata (
  account_id                                   TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- activity_report_itemized: no column detail published; see sigma_schema.json

-- aggregate_optimization_details: no column detail published; see sigma_schema.json

-- analytics_acceptance_itemized: no column detail published; see sigma_schema.json

-- Refunds of application fees back to connected accounts.
CREATE TABLE application_fee_refunds (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  balance_transaction_id                       TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  fee_id                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on application_fee_refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE application_fee_refunds_metadata (
  application_fee_refund_id                    TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Fees your Connect platform collected from connected accounts.
CREATE TABLE application_fees (
  id                                           TEXT  -- unverified,
  account_id                                   TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  balance_transaction_id                       TEXT  -- unverified,
  charge_id                                    TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  refunded                                     INTEGER  -- unverified
);

-- Individual 3D Secure authentication attempts, including the resulting charge outcome.
CREATE TABLE authentication_report_attempts (
  charge_outcome                               TEXT,
  created                                      TEXT  -- unverified,
  intent_id                                    TEXT,
  is_final_attempt                             INTEGER,
  threeds_outcome_result                       TEXT
);

-- Line-item breakdown of the fee column on balance_transactions.
CREATE TABLE balance_transaction_fee_details (
  amount                                       INTEGER,
  balance_transaction_id                       TEXT,
  currency                                     TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  "type"                                       TEXT
);

-- Ledger-style record of every event that moves money into or out of your Stripe balance. The canonical starting point for accounting and reconciliation
CREATE TABLE balance_transactions (
  id                                           TEXT,
  amount                                       INTEGER,
  automatic_transfer_id                        TEXT,
  available_on                                 TEXT  -- unverified,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT  -- unverified,
  exchange_rate                                REAL  -- unverified,
  fee                                          INTEGER,
  net                                          INTEGER,
  reporting_category                           TEXT,
  source_id                                    TEXT,
  "type"                                       TEXT
);

-- Aggregated meter usage per customer over a time window.
CREATE TABLE billing_meter_event_summaries (
  aggregated_value                             REAL,
  customer_id                                  TEXT,
  end_time                                     TEXT,
  meter_id                                     TEXT,
  start_time                                   TEXT,
  value_grouping_window                        TEXT
);

-- Meter events that failed validation and were not counted toward usage.
CREATE TABLE billing_meter_invalid_events (
  id                                           TEXT,
  created                                      TEXT  -- unverified,
  error_code                                   TEXT,
  error_message                                TEXT
);

-- Key/value payload of each invalid meter event.
CREATE TABLE billing_meter_invalid_events_payload (
  event_id                                     TEXT,
  "key"                                        TEXT,
  "value"                                      TEXT
);

-- Usage-based billing meters that aggregate metered events.
CREATE TABLE billing_meters (
  id                                           TEXT  -- unverified,
  default_aggregation_formula                  TEXT,
  display_name                                 TEXT,
  event_name                                   TEXT  -- unverified,
  livemode                                     INTEGER,
  status                                       TEXT
);

-- card_testing: no column detail published; see sigma_schema.json

-- cau_fees: no column detail published; see sigma_schema.json

-- charge_groups: no column detail published; see sigma_schema.json

-- Per-charge record of which Stripe payment optimizations were applied and what they recovered.
CREATE TABLE charge_optimization_details (
  charge_id                                    TEXT  -- unverified
);

-- One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance
CREATE TABLE charges (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_refunded                              INTEGER  -- unverified,
  application_fee_id                           TEXT  -- unverified,
  balance_transaction_id                       TEXT  -- unverified,
  captured_at                                  TEXT  -- unverified,
  card_address_zip_check                       TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_cvc_check                               TEXT,
  card_funding                                 TEXT  -- unverified,
  card_last4                                   TEXT  -- unverified,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  description                                  TEXT  -- unverified,
  destination_id                               TEXT,
  dispute_id                                   TEXT  -- unverified,
  failure_code                                 TEXT,
  failure_message                              TEXT,
  invoice_id                                   TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  outcome_network_status                       TEXT  -- unverified,
  outcome_risk_level                           TEXT  -- unverified,
  outcome_risk_score                           INTEGER,
  outcome_rule_id                              TEXT,
  outcome_seller_message                       TEXT  -- unverified,
  outcome_type                                 TEXT,
  paid                                         INTEGER,
  payment_intent_id                            TEXT  -- unverified,
  payment_method_id                            TEXT  -- unverified,
  payment_method_type                          TEXT  -- unverified,
  receipt_email                                TEXT  -- unverified,
  refunded                                     INTEGER  -- unverified,
  statement_descriptor                         TEXT  -- unverified,
  status                                       TEXT,
  transfer_group                               TEXT  -- unverified,
  transfer_id                                  TEXT
);

-- Metadata key/value pairs set on charges. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE charges_metadata (
  charge_id                                    TEXT,
  "key"                                        TEXT,
  "value"                                      TEXT
);

-- Values customers entered into custom fields you configured on a Checkout session.
CREATE TABLE checkout_custom_fields (
  checkout_session_id                          TEXT  -- unverified,
  "key"                                        TEXT  -- unverified
);

-- Line items on a Checkout session.
CREATE TABLE checkout_line_items (
  id                                           TEXT  -- unverified,
  amount_total                                 INTEGER  -- unverified,
  checkout_session_id                          TEXT  -- unverified,
  price_id                                     TEXT  -- unverified,
  quantity                                     INTEGER  -- unverified
);

-- Stripe Checkout sessions, including abandoned ones. The table to use for hosted-checkout conversion analysis.
CREATE TABLE checkout_sessions (
  id                                           TEXT  -- unverified,
  amount_total                                 INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  mode                                         TEXT  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  payment_link_id                              TEXT  -- unverified,
  payment_status                               TEXT  -- unverified,
  status                                       TEXT  -- unverified,
  subscription_id                              TEXT  -- unverified
);

-- Connect platform view of activity_report_itemized, per connected account.
CREATE TABLE connected_account_activity_report_itemized (
  account                                      TEXT  -- unverified
);

-- Connect platform view of balance_transactions for connected accounts. Ledger-style record of every event that moves money into or out of your Stripe b
CREATE TABLE connected_account_balance_transactions (
  account                                      TEXT,
  amount                                       INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  source_id                                    TEXT,
  "type"                                       TEXT,
  id                                           TEXT,
  automatic_transfer_id                        TEXT,
  available_on                                 TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  exchange_rate                                REAL  -- unverified,
  fee                                          INTEGER,
  net                                          INTEGER,
  reporting_category                           TEXT
);

-- Connect platform view of charges for connected accounts. One row per Charge object. Use for charge-level analysis such as card brand mix, decline reas
CREATE TABLE connected_account_charges (
  account                                      TEXT  -- unverified,
  id                                           TEXT,
  amount                                       INTEGER,
  amount_refunded                              INTEGER  -- unverified,
  application_fee_id                           TEXT  -- unverified,
  balance_transaction_id                       TEXT  -- unverified,
  captured_at                                  TEXT  -- unverified,
  card_address_zip_check                       TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_cvc_check                               TEXT,
  card_funding                                 TEXT  -- unverified,
  card_last4                                   TEXT  -- unverified,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  description                                  TEXT  -- unverified,
  destination_id                               TEXT,
  dispute_id                                   TEXT  -- unverified,
  failure_code                                 TEXT,
  failure_message                              TEXT,
  invoice_id                                   TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  outcome_network_status                       TEXT  -- unverified,
  outcome_risk_level                           TEXT  -- unverified,
  outcome_risk_score                           INTEGER,
  outcome_rule_id                              TEXT,
  outcome_seller_message                       TEXT  -- unverified,
  outcome_type                                 TEXT,
  paid                                         INTEGER,
  payment_intent_id                            TEXT  -- unverified,
  payment_method_id                            TEXT  -- unverified,
  payment_method_type                          TEXT  -- unverified,
  receipt_email                                TEXT  -- unverified,
  refunded                                     INTEGER  -- unverified,
  statement_descriptor                         TEXT  -- unverified,
  status                                       TEXT,
  transfer_group                               TEXT  -- unverified,
  transfer_id                                  TEXT
);

-- Connect platform view of issuing_authorizations for connected accounts. Authorization requests created whenever an issued card is used. Includes decli
CREATE TABLE connected_account_issuing_authorizations (
  account                                      TEXT  -- unverified,
  id                                           TEXT,
  amount                                       INTEGER,
  approved                                     INTEGER,
  card_id                                      TEXT,
  cardholder_id                                TEXT  -- unverified,
  created                                      TEXT,
  currency                                     TEXT  -- unverified,
  merchant_category_code                       TEXT  -- unverified,
  merchant_country                             TEXT  -- unverified,
  merchant_name                                TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Connect platform view of itemized_fees, showing fees paid by each connected account.
CREATE TABLE connected_account_itemized_fees (
  account                                      TEXT,
  amount                                       REAL,
  incurred_at                                  TEXT,
  activity_end_date                            TEXT,
  activity_start_date                          TEXT,
  balance_transaction_created                  TEXT,
  balance_transaction_description              TEXT,
  balance_transaction_id                       TEXT,
  currency                                     TEXT,
  incurred_by                                  TEXT,
  incurred_by_type                             TEXT,
  product_feature_description                  TEXT,
  tax                                          REAL
);

-- Preview version of connected_account_itemized_fees.
CREATE TABLE connected_account_itemized_fees_beta (
  account                                      TEXT  -- unverified,
  activity_end_date                            TEXT,
  activity_start_date                          TEXT,
  amount                                       REAL,
  balance_transaction_created                  TEXT,
  balance_transaction_description              TEXT,
  balance_transaction_id                       TEXT,
  currency                                     TEXT,
  incurred_at                                  TEXT,
  incurred_by                                  TEXT,
  incurred_by_type                             TEXT,
  product_feature_description                  TEXT,
  tax                                          REAL
);

-- Connect platform view of payment_records for connected accounts.
CREATE TABLE connected_account_payment_records (
  account                                      TEXT  -- unverified,
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified
);

-- Metadata key/value pairs set on connected_account_payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE connected_account_payment_records_metadata (
  account                                      TEXT  -- unverified,
  connected_account_payment_record_id          TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Connect platform view of summarized_balance_transactions, per connected account.
CREATE TABLE connected_account_summarized_balance_transactions (
  account                                      TEXT  -- unverified
);

-- Connect platform view of connected accounts, including legal entity, onboarding requirements and terms-of-service acceptance.
CREATE TABLE connected_accounts (
  id                                           TEXT,
  business_name                                TEXT,
  country                                      TEXT,
  email                                        TEXT,
  future_requirements_currently_due            TEXT,
  future_requirements_eventually_due           TEXT  -- unverified,
  future_requirements_past_due                 TEXT  -- unverified,
  future_requirements_pending_verification     TEXT  -- unverified,
  legal_entity_address_city                    TEXT,
  legal_entity_address_line1                   TEXT,
  legal_entity_address_postal_code             TEXT,
  legal_entity_address_state                   TEXT,
  legal_entity_dob_day                         INTEGER,
  legal_entity_dob_month                       INTEGER,
  legal_entity_dob_year                        INTEGER,
  legal_entity_first_name                      TEXT,
  legal_entity_last_name                       TEXT,
  legal_entity_personal_id_number_provided     INTEGER,
  legal_entity_ssn_last_4_provided             INTEGER,
  legal_entity_type                            TEXT,
  legal_entity_verification_document_id        TEXT,
  payouts_enabled                              INTEGER,
  requirements_currently_due                   TEXT,
  requirements_eventually_due                  TEXT  -- unverified,
  requirements_past_due                        TEXT  -- unverified,
  requirements_pending_verification            TEXT  -- unverified,
  tos_acceptance_date                          TEXT,
  tos_acceptance_ip                            TEXT
);

-- Discount definitions that can be applied to customers, subscriptions or invoices.
CREATE TABLE coupons (
  id                                           TEXT,
  amount_off                                   INTEGER,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  duration                                     TEXT  -- unverified,
  duration_in_months                           INTEGER  -- unverified,
  max_redemptions                              INTEGER  -- unverified,
  name                                         TEXT  -- unverified,
  percent_off                                  REAL,
  times_redeemed                               INTEGER  -- unverified,
  valid                                        INTEGER
);

-- Per-currency overrides for multi-currency coupons.
CREATE TABLE coupons_currency_options (
  amount_off                                   INTEGER  -- unverified,
  coupon_id                                    TEXT  -- unverified,
  currency                                     TEXT  -- unverified
);

-- Metadata key/value pairs set on coupons. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE coupons_metadata (
  coupon_id                                    TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Discount amounts applied at the credit note level.
CREATE TABLE credit_note_discount_amounts (
  amount                                       INTEGER  -- unverified,
  credit_note_id                               TEXT  -- unverified,
  discount_id                                  TEXT  -- unverified
);

-- Discount amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_discount_amounts (
  amount                                       INTEGER  -- unverified,
  credit_note_line_item_id                     TEXT  -- unverified
);

-- Tax amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_tax_amounts (
  amount                                       INTEGER  -- unverified,
  credit_note_line_item_id                     TEXT  -- unverified,
  tax_rate_id                                  TEXT  -- unverified
);

-- Line items on a credit note.
CREATE TABLE credit_note_line_items (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  credit_note_id                               TEXT  -- unverified,
  invoice_line_item_id                         TEXT  -- unverified
);

-- Tax amounts applied at the credit note level.
CREATE TABLE credit_note_tax_amounts (
  amount                                       INTEGER  -- unverified,
  credit_note_id                               TEXT  -- unverified,
  tax_rate_id                                  TEXT  -- unverified
);

-- Post-issuance adjustments to invoices — the correct way to represent refunds and write-offs against a finalized invoice.
CREATE TABLE credit_notes (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  reason                                       TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on credit_notes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE credit_notes_metadata (
  credit_note_id                               TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Stripe crypto onramp sessions where users bought crypto with fiat.
CREATE TABLE crypto_onramp_sessions (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Changes to a customer's account credit balance.
CREATE TABLE customer_balance_transactions (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on customer_balance_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customer_balance_transactions_metadata (
  customer_balance_transaction_id              TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Changes to a customer's cash balance held at Stripe, used for bank-transfer funding.
CREATE TABLE customer_cash_balance_transactions (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  net_amount                                   INTEGER  -- unverified
);

-- Tax identifiers stored against a customer.
CREATE TABLE customer_tax_ids (
  id                                           TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  "type"                                       TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- One row per Customer object.
CREATE TABLE customers (
  id                                           TEXT,
  address_city                                 TEXT  -- unverified,
  address_country                              TEXT  -- unverified,
  address_postal_code                          TEXT  -- unverified,
  balance                                      INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  default_source_id                            TEXT  -- unverified,
  delinquent                                   INTEGER  -- unverified,
  description                                  TEXT  -- unverified,
  email                                        TEXT,
  is_deleted                                   INTEGER  -- unverified,
  livemode                                     INTEGER  -- unverified,
  name                                         TEXT  -- unverified
);

-- Metadata key/value pairs set on customers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customers_metadata (
  customer_id                                  TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Applications of a coupon or promotion code to a customer, subscription or invoice.
CREATE TABLE discounts (
  id                                           TEXT,
  coupon_id                                    TEXT,
  customer_id                                  TEXT  -- unverified,
  "end"                                        TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  promotion_code_id                            TEXT  -- unverified,
  "start"                                      TEXT  -- unverified,
  subscription_id                              TEXT  -- unverified
);

-- One row per Dispute (chargeback), including any evidence you submitted.
CREATE TABLE disputes (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_transaction_id                       TEXT  -- unverified,
  charge_id                                    TEXT,
  created                                      TEXT,
  currency                                     TEXT  -- unverified,
  evidence_due_by                              TEXT  -- unverified,
  is_charge_refundable                         INTEGER  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  reason                                       TEXT,
  status                                       TEXT
);

-- Eligibility of each dispute for enhanced evidence programs such as Visa Compelling Evidence 3.0.
CREATE TABLE disputes_enhanced_eligibility (
  dispute_id                                   TEXT  -- unverified
);

-- Metadata key/value pairs set on disputes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE disputes_metadata (
  dispute_id                                   TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Fraud reports issued by the card network before a formal dispute is filed. Leading indicator for card brand monitoring programs such as Visa VAMP.
CREATE TABLE early_fraud_warnings (
  id                                           TEXT  -- unverified,
  actionable                                   INTEGER  -- unverified,
  charge_id                                    TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  fraud_type                                   TEXT  -- unverified,
  payment_intent_id                            TEXT  -- unverified
);

-- Daily currency conversion rates expressed relative to USD. Needed to sum multi-currency amounts into one reporting currency.
CREATE TABLE exchange_rates_from_usd (
  buy_currency_exchange_rates                  TEXT,
  "date"                                       TEXT
);

-- financing_balances: no column detail published; see sigma_schema.json

-- Stripe Capital financing offers extended to you or your connected accounts.
CREATE TABLE financing_offers (
  id                                           TEXT  -- unverified,
  account_id                                   TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Repayments and drawdowns against Stripe Capital financing.
CREATE TABLE financing_transactions (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Interchange-plus fee breakdown, splitting each fee into interchange, scheme and Stripe components.
CREATE TABLE icplus_fees (
  balance_transaction_created_at               TEXT,
  balance_transaction_id                       TEXT,
  billing_amount                               INTEGER,
  billing_currency                             TEXT,
  charge_id                                    TEXT
);

-- Custom key/value fields rendered on an invoice.
CREATE TABLE invoice_custom_fields (
  invoice_id                                   TEXT  -- unverified,
  name                                         TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Customer tax identifiers captured on an invoice.
CREATE TABLE invoice_customer_tax_ids (
  invoice_id                                   TEXT  -- unverified,
  "type"                                       TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- One-off charges or credits queued onto a customer's next invoice.
CREATE TABLE invoice_items (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  proration                                    INTEGER  -- unverified,
  subscription_id                              TEXT  -- unverified
);

-- Metadata key/value pairs set on invoice_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoice_items_metadata (
  invoice_item_id                              TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Discount amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_discount_amounts (
  amount                                       INTEGER,
  discount_id                                  TEXT  -- unverified,
  invoice_id                                   TEXT,
  invoice_line_item_id                         TEXT  -- unverified
);

-- Tax amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_tax_amounts (
  amount                                       INTEGER  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  invoice_line_item_id                         TEXT  -- unverified,
  tax_rate_id                                  TEXT  -- unverified
);

-- Individual line items on an invoice.
CREATE TABLE invoice_line_items (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  currency                                     TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  period_end                                   TEXT  -- unverified,
  period_start                                 TEXT  -- unverified,
  price_id                                     TEXT  -- unverified,
  proration                                    INTEGER  -- unverified,
  quantity                                     INTEGER  -- unverified,
  source_id                                    TEXT,
  source_type                                  TEXT,
  subscription_id                              TEXT  -- unverified
);

-- Payment attempts against an invoice, linking invoices to the charges or payment intents that settled them.
CREATE TABLE invoice_payments (
  amount_paid                                  INTEGER  -- unverified,
  charge_id                                    TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Tax applied to shipping costs on an invoice.
CREATE TABLE invoice_shipping_cost_taxes (
  amount                                       INTEGER  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  tax_rate_id                                  TEXT  -- unverified
);

-- One row per Invoice object. Each subscription generates invoices on a recurring basis covering the subscription amount plus any invoice items.
CREATE TABLE invoices (
  id                                           TEXT,
  amount_due                                   INTEGER,
  amount_paid                                  INTEGER  -- unverified,
  amount_remaining                             INTEGER  -- unverified,
  attempt_count                                INTEGER  -- unverified,
  billing_reason                               TEXT  -- unverified,
  charge_id                                    TEXT,
  collection_method                            TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT,
  customer_id                                  TEXT  -- unverified,
  due_date                                     TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  number                                       TEXT  -- unverified,
  paid                                         INTEGER  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  period_end                                   TEXT,
  period_start                                 TEXT,
  status                                       TEXT  -- unverified,
  subscription_id                              TEXT,
  subtotal                                     INTEGER  -- unverified,
  tax                                          INTEGER  -- unverified,
  total                                        INTEGER
);

-- Metadata key/value pairs set on invoices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoices_metadata (
  invoice_id                                   TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Authorization requests created whenever an issued card is used. Includes declined attempts.
CREATE TABLE issuing_authorizations (
  id                                           TEXT,
  amount                                       INTEGER,
  approved                                     INTEGER,
  card_id                                      TEXT,
  cardholder_id                                TEXT  -- unverified,
  created                                      TEXT,
  currency                                     TEXT  -- unverified,
  merchant_category_code                       TEXT  -- unverified,
  merchant_country                             TEXT  -- unverified,
  merchant_name                                TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on issuing_authorizations. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_authorizations_metadata (
  issuing_authorization_id                     TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- People or businesses that hold cards you have issued.
CREATE TABLE issuing_cardholders (
  id                                           TEXT  -- unverified,
  created                                      TEXT,
  email                                        TEXT,
  name                                         TEXT  -- unverified,
  phone_number                                 TEXT  -- unverified,
  status                                       TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on issuing_cardholders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cardholders_metadata (
  issuing_cardholder_id                        TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Cards you have issued.
CREATE TABLE issuing_cards (
  id                                           TEXT  -- unverified,
  brand                                        TEXT  -- unverified,
  cardholder_id                                TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  exp_month                                    INTEGER  -- unverified,
  exp_year                                     INTEGER  -- unverified,
  last4                                        TEXT  -- unverified,
  status                                       TEXT  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on issuing_cards. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cards_metadata (
  issuing_card_id                              TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Disputes you filed on behalf of cardholders against merchants.
CREATE TABLE issuing_disputes (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  reason                                       TEXT  -- unverified,
  status                                       TEXT  -- unverified,
  transaction_id                               TEXT  -- unverified
);

-- Network tokens provisioned for issued cards, such as those created when a card is added to a mobile wallet.
CREATE TABLE issuing_network_tokens (
  id                                           TEXT  -- unverified,
  card_id                                      TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Uses of an issued card that actually moved funds, such as completed purchases and refunds.
CREATE TABLE issuing_transactions (
  id                                           TEXT,
  amount                                       INTEGER,
  authorization_id                             TEXT,
  balance_transaction_id                       TEXT,
  card_id                                      TEXT  -- unverified,
  cardholder_id                                TEXT  -- unverified,
  created                                      TEXT,
  currency                                     TEXT  -- unverified,
  merchant_name                                TEXT  -- unverified,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on issuing_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_transactions_metadata (
  issuing_transaction_id                       TEXT  -- unverified,
  "key"                                        TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Granular breakdown of every fee charged or deducted from your Stripe balance, one row per fee component.
CREATE TABLE itemized_fees (
  activity_end_date                            TEXT,
  activity_start_date                          TEXT,
  amount                                       REAL,
  balance_transaction_created                  TEXT,
  balance_transaction_description              TEXT,
  balance_transaction_id                       TEXT,
  currency                                     TEXT,
  incurred_at                                  TEXT,
  incurred_by                                  TEXT,
  incurred_by_type                             TEXT,
  product_feature_description                  TEXT,
  tax                                          REAL
);

-- Preview version of itemized_fees.
CREATE TABLE itemized_fees_beta (
  activity_end_date                            TEXT,
  activity_start_date                          TEXT,
  amount                                       REAL,
  balance_transaction_created                  TEXT,
  balance_transaction_description              TEXT,
  balance_transaction_id                       TEXT,
  currency                                     TEXT,
  incurred_at                                  TEXT,
  incurred_by                                  TEXT,
  incurred_by_type                             TEXT,
  product_feature_description                  TEXT,
  tax                                          REAL
);

-- network_cost_insights_report: no column detail published; see sigma_schema.json

-- One row per PaymentIntent. Represents the full lifecycle of collecting a payment, including attempts that never produced a charge.
CREATE TABLE payment_intents (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  amount_received                              INTEGER  -- unverified,
  cancellation_reason                          TEXT  -- unverified,
  capture_method                               TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  payment_method_id                            TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on payment_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_intents_metadata (
  "key"                                        TEXT  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Reusable shareable links that open a Checkout session.
CREATE TABLE payment_links (
  id                                           TEXT  -- unverified,
  active                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  url                                          TEXT  -- unverified
);

-- Per-charge payment method detail that does not fit in the flattened card_* columns on charges, including 3D Secure results and wallet information.
CREATE TABLE payment_method_details (
  card_3ds_authenticated                       INTEGER  -- unverified,
  card_3ds_succeeded                           INTEGER,
  card_network                                 TEXT  -- unverified,
  card_wallet_type                             TEXT  -- unverified,
  charge_id                                    TEXT,
  "type"                                       TEXT  -- unverified
);

-- Saved payment instruments attached to customers.
CREATE TABLE payment_methods (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on payment_methods. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_methods_metadata (
  "key"                                        TEXT  -- unverified,
  payment_method_id                            TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Unified payment records spanning Stripe and externally processed payments.
CREATE TABLE payment_records (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified
);

-- Metadata key/value pairs set on payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_records_metadata (
  "key"                                        TEXT  -- unverified,
  payment_record_id                            TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Payments flagged by Radar for manual review, and how they were resolved.
CREATE TABLE payment_reviews (
  id                                           TEXT  -- unverified,
  charge_id                                    TEXT  -- unverified,
  closed_reason                                TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  reason                                       TEXT  -- unverified
);

-- Legacy recurring pricing objects, superseded by prices. Retained for older integrations.
CREATE TABLE plans (
  id                                           TEXT  -- unverified,
  active                                       INTEGER  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  "interval"                                   TEXT  -- unverified,
  product_id                                   TEXT  -- unverified
);

-- Metadata key/value pairs set on plans. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE plans_metadata (
  "key"                                        TEXT  -- unverified,
  plan_id                                      TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Tier definitions for prices using tiered billing.
CREATE TABLE price_tiers (
  amount                                       INTEGER,
  flat_amount                                  INTEGER  -- unverified,
  price_id                                     TEXT,
  upto                                         INTEGER
);

-- How much and how often to charge for a product.
CREATE TABLE prices (
  id                                           TEXT,
  active                                       INTEGER  -- unverified,
  billing_scheme                               TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT,
  livemode                                     INTEGER  -- unverified,
  nickname                                     TEXT  -- unverified,
  product_id                                   TEXT  -- unverified,
  recurring_interval                           TEXT  -- unverified,
  recurring_interval_count                     INTEGER  -- unverified,
  recurring_usage_type                         TEXT  -- unverified,
  tiers_mode                                   TEXT  -- unverified,
  "type"                                       TEXT  -- unverified,
  unit_amount                                  INTEGER  -- unverified
);

-- Per-currency overrides for multi-currency prices.
CREATE TABLE prices_currency_options (
  currency                                     TEXT  -- unverified,
  price_id                                     TEXT  -- unverified,
  unit_amount                                  INTEGER  -- unverified
);

-- Metadata key/value pairs set on prices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE prices_metadata (
  "key"                                        TEXT  -- unverified,
  price_id                                     TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Goods or services you sell.
CREATE TABLE products (
  id                                           TEXT,
  active                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  name                                         TEXT,
  statement_descriptor                         TEXT,
  unit_label                                   TEXT  -- unverified
);

-- Metadata key/value pairs set on products. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE products_metadata (
  "key"                                        TEXT  -- unverified,
  product_id                                   TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Customer-facing codes that map to a coupon.
CREATE TABLE promotion_codes (
  id                                           TEXT,
  active                                       INTEGER  -- unverified,
  code                                         TEXT,
  coupon_id                                    TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  expires_at                                   TEXT  -- unverified,
  max_redemptions                              INTEGER  -- unverified,
  times_redeemed                               INTEGER
);

-- Sales quotes that can be accepted to create an invoice or subscription.
CREATE TABLE quotes (
  id                                           TEXT  -- unverified,
  amount_total                                 INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified,
  status                                       TEXT  -- unverified,
  subscription_id                              TEXT  -- unverified
);

-- radar_data_integration: no column detail published; see sigma_schema.json

-- Snapshot of most Radar rule attribute values as evaluated for a single charge. Useful for backtesting rules against known outcomes.
CREATE TABLE radar_rule_attributes (
  card_3d_secure_support                       TEXT,
  cvc_check                                    TEXT,
  is_3d_secure_authenticated                   INTEGER,
  risk_score                                   INTEGER,
  total_charges_per_card_number_all_time       INTEGER,
  transaction_id                               TEXT
);

-- Radar for Fraud Teams custom rules, with their action and predicate. Built-in Stripe rules have fixed ids.
CREATE TABLE radar_rules (
  id                                           TEXT  -- unverified,
  action                                       TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  predicate                                    TEXT  -- unverified
);

-- Smart Retries and dunning outcomes — revenue recovered after a failed subscription payment.
CREATE TABLE recoveries (
  customer_id                                  TEXT  -- unverified,
  invoice_id                                   TEXT  -- unverified
);

-- One row per Refund object. Refunds are separate objects from charges; refunding a charge creates a row here and a matching balance transaction.
CREATE TABLE refunds (
  id                                           TEXT,
  amount                                       INTEGER  -- unverified,
  balance_transaction_id                       TEXT,
  charge_id                                    TEXT,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  description                                  TEXT  -- unverified,
  payment_intent_id                            TEXT  -- unverified,
  reason                                       TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE refunds_metadata (
  "key"                                        TEXT  -- unverified,
  refund_id                                    TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- revenue_recognition_debits_and_credits: no column detail published; see sigma_schema.json

-- Every Radar rule evaluation, including 3DS rules triggered on PaymentIntents and SetupIntents.
CREATE TABLE rule_decisions (
  id                                           TEXT,
  action                                       TEXT,
  charge_id                                    TEXT  -- unverified,
  created                                      TEXT,
  payment_intent_id                            TEXT,
  rule_id                                      TEXT,
  setup_intent_id                              TEXT  -- unverified
);

-- Individual attempts to confirm a SetupIntent, including failures.
CREATE TABLE setup_attempts (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  setup_intent_id                              TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Attempts to save a payment method for future use without charging it immediately.
CREATE TABLE setup_intents (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  payment_method_id                            TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on setup_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE setup_intents_metadata (
  "key"                                        TEXT  -- unverified,
  setup_intent_id                              TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Legacy payment sources, superseded by payment_methods. Present for older integrations.
CREATE TABLE sources (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on sources. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE sources_metadata (
  "key"                                        TEXT  -- unverified,
  source_id                                    TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Pre-computed MRR movement events. Stripe's recommended basis for MRR, churn and expansion reporting — far more reliable than deriving movements from s
CREATE TABLE subscription_item_change_events (
  currency                                     TEXT,
  customer_id                                  TEXT,
  event_type                                   TEXT,
  local_event_timestamp                        TEXT,
  mrr_change                                   INTEGER,
  price_id                                     TEXT,
  product_id                                   TEXT,
  quantity_change                              INTEGER,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT
);

-- Sandbox/test-mode equivalent of subscription_item_change_events.
CREATE TABLE subscription_item_change_events_testmode (
  currency                                     TEXT,
  customer_id                                  TEXT,
  event_type                                   TEXT,
  local_event_timestamp                        TEXT,
  mrr_change                                   INTEGER,
  price_id                                     TEXT,
  product_id                                   TEXT,
  quantity_change                              INTEGER,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT
);

-- Public preview rebuild of subscription_item_change_events with 3-hour freshness instead of 24-hour. Same columns.
CREATE TABLE subscription_item_change_events_v2_beta (
  currency                                     TEXT,
  customer_id                                  TEXT,
  event_type                                   TEXT,
  local_event_timestamp                        TEXT,
  mrr_change                                   INTEGER,
  price_id                                     TEXT,
  product_id                                   TEXT,
  quantity_change                              INTEGER,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT
);

-- Individual priced items on a subscription. A subscription with multiple products has one row per product here.
CREATE TABLE subscription_items (
  id                                           TEXT,
  created                                      TEXT  -- unverified,
  price_id                                     TEXT,
  price_product_id                             TEXT,
  quantity                                     INTEGER  -- unverified,
  subscription_id                              TEXT
);

-- Metadata key/value pairs set on subscription_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_items_metadata (
  "key"                                        TEXT  -- unverified,
  subscription_item_id                         TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- One-off invoice items attached to a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_add_invoice_items (
  price_id                                     TEXT  -- unverified,
  subscription_schedule_id                     TEXT  -- unverified
);

-- Priced items configured within a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_configuration_items (
  price_id                                     TEXT  -- unverified,
  quantity                                     INTEGER  -- unverified,
  subscription_schedule_id                     TEXT  -- unverified
);

-- Individual phases of a subscription schedule.
CREATE TABLE subscription_schedule_phases (
  id                                           TEXT  -- unverified,
  end_date                                     TEXT  -- unverified,
  start_date                                   TEXT  -- unverified,
  subscription_schedule_id                     TEXT  -- unverified
);

-- Metadata key/value pairs set on subscription_schedule_phases. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedule_phases_metadata (
  "key"                                        TEXT  -- unverified,
  subscription_schedule_phas_id                TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Planned sequences of subscription phases, used for scheduled price or term changes.
CREATE TABLE subscription_schedules (
  id                                           TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  status                                       TEXT  -- unverified,
  subscription_id                              TEXT  -- unverified
);

-- Metadata key/value pairs set on subscription_schedules. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedules_metadata (
  "key"                                        TEXT  -- unverified,
  subscription_schedule_id                     TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- One row per Subscription object. The primary Billing table alongside invoices.
CREATE TABLE subscriptions (
  id                                           TEXT,
  billing_cycle_anchor                         TEXT  -- unverified,
  cancel_at_period_end                         INTEGER  -- unverified,
  canceled_at                                  TEXT  -- unverified,
  collection_method                            TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  current_period_end                           TEXT  -- unverified,
  current_period_start                         TEXT  -- unverified,
  customer_id                                  TEXT,
  default_payment_method_id                    TEXT  -- unverified,
  discounts                                    TEXT  -- unverified,
  ended_at                                     TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  plan_id                                      TEXT  -- unverified,
  price_id                                     TEXT,
  quantity                                     INTEGER  -- unverified,
  start_date                                   TEXT  -- unverified,
  status                                       TEXT,
  trial_end                                    TEXT  -- unverified,
  trial_start                                  TEXT  -- unverified
);

-- Metadata key/value pairs set on subscriptions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscriptions_metadata (
  "key"                                        TEXT  -- unverified,
  subscription_id                              TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- summarized_balance_transactions: no column detail published; see sigma_schema.json

-- Product categories Stripe Tax uses to determine tax treatment. Contains all generally available tax codes, not just ones you use.
CREATE TABLE tax_codes (
  id                                           TEXT,
  description                                  TEXT  -- unverified,
  name                                         TEXT
);

-- Tax forms (such as 1099s) generated for your connected accounts.
CREATE TABLE tax_forms (
  id                                           TEXT  -- unverified,
  account_id                                   TEXT  -- unverified,
  "type"                                       TEXT  -- unverified
);

-- Manually defined tax rates used on invoices and subscriptions. Distinct from Stripe Tax's automatic calculations.
CREATE TABLE tax_rates (
  id                                           TEXT  -- unverified,
  active                                       INTEGER  -- unverified,
  country                                      TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  display_name                                 TEXT  -- unverified,
  inclusive                                    INTEGER  -- unverified,
  jurisdiction                                 TEXT  -- unverified,
  percentage                                   REAL  -- unverified
);

-- Metadata key/value pairs set on tax_rates. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_rates_metadata (
  "key"                                        TEXT  -- unverified,
  tax_rate_id                                  TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Per-jurisdiction breakdown of the tax liability for a tax transaction item.
CREATE TABLE tax_transaction_jurisdiction_details (
  id                                           TEXT,
  amount_non_taxable                           INTEGER,
  amount_tax                                   INTEGER,
  amount_taxable                               INTEGER,
  currency                                     TEXT,
  filing_amount_non_taxable                    INTEGER,
  filing_amount_tax                            INTEGER,
  filing_amount_taxable                        INTEGER,
  filing_currency                              TEXT,
  jurisdiction_country                         TEXT,
  jurisdiction_level                           TEXT,
  jurisdiction_name                            TEXT,
  jurisdiction_state                           TEXT,
  tax_rate_percentage                          REAL,
  tax_transaction_id                           TEXT,
  tax_transaction_item_id                      TEXT,
  tax_transaction_item_type                    TEXT,
  tax_type                                     TEXT,
  taxability                                   TEXT,
  taxability_reason                            TEXT
);

-- Line items contributing to the sale of goods for a tax transaction.
CREATE TABLE tax_transaction_line_items (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_tax                                   INTEGER,
  currency                                     TEXT,
  quantity_decimal                             TEXT,
  source_line_item_id                          TEXT,
  tax_behavior                                 TEXT,
  tax_code                                     TEXT,
  tax_transaction_id                           TEXT
);

-- Metadata key/value pairs set on tax_transaction_line_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transaction_line_items_metadata (
  "key"                                        TEXT  -- unverified,
  tax_transaction_line_item_id                 TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Shipping costs contributing to a tax transaction. Structurally parallel to tax_transaction_line_items.
CREATE TABLE tax_transaction_shipping_costs (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_tax                                   INTEGER,
  currency                                     TEXT,
  tax_behavior                                 TEXT,
  tax_code                                     TEXT,
  tax_transaction_id                           TEXT
);

-- Records of assumed or reduced tax liability. The recommended starting point for tax reporting, and the bridge between tax tables and invoices or check
CREATE TABLE tax_transactions (
  id                                           TEXT,
  currency                                     TEXT  -- unverified,
  customer_id                                  TEXT  -- unverified,
  livemode                                     INTEGER  -- unverified,
  posted_at                                    TEXT,
  source_id                                    TEXT,
  source_type                                  TEXT,
  tax_date                                     TEXT,
  "type"                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on tax_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transactions_metadata (
  "key"                                        TEXT  -- unverified,
  tax_transaction_id                           TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Line items on a Terminal hardware order.
CREATE TABLE terminal_hardware_order_items (
  amount                                       INTEGER  -- unverified,
  quantity                                     INTEGER  -- unverified,
  terminal_hardware_order_id                   TEXT  -- unverified
);

-- Metadata key/value pairs set on terminal_hardware_orders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE terminal_hardware_order_metadata (
  "key"                                        TEXT  -- unverified,
  terminal_hardware_order_id                   TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Shipment tracking information for Terminal hardware orders.
CREATE TABLE terminal_hardware_order_shipment_tracking (
  carrier                                      TEXT  -- unverified,
  terminal_hardware_order_id                   TEXT  -- unverified,
  tracking_number                              TEXT  -- unverified
);

-- Tax applied to a Terminal hardware order.
CREATE TABLE terminal_hardware_order_tax_amounts (
  amount                                       INTEGER  -- unverified,
  terminal_hardware_order_id                   TEXT  -- unverified
);

-- Orders you placed for Terminal reader hardware.
CREATE TABLE terminal_hardware_orders (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Physical locations where you operate Terminal card readers.
CREATE TABLE terminal_locations (
  id                                           TEXT  -- unverified,
  address_city                                 TEXT  -- unverified,
  address_country                              TEXT  -- unverified,
  display_name                                 TEXT  -- unverified
);

-- Terminal card reader devices registered to your account.
CREATE TABLE terminal_readers (
  id                                           TEXT  -- unverified,
  device_type                                  TEXT  -- unverified,
  label                                        TEXT  -- unverified,
  location_id                                  TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Reversals of manually created transfers or payouts. Automatic payouts cannot be reversed.
CREATE TABLE transfer_reversals (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  balance_transaction_id                       TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  transfer_id                                  TEXT  -- unverified
);

-- Metadata key/value pairs set on transfer_reversals. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfer_reversals_metadata (
  "key"                                        TEXT  -- unverified,
  transfer_reversal_id                         TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Payouts from your Stripe balance to your bank account, and — for Connect platforms — transfers of funds to connected accounts.
CREATE TABLE transfers (
  id                                           TEXT,
  amount                                       INTEGER,
  automatic                                    INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  "date"                                       TEXT,
  description                                  TEXT  -- unverified,
  destination_id                               TEXT,
  failure_code                                 TEXT  -- unverified,
  status                                       TEXT  -- unverified,
  transfer_group                               TEXT  -- unverified
);

-- Metadata key/value pairs set on transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfers_metadata (
  "key"                                        TEXT  -- unverified,
  transfer_id                                  TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Treasury financial accounts that store funds for your platform's users.
CREATE TABLE treasury_financial_accounts (
  id                                           TEXT  -- unverified,
  country                                      TEXT  -- unverified,
  created                                      TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on treasury_financial_accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_financial_accounts_metadata (
  "key"                                        TEXT  -- unverified,
  treasury_financial_account_id                TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Money pulled into a Treasury financial account from an external bank account.
CREATE TABLE treasury_inbound_transfers (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  financial_account_id                         TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on treasury_inbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_inbound_transfers_metadata (
  "key"                                        TEXT  -- unverified,
  treasury_inbound_transfer_id                 TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Money sent from a Treasury financial account to a third party.
CREATE TABLE treasury_outbound_payments (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  financial_account_id                         TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on treasury_outbound_payments. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_payments_metadata (
  "key"                                        TEXT  -- unverified,
  treasury_outbound_payment_id                 TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Money sent from a Treasury financial account to an external bank account you own.
CREATE TABLE treasury_outbound_transfers (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  financial_account_id                         TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Metadata key/value pairs set on treasury_outbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_transfers_metadata (
  "key"                                        TEXT  -- unverified,
  treasury_outbound_transfer_id                TEXT  -- unverified,
  "value"                                      TEXT  -- unverified
);

-- Individual ledger entries making up a Treasury transaction.
CREATE TABLE treasury_transaction_entries (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  transaction_id                               TEXT  -- unverified
);

-- Ledger of all money movement on Treasury financial accounts.
CREATE TABLE treasury_transactions (
  id                                           TEXT  -- unverified,
  amount                                       INTEGER  -- unverified,
  created                                      TEXT  -- unverified,
  currency                                     TEXT  -- unverified,
  financial_account_id                         TEXT  -- unverified,
  status                                       TEXT  -- unverified
);

-- Reported usage quantities for metered subscription items. Legacy path; newer integrations use billing meters.
CREATE TABLE usage_records (
  quantity                                     INTEGER  -- unverified,
  subscription_item_id                         TEXT  -- unverified,
  timestamp                                    TEXT  -- unverified
);

