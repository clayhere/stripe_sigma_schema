-- Stripe Sigma schema as SQLite DDL
-- Generated from sigma_schema.json v1.0.0 by tools/emit_artifacts.py
-- Sigma itself is read-only; this DDL exists for tooling, docs and local sandboxes.
-- Columns marked (?) are unverified - see the confidence field in sigma_schema.json.


CREATE TABLE acceptance_reporting_preaggregated_deduplicated_v2 (
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  attributable_optimization                    TEXT,
  blocked_by_default_high_risk_rule_count      INTEGER,
  blocked_by_radar_rule_count                  INTEGER,
  blocked_by_stripe_count                      INTEGER,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  created_day                                  TEXT,
  currency                                     TEXT,
  is_connected_account                         INTEGER,
  outcome_reason                               TEXT,
  outcome_rule_id                              TEXT,
  outcome_type                                 TEXT,
  transaction_amount                           INTEGER,
  transaction_amount_in_usd                    INTEGER,
  transaction_count                            INTEGER
);


CREATE TABLE acceptance_reporting_preaggregated_deduplicated_v3 (
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  attributable_optimization                    TEXT,
  blocked_by_default_high_risk_rule_count      INTEGER,
  blocked_by_radar_rule_count                  INTEGER,
  blocked_by_stripe_count                      INTEGER,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  cof                                          INTEGER,
  created_day                                  TEXT,
  currency                                     TEXT,
  is_connected_account                         INTEGER,
  nsf_count                                    INTEGER,
  outcome_reason                               TEXT,
  outcome_rule_id                              TEXT,
  outcome_type                                 TEXT,
  transaction_amount                           INTEGER,
  transaction_amount_in_usd                    INTEGER,
  transaction_count                            INTEGER,
  used_network_tokens                          INTEGER
);


CREATE TABLE acceptance_reporting_preaggregated_v2 (
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  attributable_optimization                    TEXT,
  blocked_by_default_high_risk_rule_count      INTEGER,
  blocked_by_radar_rule_count                  INTEGER,
  blocked_by_stripe_count                      INTEGER,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  created_day                                  TEXT,
  currency                                     TEXT,
  is_connected_account                         INTEGER,
  outcome_reason                               TEXT,
  outcome_rule_id                              TEXT,
  outcome_type                                 TEXT,
  transaction_amount                           INTEGER,
  transaction_amount_in_usd                    INTEGER,
  transaction_count                            INTEGER
);


CREATE TABLE acceptance_reporting_preaggregated_v3 (
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  attributable_optimization                    TEXT,
  blocked_by_default_high_risk_rule_count      INTEGER,
  blocked_by_radar_rule_count                  INTEGER,
  blocked_by_stripe_count                      INTEGER,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  cof                                          INTEGER,
  created_day                                  TEXT,
  currency                                     TEXT,
  is_connected_account                         INTEGER,
  nsf_count                                    INTEGER,
  outcome_reason                               TEXT,
  outcome_rule_id                              TEXT,
  outcome_type                                 TEXT,
  transaction_amount                           INTEGER,
  transaction_amount_in_usd                    INTEGER,
  transaction_count                            INTEGER,
  used_network_tokens                          INTEGER
);

-- Itemized payment acceptance reporting: authorization attempts with decline and retry classification.
CREATE TABLE acceptance_reporting_v3_itemized (
  amount                                       INTEGER,
  amount_in_usd                                INTEGER,
  attributable_optimization                    TEXT,
  blocked_reason                               TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  charge_id                                    TEXT,
  cof                                          INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  decline_reason                               TEXT,
  final_charge_id                              TEXT,
  gateway_conversation_avs_outcome             TEXT,
  gateway_conversation_cvc_outcome             TEXT,
  id                                           TEXT,
  invoice_id                                   TEXT,
  is_connected_account                         INTEGER,
  is_final_attempt                             INTEGER,
  outcome_type                                 TEXT,
  payment_intent_id                            TEXT,
  tds_flow_type                                TEXT,
  tds_is_in_sca_scope                          INTEGER,
  tds_outcome                                  TEXT,
  tds_outcome_type                             TEXT,
  tds_reason                                   TEXT,
  tds_sca_exemption_type                       TEXT,
  tds_triggered                                INTEGER,
  transaction_initiator                        TEXT,
  used_network_tokens                          INTEGER
);


CREATE TABLE account_capabilities_v2 (
  account_id                                   TEXT,
  acss_debit_payments                          TEXT,
  affirm_payments                              TEXT,
  afterpay_clearpay_payments                   TEXT,
  amazon_pay_payments                          TEXT,
  au_becs_debit_payments                       TEXT,
  bacs_debit_payments                          TEXT,
  bancontact_payments                          TEXT,
  bank_transfer_payments                       TEXT,
  batch_timestamp                              TEXT,
  blik_payments                                TEXT,
  boleto_payments                              TEXT,
  card_issuing                                 TEXT,
  card_payments                                TEXT,
  cartes_bancaires_payments                    TEXT,
  cashapp_payments                             TEXT,
  eps_payments                                 TEXT,
  fpx_payments                                 TEXT,
  giropay_payments                             TEXT,
  grabpay_payments                             TEXT,
  ideal_payments                               TEXT,
  india_international_payments                 TEXT,
  jcb_payments                                 TEXT,
  klarna_payments                              TEXT,
  konbini_payments                             TEXT,
  legacy_payments                              TEXT,
  link_payments                                TEXT,
  mobilepay_payments                           TEXT,
  multibanco_payments                          TEXT,
  oxxo_payments                                TEXT,
  p24_payments                                 TEXT,
  paynow_payments                              TEXT,
  promptpay_payments                           TEXT,
  revolut_pay_payments                         TEXT,
  sepa_debit_payments                          TEXT,
  sofort_payments                              TEXT,
  swish_payments                               TEXT,
  tax_reporting_us_1099_k                      TEXT,
  tax_reporting_us_1099_misc                   TEXT,
  transfers                                    TEXT,
  twint_payments                               TEXT,
  us_bank_account_ach_payments                 TEXT,
  zip_payments                                 TEXT
);

-- Your own account and, for Connect platforms, your connected accounts.
CREATE TABLE accounts (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  business_name                                TEXT,
  business_profile_mcc                         TEXT,
  business_url                                 TEXT,
  capabilities_acss_debit_payments             TEXT,
  capabilities_affirm_payments                 TEXT,
  capabilities_afterpay_clearpay_payments      TEXT,
  capabilities_amazon_pay_payments             TEXT,
  capabilities_au_becs_debit_payments          TEXT,
  capabilities_bacs_debit_payments             TEXT,
  capabilities_bancontact_payments             TEXT,
  capabilities_bank_transfer_payments          TEXT,
  capabilities_blik_payments                   TEXT,
  capabilities_boleto_payments                 TEXT,
  capabilities_card_issuing                    TEXT,
  capabilities_card_payments                   TEXT,
  capabilities_cartes_bancaires_payments       TEXT,
  capabilities_cashapp_payments                TEXT,
  capabilities_eps_payments                    TEXT,
  capabilities_fpx_payments                    TEXT,
  capabilities_giropay_payments                TEXT,
  capabilities_grabpay_payments                TEXT,
  capabilities_ideal_payments                  TEXT,
  capabilities_india_international_payments    TEXT,
  capabilities_jcb_payments                    TEXT,
  capabilities_klarna_payments                 TEXT,
  capabilities_konbini_payments                TEXT,
  capabilities_legacy_payments                 TEXT,
  capabilities_link_payments                   TEXT,
  capabilities_mobilepay_payments              TEXT,
  capabilities_multibanco_payments             TEXT,
  capabilities_oxxo_payments                   TEXT,
  capabilities_p24_payments                    TEXT,
  capabilities_paynow_payments                 TEXT,
  capabilities_promptpay_payments              TEXT,
  capabilities_revolut_pay_payments            TEXT,
  capabilities_sepa_debit_payments             TEXT,
  capabilities_sofort_payments                 TEXT,
  capabilities_swish_payments                  TEXT,
  capabilities_tax_reporting_us_1099_k         TEXT,
  capabilities_tax_reporting_us_1099_misc      TEXT,
  capabilities_transfers                       TEXT,
  capabilities_twint_payments                  TEXT,
  capabilities_us_bank_account_ach_payments    TEXT,
  capabilities_zip_payments                    TEXT,
  charges_enabled                              INTEGER,
  controller_fees_payer                        TEXT,
  controller_losses_payments                   TEXT,
  controller_requirement_collection            TEXT,
  controller_stripe_dashboard_type             TEXT,
  country                                      TEXT,
  created                                      TEXT,
  debit_negative_balances                      INTEGER,
  decline_charge_on_avs_failure                INTEGER,
  decline_charge_on_cvc_failure                INTEGER,
  default_currency                             TEXT,
  details_submitted                            INTEGER,
  display_name                                 TEXT,
  email                                        TEXT,
  future_requirements_current_deadline         TEXT,
  future_requirements_currently_due            TEXT,
  future_requirements_eventually_due           TEXT,
  future_requirements_past_due                 TEXT,
  future_requirements_pending_verification     TEXT,
  legal_entity_address_city                    TEXT,
  legal_entity_address_country                 TEXT,
  legal_entity_address_kana_city               TEXT,
  legal_entity_address_kana_country            TEXT,
  legal_entity_address_kana_line1              TEXT,
  legal_entity_address_kana_line2              TEXT,
  legal_entity_address_kana_postal_code        TEXT,
  legal_entity_address_kana_state              TEXT,
  legal_entity_address_kanji_city              TEXT,
  legal_entity_address_kanji_country           TEXT,
  legal_entity_address_kanji_line1             TEXT,
  legal_entity_address_kanji_line2             TEXT,
  legal_entity_address_kanji_postal_code       TEXT,
  legal_entity_address_kanji_state             TEXT,
  legal_entity_address_line1                   TEXT,
  legal_entity_address_line2                   TEXT,
  legal_entity_address_postal_code             TEXT,
  legal_entity_address_state                   TEXT,
  legal_entity_business_name                   TEXT,
  legal_entity_business_name_kana              TEXT,
  legal_entity_business_name_kanji             TEXT,
  legal_entity_business_tax_id_provided        INTEGER,
  legal_entity_business_vat_id_provided        INTEGER,
  legal_entity_dob_day                         INTEGER,
  legal_entity_dob_month                       INTEGER,
  legal_entity_dob_year                        INTEGER,
  legal_entity_first_name                      TEXT,
  legal_entity_first_name_kana                 TEXT,
  legal_entity_first_name_kanji                TEXT,
  legal_entity_gender                          TEXT,
  legal_entity_last_name                       TEXT,
  legal_entity_last_name_kana                  TEXT,
  legal_entity_last_name_kanji                 TEXT,
  legal_entity_maiden_name                     TEXT,
  legal_entity_personal_address_city           TEXT,
  legal_entity_personal_address_country        TEXT,
  legal_entity_personal_address_kana_city      TEXT,
  legal_entity_personal_address_kana_country   TEXT,
  legal_entity_personal_address_kana_line1     TEXT,
  legal_entity_personal_address_kana_line2     TEXT,
  legal_entity_personal_address_kana_postal_code TEXT,
  legal_entity_personal_address_kana_state     TEXT,
  legal_entity_personal_address_kanji_city     TEXT,
  legal_entity_personal_address_kanji_country  TEXT,
  legal_entity_personal_address_kanji_line1    TEXT,
  legal_entity_personal_address_kanji_line2    TEXT,
  legal_entity_personal_address_kanji_postal_code TEXT,
  legal_entity_personal_address_kanji_state    TEXT,
  legal_entity_personal_address_line1          TEXT,
  legal_entity_personal_address_line2          TEXT,
  legal_entity_personal_address_postal_code    TEXT,
  legal_entity_personal_address_state          TEXT,
  legal_entity_personal_id_number_provided     INTEGER,
  legal_entity_phone_number                    TEXT,
  legal_entity_ssn_last_4_provided             INTEGER,
  legal_entity_tax_id_registrar                TEXT,
  legal_entity_type                            TEXT,
  legal_entity_verification_details            TEXT,
  legal_entity_verification_details_code       TEXT,
  legal_entity_verification_document_id        TEXT,
  legal_entity_verification_status             TEXT,
  payout_schedule_delay_days                   INTEGER,
  payout_schedule_interval                     TEXT,
  payout_schedule_monthly_anchor               INTEGER,
  payout_schedule_weekly_anchor                TEXT,
  payout_statement_descriptor                  TEXT,
  payouts_enabled                              INTEGER,
  product_description                          TEXT,
  requirements_current_deadline                TEXT,
  requirements_currently_due                   TEXT,
  requirements_eventually_due                  TEXT,
  requirements_past_due                        TEXT,
  requirements_pending_verification            TEXT,
  statement_descriptor                         TEXT,
  support_email                                TEXT,
  support_phone                                TEXT,
  timezone                                     TEXT,
  tos_acceptance_date                          TEXT,
  tos_acceptance_ip                            TEXT,
  tos_acceptance_user_agent                    TEXT,
  "type"                                       TEXT,
  verification_disabled_reason                 TEXT,
  verification_due_by                          TEXT,
  verification_fields_needed                   TEXT
);

-- Metadata key/value pairs set on accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE accounts_metadata (
  account_id                                   TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- activity_report_itemized: no column detail published; see sigma_schema.json

-- Aggregated view of Stripe's payment optimizations (such as Adaptive Acceptance) and their measured impact.
CREATE TABLE aggregate_optimization_details (
  card_updates                                 INTEGER,
  "day"                                        REAL,
  dynamic_validations                          INTEGER
);

-- Itemized acceptance analytics used by Stripe's authorization rate reporting.
CREATE TABLE analytics_acceptance_itemized (
  amount                                       INTEGER,
  amount_in_usd                                INTEGER,
  block_reason                                 TEXT,
  buyer_country                                TEXT,
  card_bank                                    TEXT,
  card_bin                                     TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  charge_country                               TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  failure_reason                               TEXT,
  final_charge_id                              TEXT,
  gateway_conversation_avs_outcome             TEXT,
  gateway_conversation_cvc_outcome             TEXT,
  id                                           TEXT,
  interaction_type                             TEXT,
  invoice_id                                   TEXT,
  is_connected_account                         INTEGER,
  is_final_attempt                             INTEGER,
  is_link                                      INTEGER,
  locality_zone                                TEXT,
  mcc                                          TEXT,
  outcome_type                                 TEXT,
  payment_intent_id                            TEXT,
  payment_method_type                          TEXT,
  payment_processor                            TEXT,
  retry_status                                 TEXT,
  three_d_s_challenge_type                     TEXT,
  three_d_s_is_in_sca_scope                    INTEGER,
  three_d_s_outcome                            TEXT,
  three_d_s_outcome_type                       TEXT,
  three_d_s_reason                             TEXT,
  three_d_s_sca_exemption_type                 TEXT,
  three_d_s_used                               INTEGER,
  used_network_tokens                          INTEGER
);


CREATE TABLE analytics_acceptance_summarized (
  _viewing_merchant                            TEXT,
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  block_reason                                 TEXT,
  buyer_country                                TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  created_hour                                 TEXT,
  currency                                     TEXT,
  failure_reason                               TEXT,
  gateway_conversation_avs_outcome             TEXT,
  gateway_conversation_cvc_outcome             TEXT,
  interaction_type                             TEXT,
  is_connected_account                         INTEGER,
  is_final_attempt                             INTEGER,
  is_link                                      INTEGER,
  locality_zone                                TEXT,
  outcome_type                                 TEXT,
  payment_amount                               INTEGER,
  payment_amount_in_usd                        INTEGER,
  payment_count                                INTEGER,
  payment_method_type                          TEXT,
  payment_processor                            TEXT,
  retry_status                                 TEXT,
  three_d_s_challenge_type                     TEXT,
  three_d_s_is_in_sca_scope                    INTEGER,
  three_d_s_outcome                            TEXT,
  three_d_s_outcome_type                       TEXT,
  three_d_s_reason                             TEXT,
  three_d_s_sca_exemption_type                 TEXT,
  three_d_s_used                               INTEGER,
  used_network_tokens                          INTEGER
);

-- Refunds of application fees back to connected accounts.
CREATE TABLE application_fee_refunds (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  fee_id                                       TEXT
);

-- Metadata key/value pairs set on application_fee_refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE application_fee_refunds_metadata (
  application_fee_refund_id                    TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Fees your Connect platform collected from connected accounts.
CREATE TABLE application_fees (
  id                                           TEXT,
  account_id                                   TEXT,
  amount                                       INTEGER,
  amount_refunded                              INTEGER,
  application_id                               TEXT,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  fee_source_id                                TEXT,
  fee_source_type                              TEXT,
  originating_transaction_id                   TEXT,
  refunded                                     INTEGER
);

-- Individual 3D Secure authentication attempts, including the resulting charge outcome.
CREATE TABLE authentication_report_attempts (
  attempt_id                                   TEXT,
  amount                                       INTEGER,
  authentication_flow                          TEXT,
  card_bin_country                             TEXT,
  charge_id                                    TEXT,
  charge_outcome                               TEXT,
  charge_outcome_reason                        TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  device_type                                  TEXT,
  final_attempt_id                             TEXT,
  intent_id                                    TEXT,
  intent_type                                  TEXT,
  is_authenticated_by_digital_wallet           INTEGER,
  is_final_attempt                             INTEGER,
  is_in_sca_scope                              INTEGER,
  is_threeds_triggered                         INTEGER,
  merchant_country                             TEXT,
  protocol_version                             TEXT,
  sca_exemption_mechanism                      TEXT,
  sca_exemption_requested                      TEXT,
  sca_exemption_status                         TEXT,
  threeds_outcome_result                       TEXT,
  threeds_outcome_result_reason                TEXT,
  threeds_reason                               TEXT
);

-- Line-item breakdown of the fee column on balance_transactions.
CREATE TABLE balance_transaction_fee_details (
  balance_transaction_id                       TEXT,
  id                                           TEXT,
  amount                                       INTEGER,
  application                                  TEXT,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  "type"                                       TEXT
);

-- Ledger-style record of every event that moves money into or out of your Stripe balance. The canonical starting point for accounting and reconciliation
CREATE TABLE balance_transactions (
  id                                           TEXT,
  amount                                       INTEGER,
  automatic_transfer_id                        TEXT,
  available_on                                 TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  exchange_rate                                REAL,
  fee                                          INTEGER,
  net                                          INTEGER,
  reporting_category                           TEXT,
  source_id                                    TEXT,
  status                                       TEXT,
  "type"                                       TEXT
);


CREATE TABLE balance_transactions_product_enrichment (
  balance_transaction_id                       TEXT,
  product_ids                                  TEXT,
  product_names                                TEXT,
  reporting_category                           TEXT,
  source_id                                    TEXT
);


CREATE TABLE billing_credit_balance_transactions (
  id                                           TEXT,
  bill_item_id                                 TEXT,
  created                                      TEXT,
  credit_amount_type                           TEXT,
  credit_grant_id                              TEXT,
  credit_monetary_amount_currency              TEXT,
  credit_monetary_amount_value                 INTEGER,
  credit_type                                  TEXT,
  debit_amount_type                            TEXT,
  debit_monetary_amount_currency               TEXT,
  debit_monetary_amount_value                  INTEGER,
  debit_type                                   TEXT,
  effective_at                                 TEXT,
  invoice_id                                   TEXT,
  invoice_line_item_id                         TEXT,
  "type"                                       TEXT
);


CREATE TABLE billing_credit_grant_metadata (
  credit_grant_id                              TEXT,
  "key"                                        TEXT,
  "value"                                      TEXT
);


CREATE TABLE billing_credit_grants (
  id                                           TEXT,
  amount_type                                  TEXT,
  applicability_config_scope_price_type        TEXT,
  category                                     TEXT,
  created                                      TEXT,
  custom_pricing_unit_id                       TEXT,
  custom_pricing_unit_value                    TEXT,
  customer_id                                  TEXT,
  effective_at                                 TEXT,
  expires_at                                   TEXT,
  monetary_amount_currency                     TEXT,
  monetary_amount_value                        INTEGER,
  name                                         TEXT,
  service_action_id                            TEXT,
  updated                                      TEXT,
  voided_at                                    TEXT
);


CREATE TABLE billing_meter_dimensions (
  dimension_payload_key                        TEXT,
  meter_id                                     TEXT
);

-- Aggregated meter usage per customer over a time window.
CREATE TABLE billing_meter_event_summaries (
  id                                           TEXT,
  aggregated_value                             REAL,
  customer_id                                  TEXT,
  end_time                                     TEXT,
  livemode                                     INTEGER,
  meter_id                                     TEXT,
  segment_hash                                 TEXT,
  start_time                                   TEXT,
  value_grouping_window                        TEXT
);


CREATE TABLE billing_meter_event_summary_segments (
  dimension_key                                TEXT,
  event_summary_id                             TEXT,
  dimension_value                              TEXT
);

-- Meter events that failed validation and were not counted toward usage.
CREATE TABLE billing_meter_invalid_events (
  id                                           TEXT,
  created                                      TEXT,
  error_code                                   TEXT,
  error_message                                TEXT,
  event_name                                   TEXT,
  livemode                                     INTEGER,
  meter_id                                     TEXT,
  received                                     TEXT
);

-- Key/value payload of each invalid meter event.
CREATE TABLE billing_meter_invalid_events_payload (
  event_id                                     TEXT,
  "key"                                        TEXT,
  "value"                                      TEXT
);

-- Usage-based billing meters that aggregate metered events.
CREATE TABLE billing_meters (
  id                                           TEXT,
  created                                      TEXT,
  customer_mapping_event_payload_key           TEXT,
  customer_mapping_type                        TEXT,
  deactivated                                  TEXT,
  default_aggregation_formula                  TEXT,
  display_name                                 TEXT,
  event_name                                   TEXT,
  event_time_window                            TEXT,
  livemode                                     INTEGER,
  status                                       TEXT,
  updated                                      TEXT,
  value_settings_event_payload_key             TEXT
);


CREATE TABLE billing_schedule_applies_tos (
  billing_schedule_key                         TEXT,
  parent_id                                    TEXT,
  batch_timestamp                              TEXT,
  price_id                                     TEXT,
  "type"                                       TEXT
);


CREATE TABLE billing_schedules (
  "key"                                        TEXT,
  parent_id                                    TEXT,
  batch_timestamp                              TEXT,
  bill_until_computed_timestamp                TEXT,
  bill_until_duration_interval                 TEXT,
  bill_until_duration_interval_count           INTEGER,
  bill_until_timestamp                         TEXT,
  bill_until_type                              TEXT
);


CREATE TABLE captures (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  currency                                     TEXT
);

-- card_testing: no column detail published; see sigma_schema.json


CREATE TABLE cardsauth_eight_digit_bins (
  _viewing_compartment                         TEXT,
  _viewing_merchant                            TEXT,
  account_funding_source                       TEXT,
  card_bin                                     TEXT,
  card_brand                                   TEXT,
  country                                      TEXT,
  description                                  TEXT,
  issuer_name                                  TEXT,
  locality_zone                                TEXT
);

-- Card Account Updater fees, charged when Stripe automatically refreshes stored card credentials.
CREATE TABLE cau_fees (
  balance_transaction_id                       TEXT,
  billing_amount                               TEXT,
  card_id                                      TEXT,
  balance_transaction_created_at               TEXT,
  billing_currency                             TEXT,
  customer_id                                  TEXT,
  event_type                                   TEXT,
  fixed_per_item_amount                        REAL,
  fixed_per_item_count                         INTEGER,
  fx_rate                                      REAL,
  incurred_at                                  TEXT,
  previous_card_id                             TEXT,
  subtotal_amount                              REAL,
  tax_amount                                   REAL,
  tax_rate                                     REAL,
  total_amount                                 REAL
);

-- Groupings that link related charges, such as a retried payment and its original attempt.
CREATE TABLE charge_groups (
  charge_id                                    TEXT,
  amount_in_usd                                INTEGER,
  created                                      TEXT,
  final_charge_id                              TEXT
);

-- Per-charge record of which Stripe payment optimizations were applied and what they recovered.
CREATE TABLE charge_optimization_details (
  charge_id                                    TEXT  -- unverified
);

-- One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance
CREATE TABLE charges (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_refunded                              INTEGER,
  application_fee_id                           TEXT,
  application_id                               TEXT,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  calculated_statement_descriptor              TEXT,
  captured                                     INTEGER,
  captured_at                                  TEXT,
  card_address_city                            TEXT,
  card_address_country                         TEXT,
  card_address_line1                           TEXT,
  card_address_line1_check                     TEXT,
  card_address_line2                           TEXT,
  card_address_state                           TEXT,
  card_address_zip                             TEXT,
  card_address_zip_check                       TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_currency                                TEXT,
  card_customer_id                             TEXT,
  card_cvc_check                               TEXT,
  card_default_for_currency                    INTEGER,
  card_dynamic_last4                           TEXT,
  card_exp_month                               INTEGER,
  card_exp_year                                INTEGER,
  card_fingerprint                             TEXT,
  card_funding                                 TEXT,
  card_id                                      TEXT,
  card_last4                                   TEXT,
  card_name                                    TEXT,
  card_network                                 TEXT,
  card_recipient_id                            TEXT,
  card_token_type                              TEXT,
  card_tokenization_method                     TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  description                                  TEXT,
  destination_id                               TEXT,
  dispute_id                                   TEXT,
  failure_code                                 TEXT,
  failure_message                              TEXT,
  invoice_id                                   TEXT,
  on_behalf_of_id                              TEXT,
  order_id                                     TEXT,
  outcome_advice_code                          TEXT,
  outcome_network_advice_code                  TEXT,
  outcome_network_decline_code                 TEXT,
  outcome_network_status                       TEXT,
  outcome_reason                               TEXT,
  outcome_risk_level                           TEXT,
  outcome_risk_score                           INTEGER,
  outcome_rule_id                              TEXT,
  outcome_seller_message                       TEXT,
  outcome_type                                 TEXT,
  paid                                         INTEGER,
  payment_intent                               TEXT,
  payment_method_id                            TEXT,
  payment_method_type                          TEXT,
  presentment_amount                           INTEGER,
  presentment_currency                         TEXT,
  receipt_email                                TEXT,
  receipt_number                               TEXT,
  refunded                                     INTEGER,
  shipping_address_city                        TEXT,
  shipping_address_country                     TEXT,
  shipping_address_line1                       TEXT,
  shipping_address_line2                       TEXT,
  shipping_address_postal_code                 TEXT,
  shipping_address_state                       TEXT,
  source_id                                    TEXT,
  source_transfer_id                           TEXT,
  statement_descriptor                         TEXT,
  statement_descriptor_suffix                  TEXT,
  status                                       TEXT,
  transfer_group                               TEXT,
  transfer_id                                  TEXT
);

-- Metadata key/value pairs set on charges. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE charges_metadata (
  charge_id                                    TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Values customers entered into custom fields you configured on a Checkout session.
CREATE TABLE checkout_custom_fields (
  checkout_session_id                          TEXT,
  id                                           TEXT,
  batch_timestamp                              TEXT,
  "key"                                        TEXT,
  optional                                     INTEGER,
  "type"                                       TEXT,
  "value"                                      TEXT
);

-- Line items on a Checkout session.
CREATE TABLE checkout_line_items (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  checkout_session_id                          TEXT,
  created                                      TEXT,
  description                                  TEXT,
  price_id                                     TEXT,
  product_id                                   TEXT,
  quantity                                     INTEGER
);

-- Stripe Checkout sessions, including abandoned ones. The table to use for hosted-checkout conversion analysis.
CREATE TABLE checkout_sessions (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  client_reference_id                          TEXT,
  consent_promotions                           TEXT,
  consent_terms_of_service                     TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  invoice_id                                   TEXT,
  managed_payments_enabled                     INTEGER,
  mode                                         TEXT,
  payment_intent_id                            TEXT,
  payment_link_id                              TEXT,
  shipping_cost_amount_subtotal                INTEGER,
  shipping_cost_amount_tax                     INTEGER,
  shipping_cost_amount_total                   INTEGER,
  status                                       TEXT,
  subscription_id                              TEXT
);


CREATE TABLE checkout_sessions_metadata (
  checkout_session_id                          TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
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
  activity_end_time                            TEXT,
  activity_start_time                          TEXT,
  amount                                       REAL,
  balance_transaction_created                  TEXT,
  balance_transaction_description              TEXT,
  balance_transaction_id                       TEXT,
  connected_account_id                         TEXT,
  credit_note_number                           TEXT,
  currency                                     TEXT,
  feature_description                          TEXT,
  feature_name                                 TEXT,
  fee_category                                 TEXT,
  fee_description                              TEXT,
  fee_transaction_created                      TEXT,
  fee_transaction_id                           TEXT,
  incurred_at                                  TEXT,
  incurred_by                                  TEXT,
  incurred_by_type                             TEXT,
  invoice_number                               TEXT,
  platform_id                                  TEXT,
  pricing_tier                                 INTEGER,
  product                                      TEXT,
  product_feature_description                  TEXT,
  settled_at                                   TEXT,
  settled_via                                  TEXT,
  suite                                        TEXT,
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


CREATE TABLE connected_account_money_management_adjustments (
  account                                      TEXT,
  amount                                       INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT
);


CREATE TABLE connected_account_money_management_financial_accounts (
  account                                      TEXT,
  country                                      TEXT,
  created                                      TEXT,
  display_name                                 TEXT,
  id                                           TEXT,
  status                                       TEXT,
  "type"                                       TEXT
);


CREATE TABLE connected_account_money_management_financial_accounts_metadata (
  account                                      TEXT,
  financial_account_id                         TEXT,
  "key"                                        TEXT,
  "value"                                      TEXT
);


CREATE TABLE connected_account_money_management_financial_addresses (
  account                                      TEXT,
  created                                      TEXT,
  credentials_bank_name                        TEXT,
  credentials_bic                              TEXT,
  credentials_clabe                            TEXT,
  credentials_country                          TEXT,
  credentials_crypto_address                   TEXT,
  credentials_crypto_memo                      TEXT,
  credentials_crypto_network                   TEXT,
  credentials_institution_number               TEXT,
  credentials_last4                            TEXT,
  credentials_routing_number                   TEXT,
  credentials_sort_code                        TEXT,
  credentials_transit_number                   TEXT,
  credentials_type                             TEXT,
  currency                                     TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT,
  settlement_currency                          TEXT,
  status                                       TEXT
);


CREATE TABLE connected_account_money_management_inbound_transfers (
  account                                      TEXT,
  created                                      TEXT,
  credited_amount                              INTEGER,
  credited_currency                            TEXT,
  debited_amount                               INTEGER,
  debited_currency                             TEXT,
  description                                  TEXT,
  from_payment_method_id                       TEXT,
  from_payment_method_type                     TEXT,
  id                                           TEXT,
  status                                       TEXT,
  to_financial_account_id                      TEXT
);


CREATE TABLE connected_account_money_management_inbound_transfers_history (
  account                                      TEXT,
  bank_debit_failure_reason                    TEXT,
  bank_debit_return_reason                     TEXT,
  created                                      TEXT,
  effective_at                                 TEXT,
  id                                           TEXT,
  inbound_transfer_id                          TEXT,
  level                                        TEXT,
  "type"                                       TEXT
);


CREATE TABLE connected_account_money_management_outbound_payments (
  account                                      TEXT,
  ach_submission                               TEXT,
  ach_transaction_purpose                      TEXT,
  canceled_at                                  TEXT,
  created                                      TEXT,
  credited_amount                              INTEGER,
  credited_currency                            TEXT,
  debited_amount                               INTEGER,
  debited_currency                             TEXT,
  delivery_options_bank_account                TEXT,
  description                                  TEXT,
  expected_arrival_date                        TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  from_financial_account_id                    TEXT,
  id                                           TEXT,
  payout_method_options_bank_account_preferred_networks TEXT,
  posted_at                                    TEXT,
  returned_at                                  TEXT,
  returned_reason                              TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  to_payout_method_id                          TEXT,
  to_recipient_id                              TEXT
);


CREATE TABLE connected_account_money_management_outbound_payments_metadata (
  account                                      TEXT,
  "key"                                        TEXT,
  outbound_payment_id                          TEXT,
  "value"                                      TEXT
);


CREATE TABLE connected_account_money_management_outbound_transfers (
  account                                      TEXT,
  canceled_at                                  TEXT,
  created                                      TEXT,
  credited_amount                              INTEGER,
  credited_currency                            TEXT,
  debited_amount                               INTEGER,
  debited_currency                             TEXT,
  delivery_options_bank_account                TEXT,
  description                                  TEXT,
  expected_arrival_date                        TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  from_financial_account_id                    TEXT,
  id                                           TEXT,
  payout_method_options_bank_account_preferred_networks TEXT,
  posted_at                                    TEXT,
  returned_at                                  TEXT,
  returned_reason                              TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  to_payout_method_id                          TEXT
);


CREATE TABLE connected_account_money_management_outbound_transfers_metadata (
  account                                      TEXT,
  "key"                                        TEXT,
  outbound_transfer_id                         TEXT,
  "value"                                      TEXT
);


CREATE TABLE connected_account_money_management_received_credits (
  account                                      TEXT,
  amount                                       INTEGER,
  balance_transfer_from_account_id             TEXT,
  balance_transfer_id                          TEXT,
  balance_transfer_type                        TEXT,
  bank_transfer_account_holder_name            TEXT,
  bank_transfer_bank_name                      TEXT,
  bank_transfer_bic                            TEXT,
  bank_transfer_financial_address_id           TEXT,
  bank_transfer_last4                          TEXT,
  bank_transfer_network                        TEXT,
  bank_transfer_origin_type                    TEXT,
  bank_transfer_routing_number                 TEXT,
  bank_transfer_sort_code                      TEXT,
  bank_transfer_statement_descriptor           TEXT,
  card_spend_card_id                           TEXT,
  card_spend_issuing_dispute                   TEXT,
  card_spend_issuing_refund                    TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT,
  returned_at                                  TEXT,
  returned_reason                              TEXT,
  status                                       TEXT,
  succeeded_at                                 TEXT,
  "type"                                       TEXT
);


CREATE TABLE connected_account_money_management_received_debits (
  account                                      TEXT,
  amount                                       INTEGER,
  bank_transfer_bank_name                      TEXT,
  bank_transfer_financial_address_id           TEXT,
  bank_transfer_network                        TEXT,
  bank_transfer_routing_number                 TEXT,
  bank_transfer_statement_descriptor           TEXT,
  canceled_at                                  TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT,
  status                                       TEXT,
  succeeded_at                                 TEXT,
  "type"                                       TEXT
);


CREATE TABLE connected_account_money_management_transaction_entries (
  account                                      TEXT,
  available_balance_impact                     INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  effective_at                                 TEXT,
  id                                           TEXT,
  inbound_pending_balance_impact               INTEGER,
  outbound_pending_balance_impact              INTEGER,
  transaction_id                               TEXT
);


CREATE TABLE connected_account_money_management_transactions (
  account                                      TEXT,
  amount                                       INTEGER,
  available_balance_impact                     INTEGER,
  category                                     TEXT,
  counterparty_name                            TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  financial_account_id                         TEXT,
  flow_id                                      TEXT,
  flow_type                                    TEXT,
  id                                           TEXT,
  inbound_pending_balance_impact               INTEGER,
  outbound_pending_balance_impact              INTEGER,
  posted_at                                    TEXT,
  status                                       TEXT,
  void_at                                      TEXT
);

-- Connect platform view of payment_records for connected accounts.
CREATE TABLE connected_account_payment_records (
  id                                           TEXT,
  account                                      TEXT,
  amount_authorized_currency                   TEXT,
  amount_authorized_value                      INTEGER,
  amount_canceled_currency                     TEXT,
  amount_canceled_value                        INTEGER,
  amount_currency                              TEXT,
  amount_disputed_currency                     TEXT,
  amount_disputed_value                        INTEGER,
  amount_failed_currency                       TEXT,
  amount_failed_value                          INTEGER,
  amount_guaranteed_currency                   TEXT,
  amount_guaranteed_value                      INTEGER,
  amount_refunded_currency                     TEXT,
  amount_refunded_value                        INTEGER,
  amount_requested_currency                    TEXT,
  amount_requested_value                       INTEGER,
  amount_value                                 INTEGER,
  application                                  TEXT,
  capture_method                               TEXT,
  created                                      TEXT,
  customer_details_customer                    TEXT,
  customer_details_email                       TEXT,
  customer_details_name                        TEXT,
  customer_details_phone                       TEXT,
  customer_presence                            TEXT,
  description                                  TEXT,
  initiated_at                                 TEXT,
  latest_occurred_at                           TEXT,
  latest_payment_attempt_record                TEXT,
  money_services_transaction_type              TEXT,
  payment_method_details_billing_address_city  TEXT,
  payment_method_details_billing_address_country TEXT,
  payment_method_details_billing_address_line1 TEXT,
  payment_method_details_billing_address_line2 TEXT,
  payment_method_details_billing_address_postal_code TEXT,
  payment_method_details_billing_address_state TEXT,
  payment_method_details_billing_email         TEXT,
  payment_method_details_billing_name          TEXT,
  payment_method_details_billing_phone         TEXT,
  payment_method_details_card_brand            TEXT,
  payment_method_details_card_capture_before   TEXT,
  payment_method_details_card_country          TEXT,
  payment_method_details_card_exp_month        INTEGER,
  payment_method_details_card_exp_year         INTEGER,
  payment_method_details_card_fingerprint      TEXT,
  payment_method_details_card_funding          TEXT,
  payment_method_details_card_last4            TEXT,
  payment_method_details_card_moto             INTEGER,
  payment_method_details_card_network          TEXT,
  payment_method_details_card_network_transaction_id TEXT,
  payment_method_details_card_payment_account_reference TEXT,
  payment_method_details_card_wallet_dynamic_last4 TEXT,
  payment_method_details_card_wallet_type      TEXT,
  payment_method_details_custom_display_name   TEXT,
  payment_method_details_custom_type           TEXT,
  payment_method_details_payment_method        TEXT,
  payment_method_details_shared_payment_granted_token TEXT,
  payment_method_details_shop_pay_external_source_id TEXT,
  payment_method_details_type                  TEXT,
  processor_adyen_merchant_account             TEXT,
  processor_adyen_psp_reference                TEXT,
  processor_braintree_merchant_account_id      TEXT,
  processor_braintree_transaction_id           TEXT,
  processor_custom_payment_reference           TEXT,
  processor_stripe_charge                      TEXT,
  processor_type                               TEXT,
  processor_worldpay_merchant_code             TEXT,
  processor_worldpay_order_code                TEXT,
  reported_by                                  TEXT,
  setup_future_usage                           TEXT,
  shipping_address_city                        TEXT,
  shipping_address_country                     TEXT,
  shipping_address_line1                       TEXT,
  shipping_address_line2                       TEXT,
  shipping_address_postal_code                 TEXT,
  shipping_address_state                       TEXT,
  shipping_name                                TEXT,
  shipping_phone                               TEXT,
  updated                                      TEXT
);

-- Metadata key/value pairs set on connected_account_payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE connected_account_payment_records_metadata (
  "key"                                        TEXT,
  payment_record_id                            TEXT,
  account                                      TEXT,
  "value"                                      TEXT
);

-- Connect platform view of summarized_balance_transactions, per connected account.
CREATE TABLE connected_account_summarized_balance_transactions (
  activity_at_time_bucket                      TEXT,
  auto_payout_id                               TEXT,
  bt_count                                     TEXT,
  bt_effective_at_interval_start               TEXT,
  currency                                     TEXT,
  gross                                        TEXT,
  net                                          TEXT,
  payout_is_auto                               TEXT,
  reporting_category                           TEXT,
  account                                      TEXT,
  auto_payout_effective_at_interval_start      TEXT,
  fee                                          REAL
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
  applies_to_products                          TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  duration                                     TEXT,
  duration_in_months                           INTEGER,
  max_redemptions                              INTEGER,
  name                                         TEXT,
  percent_off                                  REAL,
  redeem_by                                    TEXT,
  times_redeemed                               INTEGER,
  valid                                        INTEGER
);

-- Per-currency overrides for multi-currency coupons.
CREATE TABLE coupons_currency_options (
  coupon_id                                    TEXT,
  currency                                     TEXT,
  amount_off                                   INTEGER,
  batch_timestamp                              TEXT
);

-- Metadata key/value pairs set on coupons. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE coupons_metadata (
  coupon_id                                    TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Discount amounts applied at the credit note level.
CREATE TABLE credit_note_discount_amounts (
  credit_note_id                               TEXT,
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  discount                                     TEXT
);

-- Discount amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_discount_amounts (
  credit_note_id                               TEXT,
  credit_note_line_item_id                     TEXT,
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  discount                                     TEXT
);

-- Tax amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_tax_amounts (
  credit_note_line_item_id                     TEXT,
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  inclusive                                    INTEGER,
  tax_rate_id                                  TEXT
);

-- Line items on a credit note.
CREATE TABLE credit_note_line_items (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  credit_note_id                               TEXT,
  description                                  TEXT,
  discount_amount                              INTEGER,
  invoice_line_item                            TEXT,
  quantity                                     INTEGER,
  "type"                                       TEXT,
  unit_amount                                  INTEGER,
  unit_amount_decimal                          TEXT
);

-- Tax amounts applied at the credit note level.
CREATE TABLE credit_note_tax_amounts (
  credit_note_id                               TEXT,
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  inclusive                                    INTEGER,
  tax_rate_id                                  TEXT
);

-- Post-issuance adjustments to invoices — the correct way to represent refunds and write-offs against a finalized invoice.
CREATE TABLE credit_notes (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_shipping                              INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_balance_transaction_id              TEXT,
  customer_id                                  TEXT,
  effective_at                                 TEXT,
  invoice_id                                   TEXT,
  memo                                         TEXT,
  number                                       TEXT,
  out_of_band_amount                           INTEGER,
  reason                                       TEXT,
  refund_id                                    TEXT,
  shipping_cost_amount_subtotal                INTEGER,
  shipping_cost_amount_tax                     INTEGER,
  shipping_cost_amount_total                   INTEGER,
  shipping_cost_shipping_rate_id               TEXT,
  status                                       TEXT,
  "type"                                       TEXT,
  voided_at                                    TEXT
);

-- Metadata key/value pairs set on credit_notes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE credit_notes_metadata (
  credit_note_id                               TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Stripe crypto onramp sessions where users bought crypto with fiat.
CREATE TABLE crypto_onramp_sessions (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  consumer_permissible_transaction_amount_tier TEXT,
  created                                      TEXT,
  destination_amount                           REAL,
  destination_currency                         TEXT,
  error_reason                                 TEXT,
  kyc_level                                    TEXT,
  network                                      TEXT,
  provided_wallet_address                      TEXT,
  source_amount                                REAL,
  source_currency                              TEXT,
  state                                        TEXT,
  updated                                      TEXT
);

-- Changes to a customer's account credit balance.
CREATE TABLE customer_balance_transactions (
  id                                           TEXT,
  account_id                                   TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  checkout_session_id                          TEXT,
  created                                      TEXT,
  credit_note_id                               TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  description                                  TEXT,
  ending_balance                               INTEGER,
  invoice_id                                   TEXT,
  merchant_balance_adjustment_id               TEXT,
  previous                                     TEXT,
  source_id                                    TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on customer_balance_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customer_balance_transactions_metadata (
  customer_balance_transaction_id              TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Changes to a customer's cash balance held at Stripe, used for bank-transfer funding.
CREATE TABLE customer_cash_balance_transactions (
  id                                           TEXT,
  amount                                       REAL,
  amount_currency                              TEXT,
  applied_to_payment_intent                    TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  customer                                     TEXT,
  ending_balance                               REAL,
  ending_balance_currency                      TEXT,
  funded_reference                             TEXT,
  linked_model_id                              TEXT,
  livemode                                     INTEGER,
  refund_from                                  TEXT,
  "type"                                       TEXT,
  unapplied_from_payment_intent                TEXT
);


CREATE TABLE customer_change_events (
  customer_id                                  TEXT,
  event_timestamp                              TEXT,
  event_type                                   TEXT,
  active_timestamp                             INTEGER,
  currency                                     TEXT,
  local_event_timestamp                        TEXT,
  mrr_change                                   INTEGER
);

-- Tax identifiers stored against a customer.
CREATE TABLE customer_tax_ids (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  country                                      TEXT,
  created                                      TEXT,
  customer                                     TEXT,
  owner_account                                TEXT,
  owner_application                            TEXT,
  owner_customer                               TEXT,
  owner_type                                   TEXT,
  "type"                                       TEXT,
  "value"                                      TEXT,
  verification_status                          TEXT,
  verification_verified_address                TEXT,
  verification_verified_name                   TEXT
);

-- One row per Customer object.
CREATE TABLE customers (
  id                                           TEXT,
  account_balance                              INTEGER,
  address_city                                 TEXT,
  address_country                              TEXT,
  address_line1                                TEXT,
  address_line2                                TEXT,
  address_postal_code                          TEXT,
  address_state                                TEXT,
  balance                                      INTEGER,
  batch_timestamp                              TEXT,
  business_name                                TEXT,
  business_vat_id                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_account_id                          TEXT,
  default_source_id                            TEXT,
  deleted                                      INTEGER,
  delinquent                                   INTEGER,
  description                                  TEXT,
  discount_checkout_session                    TEXT,
  discount_coupon_id                           TEXT,
  discount_customer_id                         TEXT,
  discount_end                                 TEXT,
  discount_invoice                             TEXT,
  discount_invoice_item                        TEXT,
  discount_promotion_code_id                   TEXT,
  discount_schedule_id                         TEXT,
  discount_start                               TEXT,
  discount_subscription                        TEXT,
  discount_subscription_item                   TEXT,
  email                                        TEXT,
  individual_name                              TEXT,
  invoice_credit_balance                       TEXT,
  invoice_settings_default_payment_method_id   TEXT,
  name                                         TEXT,
  phone                                        TEXT,
  preferred_locales                            TEXT,
  shipping_address_city                        TEXT,
  shipping_address_country                     TEXT,
  shipping_address_line1                       TEXT,
  shipping_address_line2                       TEXT,
  shipping_address_postal_code                 TEXT,
  shipping_address_state                       TEXT,
  shipping_name                                TEXT,
  shipping_phone                               TEXT,
  sources_data_id                              TEXT,
  tax_exempt                                   TEXT,
  tax_info_tax_id                              TEXT,
  tax_info_type                                TEXT,
  tax_ip_address                               TEXT
);

-- Metadata key/value pairs set on customers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customers_metadata (
  customer_id                                  TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Applications of a coupon or promotion code to a customer, subscription or invoice.
CREATE TABLE discounts (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  checkout_session_id                          TEXT,
  coupon_id                                    TEXT,
  created                                      TEXT,
  customer_id                                  TEXT,
  "end"                                        INTEGER,
  invoice_id                                   TEXT,
  invoice_item_id                              TEXT,
  promotion_code_id                            TEXT,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT
);

-- One row per Dispute (chargeback), including any evidence you submitted.
CREATE TABLE disputes (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  evidence_access_activity_log                 TEXT,
  evidence_billing_address                     TEXT,
  evidence_cancellation_policy_disclosure      TEXT,
  evidence_cancellation_policy_id              TEXT,
  evidence_cancellation_rebuttal               TEXT,
  evidence_customer_communication_id           TEXT,
  evidence_customer_email_address              TEXT,
  evidence_customer_name                       TEXT,
  evidence_customer_purchase_ip                TEXT,
  evidence_customer_signature_id               TEXT,
  evidence_details_due_by                      TEXT,
  evidence_details_has_evidence                INTEGER,
  evidence_details_past_due                    INTEGER,
  evidence_details_submission_count            INTEGER,
  evidence_details_submitted_at                TEXT,
  evidence_duplicate_charge_documentation_id   TEXT,
  evidence_duplicate_charge_id                 TEXT,
  evidence_product_description                 TEXT,
  evidence_receipt_id                          TEXT,
  evidence_refund_policy_disclosure            TEXT,
  evidence_refund_policy_id                    TEXT,
  evidence_refund_refusal_explanation          TEXT,
  evidence_service_date                        TEXT,
  evidence_service_documentation_id            TEXT,
  evidence_shipping_address                    TEXT,
  evidence_shipping_carrier                    TEXT,
  evidence_shipping_date                       TEXT,
  evidence_shipping_documentation_id           TEXT,
  evidence_shipping_tracking_number            TEXT,
  evidence_uncategorized_file_id               TEXT,
  evidence_uncategorized_text                  TEXT,
  is_charge_refundable                         INTEGER,
  network_details_type                         TEXT,
  network_details_visa_rapid_dispute_resolution INTEGER,
  network_reason_code                          TEXT,
  partner_processed_at                         TEXT,
  reason                                       TEXT,
  status                                       TEXT
);

-- Eligibility of each dispute for enhanced evidence programs such as Visa Compelling Evidence 3.0.
CREATE TABLE disputes_enhanced_eligibility (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      REAL,
  mastercard_compliance_status                 TEXT,
  visa_compelling_evidence_3_required_actions  TEXT,
  visa_compelling_evidence_3_status            TEXT,
  visa_compliance_status                       TEXT
);

-- Metadata key/value pairs set on disputes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE disputes_metadata (
  dispute_id                                   TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE disputes_reporting_v1_itemized (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_in_usd                                INTEGER,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  charge_id                                    TEXT,
  currency                                     TEXT,
  dispute_amount                               INTEGER,
  dispute_amount_in_usd                        INTEGER,
  dispute_created_day                          TEXT,
  dispute_id                                   TEXT,
  dispute_type                                 TEXT,
  gateway_country                              TEXT,
  has_early_fraud_warning                      INTEGER,
  is_connected_account                         INTEGER,
  payment_created_day                          TEXT,
  representment_product                        TEXT,
  responded                                    INTEGER,
  status                                       TEXT,
  user_facing_reason                           TEXT
);


CREATE TABLE draft_tax_forms (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  email                                        TEXT,
  filing_requirement                           TEXT,
  livemode                                     INTEGER,
  payee_account_id                             TEXT,
  payee_address_line_1                         TEXT,
  payee_address_line_2                         TEXT,
  payee_city                                   TEXT,
  payee_country                                TEXT,
  payee_name_line_1                            TEXT,
  payee_name_line_2                            TEXT,
  payee_postal_code                            TEXT,
  payee_region                                 TEXT,
  payee_tin_type                               TEXT,
  payee_type                                   TEXT,
  payer_override                               TEXT,
  postal_delivery                              TEXT,
  reporting_year                               INTEGER,
  "type"                                       TEXT,
  us_1099_k_numerical_data_by_calculation_type TEXT,
  us_1099_k_numerical_deltas                   TEXT,
  us_1099_k_selected_calculation_type          TEXT,
  us_1099_misc_numerical_data_by_calculation_type TEXT,
  us_1099_misc_numerical_deltas                TEXT,
  us_1099_misc_selected_calculation_type       TEXT,
  us_1099_nec_numerical_data_by_calculation_type TEXT,
  us_1099_nec_numerical_deltas                 TEXT,
  us_1099_nec_selected_calculation_type        TEXT
);

-- Fraud reports issued by the card network before a formal dispute is filed. Leading indicator for card brand monitoring programs such as Visa VAMP.
CREATE TABLE early_fraud_warnings (
  id                                           TEXT,
  actionable                                   INTEGER,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  fraud_type                                   TEXT
);

-- Daily currency conversion rates expressed relative to USD. Needed to sum multi-currency amounts into one reporting currency.
CREATE TABLE exchange_rates_from_usd (
  "date"                                       TEXT,
  buy_currency_exchange_rates                  TEXT,
  sell_currency                                TEXT
);


CREATE TABLE external_account_bank_accounts (
  account_id                                   TEXT,
  id                                           TEXT,
  account_holder_name                          TEXT,
  account_holder_type                          TEXT,
  account_type                                 TEXT,
  available_payout_methods                     TEXT,
  bank_name                                    TEXT,
  batch_timestamp                              TEXT,
  country                                      TEXT,
  currency                                     TEXT,
  default_for_currency                         INTEGER,
  fingerprint                                  TEXT,
  last4                                        TEXT,
  routing_number                               TEXT,
  status                                       TEXT
);


CREATE TABLE external_account_cards (
  account_id                                   TEXT,
  id                                           TEXT,
  address_city                                 TEXT,
  address_country                              TEXT,
  address_line1                                TEXT,
  address_line1_check                          TEXT,
  address_line2                                TEXT,
  address_state                                TEXT,
  address_zip                                  TEXT,
  address_zip_check                            TEXT,
  allow_redisplay                              TEXT,
  available_payout_methods                     TEXT,
  batch_timestamp                              TEXT,
  brand                                        TEXT,
  country                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  cvc_check                                    TEXT,
  default_for_currency                         INTEGER,
  dynamic_last4                                TEXT,
  exp_month                                    INTEGER,
  exp_year                                     INTEGER,
  fingerprint                                  TEXT,
  funding                                      TEXT,
  last4                                        TEXT,
  name                                         TEXT,
  recipient_id                                 TEXT,
  regulated_status                             TEXT,
  status                                       TEXT,
  tokenization_method                          TEXT
);


CREATE TABLE fee_credits_activities (
  credit_id                                    TEXT,
  transaction_id                               TEXT,
  amount_in_minor                              INTEGER,
  attribution_window_end                       TEXT,
  attribution_window_start                     TEXT,
  billing_account_id                           TEXT,
  created_at                                   TEXT,
  credit_name                                  TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  owner_account_id                             TEXT
);

-- Outstanding Stripe Capital loan balances over time.
CREATE TABLE financing_balances (
  id                                           TEXT,
  account_id                                   TEXT,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  effective_date_utc                           TEXT,
  financing_offer                              TEXT,
  overdue_payment_amount                       INTEGER,
  pending_payment_amount                       INTEGER,
  premium_outstanding_amount                   INTEGER,
  principal_outstanding_amount                 INTEGER
);

-- Stripe Capital financing offers extended to you or your connected accounts.
CREATE TABLE financing_offers (
  id                                           TEXT,
  accepted_advance_amount                      INTEGER,
  accepted_at                                  TEXT,
  accepted_premium_amount                      INTEGER,
  accepted_terms_repayment_interval_configuration_duration_days INTEGER,
  accepted_terms_repayment_interval_configuration_maximum_amount INTEGER,
  accepted_terms_repayment_interval_configuration_minimum_amount INTEGER,
  accepted_terms_target_payback_days           INTEGER,
  accepted_withhold_rate                       REAL,
  account_id                                   TEXT,
  batch_timestamp                              TEXT,
  campaign_type                                TEXT,
  canceled_at                                  TEXT,
  charged_off_at                               TEXT,
  created_at                                   TEXT,
  currency                                     TEXT,
  expires_at                                   TEXT,
  financing_application_status_transitions_accepted_at TEXT,
  financing_application_status_transitions_initiated_at TEXT,
  financing_type                               TEXT,
  fully_repaid_at                              TEXT,
  is_first_time_offer                          INTEGER,
  max_advance_amount                           INTEGER,
  max_premium_amount                           INTEGER,
  max_withhold_rate                            REAL,
  metadata                                     TEXT,
  offered_terms_repayment_interval_configuration_duration_days INTEGER,
  offered_terms_repayment_interval_configuration_maximum_amount INTEGER,
  offered_terms_repayment_interval_configuration_minimum_amount INTEGER,
  offered_terms_target_payback_days            INTEGER,
  paid_out_at                                  TEXT,
  previous_financing_fee_discount_amount       INTEGER,
  previous_financing_fee_discount_rate         REAL,
  product_type                                 TEXT,
  rejected_at                                  TEXT,
  replacement_for                              TEXT,
  replacement_type                             TEXT,
  revshare_earned_amount                       INTEGER,
  state                                        TEXT
);

-- Repayments and drawdowns against Stripe Capital financing.
CREATE TABLE financing_transactions (
  id                                           TEXT,
  advance_amount                               INTEGER,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  effective_time                               TEXT,
  fee_amount                                   INTEGER,
  financing_offer                              TEXT,
  legacy_balance_transaction_source            TEXT,
  linked_withholdable_object_id                TEXT,
  linked_withholdable_object_type              TEXT,
  reason                                       TEXT,
  reversed_transaction                         TEXT,
  total_amount                                 INTEGER,
  transaction_type                             TEXT
);

-- Interchange-plus fee breakdown, splitting each fee into interchange, scheme and Stripe components.
CREATE TABLE icplus_fees (
  balance_transaction_created_at               TEXT,
  balance_transaction_id                       TEXT,
  billing_amount                               INTEGER,
  billing_currency                             TEXT,
  charge_id                                    TEXT
);


CREATE TABLE iins (
  id                                           TEXT,
  bank                                         TEXT,
  country_code                                 TEXT,
  description                                  TEXT
);

-- Custom key/value fields rendered on an invoice.
CREATE TABLE invoice_custom_fields (
  invoice_id                                   TEXT,
  name                                         TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Customer tax identifiers captured on an invoice.
CREATE TABLE invoice_customer_tax_ids (
  invoice_id                                   TEXT,
  "value"                                      TEXT,
  batch_timestamp                              TEXT,
  "type"                                       TEXT
);


CREATE TABLE invoice_item_discount_amounts (
  discount_id                                  TEXT,
  invoice_item_id                              TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT
);

-- One-off charges or credits queued onto a customer's next invoice.
CREATE TABLE invoice_items (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  "date"                                       TEXT,
  description                                  TEXT,
  discountable                                 INTEGER,
  discounts                                    TEXT,
  invoice_id                                   TEXT,
  net_amount                                   INTEGER,
  period_end                                   TEXT,
  period_start                                 TEXT,
  plan_id                                      TEXT,
  price_id                                     TEXT,
  proration                                    INTEGER,
  quantity                                     INTEGER,
  quantity_decimal                             TEXT,
  subscription_id                              TEXT,
  subscription_item                            TEXT,
  unit_amount                                  INTEGER,
  unit_amount_decimal                          TEXT
);

-- Metadata key/value pairs set on invoice_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoice_items_metadata (
  invoice_item_id                              TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Discount amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_discount_amounts (
  id                                           TEXT,
  invoice_id                                   TEXT,
  invoice_line_item_id                         TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  discount                                     TEXT
);

-- Tax amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_tax_amounts (
  id                                           TEXT,
  invoice_id                                   TEXT,
  invoice_line_item_id                         TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  filing_amount                                INTEGER,
  inclusive                                    INTEGER,
  tax_rate                                     TEXT,
  taxable_amount                               INTEGER
);

-- Individual line items on an invoice.
CREATE TABLE invoice_line_items (
  invoice_id                                   TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  discountable                                 INTEGER,
  id                                           TEXT,
  invoice_item_id                              TEXT,
  line_item_parent_id                          TEXT,
  line_item_parent_type                        TEXT,
  period_end                                   TEXT,
  period_start                                 TEXT,
  plan_id                                      TEXT,
  price_id                                     TEXT,
  proration                                    INTEGER,
  proration_details_credited_items_invoice     TEXT,
  proration_details_credited_items_invoice_line_items TEXT,
  quantity                                     INTEGER,
  quantity_decimal                             TEXT,
  source_id                                    TEXT,
  source_type                                  TEXT,
  subscription                                 TEXT,
  subscription_item_id                         TEXT,
  total_discount                               INTEGER,
  total_exclusive_tax                          INTEGER
);

-- Payment attempts against an invoice, linking invoices to the charges or payment intents that settled them.
CREATE TABLE invoice_payments (
  id                                           TEXT,
  amount_overpaid                              INTEGER,
  amount_paid                                  INTEGER,
  amount_requested                             INTEGER,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  invoice                                      TEXT,
  is_default                                   INTEGER,
  payment_id                                   TEXT,
  payment_intent                               TEXT,
  payment_type                                 TEXT,
  status                                       TEXT,
  status_transitions_canceled_at               TEXT,
  status_transitions_paid_at                   TEXT
);

-- Tax applied to shipping costs on an invoice.
CREATE TABLE invoice_shipping_cost_taxes (
  id                                           TEXT,
  invoice_id                                   TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  filing_amount                                INTEGER,
  inclusive                                    INTEGER,
  tax_rate                                     TEXT,
  taxable_amount                               INTEGER
);

-- One row per Invoice object. Each subscription generates invoices on a recurring basis covering the subscription amount plus any invoice items.
CREATE TABLE invoices (
  id                                           TEXT,
  amount_due                                   INTEGER,
  amount_paid                                  INTEGER,
  amount_remaining                             INTEGER,
  amount_shipping                              INTEGER,
  application_fee                              INTEGER,
  application_id                               TEXT,
  attempt_count                                INTEGER,
  attempted                                    INTEGER,
  auto_advance                                 INTEGER,
  automatic_tax_enabled                        INTEGER,
  automatic_tax_provider                       TEXT,
  automatic_tax_status                         TEXT,
  batch_timestamp                              TEXT,
  billing_reason                               TEXT,
  charge_id                                    TEXT,
  collection_method                            TEXT,
  currency                                     TEXT,
  customer_address_city                        TEXT,
  customer_address_country                     TEXT,
  customer_address_line1                       TEXT,
  customer_address_line2                       TEXT,
  customer_address_postal_code                 TEXT,
  customer_address_state                       TEXT,
  customer_description                         TEXT,
  customer_email                               TEXT,
  customer_id                                  TEXT,
  customer_name                                TEXT,
  customer_phone                               TEXT,
  customer_shipping_address_city               TEXT,
  customer_shipping_address_country            TEXT,
  customer_shipping_address_line1              TEXT,
  customer_shipping_address_line2              TEXT,
  customer_shipping_address_postal_code        TEXT,
  customer_shipping_address_state              TEXT,
  customer_shipping_name                       TEXT,
  customer_shipping_phone                      TEXT,
  customer_tax_exempt                          TEXT,
  "date"                                       TEXT,
  default_payment_method_id                    TEXT,
  description                                  TEXT,
  discount_checkout_session                    TEXT,
  discount_coupon_id                           TEXT,
  discount_customer_id                         TEXT,
  discount_end                                 TEXT,
  discount_invoice                             TEXT,
  discount_invoice_item                        TEXT,
  discount_promotion_code_id                   TEXT,
  discount_schedule_id                         TEXT,
  discount_start                               TEXT,
  discount_subscription                        TEXT,
  discount_subscription_item                   TEXT,
  discounts                                    TEXT,
  due_date                                     TEXT,
  effective_at                                 TEXT,
  ending_balance                               INTEGER,
  footer                                       TEXT,
  next_payment_attempt                         TEXT,
  number                                       TEXT,
  on_behalf_of_id                              TEXT,
  paid                                         INTEGER,
  paid_out_of_band                             INTEGER,
  parent_id                                    TEXT,
  parent_type                                  TEXT,
  period_end                                   TEXT,
  period_start                                 TEXT,
  post_payment_credit_notes_amount             INTEGER,
  pre_payment_credit_notes_amount              INTEGER,
  quote_id                                     TEXT,
  receipt_number                               TEXT,
  shipping_cost_amount_subtotal                INTEGER,
  shipping_cost_amount_tax                     INTEGER,
  shipping_cost_amount_total                   INTEGER,
  shipping_cost_shipping_rate_id               TEXT,
  shipping_details_address_city                TEXT,
  shipping_details_address_country             TEXT,
  shipping_details_address_line1               TEXT,
  shipping_details_address_line2               TEXT,
  shipping_details_address_postal_code         TEXT,
  shipping_details_address_state               TEXT,
  shipping_details_name                        TEXT,
  shipping_details_phone                       TEXT,
  starting_balance                             INTEGER,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  status_transitions_finalized_at              TEXT,
  status_transitions_marked_uncollectible_at   TEXT,
  status_transitions_paid_at                   TEXT,
  status_transitions_voided_at                 TEXT,
  subscription_id                              TEXT,
  subscription_proration_date                  TEXT,
  subtotal                                     INTEGER,
  tax                                          INTEGER,
  tax_percent                                  REAL,
  total                                        INTEGER,
  transfer_data_amount                         INTEGER,
  transfer_data_destination_id                 TEXT,
  webhooks_delivered_at                        TEXT
);

-- Metadata key/value pairs set on invoices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoices_metadata (
  invoice_id                                   TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Authorization requests created whenever an issued card is used. Includes declined attempts.
CREATE TABLE issuing_authorizations (
  id                                           TEXT,
  amount                                       INTEGER,
  approved                                     INTEGER,
  authorization_method                         TEXT,
  batch_timestamp                              TEXT,
  card_id                                      TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  fraud_disputability_likelihood               TEXT,
  merchant_amount                              INTEGER,
  merchant_currency                            TEXT,
  merchant_data_category                       TEXT,
  merchant_data_category_code                  TEXT,
  merchant_data_city                           TEXT,
  merchant_data_country                        TEXT,
  merchant_data_name                           TEXT,
  merchant_data_network_id                     TEXT,
  merchant_data_postal_code                    TEXT,
  merchant_data_state                          TEXT,
  network_data_acquiring_institution_id        TEXT,
  risk_assessment_card_testing_risk_invalid_account_number_decline_rate_past_hour INTEGER,
  risk_assessment_card_testing_risk_invalid_credentials_decline_rate_past_hour INTEGER,
  risk_assessment_card_testing_risk_level      TEXT,
  risk_assessment_fraud_risk_level             TEXT,
  risk_assessment_fraud_risk_score             REAL,
  risk_assessment_merchant_dispute_risk_dispute_rate INTEGER,
  risk_assessment_merchant_dispute_risk_level  TEXT,
  status                                       TEXT,
  "type"                                       TEXT,
  verification_data_address_line1_check        TEXT,
  verification_data_address_postal_code_check  TEXT,
  verification_data_cvc_check                  TEXT,
  verification_data_expiry_check               TEXT,
  verification_data_postal_code                TEXT,
  wallet                                       TEXT
);

-- Metadata key/value pairs set on issuing_authorizations. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_authorizations_metadata (
  issuing_authorization_id                     TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE issuing_authorizations_request_history (
  issuing_authorization_id                     TEXT,
  amount                                       INTEGER,
  amount_details_atm_fee                       INTEGER,
  amount_details_cashback_amount               INTEGER,
  approved                                     INTEGER,
  authorization_code                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  merchant_amount                              INTEGER,
  merchant_currency                            TEXT,
  network_risk_score                           INTEGER,
  reason                                       TEXT,
  reason_message                               TEXT,
  requested_at                                 TEXT
);

-- People or businesses that hold cards you have issued.
CREATE TABLE issuing_cardholders (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  billing_address_city                         TEXT,
  billing_address_country                      TEXT,
  billing_address_line1                        TEXT,
  billing_address_line2                        TEXT,
  billing_address_postal_code                  TEXT,
  billing_address_state                        TEXT,
  company_tax_id_provided                      INTEGER,
  created                                      TEXT,
  email                                        TEXT,
  individual_dob_day                           INTEGER,
  individual_dob_month                         INTEGER,
  individual_dob_year                          INTEGER,
  individual_first_name                        TEXT,
  individual_last_name                         TEXT,
  individual_verification_document_back_id     TEXT,
  individual_verification_document_front_id    TEXT,
  name                                         TEXT,
  phone_number                                 TEXT,
  requirements_disabled_reason                 TEXT,
  requirements_past_due                        TEXT,
  status                                       TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on issuing_cardholders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cardholders_metadata (
  issuing_cardholder_id                        TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Cards you have issued.
CREATE TABLE issuing_cards (
  id                                           TEXT,
  allowed_authorization_period_ends_at         TEXT,
  allowed_authorization_period_starts_at       TEXT,
  batch_timestamp                              TEXT,
  brand                                        TEXT,
  cancellation_reason                          TEXT,
  cardholder_id                                TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  exp_month                                    INTEGER,
  exp_year                                     INTEGER,
  last4                                        TEXT,
  latest_fraud_warning_started_at              TEXT,
  latest_fraud_warning_type                    TEXT,
  lifecycle_controls_cancel_after_payment_count INTEGER,
  mcc_groups_allowed_categories                TEXT,
  mcc_groups_blocked_categories                TEXT,
  personalization_design_id                    TEXT,
  program_id                                   TEXT,
  replaced_by_id                               TEXT,
  replacement_for_id                           TEXT,
  shipping_address_city                        TEXT,
  shipping_address_country                     TEXT,
  shipping_address_line1                       TEXT,
  shipping_address_line2                       TEXT,
  shipping_address_postal_code                 TEXT,
  shipping_address_state                       TEXT,
  shipping_address_validation_mode             TEXT,
  shipping_address_validation_normalized_address_city TEXT,
  shipping_address_validation_normalized_address_country TEXT,
  shipping_address_validation_normalized_address_line1 TEXT,
  shipping_address_validation_normalized_address_line2 TEXT,
  shipping_address_validation_normalized_address_postal_code TEXT,
  shipping_address_validation_normalized_address_state TEXT,
  shipping_address_validation_result           TEXT,
  shipping_carrier                             TEXT,
  shipping_eta                                 TEXT,
  shipping_name                                TEXT,
  shipping_service                             TEXT,
  shipping_status                              TEXT,
  shipping_tracking_number                     TEXT,
  shipping_tracking_url                        TEXT,
  shipping_type                                TEXT,
  spending_limits                              TEXT,
  status                                       TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on issuing_cards. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cards_metadata (
  issuing_card_id                              TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE issuing_credit_ledger_adjustments (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  livemode                                     INTEGER,
  merchant                                     TEXT,
  reason                                       TEXT,
  reason_description                           TEXT
);


CREATE TABLE issuing_credit_ledger_entries (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  livemode                                     INTEGER,
  source_id                                    TEXT,
  source_type                                  TEXT
);


CREATE TABLE issuing_credit_policies (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  credit_limit_amount                          INTEGER,
  credit_limit_currency                        TEXT,
  credit_period_ends_on_days                   TEXT,
  credit_period_interval                       TEXT,
  credit_period_interval_count                 INTEGER,
  days_until_due                               INTEGER,
  last_effective_attributes_credit_limit_amount_amount INTEGER,
  last_effective_attributes_credit_limit_amount_currency TEXT,
  last_effective_attributes_credit_period_ends_on_days TEXT,
  last_effective_attributes_credit_period_interval TEXT,
  last_effective_attributes_credit_period_interval_count INTEGER,
  last_effective_attributes_effective_until    TEXT,
  livemode                                     INTEGER,
  status                                       TEXT,
  upcoming_attributes_credit_limit_amount_amount INTEGER,
  upcoming_attributes_credit_limit_amount_currency TEXT,
  upcoming_attributes_credit_period_ends_on_days TEXT,
  upcoming_attributes_credit_period_interval   TEXT,
  upcoming_attributes_credit_period_interval_count INTEGER,
  upcoming_attributes_effective_at             TEXT
);


CREATE TABLE issuing_credit_policy_archive (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  credit_limit_amount                          INTEGER,
  credit_limit_currency                        TEXT,
  credit_period_ends_on_days                   TEXT,
  credit_period_interval                       TEXT,
  credit_period_interval_count                 INTEGER,
  credit_policy_id                             TEXT,
  days_until_due                               INTEGER,
  last_effective_attributes_credit_limit_amount_amount INTEGER,
  last_effective_attributes_credit_limit_amount_currency TEXT,
  last_effective_attributes_credit_period_ends_on_days TEXT,
  last_effective_attributes_credit_period_interval TEXT,
  last_effective_attributes_credit_period_interval_count INTEGER,
  last_effective_attributes_effective_until    TEXT,
  livemode                                     INTEGER,
  status                                       TEXT,
  upcoming_attributes_credit_limit_amount_amount INTEGER,
  upcoming_attributes_credit_limit_amount_currency TEXT,
  upcoming_attributes_credit_period_ends_on_days TEXT,
  upcoming_attributes_credit_period_interval   TEXT,
  upcoming_attributes_credit_period_interval_count INTEGER,
  upcoming_attributes_effective_at             TEXT
);


CREATE TABLE issuing_credit_repayments (
  id                                           TEXT,
  allocation_fees                              INTEGER,
  allocation_interest                          INTEGER,
  allocation_principal                         INTEGER,
  amount                                       INTEGER,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  connected_account                            TEXT,
  created                                      TEXT,
  credit_statement_descriptor                  TEXT,
  currency                                     TEXT,
  destination                                  TEXT,
  destination_balance_type                     TEXT,
  failure_balance_transaction_id               TEXT,
  merchant                                     TEXT,
  status                                       TEXT,
  status_transitions_canceled_at               TEXT,
  status_transitions_failed_at                 TEXT,
  status_transitions_processing_at             TEXT,
  status_transitions_reversed_at               TEXT,
  status_transitions_succeeded_at              TEXT
);


CREATE TABLE issuing_credit_underwriting_records (
  id                                           TEXT,
  application_application_method               TEXT,
  application_purpose                          TEXT,
  application_submitted_at                     INTEGER,
  batch_timestamp                              TEXT,
  created                                      REAL,
  created_from                                 TEXT,
  credit_user_email                            TEXT,
  credit_user_name                             TEXT,
  decided_at                                   INTEGER,
  decision_application_rejected_reason_other_explanation TEXT,
  decision_application_rejected_reasons        TEXT,
  decision_credit_limit_approved_amount_amount INTEGER,
  decision_credit_limit_approved_amount_currency TEXT,
  decision_credit_limit_decreased_amount_amount INTEGER,
  decision_credit_limit_decreased_amount_currency TEXT,
  decision_credit_limit_decreased_reasons      TEXT,
  decision_credit_line_closed_reasons          TEXT,
  decision_deadline                            INTEGER,
  decision_type                                TEXT,
  livemode                                     INTEGER,
  merchant                                     TEXT,
  regulatory_reporting_file                    TEXT,
  underwriting_exception_reason                TEXT
);


CREATE TABLE issuing_credit_underwriting_records_metadata (
  credit_underwriting_record_id                TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Disputes you filed on behalf of cardholders against merchants.
CREATE TABLE issuing_disputes (
  id                                           TEXT,
  amount                                       REAL,
  batch_timestamp                              TEXT,
  card                                         TEXT,
  cardholder                                   TEXT,
  created                                      REAL,
  currency                                     TEXT,
  evidence_additional_documentation            TEXT,
  evidence_canceled_at                         INTEGER,
  evidence_cancellation_policy_provided        INTEGER,
  evidence_cancellation_reason                 TEXT,
  evidence_card_statement                      TEXT,
  evidence_cash_receipt                        TEXT,
  evidence_check_image                         TEXT,
  evidence_expected_at                         INTEGER,
  evidence_explanation                         TEXT,
  evidence_original_transaction                TEXT,
  evidence_product_description                 TEXT,
  evidence_product_type                        TEXT,
  evidence_received_at                         INTEGER,
  evidence_return_description                  TEXT,
  evidence_return_status                       TEXT,
  evidence_returned_at                         INTEGER,
  internal_reason                              TEXT,
  loss_reason                                  TEXT,
  merchant                                     TEXT,
  reason                                       TEXT,
  status                                       TEXT,
  transaction                                  TEXT,
  updated                                      REAL
);


CREATE TABLE issuing_disputes_metadata (
  dispute_id                                   TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE issuing_funding_obligations (
  id                                           TEXT,
  amount_outstanding                           INTEGER,
  amount_paid                                  INTEGER,
  amount_paid_from_reserve                     INTEGER,
  amount_total                                 INTEGER,
  balance_type                                 TEXT,
  batch_timestamp                              TEXT,
  created                                      REAL,
  credit_period_ends_at                        INTEGER,
  credit_period_starts_at                      INTEGER,
  currency                                     TEXT,
  due_at                                       INTEGER,
  finalized_at                                 INTEGER,
  grace_period_ends_at                         INTEGER,
  livemode                                     INTEGER,
  merchant                                     TEXT,
  owed_to                                      TEXT,
  paid_at                                      INTEGER,
  status                                       TEXT,
  transaction_period_ends_at                   INTEGER,
  transaction_period_starts_at                 INTEGER
);


CREATE TABLE issuing_funding_obligations_metadata (
  funding_obligation_id                        TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Network tokens provisioned for issued cards, such as those created when a card is added to a mobile wallet.
CREATE TABLE issuing_network_tokens (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  card                                         TEXT,
  created                                      REAL,
  device_fingerprint                           TEXT,
  last4                                        TEXT,
  merchant                                     TEXT,
  network                                      TEXT,
  network_updated_at                           REAL,
  status                                       TEXT,
  wallet_provider                              TEXT
);


CREATE TABLE issuing_personalization_designs (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  card_logo                                    TEXT,
  carrier_text_footer_body                     TEXT,
  carrier_text_footer_title                    TEXT,
  carrier_text_header_body                     TEXT,
  carrier_text_header_title                    TEXT,
  created                                      TEXT,
  livemode                                     INTEGER,
  lookup_key                                   TEXT,
  name                                         TEXT,
  physical_bundle                              TEXT,
  preferences_is_default                       INTEGER,
  preferences_is_platform_default              INTEGER,
  rejection_reasons_card_logo                  TEXT,
  rejection_reasons_carrier_text               TEXT,
  status                                       TEXT
);


CREATE TABLE issuing_personalization_designs_metadata (
  card_design_id                               TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE issuing_programs (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  is_default                                   INTEGER,
  platform_program_id                          TEXT
);


CREATE TABLE issuing_programs_metadata (
  issuing_program_id                           TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE issuing_transaction_amount_details_tax (
  issuing_transaction_id                       TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  behavior                                     TEXT,
  jurisdiction                                 TEXT
);

-- Uses of an issued card that actually moved funds, such as completed purchases and refunds.
CREATE TABLE issuing_transactions (
  id                                           TEXT,
  amount                                       INTEGER,
  authorization_id                             TEXT,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  card_id                                      TEXT,
  cardholder_id                                TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  interchange_amount_decimal                   TEXT,
  interchange_enhanced_data_interchange_amount_decimal TEXT,
  interchange_enhanced_data_interchange_received_on TEXT,
  merchant_amount                              INTEGER,
  merchant_currency                            TEXT,
  merchant_data_category                       TEXT,
  merchant_data_category_code                  TEXT,
  merchant_data_city                           TEXT,
  merchant_data_country                        TEXT,
  merchant_data_name                           TEXT,
  merchant_data_network_id                     TEXT,
  merchant_data_postal_code                    TEXT,
  merchant_data_state                          TEXT,
  network_data_authorization_code              TEXT,
  network_data_processing_date                 TEXT,
  network_data_transaction_id                  TEXT,
  purchase_details_flight_departure_at         INTEGER,
  purchase_details_flight_passenger_name       TEXT,
  purchase_details_flight_refundable           INTEGER,
  purchase_details_flight_travel_agency        TEXT,
  purchase_details_fuel_type                   TEXT,
  purchase_details_fuel_unit                   TEXT,
  purchase_details_fuel_unit_cost              INTEGER,
  purchase_details_fuel_unit_cost_decimal      TEXT,
  purchase_details_fuel_volume                 INTEGER,
  purchase_details_fuel_volume_decimal         TEXT,
  purchase_details_lodging_check_in_at         INTEGER,
  purchase_details_lodging_nights              INTEGER,
  purchase_details_reference                   TEXT,
  token_id                                     TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on issuing_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_transactions_metadata (
  issuing_transaction_id                       TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Granular breakdown of every fee charged or deducted from your Stripe balance, one row per fee component.
CREATE TABLE itemized_fees (
  activity_end_time                            TEXT,
  activity_start_time                          TEXT,
  amount                                       REAL,
  balance_transaction_created                  TEXT,
  balance_transaction_description              TEXT,
  balance_transaction_id                       TEXT,
  connected_account_id                         TEXT,
  credit_note_number                           TEXT,
  currency                                     TEXT,
  feature_description                          TEXT,
  feature_name                                 TEXT,
  fee_category                                 TEXT,
  fee_description                              TEXT,
  fee_transaction_created                      TEXT,
  fee_transaction_id                           TEXT,
  incurred_at                                  TEXT,
  incurred_by                                  TEXT,
  incurred_by_type                             TEXT,
  invoice_number                               TEXT,
  platform_id                                  TEXT,
  pricing_tier                                 INTEGER,
  product                                      TEXT,
  product_feature_description                  TEXT,
  settled_at                                   TEXT,
  settled_via                                  TEXT,
  suite                                        TEXT,
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


CREATE TABLE mandates (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  customer_acceptance_accepted_at              REAL,
  customer_acceptance_online_ip_address        TEXT,
  customer_acceptance_online_user_agent        TEXT,
  customer_acceptance_type                     TEXT,
  on_behalf_of                                 TEXT,
  payment_method                               TEXT,
  payment_method_details_acss_debit_interval_description TEXT,
  payment_method_details_acss_debit_payment_schedule TEXT,
  payment_method_details_acss_debit_transaction_type TEXT,
  payment_method_details_au_becs_debit_url     TEXT,
  payment_method_details_bacs_debit_network_status TEXT,
  payment_method_details_bacs_debit_reference  TEXT,
  payment_method_details_bacs_debit_revocation_reason TEXT,
  payment_method_details_bacs_debit_url        TEXT,
  payment_method_details_paypal_billing_agreement_id TEXT,
  payment_method_details_payto_amount          INTEGER,
  payment_method_details_payto_amount_type     TEXT,
  payment_method_details_payto_end_date        TEXT,
  payment_method_details_payto_payment_schedule TEXT,
  payment_method_details_payto_payments_per_period INTEGER,
  payment_method_details_payto_purpose         TEXT,
  payment_method_details_payto_start_date      TEXT,
  payment_method_details_sepa_debit_reference  TEXT,
  payment_method_details_sepa_debit_url        TEXT,
  payment_method_details_type                  TEXT,
  payment_method_details_upi_amount            INTEGER,
  payment_method_details_upi_amount_type       TEXT,
  payment_method_details_upi_description       TEXT,
  payment_method_details_upi_end_date          INTEGER,
  payment_method_details_us_bank_account_collection_method TEXT,
  single_use_amount                            INTEGER,
  single_use_currency                          TEXT,
  status                                       TEXT,
  "type"                                       TEXT
);


CREATE TABLE metered_items_beta (
  id                                           TEXT,
  created_at                                   INTEGER,
  display_name                                 TEXT,
  invoice_presentation_dimensions              TEXT,
  locality_zone                                TEXT,
  lookup_key                                   TEXT,
  metadata                                     TEXT,
  meter                                        TEXT,
  object                                       TEXT,
  tax_details_tax_code                         TEXT,
  unit_label                                   TEXT
);


CREATE TABLE money_management_adjustments (
  amount                                       INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT
);


CREATE TABLE money_management_financial_accounts (
  country                                      TEXT,
  created                                      TEXT,
  display_name                                 TEXT,
  id                                           TEXT,
  status                                       TEXT,
  "type"                                       TEXT
);


CREATE TABLE money_management_financial_accounts_metadata (
  financial_account_id                         TEXT,
  "key"                                        TEXT,
  "value"                                      TEXT
);


CREATE TABLE money_management_financial_addresses (
  created                                      TEXT,
  credentials_bank_name                        TEXT,
  credentials_bic                              TEXT,
  credentials_clabe                            TEXT,
  credentials_country                          TEXT,
  credentials_crypto_address                   TEXT,
  credentials_crypto_memo                      TEXT,
  credentials_crypto_network                   TEXT,
  credentials_institution_number               TEXT,
  credentials_last4                            TEXT,
  credentials_routing_number                   TEXT,
  credentials_sort_code                        TEXT,
  credentials_transit_number                   TEXT,
  credentials_type                             TEXT,
  currency                                     TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT,
  settlement_currency                          TEXT,
  status                                       TEXT
);


CREATE TABLE money_management_inbound_transfers (
  created                                      TEXT,
  credited_amount                              INTEGER,
  credited_currency                            TEXT,
  debited_amount                               INTEGER,
  debited_currency                             TEXT,
  description                                  TEXT,
  from_payment_method_id                       TEXT,
  from_payment_method_type                     TEXT,
  id                                           TEXT,
  status                                       TEXT,
  to_financial_account_id                      TEXT
);


CREATE TABLE money_management_inbound_transfers_history (
  bank_debit_failure_reason                    TEXT,
  bank_debit_return_reason                     TEXT,
  created                                      TEXT,
  effective_at                                 TEXT,
  id                                           TEXT,
  inbound_transfer_id                          TEXT,
  level                                        TEXT,
  "type"                                       TEXT
);


CREATE TABLE money_management_outbound_payments (
  ach_submission                               TEXT,
  ach_transaction_purpose                      TEXT,
  canceled_at                                  TEXT,
  created                                      TEXT,
  credited_amount                              INTEGER,
  credited_currency                            TEXT,
  debited_amount                               INTEGER,
  debited_currency                             TEXT,
  delivery_options_bank_account                TEXT,
  description                                  TEXT,
  expected_arrival_date                        TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  from_financial_account_id                    TEXT,
  id                                           TEXT,
  payout_method_options_bank_account_preferred_networks TEXT,
  posted_at                                    TEXT,
  returned_at                                  TEXT,
  returned_reason                              TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  to_payout_method_id                          TEXT,
  to_recipient_id                              TEXT
);


CREATE TABLE money_management_outbound_payments_metadata (
  "key"                                        TEXT,
  outbound_payment_id                          TEXT,
  "value"                                      TEXT
);


CREATE TABLE money_management_outbound_transfers (
  canceled_at                                  TEXT,
  created                                      TEXT,
  credited_amount                              INTEGER,
  credited_currency                            TEXT,
  debited_amount                               INTEGER,
  debited_currency                             TEXT,
  delivery_options_bank_account                TEXT,
  description                                  TEXT,
  expected_arrival_date                        TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  from_financial_account_id                    TEXT,
  id                                           TEXT,
  payout_method_options_bank_account_preferred_networks TEXT,
  posted_at                                    TEXT,
  returned_at                                  TEXT,
  returned_reason                              TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  to_payout_method_id                          TEXT
);


CREATE TABLE money_management_outbound_transfers_metadata (
  "key"                                        TEXT,
  outbound_transfer_id                         TEXT,
  "value"                                      TEXT
);


CREATE TABLE money_management_received_credits (
  amount                                       INTEGER,
  balance_transfer_from_account_id             TEXT,
  balance_transfer_id                          TEXT,
  balance_transfer_type                        TEXT,
  bank_transfer_account_holder_name            TEXT,
  bank_transfer_bank_name                      TEXT,
  bank_transfer_bic                            TEXT,
  bank_transfer_financial_address_id           TEXT,
  bank_transfer_last4                          TEXT,
  bank_transfer_network                        TEXT,
  bank_transfer_origin_type                    TEXT,
  bank_transfer_routing_number                 TEXT,
  bank_transfer_sort_code                      TEXT,
  bank_transfer_statement_descriptor           TEXT,
  card_spend_card_id                           TEXT,
  card_spend_issuing_dispute                   TEXT,
  card_spend_issuing_refund                    TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT,
  returned_at                                  TEXT,
  returned_reason                              TEXT,
  status                                       TEXT,
  succeeded_at                                 TEXT,
  "type"                                       TEXT
);


CREATE TABLE money_management_received_debits (
  amount                                       INTEGER,
  bank_transfer_bank_name                      TEXT,
  bank_transfer_financial_address_id           TEXT,
  bank_transfer_network                        TEXT,
  bank_transfer_routing_number                 TEXT,
  bank_transfer_statement_descriptor           TEXT,
  canceled_at                                  TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failed_at                                    TEXT,
  failed_reason                                TEXT,
  financial_account_id                         TEXT,
  id                                           TEXT,
  status                                       TEXT,
  succeeded_at                                 TEXT,
  "type"                                       TEXT
);


CREATE TABLE money_management_transaction_entries (
  available_balance_impact                     INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  effective_at                                 TEXT,
  id                                           TEXT,
  inbound_pending_balance_impact               INTEGER,
  outbound_pending_balance_impact              INTEGER,
  transaction_id                               TEXT
);


CREATE TABLE money_management_transactions (
  amount                                       INTEGER,
  available_balance_impact                     INTEGER,
  category                                     TEXT,
  counterparty_name                            TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  financial_account_id                         TEXT,
  flow_id                                      TEXT,
  flow_type                                    TEXT,
  id                                           TEXT,
  inbound_pending_balance_impact               INTEGER,
  outbound_pending_balance_impact              INTEGER,
  posted_at                                    TEXT,
  status                                       TEXT,
  void_at                                      TEXT
);

-- network_cost_insights_report: no column detail published; see sigma_schema.json


CREATE TABLE payins_insights_lightning_astro_deduped_aggregated_with_attempts_v2 (
  attributable_optimization                    TEXT,
  blocked_reason                               TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  cof                                          TEXT,
  currency                                     TEXT,
  decline_reason                               TEXT,
  gateway_conversation_avs_outcome             TEXT,
  gateway_conversation_cvc_outcome             TEXT,
  is_connected_account                         TEXT,
  outcome_type                                 TEXT,
  transaction_initiator                        TEXT,
  used_network_tokens                          TEXT,
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  created_hour                                 TEXT,
  transaction_amount                           INTEGER,
  transaction_amount_in_usd                    INTEGER,
  transaction_count                            INTEGER
);


CREATE TABLE payins_insights_lightning_astro_raw_aggregated_with_attempts_v2 (
  attributable_optimization                    TEXT,
  blocked_reason                               TEXT,
  card_brand                                   TEXT,
  card_country                                 TEXT,
  card_input_method                            TEXT,
  card_type                                    TEXT,
  cof                                          TEXT,
  currency                                     TEXT,
  decline_reason                               TEXT,
  gateway_conversation_avs_outcome             TEXT,
  gateway_conversation_cvc_outcome             TEXT,
  is_connected_account                         TEXT,
  outcome_type                                 TEXT,
  transaction_initiator                        TEXT,
  used_network_tokens                          TEXT,
  accepted_amount                              INTEGER,
  accepted_amount_in_usd                       INTEGER,
  accepted_count                               INTEGER,
  created_hour                                 TEXT,
  transaction_amount                           INTEGER,
  transaction_amount_in_usd                    INTEGER,
  transaction_count                            INTEGER
);


CREATE TABLE payment_evaluations (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  billing_email                                TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_email                               TEXT,
  early_fraud_warning_risk_level               TEXT,
  early_fraud_warning_score                    REAL,
  fraudulent_dispute_risk_level                TEXT,
  fraudulent_dispute_score                     REAL,
  fraudulent_payment_risk_level                TEXT,
  fraudulent_payment_score                     REAL,
  payment_method_id                            TEXT,
  recommended_action                           TEXT,
  risk_recommended_action                      TEXT,
  risk_score                                   INTEGER
);


CREATE TABLE payment_intent_line_items (
  id                                           TEXT,
  payment_intent_id                            TEXT,
  batch_timestamp                              TEXT,
  created                                      REAL,
  discount_amount                              INTEGER,
  livemode                                     INTEGER,
  merchant                                     TEXT,
  payment_method_options_klarna_image_url      TEXT,
  payment_method_options_klarna_product_url    TEXT,
  payment_method_options_paypal_category       TEXT,
  payment_method_options_paypal_description    TEXT,
  payment_method_options_paypal_sold_by        TEXT,
  product_code                                 TEXT,
  product_name                                 TEXT,
  quantity                                     INTEGER,
  total_tax_amount                             INTEGER,
  unit_cost                                    INTEGER
);

-- One row per PaymentIntent. Represents the full lifecycle of collecting a payment, including attempts that never produced a charge.
CREATE TABLE payment_intents (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_capturable                            INTEGER,
  amount_details_discount_amount               INTEGER,
  amount_details_shipping_amount               INTEGER,
  amount_details_shipping_from_postal_code     TEXT,
  amount_details_shipping_to_postal_code       TEXT,
  amount_details_surcharge_amount              INTEGER,
  amount_details_tax_total_tax_amount          INTEGER,
  amount_details_tip_amount                    INTEGER,
  application_fee_amount                       INTEGER,
  application_id                               TEXT,
  batch_timestamp                              TEXT,
  canceled_at                                  TEXT,
  cancellation_reason                          TEXT,
  capture_method                               TEXT,
  card_request_three_d_secure                  TEXT,
  confirmation_method                          TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  description                                  TEXT,
  invoice_id                                   TEXT,
  last_payment_error_charge                    TEXT,
  last_payment_error_source                    TEXT,
  last_payment_error_type                      TEXT,
  managed_payments_enabled                     INTEGER,
  on_behalf_of_id                              TEXT,
  payment_details_customer_reference           TEXT,
  payment_details_order_reference              TEXT,
  payment_method_id                            TEXT,
  payment_method_types                         TEXT,
  presentment_amount                           INTEGER,
  presentment_currency                         TEXT,
  receipt_email                                TEXT,
  review_id                                    TEXT,
  setup_future_usage                           TEXT,
  statement_descriptor                         TEXT,
  statement_descriptor_suffix                  TEXT,
  status                                       TEXT
);

-- Metadata key/value pairs set on payment_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_intents_metadata (
  "key"                                        TEXT,
  payment_intent_id                            TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Reusable shareable links that open a Checkout session.
CREATE TABLE payment_links (
  id                                           TEXT,
  active                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT
);

-- Per-charge payment method detail that does not fit in the flattened card_* columns on charges, including 3D Secure results and wallet information.
CREATE TABLE payment_method_details (
  charge_id                                    TEXT,
  ach_debit_account_holder_type                TEXT,
  ach_debit_bank_name                          TEXT,
  ach_debit_country                            TEXT,
  ach_debit_fingerprint                        TEXT,
  ach_debit_last4                              TEXT,
  ach_debit_routing_number                     TEXT,
  acss_debit_fingerprint                       TEXT,
  acss_debit_institution_number                TEXT,
  acss_debit_last4                             TEXT,
  acss_debit_mandate_id                        TEXT,
  acss_debit_transit_number                    TEXT,
  alipay_fingerprint                           TEXT,
  alipay_transaction_id                        TEXT,
  au_becs_debit_bsb_number                     TEXT,
  au_becs_debit_fingerprint                    TEXT,
  au_becs_debit_last4                          TEXT,
  au_becs_debit_mandate_id                     TEXT,
  bacs_debit_fingerprint                       TEXT,
  bacs_debit_last4                             TEXT,
  bacs_debit_mandate_id                        TEXT,
  bacs_debit_sort_code                         TEXT,
  batch_timestamp                              TEXT,
  bizum_buyer_id                               TEXT,
  bizum_transaction_id                         TEXT,
  boleto_expires_at                            INTEGER,
  boleto_number                                TEXT,
  card_3ds_authenticated                       INTEGER,
  card_3ds_succeeded                           INTEGER,
  card_3ds_version                             TEXT,
  card_address_line1_check                     TEXT,
  card_address_postal_code_check               TEXT,
  card_amount_authorized                       INTEGER,
  card_authorization_code                      TEXT,
  card_brand                                   TEXT,
  card_brand_product                           TEXT,
  card_country                                 TEXT,
  card_cvc_check                               TEXT,
  card_exp_month                               INTEGER,
  card_exp_year                                INTEGER,
  card_fingerprint                             TEXT,
  card_funding                                 TEXT,
  card_generated_card                          TEXT,
  card_iin                                     TEXT,
  card_installments_plan_count                 INTEGER,
  card_installments_plan_interval              TEXT,
  card_installments_plan_type                  TEXT,
  card_last4                                   TEXT,
  card_mandate                                 TEXT,
  card_moto                                    INTEGER,
  card_network                                 TEXT,
  card_network_token_used                      INTEGER,
  card_network_transaction_id                  TEXT,
  card_present_dynamic_currency_conversion_cardholder_rate REAL,
  card_present_dynamic_currency_conversion_markup_percent REAL,
  card_present_dynamic_currency_conversion_original_amount INTEGER,
  card_present_dynamic_currency_conversion_original_currency TEXT,
  card_present_dynamic_currency_conversion_status TEXT,
  card_present_dynamic_currency_conversion_transaction_fx_rate REAL,
  card_read_method                             TEXT,
  card_regulated_status                        TEXT,
  card_transaction_link_id                     TEXT,
  card_wallet_apple_pay_type                   TEXT,
  card_wallet_type                             TEXT,
  cashapp_buyer_id                             TEXT,
  cashapp_cashtag                              TEXT,
  cashapp_transaction_id                       TEXT,
  customer_balance_bank_transfer_type          TEXT,
  customer_balance_funding_type                TEXT,
  eps_bank                                     TEXT,
  eps_verified_name                            TEXT,
  fpx_account_holder_type                      TEXT,
  fpx_bank                                     TEXT,
  fpx_transaction_id                           TEXT,
  giropay_bank_code                            TEXT,
  giropay_bank_name                            TEXT,
  giropay_bic                                  TEXT,
  giropay_verified_name                        TEXT,
  ideal_bank                                   TEXT,
  ideal_bic                                    TEXT,
  ideal_generated_sepa_debit_id                TEXT,
  ideal_generated_sepa_debit_mandate_id        TEXT,
  ideal_iban_last4                             TEXT,
  ideal_transaction_id                         TEXT,
  ideal_verified_name                          TEXT,
  klarna_payer_details_address_country         TEXT,
  klarna_payment_method_category               TEXT,
  klarna_preferred_locale                      TEXT,
  konbini_store_chain                          TEXT,
  link_country                                 TEXT,
  multibanco_entity                            TEXT,
  multibanco_reference                         TEXT,
  naver_buyer_id                               TEXT,
  naver_transaction_id                         TEXT,
  nz_bank_account_account_holder_name          TEXT,
  nz_bank_account_bank_code                    TEXT,
  nz_bank_account_bank_name                    TEXT,
  nz_bank_account_branch_code                  TEXT,
  nz_bank_account_last4                        TEXT,
  nz_bank_account_suffix                       TEXT,
  oxxo_number                                  TEXT,
  p24_bank                                     TEXT,
  p24_reference                                TEXT,
  p24_verified_name                            TEXT,
  paynow_transaction_id                        TEXT,
  payto_account_number                         TEXT,
  payto_bsb_number                             TEXT,
  payto_last4                                  TEXT,
  payto_mandate                                TEXT,
  payto_pay_id                                 TEXT,
  pix_bank_transaction_id                      TEXT,
  pix_fingerprint                              TEXT,
  promptpay_transaction_id                     TEXT,
  sepa_debit_bank_code                         TEXT,
  sepa_debit_branch_code                       TEXT,
  sepa_debit_country                           TEXT,
  sepa_debit_fingerprint                       TEXT,
  sepa_debit_last4                             TEXT,
  sepa_debit_mandate_id                        TEXT,
  sofort_bank_code                             TEXT,
  sofort_bank_name                             TEXT,
  sofort_bic                                   TEXT,
  sofort_country                               TEXT,
  sofort_iban_last4                            TEXT,
  sofort_preferred_language                    TEXT,
  sofort_verified_name                         TEXT,
  swish_fingerprint                            TEXT,
  swish_payment_reference                      TEXT,
  swish_verified_phone_last4                   TEXT,
  terminal_location_id                         TEXT,
  terminal_reader_id                           TEXT,
  "type"                                       TEXT,
  us_bank_account_account_holder_type          TEXT,
  us_bank_account_account_type                 TEXT,
  us_bank_account_bank_name                    TEXT,
  us_bank_account_fingerprint                  TEXT,
  us_bank_account_last4                        TEXT,
  us_bank_account_mandate_id                   TEXT,
  us_bank_account_payment_reference            TEXT,
  us_bank_account_routing_number               TEXT
);

-- Saved payment instruments attached to customers.
CREATE TABLE payment_methods (
  id                                           TEXT,
  acss_debit_fingerprint                       TEXT,
  acss_debit_institution_number                TEXT,
  acss_debit_last4                             TEXT,
  acss_debit_transit_number                    TEXT,
  au_becs_debit_bsb_number                     TEXT,
  au_becs_debit_fingerprint                    TEXT,
  au_becs_debit_last4                          TEXT,
  bacs_debit_fingerprint                       TEXT,
  bacs_debit_last4                             TEXT,
  bacs_debit_sort_code                         TEXT,
  batch_timestamp                              TEXT,
  billing_details_address_city                 TEXT,
  billing_details_address_country              TEXT,
  billing_details_address_line1                TEXT,
  billing_details_address_line2                TEXT,
  billing_details_address_postal_code          TEXT,
  billing_details_address_state                TEXT,
  billing_details_email                        TEXT,
  billing_details_name                         TEXT,
  billing_details_phone                        TEXT,
  bizum_buyer_id                               TEXT,
  boleto_tax_id                                TEXT,
  card_address_line1_check                     TEXT,
  card_address_postal_code_check               TEXT,
  card_brand                                   TEXT,
  card_brand_product                           TEXT,
  card_country                                 TEXT,
  card_cvc_check                               TEXT,
  card_exp_month                               INTEGER,
  card_exp_year                                INTEGER,
  card_fingerprint                             TEXT,
  card_funding                                 TEXT,
  card_generated_from_charge_id                TEXT,
  card_iin                                     TEXT,
  card_last4                                   TEXT,
  card_regulated_status                        TEXT,
  card_three_d_secure_supported                INTEGER,
  card_wallet_apple_pay_type                   TEXT,
  card_wallet_type                             TEXT,
  cashapp_buyer_id                             TEXT,
  cashapp_cashtag                              TEXT,
  created                                      TEXT,
  custom_type                                  TEXT,
  customer_id                                  TEXT,
  eps_bank                                     TEXT,
  fpx_account_holder_type                      TEXT,
  fpx_bank                                     TEXT,
  ideal_bank                                   TEXT,
  ideal_bic                                    TEXT,
  klarna_dob_day                               INTEGER,
  klarna_dob_month                             INTEGER,
  klarna_dob_year                              INTEGER,
  link_email                                   TEXT,
  naver_buyer_id                               TEXT,
  naver_funding                                TEXT,
  nz_bank_account_account_holder_name          TEXT,
  nz_bank_account_bank_code                    TEXT,
  nz_bank_account_bank_name                    TEXT,
  nz_bank_account_branch_code                  TEXT,
  nz_bank_account_last4                        TEXT,
  nz_bank_account_suffix                       TEXT,
  p24_bank                                     TEXT,
  paypal_country                               TEXT,
  paypal_payer_email                           TEXT,
  paypal_payer_id                              TEXT,
  payto_account_number                         TEXT,
  payto_bsb_number                             TEXT,
  payto_last4                                  TEXT,
  payto_pay_id                                 TEXT,
  pix_fingerprint                              TEXT,
  sepa_debit_bank_code                         TEXT,
  sepa_debit_branch_code                       TEXT,
  sepa_debit_country                           TEXT,
  sepa_debit_fingerprint                       TEXT,
  sepa_debit_generated_from_charge_id          TEXT,
  sepa_debit_generated_from_setup_attempt_id   TEXT,
  sepa_debit_last4                             TEXT,
  sofort_country                               TEXT,
  "type"                                       TEXT,
  upi_vpa                                      TEXT,
  us_bank_account_account_holder_type          TEXT,
  us_bank_account_account_type                 TEXT,
  us_bank_account_fingerprint                  TEXT,
  us_bank_account_last4                        TEXT,
  us_bank_account_linked_account               TEXT,
  us_bank_account_routing_number               TEXT
);

-- Metadata key/value pairs set on payment_methods. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_methods_metadata (
  "key"                                        TEXT,
  payment_method_id                            TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Unified payment records spanning Stripe and externally processed payments.
CREATE TABLE payment_records (
  id                                           TEXT,
  amount_authorized_currency                   TEXT,
  amount_authorized_value                      INTEGER,
  amount_canceled_currency                     TEXT,
  amount_canceled_value                        INTEGER,
  amount_currency                              TEXT,
  amount_disputed_currency                     TEXT,
  amount_disputed_value                        INTEGER,
  amount_failed_currency                       TEXT,
  amount_failed_value                          INTEGER,
  amount_guaranteed_currency                   TEXT,
  amount_guaranteed_value                      INTEGER,
  amount_refunded_currency                     TEXT,
  amount_refunded_value                        INTEGER,
  amount_requested_currency                    TEXT,
  amount_requested_value                       INTEGER,
  amount_value                                 INTEGER,
  application                                  TEXT,
  capture_method                               TEXT,
  created                                      TEXT,
  customer_details_customer                    TEXT,
  customer_details_email                       TEXT,
  customer_details_name                        TEXT,
  customer_details_phone                       TEXT,
  customer_presence                            TEXT,
  description                                  TEXT,
  initiated_at                                 TEXT,
  latest_occurred_at                           TEXT,
  latest_payment_attempt_record                TEXT,
  money_services_transaction_type              TEXT,
  payment_method_details_billing_address_city  TEXT,
  payment_method_details_billing_address_country TEXT,
  payment_method_details_billing_address_line1 TEXT,
  payment_method_details_billing_address_line2 TEXT,
  payment_method_details_billing_address_postal_code TEXT,
  payment_method_details_billing_address_state TEXT,
  payment_method_details_billing_email         TEXT,
  payment_method_details_billing_name          TEXT,
  payment_method_details_billing_phone         TEXT,
  payment_method_details_card_brand            TEXT,
  payment_method_details_card_capture_before   TEXT,
  payment_method_details_card_country          TEXT,
  payment_method_details_card_exp_month        INTEGER,
  payment_method_details_card_exp_year         INTEGER,
  payment_method_details_card_fingerprint      TEXT,
  payment_method_details_card_funding          TEXT,
  payment_method_details_card_last4            TEXT,
  payment_method_details_card_moto             INTEGER,
  payment_method_details_card_network          TEXT,
  payment_method_details_card_network_transaction_id TEXT,
  payment_method_details_card_payment_account_reference TEXT,
  payment_method_details_card_wallet_dynamic_last4 TEXT,
  payment_method_details_card_wallet_type      TEXT,
  payment_method_details_custom_display_name   TEXT,
  payment_method_details_custom_type           TEXT,
  payment_method_details_payment_method        TEXT,
  payment_method_details_shared_payment_granted_token TEXT,
  payment_method_details_shop_pay_external_source_id TEXT,
  payment_method_details_type                  TEXT,
  processor_adyen_merchant_account             TEXT,
  processor_adyen_psp_reference                TEXT,
  processor_braintree_merchant_account_id      TEXT,
  processor_braintree_transaction_id           TEXT,
  processor_custom_payment_reference           TEXT,
  processor_stripe_charge                      TEXT,
  processor_type                               TEXT,
  processor_worldpay_merchant_code             TEXT,
  processor_worldpay_order_code                TEXT,
  reported_by                                  TEXT,
  setup_future_usage                           TEXT,
  shipping_address_city                        TEXT,
  shipping_address_country                     TEXT,
  shipping_address_line1                       TEXT,
  shipping_address_line2                       TEXT,
  shipping_address_postal_code                 TEXT,
  shipping_address_state                       TEXT,
  shipping_name                                TEXT,
  shipping_phone                               TEXT,
  updated                                      TEXT
);

-- Metadata key/value pairs set on payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_records_metadata (
  "key"                                        TEXT,
  payment_record_id                            TEXT,
  "value"                                      TEXT
);

-- Payments flagged by Radar for manual review, and how they were resolved.
CREATE TABLE payment_reviews (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  early_fraud_warning_id                       TEXT,
  open                                         INTEGER,
  payment_intent_id                            TEXT,
  reason                                       TEXT,
  recommended_refund_confidence_level          TEXT,
  recommended_refund_created_at                TEXT
);


CREATE TABLE payout_minimum_balance_settings (
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  currency                                     TEXT
);

-- Legacy recurring pricing objects, superseded by prices. Retained for older integrations.
CREATE TABLE plans (
  id                                           TEXT,
  aggregate_usage                              TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  billing_scheme                               TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  "interval"                                   TEXT,
  interval_count                               INTEGER,
  nickname                                     TEXT,
  product_id                                   TEXT,
  tiers_mode                                   TEXT,
  transform_usage_divide_by                    INTEGER,
  transform_usage_round                        TEXT,
  trial_period_days                            INTEGER,
  unit_amount_decimal                          TEXT,
  usage_type                                   TEXT
);

-- Metadata key/value pairs set on plans. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE plans_metadata (
  "key"                                        TEXT,
  plan_id                                      TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE platform_tax_settings (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  default_form_type                            TEXT,
  k_default_calculation_type                   TEXT,
  livemode                                     INTEGER,
  merchant                                     TEXT,
  misc_default_calculation_type                TEXT,
  nec_default_calculation_type                 TEXT,
  reporting_year                               INTEGER,
  "year"                                       INTEGER
);

-- Tier definitions for prices using tiered billing.
CREATE TABLE price_tiers (
  price_id                                     TEXT,
  upto                                         TEXT,
  amount                                       INTEGER,
  amount_decimal                               TEXT,
  batch_timestamp                              TEXT,
  flat_amount                                  INTEGER,
  flat_amount_decimal                          TEXT
);

-- How much and how often to charge for a product.
CREATE TABLE prices (
  id                                           TEXT,
  active                                       INTEGER,
  batch_timestamp                              TEXT,
  billing_scheme                               TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  custom_unit_amount_default                   INTEGER,
  custom_unit_amount_maximum                   INTEGER,
  custom_unit_amount_minimum                   INTEGER,
  lookup_key                                   TEXT,
  nickname                                     TEXT,
  product_id                                   TEXT,
  recurring_aggregate_usage                    TEXT,
  recurring_interval                           TEXT,
  recurring_interval_count                     INTEGER,
  recurring_meter_id                           TEXT,
  recurring_trial_period_days                  INTEGER,
  recurring_usage_type                         TEXT,
  tax_behavior                                 TEXT,
  tiers_mode                                   TEXT,
  transform_quantity_divide_by                 INTEGER,
  transform_quantity_round                     TEXT,
  "type"                                       TEXT,
  unit_amount                                  INTEGER,
  unit_amount_decimal                          TEXT
);

-- Per-currency overrides for multi-currency prices.
CREATE TABLE prices_currency_options (
  currency                                     TEXT,
  price_id                                     TEXT,
  batch_timestamp                              TEXT,
  unit_amount                                  INTEGER,
  unit_amount_decimal                          TEXT
);

-- Metadata key/value pairs set on prices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE prices_metadata (
  "key"                                        TEXT,
  price_id                                     TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Goods or services you sell.
CREATE TABLE products (
  id                                           TEXT,
  active                                       INTEGER,
  batch_timestamp                              TEXT,
  caption                                      TEXT,
  created                                      TEXT,
  deactivate_on                                TEXT,
  description                                  TEXT,
  name                                         TEXT,
  shippable                                    INTEGER,
  statement_descriptor                         TEXT,
  "type"                                       TEXT,
  unit_label                                   TEXT,
  url                                          TEXT
);

-- Metadata key/value pairs set on products. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE products_metadata (
  "key"                                        TEXT,
  product_id                                   TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Customer-facing codes that map to a coupon.
CREATE TABLE promotion_codes (
  id                                           TEXT,
  active                                       INTEGER,
  batch_timestamp                              TEXT,
  code                                         TEXT,
  coupon_id                                    TEXT,
  created                                      TEXT,
  customer_id                                  TEXT,
  expires_at                                   INTEGER,
  max_redemptions                              INTEGER,
  restrictions_first_time_transaction          INTEGER,
  restrictions_minium_amount                   INTEGER,
  restrictions_minium_amount_currency          TEXT,
  times_redeemed                               INTEGER
);


CREATE TABLE purchase_details_receipts (
  issuing_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  description                                  TEXT,
  quantity                                     REAL,
  total                                        INTEGER,
  unit_cost                                    INTEGER
);


CREATE TABLE quote_metadata (
  "key"                                        TEXT,
  quote_id                                     TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Sales quotes that can be accepted to create an invoice or subscription.
CREATE TABLE quotes (
  id                                           TEXT,
  accepted_at                                  TEXT,
  amount_subtotal                              INTEGER,
  amount_total                                 INTEGER,
  application_fee_amount                       INTEGER,
  application_fee_percent                      INTEGER,
  automatic_tax_enabled                        INTEGER,
  automatic_tax_status                         TEXT,
  batch_timestamp                              TEXT,
  canceled_at                                  TEXT,
  cloned_from                                  TEXT,
  collection_method                            TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  default_tax_rates                            TEXT,
  description                                  TEXT,
  expires_at                                   TEXT,
  finalized_at                                 TEXT,
  footer                                       TEXT,
  header                                       TEXT,
  invoice_id                                   TEXT,
  invoice_settings_days_until_due              REAL,
  is_revision                                  INTEGER,
  line_item_group                              TEXT,
  number                                       TEXT,
  on_behalf_of_id                              TEXT,
  recurring_line_item_group                    TEXT,
  status                                       TEXT,
  subscription_data_billing_mode_type          TEXT,
  subscription_data_description                TEXT,
  subscription_data_effective_date             INTEGER,
  subscription_data_proration_discounts        TEXT,
  subscription_data_trial_period_days          INTEGER,
  subscription_id                              TEXT,
  transfer_data_amount                         INTEGER,
  transfer_data_destination_amount_percent     REAL,
  transfer_data_destination_id                 TEXT,
  upcoming_line_item_group                     TEXT
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
  rule_id                                      TEXT,
  action                                       TEXT,
  predicate                                    TEXT
);


CREATE TABLE rate_card_rates_beta (
  id                                           TEXT,
  created_at                                   INTEGER,
  custom_pricing_unit_amount_custom_pricing_unit_id TEXT,
  custom_pricing_unit_amount_value             TEXT,
  locality_zone                                TEXT,
  metadata                                     TEXT,
  metered_item_id                              TEXT,
  object                                       TEXT,
  rate_card_id                                 TEXT,
  rate_card_version_id                         TEXT,
  tiering_mode                                 TEXT,
  transform_quantity_divide_by                 INTEGER,
  transform_quantity_round                     TEXT,
  unit_amount                                  TEXT
);

-- Smart Retries and dunning outcomes — revenue recovered after a failed subscription payment.
CREATE TABLE recoveries (
  id                                           TEXT,
  amount_due                                   INTEGER,
  amount_paid                                  INTEGER,
  attempt_count                                INTEGER,
  initial_failed_amount                        INTEGER,
  initial_payment_decline_reason               TEXT,
  initial_payment_failed_at                    TEXT,
  next_payment_attempt                         TEXT,
  on_behalf_of_id                              TEXT,
  paid_at                                      TEXT,
  recovered_amount                             INTEGER,
  recovered_at                                 TEXT,
  recovery_method                              TEXT,
  reporting_currency                           TEXT,
  retries_exhausted                            INTEGER,
  retry_attempt_count                          INTEGER,
  source_id                                    TEXT,
  source_type                                  TEXT
);

-- One row per Refund object. Refunds are separate objects from charges; refunding a charge creates a row here and a matching balance transaction.
CREATE TABLE refunds (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  failure_balance_transaction_id               TEXT,
  failure_reason                               TEXT,
  reason                                       TEXT,
  receipt_number                               TEXT,
  refund_description                           TEXT,
  refund_payment_intent                        TEXT,
  refund_transfer_reversal_id                  TEXT,
  source_transfer_reversal_id                  TEXT,
  status                                       TEXT
);

-- Metadata key/value pairs set on refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE refunds_metadata (
  "key"                                        TEXT,
  refund_id                                    TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Double-entry debits and credits produced by Stripe Revenue Recognition, for building deferred revenue and recognized revenue schedules.
CREATE TABLE revenue_recognition_debits_and_credits (
  id                                           TEXT,
  accounting_period_date                       TEXT,
  adjustment_id                                TEXT,
  amount                                       REAL,
  booked_date                                  TEXT,
  charge_id                                    TEXT,
  credit                                       TEXT,
  credit_account_type                          TEXT,
  credit_gl_code                               TEXT,
  credit_note_id                               TEXT,
  currency                                     TEXT,
  customer_balance_transaction_id              TEXT,
  customer_id                                  TEXT,
  debit                                        TEXT,
  debit_account_type                           TEXT,
  debit_gl_code                                TEXT,
  dispute_id                                   TEXT,
  event_type                                   TEXT,
  external_transaction_source                  TEXT,
  invoice_id                                   TEXT,
  invoice_item_id                              TEXT,
  is_accounting_period_open                    INTEGER,
  line_item_id                                 TEXT,
  livemode                                     INTEGER,
  manual_journal_entry_model_id                TEXT,
  original_accounting_period_date              TEXT,
  plan_type                                    TEXT,
  presentment_amount                           REAL,
  presentment_currency                         TEXT,
  price_id                                     TEXT,
  product_id                                   TEXT,
  product_type                                 TEXT,
  refund_id                                    TEXT,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT,
  subscription_type                            TEXT
);


CREATE TABLE revenue_recognition_exclusions (
  transaction_id                               TEXT,
  created_at                                   TEXT,
  deleted_at                                   TEXT
);


CREATE TABLE revenue_recognition_manual_journal_entries (
  id                                           TEXT,
  accounting_period_date                       TEXT,
  created                                      TEXT,
  credit_account                               TEXT,
  credit_account_gl_name                       TEXT,
  debit_account                                TEXT,
  debit_account_gl_name                        TEXT,
  deleted_at                                   TEXT,
  description                                  TEXT,
  email                                        TEXT,
  livemode                                     INTEGER,
  presentment_amount                           REAL,
  presentment_currency                         TEXT,
  settlement_amount                            REAL,
  settlement_currency                          TEXT,
  transaction_id                               TEXT
);


CREATE TABLE revenue_recognition_month_summary (
  id                                           TEXT,
  accounting_period_date                       TEXT,
  billing_interval                             TEXT,
  billing_interval_count                       INTEGER,
  charge_id                                    TEXT,
  credit_note_id                               TEXT,
  customer_balance_transaction_id              TEXT,
  customer_id                                  TEXT,
  dispute_id                                   TEXT,
  external_transaction_source                  TEXT,
  invoice_id                                   TEXT,
  invoice_item_id                              TEXT,
  line_item_id                                 TEXT,
  livemode                                     INTEGER,
  locality_zone                                TEXT,
  month_summary_entry_type                     TEXT,
  plan_id                                      TEXT,
  presentment_currency                         TEXT,
  presentment_net_amount                       INTEGER,
  product_id                                   TEXT,
  refund_id                                    TEXT,
  settlement_currency                          TEXT,
  settlement_net_amount                        INTEGER,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT,
  transaction_type                             TEXT
);

-- Every Radar rule evaluation, including 3DS rules triggered on PaymentIntents and SetupIntents.
CREATE TABLE rule_decisions (
  id                                           TEXT,
  action                                       TEXT,
  batch_timestamp                              TEXT,
  charge_id                                    TEXT,
  created                                      TEXT,
  payment_intent_id                            TEXT,
  rule_id                                      TEXT,
  rule_override_by_allow_rule                  INTEGER,
  setup_intent_id                              TEXT
);

-- Individual attempts to confirm a SetupIntent, including failures.
CREATE TABLE setup_attempts (
  id                                           TEXT,
  application_id                               TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  customer_id                                  TEXT,
  flow_directions                              TEXT,
  on_behalf_of_id                              TEXT,
  payment_method_id                            TEXT,
  setup_error_advice_code                      TEXT,
  setup_error_code                             TEXT,
  setup_error_decline_code                     TEXT,
  setup_error_doc_url                          TEXT,
  setup_error_message                          TEXT,
  setup_error_network_advice_code              TEXT,
  setup_error_network_decline_code             TEXT,
  setup_error_param                            TEXT,
  setup_error_payment_method_id                TEXT,
  setup_error_type                             TEXT,
  setup_intent_id                              TEXT,
  status                                       TEXT,
  usage                                        TEXT
);

-- Attempts to save a payment method for future use without charging it immediately.
CREATE TABLE setup_intents (
  id                                           TEXT,
  application_id                               TEXT,
  batch_timestamp                              TEXT,
  cancellation_reason                          TEXT,
  card_request_three_d_secure                  TEXT,
  created                                      TEXT,
  customer_id                                  TEXT,
  description                                  TEXT,
  flow_directions                              TEXT,
  last_setup_error_advice_code                 TEXT,
  last_setup_error_code                        TEXT,
  last_setup_error_decline_code                TEXT,
  last_setup_error_doc_url                     TEXT,
  last_setup_error_message                     TEXT,
  last_setup_error_network_advice_code         TEXT,
  last_setup_error_network_decline_code        TEXT,
  last_setup_error_param                       TEXT,
  last_setup_error_payment_method_id           TEXT,
  last_setup_error_type                        TEXT,
  latest_attempt_id                            TEXT,
  managed_payments_enabled                     INTEGER,
  mandate_id                                   TEXT,
  on_behalf_of_id                              TEXT,
  payment_method_id                            TEXT,
  payment_method_types                         TEXT,
  single_use_mandate_id                        TEXT,
  status                                       TEXT,
  usage                                        TEXT
);

-- Metadata key/value pairs set on setup_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE setup_intents_metadata (
  "key"                                        TEXT,
  setup_intent_id                              TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Legacy payment sources, superseded by payment_methods. Present for older integrations.
CREATE TABLE sources (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  client_secret                                TEXT,
  code_verification_attempts_remaining         INTEGER,
  code_verification_status                     TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  flow                                         TEXT,
  owner_address_city                           TEXT,
  owner_address_country                        TEXT,
  owner_address_line1                          TEXT,
  owner_address_line2                          TEXT,
  owner_address_postal_code                    TEXT,
  owner_address_state                          TEXT,
  owner_email                                  TEXT,
  owner_name                                   TEXT,
  owner_phone                                  TEXT,
  owner_verified_address_city                  TEXT,
  owner_verified_address_country               TEXT,
  owner_verified_address_line1                 TEXT,
  owner_verified_address_line2                 TEXT,
  owner_verified_address_postal_code           TEXT,
  owner_verified_address_state                 TEXT,
  owner_verified_email                         TEXT,
  owner_verified_name                          TEXT,
  owner_verified_phone                         TEXT,
  receiver_address                             TEXT,
  receiver_amount_charged                      INTEGER,
  receiver_amount_received                     INTEGER,
  receiver_amount_returned                     INTEGER,
  redirect_failure_reason                      TEXT,
  redirect_return_url                          TEXT,
  redirect_status                              TEXT,
  redirect_url                                 TEXT,
  status                                       TEXT,
  "type"                                       TEXT,
  usage                                        TEXT
);

-- Metadata key/value pairs set on sources. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE sources_metadata (
  "key"                                        TEXT,
  source_id                                    TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Pre-computed MRR movement events. Stripe's recommended basis for MRR, churn and expansion reporting — far more reliable than deriving movements from s
CREATE TABLE subscription_item_change_events (
  event_timestamp                              TEXT,
  event_type                                   TEXT,
  subscription_item_id                         TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  local_event_timestamp                        TEXT,
  mrr_change                                   INTEGER,
  price_id                                     TEXT,
  product_id                                   TEXT,
  quantity_change                              INTEGER,
  subscription_id                              TEXT
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
  event_timestamp                              TEXT,
  event_type                                   TEXT,
  subscription_item_id                         TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  local_event_timestamp                        TEXT,
  mrr_change                                   INTEGER,
  price_id                                     TEXT,
  product_id                                   TEXT,
  quantity_change                              INTEGER,
  subscription_id                              TEXT
);

-- Individual priced items on a subscription. A subscription with multiple products has one row per product here.
CREATE TABLE subscription_items (
  id                                           TEXT,
  subscription_id                              TEXT,
  batch_timestamp                              TEXT,
  billing_thresholds_usage_gte                 INTEGER,
  created                                      INTEGER,
  discounts                                    TEXT,
  item_current_period_end                      TEXT,
  item_current_period_start                    TEXT,
  plan_amount                                  INTEGER,
  plan_created                                 TEXT,
  plan_currency                                TEXT,
  plan_id                                      TEXT,
  plan_interval                                TEXT,
  plan_interval_count                          INTEGER,
  plan_nickname                                TEXT,
  plan_product_id                              TEXT,
  plan_trial_period_days                       INTEGER,
  price_created                                TEXT,
  price_currency                               TEXT,
  price_id                                     TEXT,
  price_nickname                               TEXT,
  price_product_id                             TEXT,
  price_recurring_interval                     TEXT,
  price_recurring_interval_count               INTEGER,
  price_recurring_trial_period_days            INTEGER,
  price_unit_amount                            INTEGER,
  quantity                                     INTEGER,
  subscription                                 TEXT
);

-- Metadata key/value pairs set on subscription_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_items_metadata (
  "key"                                        TEXT,
  subscription_id                              TEXT,
  subscription_item_id                         TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- One-off invoice items attached to a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_add_invoice_items (
  phase_id                                     TEXT,
  price                                        TEXT,
  schedule_id                                  TEXT,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  period_end_timestamp                         INTEGER,
  period_end_type                              TEXT,
  period_start_timestamp                       INTEGER,
  period_start_type                            TEXT,
  quantity                                     INTEGER
);


CREATE TABLE subscription_schedule_phase_add_invoice_items_metadata (
  "key"                                        TEXT,
  phase_id                                     TEXT,
  price                                        TEXT,
  schedule_id                                  TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Priced items configured within a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_configuration_items (
  phase_id                                     TEXT,
  price                                        TEXT,
  schedule_id                                  TEXT,
  batch_timestamp                              TEXT,
  billing_thresholds_usage_gte                 INTEGER,
  quantity                                     INTEGER,
  trial_offer_id                               TEXT
);


CREATE TABLE subscription_schedule_phase_configuration_items_metadata (
  "key"                                        TEXT,
  phase_id                                     TEXT,
  price                                        TEXT,
  schedule_id                                  TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Individual phases of a subscription schedule.
CREATE TABLE subscription_schedule_phases (
  id                                           TEXT,
  application_fee_percent                      REAL,
  automatic_tax_enabled                        INTEGER,
  batch_timestamp                              TEXT,
  billing_cycle_anchor                         TEXT,
  billing_thresholds_amount_gte                INTEGER,
  billing_thresholds_reset_billing_cycle_anchor INTEGER,
  collection_method                            TEXT,
  coupon_id                                    TEXT,
  currency                                     TEXT,
  default_payment_method                       TEXT,
  description                                  TEXT,
  end_date                                     TEXT,
  invoice_settings_days_until_due              REAL,
  on_behalf_of                                 TEXT,
  proration_behavior                           TEXT,
  schedule_id                                  TEXT,
  start_date                                   TEXT,
  transfer_data_amount_percent                 REAL,
  transfer_data_destination                    TEXT,
  trial_end                                    INTEGER
);

-- Metadata key/value pairs set on subscription_schedule_phases. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedule_phases_metadata (
  "key"                                        TEXT,
  phase_id                                     TEXT,
  schedule_id                                  TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Planned sequences of subscription phases, used for scheduled price or term changes.
CREATE TABLE subscription_schedules (
  id                                           TEXT,
  application_id                               TEXT,
  batch_timestamp                              TEXT,
  billing_mode_type                            TEXT,
  canceled_at                                  TEXT,
  completed_at                                 TEXT,
  created                                      TEXT,
  customer                                     TEXT,
  default_settings_application_fee_percent     REAL,
  default_settings_automatic_tax_enabled       INTEGER,
  default_settings_billing_cycle_anchor        TEXT,
  default_settings_collection_method           TEXT,
  default_settings_default_payment_method      TEXT,
  default_settings_default_source              TEXT,
  default_settings_description                 TEXT,
  default_settings_invoice_settings_days_until_due REAL,
  default_settings_on_behalf_of                TEXT,
  default_settings_transfer_data_amount_percent REAL,
  default_settings_transfer_data_destination   TEXT,
  end_behavior                                 TEXT,
  proration_discounts                          TEXT,
  released_at                                  TEXT,
  released_subscription                        TEXT,
  renewal_interval                             TEXT,
  renewal_interval_length                      INTEGER,
  subscription                                 TEXT
);

-- Metadata key/value pairs set on subscription_schedules. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedules_metadata (
  "key"                                        TEXT,
  schedule_id                                  TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- One row per Subscription object. The primary Billing table alongside invoices.
CREATE TABLE subscriptions (
  id                                           TEXT,
  application_fee_percent                      REAL,
  application_id                               TEXT,
  automatic_tax_enabled                        INTEGER,
  batch_timestamp                              TEXT,
  billing                                      TEXT,
  billing_cycle_anchor                         TEXT,
  billing_mode_type                            TEXT,
  billing_mode_updated_at                      TEXT,
  billing_thresholds_amount_gte                INTEGER,
  billing_thresholds_reset_billing_cycle_anchor INTEGER,
  cancel_at                                    TEXT,
  cancel_at_period_end                         INTEGER,
  canceled_at                                  TEXT,
  cancellation_details_comment                 TEXT,
  cancellation_details_feedback                TEXT,
  cancellation_details_reason                  TEXT,
  cancellation_reason                          TEXT,
  cancellation_reason_text                     TEXT,
  created                                      TEXT,
  current_period_end                           TEXT,
  current_period_start                         TEXT,
  customer_id                                  TEXT,
  days_until_due                               INTEGER,
  default_payment_method_id                    TEXT,
  default_source_id                            TEXT,
  description                                  TEXT,
  discount_checkout_session                    TEXT,
  discount_coupon_id                           TEXT,
  discount_customer_id                         TEXT,
  discount_end                                 TEXT,
  discount_invoice                             TEXT,
  discount_invoice_item                        TEXT,
  discount_promotion_code_id                   TEXT,
  discount_schedule_id                         TEXT,
  discount_start                               TEXT,
  discount_subscription                        TEXT,
  discount_subscription_item                   TEXT,
  discounts                                    TEXT,
  ended_at                                     TEXT,
  latest_invoice_id                            TEXT,
  managed_payments_enabled                     INTEGER,
  next_pending_invoice_item_invoice            TEXT,
  on_behalf_of_id                              TEXT,
  pause_collection_behavior                    TEXT,
  pause_collection_resumes_at                  TEXT,
  payment_settings_payment_method_options_acss_debit_mandate_options_transaction_type TEXT,
  payment_settings_payment_method_options_acss_debit_verification_method TEXT,
  payment_settings_payment_method_options_bancontact_preferred_language TEXT,
  payment_settings_payment_method_options_card_mandate_options_amount INTEGER,
  payment_settings_payment_method_options_card_mandate_options_amount_type TEXT,
  payment_settings_payment_method_options_card_mandate_options_description TEXT,
  payment_settings_payment_method_options_card_network TEXT,
  payment_settings_payment_method_options_card_request_three_d_secure TEXT,
  payment_settings_payment_method_options_customer_balance_bank_transfer_eu_bank_transfer_country TEXT,
  payment_settings_payment_method_options_customer_balance_bank_transfer_id_bank_transfer_bank TEXT,
  payment_settings_payment_method_options_customer_balance_bank_transfer_type TEXT,
  payment_settings_payment_method_options_customer_balance_funding_type TEXT,
  payment_settings_payment_method_options_us_bank_account_verification_method TEXT,
  payment_settings_save_default_payment_method TEXT,
  pending_invoice_item_interval                TEXT,
  pending_invoice_item_interval_count          INTEGER,
  pending_setup_intent_id                      TEXT,
  pending_update_billing_cycle_anchor          TEXT,
  pending_update_discount_checkout_session     TEXT,
  pending_update_discount_coupon_id            TEXT,
  pending_update_discount_customer_id          TEXT,
  pending_update_discount_end                  TEXT,
  pending_update_discount_invoice              TEXT,
  pending_update_discount_invoice_item         TEXT,
  pending_update_discount_promotion_code_id    TEXT,
  pending_update_discount_schedule_id          TEXT,
  pending_update_discount_start                TEXT,
  pending_update_discount_subscription         TEXT,
  pending_update_discount_subscription_item    TEXT,
  pending_update_expires_at                    TEXT,
  pending_update_trial_end                     TEXT,
  pending_update_trial_from_plan               INTEGER,
  plan_id                                      TEXT,
  price_id                                     TEXT,
  proration_discounts                          TEXT,
  quantity                                     INTEGER,
  schedule_id                                  TEXT,
  "start"                                      TEXT,
  start_date                                   TEXT,
  status                                       TEXT,
  status_details                               TEXT,
  tax_percent                                  REAL,
  transfer_data_amount_percent                 REAL,
  transfer_data_destination_id                 TEXT,
  trial_end                                    TEXT,
  trial_settings_end_behavior_missing_payment_method TEXT,
  trial_start                                  TEXT
);

-- Metadata key/value pairs set on subscriptions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscriptions_metadata (
  "key"                                        TEXT,
  subscription_id                              TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE subscriptions_paid_usage_beta (
  billable_item_source_id                      TEXT,
  billing_meter_id                             TEXT,
  customer_id                                  TEXT,
  start_time                                   TEXT,
  billable_item_type                           TEXT,
  currency                                     TEXT,
  gross_amount                                 INTEGER,
  price_source_id                              TEXT,
  price_type                                   TEXT,
  segment                                      TEXT
);

-- Pre-aggregated balance transaction totals, grouped by period and reporting category. Much cheaper than aggregating balance_transactions yourself.
CREATE TABLE summarized_balance_transactions (
  activity_at_time_bucket                      TEXT,
  auto_payout_id                               TEXT,
  bt_count                                     TEXT,
  bt_effective_at_interval_start               TEXT,
  currency                                     TEXT,
  gross                                        TEXT,
  net                                          TEXT,
  payout_is_auto                               TEXT,
  reporting_category                           TEXT,
  auto_payout_effective_at_interval_start      TEXT,
  fee                                          REAL
);

-- Product categories Stripe Tax uses to determine tax treatment. Contains all generally available tax codes, not just ones you use.
CREATE TABLE tax_codes (
  id                                           TEXT,
  description                                  TEXT,
  name                                         TEXT
);


CREATE TABLE tax_form_filing_statuses (
  tax_form_id                                  TEXT,
  batch_timestamp                              TEXT,
  effective_at                                 TEXT,
  jurisdiction_country                         TEXT,
  jurisdiction_level                           TEXT,
  jurisdiction_state                           TEXT,
  "value"                                      TEXT
);

-- Tax forms (such as 1099s) generated for your connected accounts.
CREATE TABLE tax_forms (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  livemode                                     INTEGER,
  payee_account_id                             TEXT,
  payee_type                                   TEXT,
  "type"                                       TEXT,
  us_1099_k_april_volume                       INTEGER,
  us_1099_k_august_volume                      INTEGER,
  us_1099_k_card_not_present_volume            INTEGER,
  us_1099_k_december_volume                    INTEGER,
  us_1099_k_february_volume                    INTEGER,
  us_1099_k_federal_income_tax_withheld        INTEGER,
  us_1099_k_january_volume                     INTEGER,
  us_1099_k_july_volume                        INTEGER,
  us_1099_k_june_volume                        INTEGER,
  us_1099_k_march_volume                       INTEGER,
  us_1099_k_may_volume                         INTEGER,
  us_1099_k_november_volume                    INTEGER,
  us_1099_k_october_volume                     INTEGER,
  us_1099_k_reporting_year                     INTEGER,
  us_1099_k_september_volume                   INTEGER,
  us_1099_k_state_income_tax_withheld          INTEGER,
  us_1099_k_transactions_count                 INTEGER,
  us_1099_misc_crop_insurance_proceeds         INTEGER,
  us_1099_misc_excess_golden_parachute_payments INTEGER,
  us_1099_misc_federal_income_tax_withheld     INTEGER,
  us_1099_misc_fish_purchased_for_resale       INTEGER,
  us_1099_misc_fishing_boat_proceeds           INTEGER,
  us_1099_misc_medical_and_health_care_payments INTEGER,
  us_1099_misc_non_qualified_deferred_compensation INTEGER,
  us_1099_misc_other_income                    INTEGER,
  us_1099_misc_payments_in_lieu_of_dividends_or_interest INTEGER,
  us_1099_misc_payments_to_attorney            INTEGER,
  us_1099_misc_rents                           INTEGER,
  us_1099_misc_reporting_year                  INTEGER,
  us_1099_misc_royalties                       INTEGER,
  us_1099_misc_section_409a_deferrals          INTEGER,
  us_1099_misc_state_income                    INTEGER,
  us_1099_misc_state_tax_withheld              INTEGER,
  us_1099_nec_federal_income_tax_withheld      INTEGER,
  us_1099_nec_nonemployee_compensation         INTEGER,
  us_1099_nec_reporting_year                   INTEGER,
  us_1099_nec_state_income                     INTEGER,
  us_1099_nec_state_income_tax_withheld        INTEGER
);

-- Manually defined tax rates used on invoices and subscriptions. Distinct from Stripe Tax's automatic calculations.
CREATE TABLE tax_rates (
  id                                           TEXT,
  active                                       INTEGER,
  batch_timestamp                              TEXT,
  country                                      TEXT,
  created                                      TEXT,
  description                                  TEXT,
  display_name                                 TEXT,
  effective_percentage                         REAL,
  inclusive                                    INTEGER,
  jurisdiction                                 TEXT,
  jurisdiction_level                           TEXT,
  percentage                                   REAL,
  state                                        TEXT,
  tax_type                                     TEXT
);

-- Metadata key/value pairs set on tax_rates. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_rates_metadata (
  "key"                                        TEXT,
  tax_rate_id                                  TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE tax_transaction_customer_tax_ids (
  tax_transaction_id                           TEXT,
  "type"                                       TEXT,
  country                                      TEXT,
  "value"                                      TEXT
);

-- Per-jurisdiction breakdown of the tax liability for a tax transaction item.
CREATE TABLE tax_transaction_jurisdiction_details (
  tax_transaction_id                           TEXT,
  tax_transaction_item_id                      TEXT,
  amount_non_taxable                           INTEGER,
  amount_tax                                   INTEGER,
  amount_taxable                               INTEGER,
  currency                                     TEXT,
  filing_amount_non_taxable                    INTEGER,
  filing_amount_tax                            INTEGER,
  filing_amount_taxable                        INTEGER,
  filing_currency                              TEXT,
  filing_exchange_rate                         REAL,
  jurisdiction_country                         TEXT,
  jurisdiction_id                              TEXT,
  jurisdiction_level                           TEXT,
  jurisdiction_name                            TEXT,
  jurisdiction_state                           TEXT,
  tax_rate_percentage                          REAL,
  tax_transaction_item_type                    TEXT,
  tax_type                                     TEXT,
  tax_type_display_name                        TEXT,
  taxability                                   TEXT,
  taxability_reason                            TEXT
);

-- Line items contributing to the sale of goods for a tax transaction.
CREATE TABLE tax_transaction_line_items (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_tax                                   INTEGER,
  currency                                     TEXT,
  determined_destination_address_city          TEXT,
  determined_destination_address_country       TEXT,
  determined_destination_address_line1         TEXT,
  determined_destination_address_line2         TEXT,
  determined_destination_address_postal_code   TEXT,
  determined_destination_address_state         TEXT,
  determined_origin_address_city               TEXT,
  determined_origin_address_country            TEXT,
  determined_origin_address_line1              TEXT,
  determined_origin_address_line2              TEXT,
  determined_origin_address_postal_code        TEXT,
  determined_origin_address_state              TEXT,
  determined_tax_location_address_city         TEXT,
  determined_tax_location_address_country      TEXT,
  determined_tax_location_address_line1        TEXT,
  determined_tax_location_address_line2        TEXT,
  determined_tax_location_address_postal_code  TEXT,
  determined_tax_location_address_state        TEXT,
  product_id                                   TEXT,
  quantity_decimal                             TEXT,
  reference                                    TEXT,
  reversal_original_tax_transaction_line_item_id TEXT,
  source_line_item_id                          TEXT,
  tax_behavior                                 TEXT,
  tax_code                                     TEXT,
  tax_transaction_id                           TEXT
);

-- Metadata key/value pairs set on tax_transaction_line_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transaction_line_items_metadata (
  "key"                                        TEXT,
  tax_transaction_line_item_id                 TEXT,
  "value"                                      TEXT
);

-- Shipping costs contributing to a tax transaction. Structurally parallel to tax_transaction_line_items.
CREATE TABLE tax_transaction_shipping_costs (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_tax                                   INTEGER,
  currency                                     TEXT,
  determined_destination_address_city          TEXT,
  determined_destination_address_country       TEXT,
  determined_destination_address_line1         TEXT,
  determined_destination_address_line2         TEXT,
  determined_destination_address_postal_code   TEXT,
  determined_destination_address_state         TEXT,
  determined_origin_address_city               TEXT,
  determined_origin_address_country            TEXT,
  determined_origin_address_line1              TEXT,
  determined_origin_address_line2              TEXT,
  determined_origin_address_postal_code        TEXT,
  determined_origin_address_state              TEXT,
  determined_tax_location_address_city         TEXT,
  determined_tax_location_address_country      TEXT,
  determined_tax_location_address_line1        TEXT,
  determined_tax_location_address_line2        TEXT,
  determined_tax_location_address_postal_code  TEXT,
  determined_tax_location_address_state        TEXT,
  shipping_rate_id                             TEXT,
  tax_behavior                                 TEXT,
  tax_code                                     TEXT,
  tax_transaction_id                           TEXT
);

-- Records of assumed or reduced tax liability. The recommended starting point for tax reporting, and the bridge between tax tables and invoices or check
CREATE TABLE tax_transactions (
  id                                           TEXT,
  created                                      TEXT,
  customer_details_address_city                TEXT,
  customer_details_address_country             TEXT,
  customer_details_address_line1               TEXT,
  customer_details_address_line2               TEXT,
  customer_details_address_postal_code         TEXT,
  customer_details_address_source              TEXT,
  customer_details_address_state               TEXT,
  customer_details_ip_address                  TEXT,
  customer_details_taxability_override         TEXT,
  customer_id                                  TEXT,
  posted_at                                    TEXT,
  provider                                     TEXT,
  reference                                    TEXT,
  reversal_original_tax_transaction_id         TEXT,
  source_id                                    TEXT,
  source_type                                  TEXT,
  tax_date                                     TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on tax_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transactions_metadata (
  "key"                                        TEXT,
  tax_transaction_id                           TEXT,
  "value"                                      TEXT
);

-- Line items on a Terminal hardware order.
CREATE TABLE terminal_hardware_order_items (
  terminal_hardware_order_id                   TEXT,
  terminal_hardware_sku_id                     TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  currency                                     TEXT,
  quantity                                     INTEGER,
  terminal_hardware_sku_amount                 INTEGER,
  terminal_hardware_sku_country                TEXT,
  terminal_hardware_sku_currency               TEXT,
  terminal_hardware_sku_product_id             TEXT,
  terminal_hardware_sku_product_type           TEXT
);

-- Metadata key/value pairs set on terminal_hardware_orders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE terminal_hardware_order_metadata (
  "key"                                        TEXT,
  terminal_hardware_order_id                   TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Shipment tracking information for Terminal hardware orders.
CREATE TABLE terminal_hardware_order_shipment_tracking (
  carrier                                      TEXT,
  terminal_hardware_order_id                   TEXT,
  tracking_number                              TEXT,
  batch_timestamp                              TEXT
);

-- Tax applied to a Terminal hardware order.
CREATE TABLE terminal_hardware_order_tax_amounts (
  rate_display_name                            TEXT,
  rate_jurisdiction                            TEXT,
  terminal_hardware_order_id                   TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  inclusive                                    INTEGER,
  rate_percentage                              REAL
);

-- Orders you placed for Terminal reader hardware.
CREATE TABLE terminal_hardware_orders (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  livemode                                     INTEGER,
  payment_type                                 TEXT,
  po_number                                    TEXT,
  shipping_address_city                        TEXT,
  shipping_address_country                     TEXT,
  shipping_address_line1                       TEXT,
  shipping_address_line2                       TEXT,
  shipping_address_postal_code                 TEXT,
  shipping_address_state                       TEXT,
  shipping_amount                              INTEGER,
  shipping_company                             TEXT,
  shipping_currency                            TEXT,
  shipping_email                               TEXT,
  shipping_method_name                         TEXT,
  shipping_name                                TEXT,
  shipping_phone                               TEXT,
  status                                       TEXT,
  tax                                          INTEGER,
  updated                                      TEXT
);

-- Physical locations where you operate Terminal card readers.
CREATE TABLE terminal_locations (
  address_city                                 TEXT,
  address_country                              TEXT,
  address_kana_city                            TEXT,
  address_kana_country                         TEXT,
  address_kana_line1                           TEXT,
  address_kana_line2                           TEXT,
  address_kana_postal_code                     TEXT,
  address_kana_state                           TEXT,
  address_kana_town                            TEXT,
  address_kanji_city                           TEXT,
  address_kanji_country                        TEXT,
  address_kanji_line1                          TEXT,
  address_kanji_line2                          TEXT,
  address_kanji_postal_code                    TEXT,
  address_kanji_state                          TEXT,
  address_kanji_town                           TEXT,
  address_line1                                TEXT,
  address_line2                                TEXT,
  address_postal_code                          TEXT,
  address_state                                TEXT,
  id                                           TEXT,
  livemode                                     INTEGER,
  metadata                                     TEXT,
  name                                         TEXT,
  name_kana                                    TEXT,
  name_kanji                                   TEXT,
  phone                                        TEXT,
  zone_id                                      TEXT
);

-- Terminal card reader devices registered to your account.
CREATE TABLE terminal_readers (
  device_type                                  TEXT,
  id                                           TEXT,
  label                                        TEXT,
  livemode                                     INTEGER,
  location_id                                  TEXT,
  metadata                                     TEXT,
  serial_number                                TEXT
);


CREATE TABLE topups (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_transaction                          TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failure_code                                 TEXT,
  failure_message                              TEXT,
  initiated_by                                 TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  transfer_group                               TEXT
);


CREATE TABLE topups_metadata (
  "key"                                        TEXT,
  topup_id                                     TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Reversals of manually created transfers or payouts. Automatic payouts cannot be reversed.
CREATE TABLE transfer_reversals (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  destination_payment_refund_id                TEXT,
  source_refund_id                             TEXT,
  transfer_id                                  TEXT
);

-- Metadata key/value pairs set on transfer_reversals. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfer_reversals_metadata (
  "key"                                        TEXT,
  transfer_reversal_id                         TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Payouts from your Stripe balance to your bank account, and — for Connect platforms — transfers of funds to connected accounts.
CREATE TABLE transfers (
  id                                           TEXT,
  amount                                       INTEGER,
  amount_reversed                              INTEGER,
  application_fee_amount                       INTEGER,
  application_fee_id                           TEXT,
  automatic                                    INTEGER,
  balance_transaction_id                       TEXT,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  "date"                                       TEXT,
  description                                  TEXT,
  destination_id                               TEXT,
  destination_payment_id                       TEXT,
  failure_code                                 TEXT,
  failure_message                              TEXT,
  kind                                         TEXT,
  original_payout                              TEXT,
  payout_method                                TEXT,
  reversed                                     INTEGER,
  reversed_by                                  TEXT,
  source_transaction_id                        TEXT,
  source_type                                  TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  trace_id                                     TEXT,
  trace_id_status                              TEXT,
  transfer_group                               TEXT,
  transfer_instruction                         TEXT,
  "type"                                       TEXT
);

-- Metadata key/value pairs set on transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfers_metadata (
  "key"                                        TEXT,
  transfer_id                                  TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE treasury_credit_reversals (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  financial_account_id                         TEXT,
  network                                      TEXT,
  received_credit_id                           TEXT,
  status                                       TEXT,
  status_transitions_posted_at                 TEXT,
  transaction_id                               TEXT
);


CREATE TABLE treasury_credit_reversals_metadata (
  credit_reversal_id                           TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE treasury_debit_reversals (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  financial_account_id                         TEXT,
  linked_flows_issuing_dispute_id              TEXT,
  network                                      TEXT,
  received_debit_id                            TEXT,
  status                                       TEXT,
  status_transitions_completed_at              TEXT,
  transaction_id                               TEXT
);


CREATE TABLE treasury_debit_reversals_metadata (
  debit_reversal_id                            TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Treasury financial accounts that store funds for your platform's users.
CREATE TABLE treasury_financial_accounts (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  country                                      TEXT,
  created                                      TEXT,
  status                                       TEXT,
  status_details_closed_reasons                TEXT
);

-- Metadata key/value pairs set on treasury_financial_accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_financial_accounts_metadata (
  financial_account_id                         TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Money pulled into a Treasury financial account from an external bank account.
CREATE TABLE treasury_inbound_transfers (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  cancelable                                   INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failure_details_code                         TEXT,
  financial_account_id                         TEXT,
  linked_flows_received_debit_id               TEXT,
  origin_payment_method_details_us_bank_account_network TEXT,
  origin_payment_method_id                     TEXT,
  returned                                     INTEGER,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  status_transitions_canceled_at               TEXT,
  status_transitions_failed_at                 TEXT,
  status_transitions_succeeded_at              TEXT,
  transaction_id                               TEXT
);

-- Metadata key/value pairs set on treasury_inbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_inbound_transfers_metadata (
  inbound_transfer_id                          TEXT,
  "key"                                        TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Money sent from a Treasury financial account to a third party.
CREATE TABLE treasury_outbound_payments (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  cancelable                                   INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  customer_id                                  TEXT,
  description                                  TEXT,
  destination_payment_method_details_financial_account_id TEXT,
  destination_payment_method_details_type      TEXT,
  destination_payment_method_details_us_bank_account_network TEXT,
  destination_payment_method_id                TEXT,
  end_user_details_ip_address                  TEXT,
  end_user_details_present                     INTEGER,
  expected_arrival_date                        TEXT,
  financial_account_id                         TEXT,
  returned_details_code                        TEXT,
  returned_details_transaction_id              TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  status_transitions_canceled_at               TEXT,
  status_transitions_failed_at                 TEXT,
  status_transitions_posted_at                 TEXT,
  status_transitions_returned_at               TEXT,
  tracking_details_ach_trace_id                TEXT,
  tracking_details_us_domestic_wire_imad       TEXT,
  tracking_details_us_domestic_wire_omad       TEXT,
  transaction_id                               TEXT
);

-- Metadata key/value pairs set on treasury_outbound_payments. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_payments_metadata (
  "key"                                        TEXT,
  outbound_payment_id                          TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);

-- Money sent from a Treasury financial account to an external bank account you own.
CREATE TABLE treasury_outbound_transfers (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  cancelable                                   INTEGER,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  destination_payment_method_details_type      TEXT,
  destination_payment_method_details_us_bank_account_ach_submission TEXT,
  destination_payment_method_details_us_bank_account_network TEXT,
  destination_payment_method_id                TEXT,
  expected_arrival_date                        TEXT,
  financial_account_id                         TEXT,
  returned_details_code                        TEXT,
  returned_details_transaction_id              TEXT,
  statement_descriptor                         TEXT,
  status                                       TEXT,
  status_transitions_canceled_at               TEXT,
  status_transitions_failed_at                 TEXT,
  status_transitions_posted_at                 TEXT,
  status_transitions_returned_at               TEXT,
  tracking_details_ach_trace_id                TEXT,
  tracking_details_us_domestic_wire_imad       TEXT,
  tracking_details_us_domestic_wire_omad       TEXT,
  transaction_id                               TEXT
);

-- Metadata key/value pairs set on treasury_outbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_transfers_metadata (
  "key"                                        TEXT,
  outbound_transfer_id                         TEXT,
  batch_timestamp                              TEXT,
  "value"                                      TEXT
);


CREATE TABLE treasury_received_credits (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failure_code                                 TEXT,
  financial_account_id                         TEXT,
  initiating_payment_method_details_financial_account_id TEXT,
  initiating_payment_method_details_issuing_card_id TEXT,
  initiating_payment_method_details_type       TEXT,
  initiating_payment_method_details_us_bank_account_last_4 TEXT,
  initiating_payment_method_details_us_bank_account_routing_number TEXT,
  linked_flows_credit_reversal_id              TEXT,
  linked_flows_issuing_authorization_id        TEXT,
  linked_flows_issuing_transaction_id          TEXT,
  linked_flows_source_flow_id                  TEXT,
  linked_flows_source_flow_type                TEXT,
  network                                      TEXT,
  reversal_details_deadline                    TEXT,
  reversal_details_restricted_reason           TEXT,
  status                                       TEXT,
  transaction_id                               TEXT
);


CREATE TABLE treasury_received_debits (
  id                                           TEXT,
  amount                                       INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  failure_code                                 TEXT,
  financial_account_id                         TEXT,
  initiating_payment_method_details_financial_account_id TEXT,
  initiating_payment_method_details_issuing_card_id TEXT,
  initiating_payment_method_details_type       TEXT,
  initiating_payment_method_details_us_bank_account_last_4 TEXT,
  initiating_payment_method_details_us_bank_account_routing_number TEXT,
  linked_flows_debit_reversal_id               TEXT,
  linked_flows_inbound_transfer_id             TEXT,
  linked_flows_issuing_authorization_id        TEXT,
  linked_flows_issuing_transaction_id          TEXT,
  linked_flows_payout_id                       TEXT,
  network                                      TEXT,
  reversal_details_deadline                    TEXT,
  reversal_details_restricted_reason           TEXT,
  status                                       TEXT,
  transaction_id                               TEXT
);

-- Individual ledger entries making up a Treasury transaction.
CREATE TABLE treasury_transaction_entries (
  id                                           TEXT,
  balance_impact_cash                          INTEGER,
  balance_impact_inbound_pending               INTEGER,
  balance_impact_outbound_pending              INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  effective_at                                 TEXT,
  financial_account_id                         TEXT,
  flow_id                                      TEXT,
  flow_type                                    TEXT,
  transaction_id                               TEXT,
  "type"                                       TEXT
);

-- Ledger of all money movement on Treasury financial accounts.
CREATE TABLE treasury_transactions (
  id                                           TEXT,
  amount                                       INTEGER,
  balance_impact_cash                          INTEGER,
  balance_impact_inbound_pending               INTEGER,
  balance_impact_outbound_pending              INTEGER,
  batch_timestamp                              TEXT,
  created                                      TEXT,
  currency                                     TEXT,
  description                                  TEXT,
  financial_account_id                         TEXT,
  flow_id                                      TEXT,
  flow_type                                    TEXT,
  status                                       TEXT,
  status_transitions_posted_at                 TEXT,
  status_transitions_void_at                   TEXT
);

-- Reported usage quantities for metered subscription items. Legacy path; newer integrations use billing meters.
CREATE TABLE usage_records (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  quantity                                     INTEGER,
  subscription_item                            TEXT,
  timestamp                                    TEXT
);


CREATE TABLE verification_reports (
  id                                           TEXT,
  address_error_code                           TEXT,
  address_status                               TEXT,
  batch_timestamp                              TEXT,
  client_reference_id                          TEXT,
  created                                      TEXT,
  document_error_code                          TEXT,
  document_error_reason                        TEXT,
  document_files                               TEXT,
  document_issuing_country                     TEXT,
  document_status                              TEXT,
  document_type                                TEXT,
  email_error_code                             TEXT,
  email_error_reason                           TEXT,
  email_status                                 TEXT,
  id_number_error_code                         TEXT,
  id_number_error_reason                       TEXT,
  id_number_status                             TEXT,
  matching_error_code                          TEXT,
  matching_status                              TEXT,
  options_document_allowed_types               TEXT,
  options_document_require_id_number           INTEGER,
  options_document_require_live_capture        INTEGER,
  options_document_require_matching_selfie     INTEGER,
  options_email_require_verification           INTEGER,
  options_phone_require_verification           INTEGER,
  phone_error_code                             TEXT,
  phone_error_reason                           TEXT,
  phone_otp_error_code                         TEXT,
  phone_otp_status                             TEXT,
  phone_records_error_code                     TEXT,
  phone_records_status                         TEXT,
  phone_status                                 TEXT,
  selfie_document_file                         TEXT,
  selfie_error_code                            TEXT,
  selfie_error_reason                          TEXT,
  selfie_file                                  TEXT,
  selfie_status                                TEXT,
  tax_id_error_code                            TEXT,
  tax_id_status                                TEXT,
  "type"                                       TEXT,
  verification_flow_id                         TEXT,
  verification_session_id                      TEXT
);


CREATE TABLE verification_sessions (
  id                                           TEXT,
  batch_timestamp                              TEXT,
  client_reference_id                          TEXT,
  created                                      TEXT,
  last_verification_report_id                  TEXT,
  options_document_allowed_types               TEXT,
  options_document_require_id_number           INTEGER,
  options_document_require_live_capture        INTEGER,
  options_document_require_matching_selfie     INTEGER,
  options_email_require_verification           INTEGER,
  options_matching_dob                         TEXT,
  options_matching_name                        TEXT,
  options_phone_require_verification           INTEGER,
  provided_details_email                       TEXT,
  provided_details_phone                       TEXT,
  redaction_status                             TEXT,
  related_customer_account_id                  TEXT,
  related_customer_id                          TEXT,
  related_person_account_id                    TEXT,
  related_person_id                            TEXT,
  started_at                                   TEXT,
  status                                       TEXT,
  submitted_at                                 TEXT,
  "type"                                       TEXT,
  verification_flow_id                         TEXT,
  verified_at                                  TEXT,
  visited_at                                   TEXT
);

