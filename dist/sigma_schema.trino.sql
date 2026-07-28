-- Stripe Sigma schema as Trino DDL
-- Generated from sigma_schema.json v1.0.0 by tools/emit_artifacts.py
-- Sigma itself is read-only; this DDL exists for tooling, docs and local sandboxes.
-- Columns marked (?) are unverified - see the confidence field in sigma_schema.json.

-- acceptance_reporting_v3_itemized: no column detail published; see sigma_schema.json

-- Your own account and, for Connect platforms, your connected accounts.
CREATE TABLE accounts (
  id                                           VARCHAR  -- unverified,
  business_name                                VARCHAR  -- unverified,
  charges_enabled                              BOOLEAN  -- unverified,
  country                                      VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  default_currency                             VARCHAR  -- unverified,
  email                                        VARCHAR  -- unverified,
  payouts_enabled                              BOOLEAN  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE accounts_metadata (
  account_id                                   VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- activity_report_itemized: no column detail published; see sigma_schema.json

-- aggregate_optimization_details: no column detail published; see sigma_schema.json

-- analytics_acceptance_itemized: no column detail published; see sigma_schema.json

-- Refunds of application fees back to connected accounts.
CREATE TABLE application_fee_refunds (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  balance_transaction_id                       VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  fee_id                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on application_fee_refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE application_fee_refunds_metadata (
  application_fee_refund_id                    VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Fees your Connect platform collected from connected accounts.
CREATE TABLE application_fees (
  id                                           VARCHAR  -- unverified,
  account_id                                   VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  balance_transaction_id                       VARCHAR  -- unverified,
  charge_id                                    VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  refunded                                     BOOLEAN  -- unverified
);

-- Individual 3D Secure authentication attempts, including the resulting charge outcome.
CREATE TABLE authentication_report_attempts (
  charge_outcome                               VARCHAR,
  created                                      TIMESTAMP  -- unverified,
  intent_id                                    VARCHAR,
  is_final_attempt                             BOOLEAN,
  threeds_outcome_result                       VARCHAR
);

-- Line-item breakdown of the fee column on balance_transactions.
CREATE TABLE balance_transaction_fee_details (
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR,
  currency                                     VARCHAR  -- unverified,
  description                                  VARCHAR  -- unverified,
  "type"                                       VARCHAR
);

-- Ledger-style record of every event that moves money into or out of your Stripe balance. The canonical starting point for accounting and reconciliation
CREATE TABLE balance_transactions (
  id                                           VARCHAR,
  amount                                       BIGINT,
  automatic_transfer_id                        VARCHAR,
  available_on                                 TIMESTAMP  -- unverified,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR  -- unverified,
  exchange_rate                                DOUBLE  -- unverified,
  fee                                          BIGINT,
  net                                          BIGINT,
  reporting_category                           VARCHAR,
  source_id                                    VARCHAR,
  "type"                                       VARCHAR
);

-- Aggregated meter usage per customer over a time window.
CREATE TABLE billing_meter_event_summaries (
  aggregated_value                             DOUBLE,
  customer_id                                  VARCHAR,
  end_time                                     TIMESTAMP,
  meter_id                                     VARCHAR,
  start_time                                   TIMESTAMP,
  value_grouping_window                        VARCHAR
);

-- Meter events that failed validation and were not counted toward usage.
CREATE TABLE billing_meter_invalid_events (
  id                                           VARCHAR,
  created                                      TIMESTAMP  -- unverified,
  error_code                                   VARCHAR,
  error_message                                VARCHAR
);

-- Key/value payload of each invalid meter event.
CREATE TABLE billing_meter_invalid_events_payload (
  event_id                                     VARCHAR,
  "key"                                        VARCHAR,
  "value"                                      VARCHAR
);

-- Usage-based billing meters that aggregate metered events.
CREATE TABLE billing_meters (
  id                                           VARCHAR  -- unverified,
  default_aggregation_formula                  VARCHAR,
  display_name                                 VARCHAR,
  event_name                                   VARCHAR  -- unverified,
  livemode                                     BOOLEAN,
  status                                       VARCHAR
);

-- card_testing: no column detail published; see sigma_schema.json

-- cau_fees: no column detail published; see sigma_schema.json

-- charge_groups: no column detail published; see sigma_schema.json

-- Per-charge record of which Stripe payment optimizations were applied and what they recovered.
CREATE TABLE charge_optimization_details (
  charge_id                                    VARCHAR  -- unverified
);

-- One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance
CREATE TABLE charges (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_refunded                              BIGINT  -- unverified,
  application_fee_id                           VARCHAR  -- unverified,
  balance_transaction_id                       VARCHAR  -- unverified,
  captured_at                                  TIMESTAMP  -- unverified,
  card_address_zip_check                       VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_cvc_check                               VARCHAR,
  card_funding                                 VARCHAR  -- unverified,
  card_last4                                   VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  description                                  VARCHAR  -- unverified,
  destination_id                               VARCHAR,
  dispute_id                                   VARCHAR  -- unverified,
  failure_code                                 VARCHAR,
  failure_message                              VARCHAR,
  invoice_id                                   VARCHAR  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  outcome_network_status                       VARCHAR  -- unverified,
  outcome_risk_level                           VARCHAR  -- unverified,
  outcome_risk_score                           BIGINT,
  outcome_rule_id                              VARCHAR,
  outcome_seller_message                       VARCHAR  -- unverified,
  outcome_type                                 VARCHAR,
  paid                                         BOOLEAN,
  payment_intent_id                            VARCHAR  -- unverified,
  payment_method_id                            VARCHAR  -- unverified,
  payment_method_type                          VARCHAR  -- unverified,
  receipt_email                                VARCHAR  -- unverified,
  refunded                                     BOOLEAN  -- unverified,
  statement_descriptor                         VARCHAR  -- unverified,
  status                                       VARCHAR,
  transfer_group                               VARCHAR  -- unverified,
  transfer_id                                  VARCHAR
);

-- Metadata key/value pairs set on charges. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE charges_metadata (
  charge_id                                    VARCHAR,
  "key"                                        VARCHAR,
  "value"                                      VARCHAR
);

-- Values customers entered into custom fields you configured on a Checkout session.
CREATE TABLE checkout_custom_fields (
  checkout_session_id                          VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified
);

-- Line items on a Checkout session.
CREATE TABLE checkout_line_items (
  id                                           VARCHAR  -- unverified,
  amount_total                                 BIGINT  -- unverified,
  checkout_session_id                          VARCHAR  -- unverified,
  price_id                                     VARCHAR  -- unverified,
  quantity                                     BIGINT  -- unverified
);

-- Stripe Checkout sessions, including abandoned ones. The table to use for hosted-checkout conversion analysis.
CREATE TABLE checkout_sessions (
  id                                           VARCHAR  -- unverified,
  amount_total                                 BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  mode                                         VARCHAR  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  payment_link_id                              VARCHAR  -- unverified,
  payment_status                               VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified,
  subscription_id                              VARCHAR  -- unverified
);

-- Connect platform view of activity_report_itemized, per connected account.
CREATE TABLE connected_account_activity_report_itemized (
  account                                      VARCHAR  -- unverified
);

-- Connect platform view of balance_transactions for connected accounts. Ledger-style record of every event that moves money into or out of your Stripe b
CREATE TABLE connected_account_balance_transactions (
  account                                      VARCHAR,
  amount                                       BIGINT,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  source_id                                    VARCHAR,
  "type"                                       VARCHAR,
  id                                           VARCHAR,
  automatic_transfer_id                        VARCHAR,
  available_on                                 TIMESTAMP  -- unverified,
  description                                  VARCHAR  -- unverified,
  exchange_rate                                DOUBLE  -- unverified,
  fee                                          BIGINT,
  net                                          BIGINT,
  reporting_category                           VARCHAR
);

-- Connect platform view of charges for connected accounts. One row per Charge object. Use for charge-level analysis such as card brand mix, decline reas
CREATE TABLE connected_account_charges (
  account                                      VARCHAR  -- unverified,
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_refunded                              BIGINT  -- unverified,
  application_fee_id                           VARCHAR  -- unverified,
  balance_transaction_id                       VARCHAR  -- unverified,
  captured_at                                  TIMESTAMP  -- unverified,
  card_address_zip_check                       VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_cvc_check                               VARCHAR,
  card_funding                                 VARCHAR  -- unverified,
  card_last4                                   VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  description                                  VARCHAR  -- unverified,
  destination_id                               VARCHAR,
  dispute_id                                   VARCHAR  -- unverified,
  failure_code                                 VARCHAR,
  failure_message                              VARCHAR,
  invoice_id                                   VARCHAR  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  outcome_network_status                       VARCHAR  -- unverified,
  outcome_risk_level                           VARCHAR  -- unverified,
  outcome_risk_score                           BIGINT,
  outcome_rule_id                              VARCHAR,
  outcome_seller_message                       VARCHAR  -- unverified,
  outcome_type                                 VARCHAR,
  paid                                         BOOLEAN,
  payment_intent_id                            VARCHAR  -- unverified,
  payment_method_id                            VARCHAR  -- unverified,
  payment_method_type                          VARCHAR  -- unverified,
  receipt_email                                VARCHAR  -- unverified,
  refunded                                     BOOLEAN  -- unverified,
  statement_descriptor                         VARCHAR  -- unverified,
  status                                       VARCHAR,
  transfer_group                               VARCHAR  -- unverified,
  transfer_id                                  VARCHAR
);

-- Connect platform view of issuing_authorizations for connected accounts. Authorization requests created whenever an issued card is used. Includes decli
CREATE TABLE connected_account_issuing_authorizations (
  account                                      VARCHAR  -- unverified,
  id                                           VARCHAR,
  amount                                       BIGINT,
  approved                                     BOOLEAN,
  card_id                                      VARCHAR,
  cardholder_id                                VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  currency                                     VARCHAR  -- unverified,
  merchant_category_code                       VARCHAR  -- unverified,
  merchant_country                             VARCHAR  -- unverified,
  merchant_name                                VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Connect platform view of itemized_fees, showing fees paid by each connected account.
CREATE TABLE connected_account_itemized_fees (
  account                                      VARCHAR,
  amount                                       DOUBLE,
  incurred_at                                  TIMESTAMP,
  activity_end_date                            TIMESTAMP,
  activity_start_date                          TIMESTAMP,
  balance_transaction_created                  TIMESTAMP,
  balance_transaction_description              VARCHAR,
  balance_transaction_id                       VARCHAR,
  currency                                     VARCHAR,
  incurred_by                                  VARCHAR,
  incurred_by_type                             VARCHAR,
  product_feature_description                  VARCHAR,
  tax                                          DOUBLE
);

-- Preview version of connected_account_itemized_fees.
CREATE TABLE connected_account_itemized_fees_beta (
  account                                      VARCHAR  -- unverified,
  activity_end_date                            TIMESTAMP,
  activity_start_date                          TIMESTAMP,
  amount                                       DOUBLE,
  balance_transaction_created                  TIMESTAMP,
  balance_transaction_description              VARCHAR,
  balance_transaction_id                       VARCHAR,
  currency                                     VARCHAR,
  incurred_at                                  TIMESTAMP,
  incurred_by                                  VARCHAR,
  incurred_by_type                             VARCHAR,
  product_feature_description                  VARCHAR,
  tax                                          DOUBLE
);

-- Connect platform view of payment_records for connected accounts.
CREATE TABLE connected_account_payment_records (
  account                                      VARCHAR  -- unverified,
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified
);

-- Metadata key/value pairs set on connected_account_payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE connected_account_payment_records_metadata (
  account                                      VARCHAR  -- unverified,
  connected_account_payment_record_id          VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Connect platform view of summarized_balance_transactions, per connected account.
CREATE TABLE connected_account_summarized_balance_transactions (
  account                                      VARCHAR  -- unverified
);

-- Connect platform view of connected accounts, including legal entity, onboarding requirements and terms-of-service acceptance.
CREATE TABLE connected_accounts (
  id                                           VARCHAR,
  business_name                                VARCHAR,
  country                                      VARCHAR,
  email                                        VARCHAR,
  future_requirements_currently_due            VARCHAR,
  future_requirements_eventually_due           VARCHAR  -- unverified,
  future_requirements_past_due                 VARCHAR  -- unverified,
  future_requirements_pending_verification     VARCHAR  -- unverified,
  legal_entity_address_city                    VARCHAR,
  legal_entity_address_line1                   VARCHAR,
  legal_entity_address_postal_code             VARCHAR,
  legal_entity_address_state                   VARCHAR,
  legal_entity_dob_day                         BIGINT,
  legal_entity_dob_month                       BIGINT,
  legal_entity_dob_year                        BIGINT,
  legal_entity_first_name                      VARCHAR,
  legal_entity_last_name                       VARCHAR,
  legal_entity_personal_id_number_provided     BOOLEAN,
  legal_entity_ssn_last_4_provided             BOOLEAN,
  legal_entity_type                            VARCHAR,
  legal_entity_verification_document_id        VARCHAR,
  payouts_enabled                              BOOLEAN,
  requirements_currently_due                   VARCHAR,
  requirements_eventually_due                  VARCHAR  -- unverified,
  requirements_past_due                        VARCHAR  -- unverified,
  requirements_pending_verification            VARCHAR  -- unverified,
  tos_acceptance_date                          TIMESTAMP,
  tos_acceptance_ip                            VARCHAR
);

-- Discount definitions that can be applied to customers, subscriptions or invoices.
CREATE TABLE coupons (
  id                                           VARCHAR,
  amount_off                                   BIGINT,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  duration                                     VARCHAR  -- unverified,
  duration_in_months                           BIGINT  -- unverified,
  max_redemptions                              BIGINT  -- unverified,
  name                                         VARCHAR  -- unverified,
  percent_off                                  DOUBLE,
  times_redeemed                               BIGINT  -- unverified,
  valid                                        BOOLEAN
);

-- Per-currency overrides for multi-currency coupons.
CREATE TABLE coupons_currency_options (
  amount_off                                   BIGINT  -- unverified,
  coupon_id                                    VARCHAR  -- unverified,
  currency                                     VARCHAR  -- unverified
);

-- Metadata key/value pairs set on coupons. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE coupons_metadata (
  coupon_id                                    VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Discount amounts applied at the credit note level.
CREATE TABLE credit_note_discount_amounts (
  amount                                       BIGINT  -- unverified,
  credit_note_id                               VARCHAR  -- unverified,
  discount_id                                  VARCHAR  -- unverified
);

-- Discount amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_discount_amounts (
  amount                                       BIGINT  -- unverified,
  credit_note_line_item_id                     VARCHAR  -- unverified
);

-- Tax amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_tax_amounts (
  amount                                       BIGINT  -- unverified,
  credit_note_line_item_id                     VARCHAR  -- unverified,
  tax_rate_id                                  VARCHAR  -- unverified
);

-- Line items on a credit note.
CREATE TABLE credit_note_line_items (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  credit_note_id                               VARCHAR  -- unverified,
  invoice_line_item_id                         VARCHAR  -- unverified
);

-- Tax amounts applied at the credit note level.
CREATE TABLE credit_note_tax_amounts (
  amount                                       BIGINT  -- unverified,
  credit_note_id                               VARCHAR  -- unverified,
  tax_rate_id                                  VARCHAR  -- unverified
);

-- Post-issuance adjustments to invoices — the correct way to represent refunds and write-offs against a finalized invoice.
CREATE TABLE credit_notes (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  reason                                       VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on credit_notes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE credit_notes_metadata (
  credit_note_id                               VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Stripe crypto onramp sessions where users bought crypto with fiat.
CREATE TABLE crypto_onramp_sessions (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Changes to a customer's account credit balance.
CREATE TABLE customer_balance_transactions (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on customer_balance_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customer_balance_transactions_metadata (
  customer_balance_transaction_id              VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Changes to a customer's cash balance held at Stripe, used for bank-transfer funding.
CREATE TABLE customer_cash_balance_transactions (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  net_amount                                   BIGINT  -- unverified
);

-- Tax identifiers stored against a customer.
CREATE TABLE customer_tax_ids (
  id                                           VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- One row per Customer object.
CREATE TABLE customers (
  id                                           VARCHAR,
  address_city                                 VARCHAR  -- unverified,
  address_country                              VARCHAR  -- unverified,
  address_postal_code                          VARCHAR  -- unverified,
  balance                                      BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  default_source_id                            VARCHAR  -- unverified,
  delinquent                                   BOOLEAN  -- unverified,
  description                                  VARCHAR  -- unverified,
  email                                        VARCHAR,
  is_deleted                                   BOOLEAN  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  name                                         VARCHAR  -- unverified
);

-- Metadata key/value pairs set on customers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customers_metadata (
  customer_id                                  VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Applications of a coupon or promotion code to a customer, subscription or invoice.
CREATE TABLE discounts (
  id                                           VARCHAR,
  coupon_id                                    VARCHAR,
  customer_id                                  VARCHAR  -- unverified,
  "end"                                        TIMESTAMP  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  promotion_code_id                            VARCHAR  -- unverified,
  "start"                                      TIMESTAMP  -- unverified,
  subscription_id                              VARCHAR  -- unverified
);

-- One row per Dispute (chargeback), including any evidence you submitted.
CREATE TABLE disputes (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR  -- unverified,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR  -- unverified,
  evidence_due_by                              TIMESTAMP  -- unverified,
  is_charge_refundable                         BOOLEAN  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  reason                                       VARCHAR,
  status                                       VARCHAR
);

-- Eligibility of each dispute for enhanced evidence programs such as Visa Compelling Evidence 3.0.
CREATE TABLE disputes_enhanced_eligibility (
  dispute_id                                   VARCHAR  -- unverified
);

-- Metadata key/value pairs set on disputes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE disputes_metadata (
  dispute_id                                   VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Fraud reports issued by the card network before a formal dispute is filed. Leading indicator for card brand monitoring programs such as Visa VAMP.
CREATE TABLE early_fraud_warnings (
  id                                           VARCHAR  -- unverified,
  actionable                                   BOOLEAN  -- unverified,
  charge_id                                    VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  fraud_type                                   VARCHAR  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified
);

-- Daily currency conversion rates expressed relative to USD. Needed to sum multi-currency amounts into one reporting currency.
CREATE TABLE exchange_rates_from_usd (
  buy_currency_exchange_rates                  VARCHAR,
  "date"                                       DATE
);

-- financing_balances: no column detail published; see sigma_schema.json

-- Stripe Capital financing offers extended to you or your connected accounts.
CREATE TABLE financing_offers (
  id                                           VARCHAR  -- unverified,
  account_id                                   VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Repayments and drawdowns against Stripe Capital financing.
CREATE TABLE financing_transactions (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Interchange-plus fee breakdown, splitting each fee into interchange, scheme and Stripe components.
CREATE TABLE icplus_fees (
  balance_transaction_created_at               TIMESTAMP,
  balance_transaction_id                       VARCHAR,
  billing_amount                               BIGINT,
  billing_currency                             VARCHAR,
  charge_id                                    VARCHAR
);

-- Custom key/value fields rendered on an invoice.
CREATE TABLE invoice_custom_fields (
  invoice_id                                   VARCHAR  -- unverified,
  name                                         VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Customer tax identifiers captured on an invoice.
CREATE TABLE invoice_customer_tax_ids (
  invoice_id                                   VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- One-off charges or credits queued onto a customer's next invoice.
CREATE TABLE invoice_items (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  description                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  proration                                    BOOLEAN  -- unverified,
  subscription_id                              VARCHAR  -- unverified
);

-- Metadata key/value pairs set on invoice_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoice_items_metadata (
  invoice_item_id                              VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Discount amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_discount_amounts (
  amount                                       BIGINT,
  discount_id                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR,
  invoice_line_item_id                         VARCHAR  -- unverified
);

-- Tax amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_tax_amounts (
  amount                                       BIGINT  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  invoice_line_item_id                         VARCHAR  -- unverified,
  tax_rate_id                                  VARCHAR  -- unverified
);

-- Individual line items on an invoice.
CREATE TABLE invoice_line_items (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  currency                                     VARCHAR  -- unverified,
  description                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  period_end                                   TIMESTAMP  -- unverified,
  period_start                                 TIMESTAMP  -- unverified,
  price_id                                     VARCHAR  -- unverified,
  proration                                    BOOLEAN  -- unverified,
  quantity                                     BIGINT  -- unverified,
  source_id                                    VARCHAR,
  source_type                                  VARCHAR,
  subscription_id                              VARCHAR  -- unverified
);

-- Payment attempts against an invoice, linking invoices to the charges or payment intents that settled them.
CREATE TABLE invoice_payments (
  amount_paid                                  BIGINT  -- unverified,
  charge_id                                    VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Tax applied to shipping costs on an invoice.
CREATE TABLE invoice_shipping_cost_taxes (
  amount                                       BIGINT  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  tax_rate_id                                  VARCHAR  -- unverified
);

-- One row per Invoice object. Each subscription generates invoices on a recurring basis covering the subscription amount plus any invoice items.
CREATE TABLE invoices (
  id                                           VARCHAR,
  amount_due                                   BIGINT,
  amount_paid                                  BIGINT  -- unverified,
  amount_remaining                             BIGINT  -- unverified,
  attempt_count                                BIGINT  -- unverified,
  billing_reason                               VARCHAR  -- unverified,
  charge_id                                    VARCHAR,
  collection_method                            VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR  -- unverified,
  due_date                                     TIMESTAMP  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  number                                       VARCHAR  -- unverified,
  paid                                         BOOLEAN  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  period_end                                   TIMESTAMP,
  period_start                                 TIMESTAMP,
  status                                       VARCHAR  -- unverified,
  subscription_id                              VARCHAR,
  subtotal                                     BIGINT  -- unverified,
  tax                                          BIGINT  -- unverified,
  total                                        BIGINT
);

-- Metadata key/value pairs set on invoices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoices_metadata (
  invoice_id                                   VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Authorization requests created whenever an issued card is used. Includes declined attempts.
CREATE TABLE issuing_authorizations (
  id                                           VARCHAR,
  amount                                       BIGINT,
  approved                                     BOOLEAN,
  card_id                                      VARCHAR,
  cardholder_id                                VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  currency                                     VARCHAR  -- unverified,
  merchant_category_code                       VARCHAR  -- unverified,
  merchant_country                             VARCHAR  -- unverified,
  merchant_name                                VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on issuing_authorizations. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_authorizations_metadata (
  issuing_authorization_id                     VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- People or businesses that hold cards you have issued.
CREATE TABLE issuing_cardholders (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  email                                        VARCHAR,
  name                                         VARCHAR  -- unverified,
  phone_number                                 VARCHAR  -- unverified,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on issuing_cardholders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cardholders_metadata (
  issuing_cardholder_id                        VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Cards you have issued.
CREATE TABLE issuing_cards (
  id                                           VARCHAR  -- unverified,
  brand                                        VARCHAR  -- unverified,
  cardholder_id                                VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  exp_month                                    BIGINT  -- unverified,
  exp_year                                     BIGINT  -- unverified,
  last4                                        VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on issuing_cards. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cards_metadata (
  issuing_card_id                              VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Disputes you filed on behalf of cardholders against merchants.
CREATE TABLE issuing_disputes (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  reason                                       VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified,
  transaction_id                               VARCHAR  -- unverified
);

-- Network tokens provisioned for issued cards, such as those created when a card is added to a mobile wallet.
CREATE TABLE issuing_network_tokens (
  id                                           VARCHAR  -- unverified,
  card_id                                      VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Uses of an issued card that actually moved funds, such as completed purchases and refunds.
CREATE TABLE issuing_transactions (
  id                                           VARCHAR,
  amount                                       BIGINT,
  authorization_id                             VARCHAR,
  balance_transaction_id                       VARCHAR,
  card_id                                      VARCHAR  -- unverified,
  cardholder_id                                VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  currency                                     VARCHAR  -- unverified,
  merchant_name                                VARCHAR  -- unverified,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on issuing_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_transactions_metadata (
  issuing_transaction_id                       VARCHAR  -- unverified,
  "key"                                        VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Granular breakdown of every fee charged or deducted from your Stripe balance, one row per fee component.
CREATE TABLE itemized_fees (
  activity_end_date                            TIMESTAMP,
  activity_start_date                          TIMESTAMP,
  amount                                       DOUBLE,
  balance_transaction_created                  TIMESTAMP,
  balance_transaction_description              VARCHAR,
  balance_transaction_id                       VARCHAR,
  currency                                     VARCHAR,
  incurred_at                                  TIMESTAMP,
  incurred_by                                  VARCHAR,
  incurred_by_type                             VARCHAR,
  product_feature_description                  VARCHAR,
  tax                                          DOUBLE
);

-- Preview version of itemized_fees.
CREATE TABLE itemized_fees_beta (
  activity_end_date                            TIMESTAMP,
  activity_start_date                          TIMESTAMP,
  amount                                       DOUBLE,
  balance_transaction_created                  TIMESTAMP,
  balance_transaction_description              VARCHAR,
  balance_transaction_id                       VARCHAR,
  currency                                     VARCHAR,
  incurred_at                                  TIMESTAMP,
  incurred_by                                  VARCHAR,
  incurred_by_type                             VARCHAR,
  product_feature_description                  VARCHAR,
  tax                                          DOUBLE
);

-- network_cost_insights_report: no column detail published; see sigma_schema.json

-- One row per PaymentIntent. Represents the full lifecycle of collecting a payment, including attempts that never produced a charge.
CREATE TABLE payment_intents (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  amount_received                              BIGINT  -- unverified,
  cancellation_reason                          VARCHAR  -- unverified,
  capture_method                               VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  description                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  payment_method_id                            VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on payment_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_intents_metadata (
  "key"                                        VARCHAR  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Reusable shareable links that open a Checkout session.
CREATE TABLE payment_links (
  id                                           VARCHAR  -- unverified,
  active                                       BOOLEAN  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  url                                          VARCHAR  -- unverified
);

-- Per-charge payment method detail that does not fit in the flattened card_* columns on charges, including 3D Secure results and wallet information.
CREATE TABLE payment_method_details (
  card_3ds_authenticated                       BOOLEAN  -- unverified,
  card_3ds_succeeded                           BOOLEAN,
  card_network                                 VARCHAR  -- unverified,
  card_wallet_type                             VARCHAR  -- unverified,
  charge_id                                    VARCHAR,
  "type"                                       VARCHAR  -- unverified
);

-- Saved payment instruments attached to customers.
CREATE TABLE payment_methods (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on payment_methods. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_methods_metadata (
  "key"                                        VARCHAR  -- unverified,
  payment_method_id                            VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Unified payment records spanning Stripe and externally processed payments.
CREATE TABLE payment_records (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified
);

-- Metadata key/value pairs set on payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_records_metadata (
  "key"                                        VARCHAR  -- unverified,
  payment_record_id                            VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Payments flagged by Radar for manual review, and how they were resolved.
CREATE TABLE payment_reviews (
  id                                           VARCHAR  -- unverified,
  charge_id                                    VARCHAR  -- unverified,
  closed_reason                                VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  reason                                       VARCHAR  -- unverified
);

-- Legacy recurring pricing objects, superseded by prices. Retained for older integrations.
CREATE TABLE plans (
  id                                           VARCHAR  -- unverified,
  active                                       BOOLEAN  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  "interval"                                   VARCHAR  -- unverified,
  product_id                                   VARCHAR  -- unverified
);

-- Metadata key/value pairs set on plans. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE plans_metadata (
  "key"                                        VARCHAR  -- unverified,
  plan_id                                      VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Tier definitions for prices using tiered billing.
CREATE TABLE price_tiers (
  amount                                       BIGINT,
  flat_amount                                  BIGINT  -- unverified,
  price_id                                     VARCHAR,
  upto                                         BIGINT
);

-- How much and how often to charge for a product.
CREATE TABLE prices (
  id                                           VARCHAR,
  active                                       BOOLEAN  -- unverified,
  billing_scheme                               VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR,
  livemode                                     BOOLEAN  -- unverified,
  nickname                                     VARCHAR  -- unverified,
  product_id                                   VARCHAR  -- unverified,
  recurring_interval                           VARCHAR  -- unverified,
  recurring_interval_count                     BIGINT  -- unverified,
  recurring_usage_type                         VARCHAR  -- unverified,
  tiers_mode                                   VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified,
  unit_amount                                  BIGINT  -- unverified
);

-- Per-currency overrides for multi-currency prices.
CREATE TABLE prices_currency_options (
  currency                                     VARCHAR  -- unverified,
  price_id                                     VARCHAR  -- unverified,
  unit_amount                                  BIGINT  -- unverified
);

-- Metadata key/value pairs set on prices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE prices_metadata (
  "key"                                        VARCHAR  -- unverified,
  price_id                                     VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Goods or services you sell.
CREATE TABLE products (
  id                                           VARCHAR,
  active                                       BOOLEAN  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  description                                  VARCHAR  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  name                                         VARCHAR,
  statement_descriptor                         VARCHAR,
  unit_label                                   VARCHAR  -- unverified
);

-- Metadata key/value pairs set on products. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE products_metadata (
  "key"                                        VARCHAR  -- unverified,
  product_id                                   VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Customer-facing codes that map to a coupon.
CREATE TABLE promotion_codes (
  id                                           VARCHAR,
  active                                       BOOLEAN  -- unverified,
  code                                         VARCHAR,
  coupon_id                                    VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  expires_at                                   TIMESTAMP  -- unverified,
  max_redemptions                              BIGINT  -- unverified,
  times_redeemed                               BIGINT
);

-- Sales quotes that can be accepted to create an invoice or subscription.
CREATE TABLE quotes (
  id                                           VARCHAR  -- unverified,
  amount_total                                 BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified,
  subscription_id                              VARCHAR  -- unverified
);

-- radar_data_integration: no column detail published; see sigma_schema.json

-- Snapshot of most Radar rule attribute values as evaluated for a single charge. Useful for backtesting rules against known outcomes.
CREATE TABLE radar_rule_attributes (
  card_3d_secure_support                       VARCHAR,
  cvc_check                                    VARCHAR,
  is_3d_secure_authenticated                   BOOLEAN,
  risk_score                                   BIGINT,
  total_charges_per_card_number_all_time       BIGINT,
  transaction_id                               VARCHAR
);

-- Radar for Fraud Teams custom rules, with their action and predicate. Built-in Stripe rules have fixed ids.
CREATE TABLE radar_rules (
  id                                           VARCHAR  -- unverified,
  action                                       VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  predicate                                    VARCHAR  -- unverified
);

-- Smart Retries and dunning outcomes — revenue recovered after a failed subscription payment.
CREATE TABLE recoveries (
  customer_id                                  VARCHAR  -- unverified,
  invoice_id                                   VARCHAR  -- unverified
);

-- One row per Refund object. Refunds are separate objects from charges; refunding a charge creates a row here and a matching balance transaction.
CREATE TABLE refunds (
  id                                           VARCHAR,
  amount                                       BIGINT  -- unverified,
  balance_transaction_id                       VARCHAR,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  description                                  VARCHAR  -- unverified,
  payment_intent_id                            VARCHAR  -- unverified,
  reason                                       VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE refunds_metadata (
  "key"                                        VARCHAR  -- unverified,
  refund_id                                    VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- revenue_recognition_debits_and_credits: no column detail published; see sigma_schema.json

-- Every Radar rule evaluation, including 3DS rules triggered on PaymentIntents and SetupIntents.
CREATE TABLE rule_decisions (
  id                                           VARCHAR,
  action                                       VARCHAR,
  charge_id                                    VARCHAR  -- unverified,
  created                                      TIMESTAMP,
  payment_intent_id                            VARCHAR,
  rule_id                                      VARCHAR,
  setup_intent_id                              VARCHAR  -- unverified
);

-- Individual attempts to confirm a SetupIntent, including failures.
CREATE TABLE setup_attempts (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  setup_intent_id                              VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Attempts to save a payment method for future use without charging it immediately.
CREATE TABLE setup_intents (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  payment_method_id                            VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on setup_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE setup_intents_metadata (
  "key"                                        VARCHAR  -- unverified,
  setup_intent_id                              VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Legacy payment sources, superseded by payment_methods. Present for older integrations.
CREATE TABLE sources (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on sources. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE sources_metadata (
  "key"                                        VARCHAR  -- unverified,
  source_id                                    VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Pre-computed MRR movement events. Stripe's recommended basis for MRR, churn and expansion reporting — far more reliable than deriving movements from s
CREATE TABLE subscription_item_change_events (
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  event_type                                   VARCHAR,
  local_event_timestamp                        TIMESTAMP,
  mrr_change                                   BIGINT,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  quantity_change                              BIGINT,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR
);

-- Sandbox/test-mode equivalent of subscription_item_change_events.
CREATE TABLE subscription_item_change_events_testmode (
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  event_type                                   VARCHAR,
  local_event_timestamp                        TIMESTAMP,
  mrr_change                                   BIGINT,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  quantity_change                              BIGINT,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR
);

-- Public preview rebuild of subscription_item_change_events with 3-hour freshness instead of 24-hour. Same columns.
CREATE TABLE subscription_item_change_events_v2_beta (
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  event_type                                   VARCHAR,
  local_event_timestamp                        TIMESTAMP,
  mrr_change                                   BIGINT,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  quantity_change                              BIGINT,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR
);

-- Individual priced items on a subscription. A subscription with multiple products has one row per product here.
CREATE TABLE subscription_items (
  id                                           VARCHAR,
  created                                      TIMESTAMP  -- unverified,
  price_id                                     VARCHAR,
  price_product_id                             VARCHAR,
  quantity                                     BIGINT  -- unverified,
  subscription_id                              VARCHAR
);

-- Metadata key/value pairs set on subscription_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_items_metadata (
  "key"                                        VARCHAR  -- unverified,
  subscription_item_id                         VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- One-off invoice items attached to a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_add_invoice_items (
  price_id                                     VARCHAR  -- unverified,
  subscription_schedule_id                     VARCHAR  -- unverified
);

-- Priced items configured within a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_configuration_items (
  price_id                                     VARCHAR  -- unverified,
  quantity                                     BIGINT  -- unverified,
  subscription_schedule_id                     VARCHAR  -- unverified
);

-- Individual phases of a subscription schedule.
CREATE TABLE subscription_schedule_phases (
  id                                           VARCHAR  -- unverified,
  end_date                                     TIMESTAMP  -- unverified,
  start_date                                   TIMESTAMP  -- unverified,
  subscription_schedule_id                     VARCHAR  -- unverified
);

-- Metadata key/value pairs set on subscription_schedule_phases. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedule_phases_metadata (
  "key"                                        VARCHAR  -- unverified,
  subscription_schedule_phas_id                VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Planned sequences of subscription phases, used for scheduled price or term changes.
CREATE TABLE subscription_schedules (
  id                                           VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified,
  subscription_id                              VARCHAR  -- unverified
);

-- Metadata key/value pairs set on subscription_schedules. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedules_metadata (
  "key"                                        VARCHAR  -- unverified,
  subscription_schedule_id                     VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- One row per Subscription object. The primary Billing table alongside invoices.
CREATE TABLE subscriptions (
  id                                           VARCHAR,
  billing_cycle_anchor                         TIMESTAMP  -- unverified,
  cancel_at_period_end                         BOOLEAN  -- unverified,
  canceled_at                                  TIMESTAMP  -- unverified,
  collection_method                            VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  current_period_end                           TIMESTAMP  -- unverified,
  current_period_start                         TIMESTAMP  -- unverified,
  customer_id                                  VARCHAR,
  default_payment_method_id                    VARCHAR  -- unverified,
  discounts                                    VARCHAR  -- unverified,
  ended_at                                     TIMESTAMP  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  plan_id                                      VARCHAR  -- unverified,
  price_id                                     VARCHAR,
  quantity                                     BIGINT  -- unverified,
  start_date                                   TIMESTAMP  -- unverified,
  status                                       VARCHAR,
  trial_end                                    TIMESTAMP  -- unverified,
  trial_start                                  TIMESTAMP  -- unverified
);

-- Metadata key/value pairs set on subscriptions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscriptions_metadata (
  "key"                                        VARCHAR  -- unverified,
  subscription_id                              VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- summarized_balance_transactions: no column detail published; see sigma_schema.json

-- Product categories Stripe Tax uses to determine tax treatment. Contains all generally available tax codes, not just ones you use.
CREATE TABLE tax_codes (
  id                                           VARCHAR,
  description                                  VARCHAR  -- unverified,
  name                                         VARCHAR
);

-- Tax forms (such as 1099s) generated for your connected accounts.
CREATE TABLE tax_forms (
  id                                           VARCHAR  -- unverified,
  account_id                                   VARCHAR  -- unverified,
  "type"                                       VARCHAR  -- unverified
);

-- Manually defined tax rates used on invoices and subscriptions. Distinct from Stripe Tax's automatic calculations.
CREATE TABLE tax_rates (
  id                                           VARCHAR  -- unverified,
  active                                       BOOLEAN  -- unverified,
  country                                      VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  display_name                                 VARCHAR  -- unverified,
  inclusive                                    BOOLEAN  -- unverified,
  jurisdiction                                 VARCHAR  -- unverified,
  percentage                                   DOUBLE  -- unverified
);

-- Metadata key/value pairs set on tax_rates. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_rates_metadata (
  "key"                                        VARCHAR  -- unverified,
  tax_rate_id                                  VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Per-jurisdiction breakdown of the tax liability for a tax transaction item.
CREATE TABLE tax_transaction_jurisdiction_details (
  id                                           VARCHAR,
  amount_non_taxable                           BIGINT,
  amount_tax                                   BIGINT,
  amount_taxable                               BIGINT,
  currency                                     VARCHAR,
  filing_amount_non_taxable                    BIGINT,
  filing_amount_tax                            BIGINT,
  filing_amount_taxable                        BIGINT,
  filing_currency                              VARCHAR,
  jurisdiction_country                         VARCHAR,
  jurisdiction_level                           VARCHAR,
  jurisdiction_name                            VARCHAR,
  jurisdiction_state                           VARCHAR,
  tax_rate_percentage                          DOUBLE,
  tax_transaction_id                           VARCHAR,
  tax_transaction_item_id                      VARCHAR,
  tax_transaction_item_type                    VARCHAR,
  tax_type                                     VARCHAR,
  taxability                                   VARCHAR,
  taxability_reason                            VARCHAR
);

-- Line items contributing to the sale of goods for a tax transaction.
CREATE TABLE tax_transaction_line_items (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_tax                                   BIGINT,
  currency                                     VARCHAR,
  quantity_decimal                             VARCHAR,
  source_line_item_id                          VARCHAR,
  tax_behavior                                 VARCHAR,
  tax_code                                     VARCHAR,
  tax_transaction_id                           VARCHAR
);

-- Metadata key/value pairs set on tax_transaction_line_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transaction_line_items_metadata (
  "key"                                        VARCHAR  -- unverified,
  tax_transaction_line_item_id                 VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Shipping costs contributing to a tax transaction. Structurally parallel to tax_transaction_line_items.
CREATE TABLE tax_transaction_shipping_costs (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_tax                                   BIGINT,
  currency                                     VARCHAR,
  tax_behavior                                 VARCHAR,
  tax_code                                     VARCHAR,
  tax_transaction_id                           VARCHAR
);

-- Records of assumed or reduced tax liability. The recommended starting point for tax reporting, and the bridge between tax tables and invoices or check
CREATE TABLE tax_transactions (
  id                                           VARCHAR,
  currency                                     VARCHAR  -- unverified,
  customer_id                                  VARCHAR  -- unverified,
  livemode                                     BOOLEAN  -- unverified,
  posted_at                                    TIMESTAMP,
  source_id                                    VARCHAR,
  source_type                                  VARCHAR,
  tax_date                                     TIMESTAMP,
  "type"                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on tax_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transactions_metadata (
  "key"                                        VARCHAR  -- unverified,
  tax_transaction_id                           VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Line items on a Terminal hardware order.
CREATE TABLE terminal_hardware_order_items (
  amount                                       BIGINT  -- unverified,
  quantity                                     BIGINT  -- unverified,
  terminal_hardware_order_id                   VARCHAR  -- unverified
);

-- Metadata key/value pairs set on terminal_hardware_orders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE terminal_hardware_order_metadata (
  "key"                                        VARCHAR  -- unverified,
  terminal_hardware_order_id                   VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Shipment tracking information for Terminal hardware orders.
CREATE TABLE terminal_hardware_order_shipment_tracking (
  carrier                                      VARCHAR  -- unverified,
  terminal_hardware_order_id                   VARCHAR  -- unverified,
  tracking_number                              VARCHAR  -- unverified
);

-- Tax applied to a Terminal hardware order.
CREATE TABLE terminal_hardware_order_tax_amounts (
  amount                                       BIGINT  -- unverified,
  terminal_hardware_order_id                   VARCHAR  -- unverified
);

-- Orders you placed for Terminal reader hardware.
CREATE TABLE terminal_hardware_orders (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Physical locations where you operate Terminal card readers.
CREATE TABLE terminal_locations (
  id                                           VARCHAR  -- unverified,
  address_city                                 VARCHAR  -- unverified,
  address_country                              VARCHAR  -- unverified,
  display_name                                 VARCHAR  -- unverified
);

-- Terminal card reader devices registered to your account.
CREATE TABLE terminal_readers (
  id                                           VARCHAR  -- unverified,
  device_type                                  VARCHAR  -- unverified,
  label                                        VARCHAR  -- unverified,
  location_id                                  VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Reversals of manually created transfers or payouts. Automatic payouts cannot be reversed.
CREATE TABLE transfer_reversals (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  balance_transaction_id                       VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  transfer_id                                  VARCHAR  -- unverified
);

-- Metadata key/value pairs set on transfer_reversals. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfer_reversals_metadata (
  "key"                                        VARCHAR  -- unverified,
  transfer_reversal_id                         VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Payouts from your Stripe balance to your bank account, and — for Connect platforms — transfers of funds to connected accounts.
CREATE TABLE transfers (
  id                                           VARCHAR,
  amount                                       BIGINT,
  automatic                                    BOOLEAN  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  "date"                                       TIMESTAMP,
  description                                  VARCHAR  -- unverified,
  destination_id                               VARCHAR,
  failure_code                                 VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified,
  transfer_group                               VARCHAR  -- unverified
);

-- Metadata key/value pairs set on transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfers_metadata (
  "key"                                        VARCHAR  -- unverified,
  transfer_id                                  VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Treasury financial accounts that store funds for your platform's users.
CREATE TABLE treasury_financial_accounts (
  id                                           VARCHAR  -- unverified,
  country                                      VARCHAR  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on treasury_financial_accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_financial_accounts_metadata (
  "key"                                        VARCHAR  -- unverified,
  treasury_financial_account_id                VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Money pulled into a Treasury financial account from an external bank account.
CREATE TABLE treasury_inbound_transfers (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  financial_account_id                         VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on treasury_inbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_inbound_transfers_metadata (
  "key"                                        VARCHAR  -- unverified,
  treasury_inbound_transfer_id                 VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Money sent from a Treasury financial account to a third party.
CREATE TABLE treasury_outbound_payments (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  financial_account_id                         VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on treasury_outbound_payments. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_payments_metadata (
  "key"                                        VARCHAR  -- unverified,
  treasury_outbound_payment_id                 VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Money sent from a Treasury financial account to an external bank account you own.
CREATE TABLE treasury_outbound_transfers (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  financial_account_id                         VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Metadata key/value pairs set on treasury_outbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_transfers_metadata (
  "key"                                        VARCHAR  -- unverified,
  treasury_outbound_transfer_id                VARCHAR  -- unverified,
  "value"                                      VARCHAR  -- unverified
);

-- Individual ledger entries making up a Treasury transaction.
CREATE TABLE treasury_transaction_entries (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  transaction_id                               VARCHAR  -- unverified
);

-- Ledger of all money movement on Treasury financial accounts.
CREATE TABLE treasury_transactions (
  id                                           VARCHAR  -- unverified,
  amount                                       BIGINT  -- unverified,
  created                                      TIMESTAMP  -- unverified,
  currency                                     VARCHAR  -- unverified,
  financial_account_id                         VARCHAR  -- unverified,
  status                                       VARCHAR  -- unverified
);

-- Reported usage quantities for metered subscription items. Legacy path; newer integrations use billing meters.
CREATE TABLE usage_records (
  quantity                                     BIGINT  -- unverified,
  subscription_item_id                         VARCHAR  -- unverified,
  timestamp                                    TIMESTAMP  -- unverified
);

