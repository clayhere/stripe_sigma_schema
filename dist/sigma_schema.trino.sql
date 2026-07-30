-- Stripe Sigma schema as Trino DDL
-- Generated from sigma_schema.json v1.0.0 by tools/emit_artifacts.py
-- Sigma itself is read-only; this DDL exists for tooling, docs and local sandboxes.
-- Columns marked (?) are unverified - see the confidence field in sigma_schema.json.


CREATE TABLE acceptance_reporting_preaggregated_deduplicated_v2 (
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  attributable_optimization                    VARCHAR,
  blocked_by_default_high_risk_rule_count      BIGINT,
  blocked_by_radar_rule_count                  BIGINT,
  blocked_by_stripe_count                      BIGINT,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  created_day                                  TIMESTAMP,
  currency                                     VARCHAR,
  is_connected_account                         BOOLEAN,
  outcome_reason                               VARCHAR,
  outcome_rule_id                              VARCHAR,
  outcome_type                                 VARCHAR,
  transaction_amount                           BIGINT,
  transaction_amount_in_usd                    BIGINT,
  transaction_count                            BIGINT
);


CREATE TABLE acceptance_reporting_preaggregated_deduplicated_v3 (
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  attributable_optimization                    VARCHAR,
  blocked_by_default_high_risk_rule_count      BIGINT,
  blocked_by_radar_rule_count                  BIGINT,
  blocked_by_stripe_count                      BIGINT,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  cof                                          BOOLEAN,
  created_day                                  TIMESTAMP,
  currency                                     VARCHAR,
  is_connected_account                         BOOLEAN,
  nsf_count                                    BIGINT,
  outcome_reason                               VARCHAR,
  outcome_rule_id                              VARCHAR,
  outcome_type                                 VARCHAR,
  transaction_amount                           BIGINT,
  transaction_amount_in_usd                    BIGINT,
  transaction_count                            BIGINT,
  used_network_tokens                          BOOLEAN
);


CREATE TABLE acceptance_reporting_preaggregated_v2 (
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  attributable_optimization                    VARCHAR,
  blocked_by_default_high_risk_rule_count      BIGINT,
  blocked_by_radar_rule_count                  BIGINT,
  blocked_by_stripe_count                      BIGINT,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  created_day                                  TIMESTAMP,
  currency                                     VARCHAR,
  is_connected_account                         BOOLEAN,
  outcome_reason                               VARCHAR,
  outcome_rule_id                              VARCHAR,
  outcome_type                                 VARCHAR,
  transaction_amount                           BIGINT,
  transaction_amount_in_usd                    BIGINT,
  transaction_count                            BIGINT
);


CREATE TABLE acceptance_reporting_preaggregated_v3 (
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  attributable_optimization                    VARCHAR,
  blocked_by_default_high_risk_rule_count      BIGINT,
  blocked_by_radar_rule_count                  BIGINT,
  blocked_by_stripe_count                      BIGINT,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  cof                                          BOOLEAN,
  created_day                                  TIMESTAMP,
  currency                                     VARCHAR,
  is_connected_account                         BOOLEAN,
  nsf_count                                    BIGINT,
  outcome_reason                               VARCHAR,
  outcome_rule_id                              VARCHAR,
  outcome_type                                 VARCHAR,
  transaction_amount                           BIGINT,
  transaction_amount_in_usd                    BIGINT,
  transaction_count                            BIGINT,
  used_network_tokens                          BOOLEAN
);

-- Itemized payment acceptance reporting: authorization attempts with decline and retry classification.
CREATE TABLE acceptance_reporting_v3_itemized (
  amount                                       BIGINT,
  amount_in_usd                                BIGINT,
  attributable_optimization                    VARCHAR,
  blocked_reason                               VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  charge_id                                    VARCHAR,
  cof                                          BOOLEAN,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  decline_reason                               VARCHAR,
  final_charge_id                              VARCHAR,
  gateway_conversation_avs_outcome             VARCHAR,
  gateway_conversation_cvc_outcome             VARCHAR,
  id                                           VARCHAR,
  invoice_id                                   VARCHAR,
  is_connected_account                         BOOLEAN,
  is_final_attempt                             BOOLEAN,
  outcome_type                                 VARCHAR,
  payment_intent_id                            VARCHAR,
  tds_flow_type                                VARCHAR,
  tds_is_in_sca_scope                          BOOLEAN,
  tds_outcome                                  VARCHAR,
  tds_outcome_type                             VARCHAR,
  tds_reason                                   VARCHAR,
  tds_sca_exemption_type                       VARCHAR,
  tds_triggered                                BOOLEAN,
  transaction_initiator                        VARCHAR,
  used_network_tokens                          BOOLEAN
);


CREATE TABLE account_capabilities_v2 (
  account_id                                   VARCHAR,
  acss_debit_payments                          VARCHAR,
  affirm_payments                              VARCHAR,
  afterpay_clearpay_payments                   VARCHAR,
  amazon_pay_payments                          VARCHAR,
  au_becs_debit_payments                       VARCHAR,
  bacs_debit_payments                          VARCHAR,
  bancontact_payments                          VARCHAR,
  bank_transfer_payments                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  blik_payments                                VARCHAR,
  boleto_payments                              VARCHAR,
  card_issuing                                 VARCHAR,
  card_payments                                VARCHAR,
  cartes_bancaires_payments                    VARCHAR,
  cashapp_payments                             VARCHAR,
  eps_payments                                 VARCHAR,
  fpx_payments                                 VARCHAR,
  giropay_payments                             VARCHAR,
  grabpay_payments                             VARCHAR,
  ideal_payments                               VARCHAR,
  india_international_payments                 VARCHAR,
  jcb_payments                                 VARCHAR,
  klarna_payments                              VARCHAR,
  konbini_payments                             VARCHAR,
  legacy_payments                              VARCHAR,
  link_payments                                VARCHAR,
  mobilepay_payments                           VARCHAR,
  multibanco_payments                          VARCHAR,
  oxxo_payments                                VARCHAR,
  p24_payments                                 VARCHAR,
  paynow_payments                              VARCHAR,
  promptpay_payments                           VARCHAR,
  revolut_pay_payments                         VARCHAR,
  sepa_debit_payments                          VARCHAR,
  sofort_payments                              VARCHAR,
  swish_payments                               VARCHAR,
  tax_reporting_us_1099_k                      VARCHAR,
  tax_reporting_us_1099_misc                   VARCHAR,
  transfers                                    VARCHAR,
  twint_payments                               VARCHAR,
  us_bank_account_ach_payments                 VARCHAR,
  zip_payments                                 VARCHAR
);

-- Your own account and, for Connect platforms, your connected accounts.
CREATE TABLE accounts (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  business_name                                VARCHAR,
  business_profile_mcc                         VARCHAR,
  business_url                                 VARCHAR,
  capabilities_acss_debit_payments             VARCHAR,
  capabilities_affirm_payments                 VARCHAR,
  capabilities_afterpay_clearpay_payments      VARCHAR,
  capabilities_amazon_pay_payments             VARCHAR,
  capabilities_au_becs_debit_payments          VARCHAR,
  capabilities_bacs_debit_payments             VARCHAR,
  capabilities_bancontact_payments             VARCHAR,
  capabilities_bank_transfer_payments          VARCHAR,
  capabilities_blik_payments                   VARCHAR,
  capabilities_boleto_payments                 VARCHAR,
  capabilities_card_issuing                    VARCHAR,
  capabilities_card_payments                   VARCHAR,
  capabilities_cartes_bancaires_payments       VARCHAR,
  capabilities_cashapp_payments                VARCHAR,
  capabilities_eps_payments                    VARCHAR,
  capabilities_fpx_payments                    VARCHAR,
  capabilities_giropay_payments                VARCHAR,
  capabilities_grabpay_payments                VARCHAR,
  capabilities_ideal_payments                  VARCHAR,
  capabilities_india_international_payments    VARCHAR,
  capabilities_jcb_payments                    VARCHAR,
  capabilities_klarna_payments                 VARCHAR,
  capabilities_konbini_payments                VARCHAR,
  capabilities_legacy_payments                 VARCHAR,
  capabilities_link_payments                   VARCHAR,
  capabilities_mobilepay_payments              VARCHAR,
  capabilities_multibanco_payments             VARCHAR,
  capabilities_oxxo_payments                   VARCHAR,
  capabilities_p24_payments                    VARCHAR,
  capabilities_paynow_payments                 VARCHAR,
  capabilities_promptpay_payments              VARCHAR,
  capabilities_revolut_pay_payments            VARCHAR,
  capabilities_sepa_debit_payments             VARCHAR,
  capabilities_sofort_payments                 VARCHAR,
  capabilities_swish_payments                  VARCHAR,
  capabilities_tax_reporting_us_1099_k         VARCHAR,
  capabilities_tax_reporting_us_1099_misc      VARCHAR,
  capabilities_transfers                       VARCHAR,
  capabilities_twint_payments                  VARCHAR,
  capabilities_us_bank_account_ach_payments    VARCHAR,
  capabilities_zip_payments                    VARCHAR,
  charges_enabled                              BOOLEAN,
  controller_fees_payer                        VARCHAR,
  controller_losses_payments                   VARCHAR,
  controller_requirement_collection            VARCHAR,
  controller_stripe_dashboard_type             VARCHAR,
  country                                      VARCHAR,
  created                                      TIMESTAMP,
  debit_negative_balances                      BOOLEAN,
  decline_charge_on_avs_failure                BOOLEAN,
  decline_charge_on_cvc_failure                BOOLEAN,
  default_currency                             VARCHAR,
  details_submitted                            BOOLEAN,
  display_name                                 VARCHAR,
  email                                        VARCHAR,
  future_requirements_current_deadline         TIMESTAMP,
  future_requirements_currently_due            VARCHAR,
  future_requirements_eventually_due           VARCHAR,
  future_requirements_past_due                 VARCHAR,
  future_requirements_pending_verification     VARCHAR,
  legal_entity_address_city                    VARCHAR,
  legal_entity_address_country                 VARCHAR,
  legal_entity_address_kana_city               VARCHAR,
  legal_entity_address_kana_country            VARCHAR,
  legal_entity_address_kana_line1              VARCHAR,
  legal_entity_address_kana_line2              VARCHAR,
  legal_entity_address_kana_postal_code        VARCHAR,
  legal_entity_address_kana_state              VARCHAR,
  legal_entity_address_kanji_city              VARCHAR,
  legal_entity_address_kanji_country           VARCHAR,
  legal_entity_address_kanji_line1             VARCHAR,
  legal_entity_address_kanji_line2             VARCHAR,
  legal_entity_address_kanji_postal_code       VARCHAR,
  legal_entity_address_kanji_state             VARCHAR,
  legal_entity_address_line1                   VARCHAR,
  legal_entity_address_line2                   VARCHAR,
  legal_entity_address_postal_code             VARCHAR,
  legal_entity_address_state                   VARCHAR,
  legal_entity_business_name                   VARCHAR,
  legal_entity_business_name_kana              VARCHAR,
  legal_entity_business_name_kanji             VARCHAR,
  legal_entity_business_tax_id_provided        BOOLEAN,
  legal_entity_business_vat_id_provided        BOOLEAN,
  legal_entity_dob_day                         BIGINT,
  legal_entity_dob_month                       BIGINT,
  legal_entity_dob_year                        BIGINT,
  legal_entity_first_name                      VARCHAR,
  legal_entity_first_name_kana                 VARCHAR,
  legal_entity_first_name_kanji                VARCHAR,
  legal_entity_gender                          VARCHAR,
  legal_entity_last_name                       VARCHAR,
  legal_entity_last_name_kana                  VARCHAR,
  legal_entity_last_name_kanji                 VARCHAR,
  legal_entity_maiden_name                     VARCHAR,
  legal_entity_personal_address_city           VARCHAR,
  legal_entity_personal_address_country        VARCHAR,
  legal_entity_personal_address_kana_city      VARCHAR,
  legal_entity_personal_address_kana_country   VARCHAR,
  legal_entity_personal_address_kana_line1     VARCHAR,
  legal_entity_personal_address_kana_line2     VARCHAR,
  legal_entity_personal_address_kana_postal_code VARCHAR,
  legal_entity_personal_address_kana_state     VARCHAR,
  legal_entity_personal_address_kanji_city     VARCHAR,
  legal_entity_personal_address_kanji_country  VARCHAR,
  legal_entity_personal_address_kanji_line1    VARCHAR,
  legal_entity_personal_address_kanji_line2    VARCHAR,
  legal_entity_personal_address_kanji_postal_code VARCHAR,
  legal_entity_personal_address_kanji_state    VARCHAR,
  legal_entity_personal_address_line1          VARCHAR,
  legal_entity_personal_address_line2          VARCHAR,
  legal_entity_personal_address_postal_code    VARCHAR,
  legal_entity_personal_address_state          VARCHAR,
  legal_entity_personal_id_number_provided     BOOLEAN,
  legal_entity_phone_number                    VARCHAR,
  legal_entity_ssn_last_4_provided             BOOLEAN,
  legal_entity_tax_id_registrar                VARCHAR,
  legal_entity_type                            VARCHAR,
  legal_entity_verification_details            VARCHAR,
  legal_entity_verification_details_code       VARCHAR,
  legal_entity_verification_document_id        VARCHAR,
  legal_entity_verification_status             VARCHAR,
  payout_schedule_delay_days                   BIGINT,
  payout_schedule_interval                     VARCHAR,
  payout_schedule_monthly_anchor               BIGINT,
  payout_schedule_weekly_anchor                VARCHAR,
  payout_statement_descriptor                  VARCHAR,
  payouts_enabled                              BOOLEAN,
  product_description                          VARCHAR,
  requirements_current_deadline                TIMESTAMP,
  requirements_currently_due                   VARCHAR,
  requirements_eventually_due                  VARCHAR,
  requirements_past_due                        VARCHAR,
  requirements_pending_verification            VARCHAR,
  statement_descriptor                         VARCHAR,
  support_email                                VARCHAR,
  support_phone                                VARCHAR,
  timezone                                     VARCHAR,
  tos_acceptance_date                          TIMESTAMP,
  tos_acceptance_ip                            VARCHAR,
  tos_acceptance_user_agent                    VARCHAR,
  "type"                                       VARCHAR,
  verification_disabled_reason                 VARCHAR,
  verification_due_by                          TIMESTAMP,
  verification_fields_needed                   VARCHAR
);

-- Metadata key/value pairs set on accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE accounts_metadata (
  account_id                                   VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- activity_report_itemized: no column detail published; see sigma_schema.json

-- Aggregated view of Stripe's payment optimizations (such as Adaptive Acceptance) and their measured impact.
CREATE TABLE aggregate_optimization_details (
  card_updates                                 BIGINT,
  "day"                                        DOUBLE,
  dynamic_validations                          BIGINT
);

-- Itemized acceptance analytics used by Stripe's authorization rate reporting.
CREATE TABLE analytics_acceptance_itemized (
  amount                                       BIGINT,
  amount_in_usd                                BIGINT,
  block_reason                                 VARCHAR,
  buyer_country                                VARCHAR,
  card_bank                                    VARCHAR,
  card_bin                                     VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  charge_country                               VARCHAR,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  failure_reason                               VARCHAR,
  final_charge_id                              VARCHAR,
  gateway_conversation_avs_outcome             VARCHAR,
  gateway_conversation_cvc_outcome             VARCHAR,
  id                                           VARCHAR,
  interaction_type                             VARCHAR,
  invoice_id                                   VARCHAR,
  is_connected_account                         BOOLEAN,
  is_final_attempt                             BOOLEAN,
  is_link                                      BOOLEAN,
  locality_zone                                VARCHAR,
  mcc                                          VARCHAR,
  outcome_type                                 VARCHAR,
  payment_intent_id                            VARCHAR,
  payment_method_type                          VARCHAR,
  payment_processor                            VARCHAR,
  retry_status                                 VARCHAR,
  three_d_s_challenge_type                     VARCHAR,
  three_d_s_is_in_sca_scope                    BOOLEAN,
  three_d_s_outcome                            VARCHAR,
  three_d_s_outcome_type                       VARCHAR,
  three_d_s_reason                             VARCHAR,
  three_d_s_sca_exemption_type                 VARCHAR,
  three_d_s_used                               BOOLEAN,
  used_network_tokens                          BOOLEAN
);


CREATE TABLE analytics_acceptance_summarized (
  _viewing_merchant                            VARCHAR,
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  block_reason                                 VARCHAR,
  buyer_country                                VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  created_hour                                 TIMESTAMP,
  currency                                     VARCHAR,
  failure_reason                               VARCHAR,
  gateway_conversation_avs_outcome             VARCHAR,
  gateway_conversation_cvc_outcome             VARCHAR,
  interaction_type                             VARCHAR,
  is_connected_account                         BOOLEAN,
  is_final_attempt                             BOOLEAN,
  is_link                                      BOOLEAN,
  locality_zone                                VARCHAR,
  outcome_type                                 VARCHAR,
  payment_amount                               BIGINT,
  payment_amount_in_usd                        BIGINT,
  payment_count                                BIGINT,
  payment_method_type                          VARCHAR,
  payment_processor                            VARCHAR,
  retry_status                                 VARCHAR,
  three_d_s_challenge_type                     VARCHAR,
  three_d_s_is_in_sca_scope                    BOOLEAN,
  three_d_s_outcome                            VARCHAR,
  three_d_s_outcome_type                       VARCHAR,
  three_d_s_reason                             VARCHAR,
  three_d_s_sca_exemption_type                 VARCHAR,
  three_d_s_used                               BOOLEAN,
  used_network_tokens                          BOOLEAN
);

-- Refunds of application fees back to connected accounts.
CREATE TABLE application_fee_refunds (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  fee_id                                       VARCHAR
);

-- Metadata key/value pairs set on application_fee_refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE application_fee_refunds_metadata (
  application_fee_refund_id                    VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Fees your Connect platform collected from connected accounts.
CREATE TABLE application_fees (
  id                                           VARCHAR,
  account_id                                   VARCHAR,
  amount                                       BIGINT,
  amount_refunded                              BIGINT,
  application_id                               VARCHAR,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  fee_source_id                                VARCHAR,
  fee_source_type                              VARCHAR,
  originating_transaction_id                   VARCHAR,
  refunded                                     BOOLEAN
);

-- Individual 3D Secure authentication attempts, including the resulting charge outcome.
CREATE TABLE authentication_report_attempts (
  attempt_id                                   VARCHAR,
  amount                                       BIGINT,
  authentication_flow                          VARCHAR,
  card_bin_country                             VARCHAR,
  charge_id                                    VARCHAR,
  charge_outcome                               VARCHAR,
  charge_outcome_reason                        VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  device_type                                  VARCHAR,
  final_attempt_id                             VARCHAR,
  intent_id                                    VARCHAR,
  intent_type                                  VARCHAR,
  is_authenticated_by_digital_wallet           BOOLEAN,
  is_final_attempt                             BOOLEAN,
  is_in_sca_scope                              BOOLEAN,
  is_threeds_triggered                         BOOLEAN,
  merchant_country                             VARCHAR,
  protocol_version                             VARCHAR,
  sca_exemption_mechanism                      VARCHAR,
  sca_exemption_requested                      VARCHAR,
  sca_exemption_status                         VARCHAR,
  threeds_outcome_result                       VARCHAR,
  threeds_outcome_result_reason                VARCHAR,
  threeds_reason                               VARCHAR
);

-- Line-item breakdown of the fee column on balance_transactions.
CREATE TABLE balance_transaction_fee_details (
  balance_transaction_id                       VARCHAR,
  id                                           VARCHAR,
  amount                                       BIGINT,
  application                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  "type"                                       VARCHAR
);

-- Ledger-style record of every event that moves money into or out of your Stripe balance. The canonical starting point for accounting and reconciliation
CREATE TABLE balance_transactions (
  id                                           VARCHAR,
  amount                                       BIGINT,
  automatic_transfer_id                        VARCHAR,
  available_on                                 TIMESTAMP,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  exchange_rate                                DOUBLE,
  fee                                          BIGINT,
  net                                          BIGINT,
  reporting_category                           VARCHAR,
  source_id                                    VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE balance_transactions_product_enrichment (
  balance_transaction_id                       VARCHAR,
  product_ids                                  VARCHAR,
  product_names                                VARCHAR,
  reporting_category                           VARCHAR,
  source_id                                    VARCHAR
);


CREATE TABLE billing_credit_balance_transactions (
  id                                           VARCHAR,
  bill_item_id                                 VARCHAR,
  created                                      TIMESTAMP,
  credit_amount_type                           VARCHAR,
  credit_grant_id                              VARCHAR,
  credit_monetary_amount_currency              VARCHAR,
  credit_monetary_amount_value                 BIGINT,
  credit_type                                  VARCHAR,
  debit_amount_type                            VARCHAR,
  debit_monetary_amount_currency               VARCHAR,
  debit_monetary_amount_value                  BIGINT,
  debit_type                                   VARCHAR,
  effective_at                                 TIMESTAMP,
  invoice_id                                   VARCHAR,
  invoice_line_item_id                         VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE billing_credit_grant_metadata (
  credit_grant_id                              VARCHAR,
  "key"                                        VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE billing_credit_grants (
  id                                           VARCHAR,
  amount_type                                  VARCHAR,
  applicability_config_scope_price_type        VARCHAR,
  category                                     VARCHAR,
  created                                      TIMESTAMP,
  custom_pricing_unit_id                       VARCHAR,
  custom_pricing_unit_value                    VARCHAR,
  customer_id                                  VARCHAR,
  effective_at                                 TIMESTAMP,
  expires_at                                   TIMESTAMP,
  monetary_amount_currency                     VARCHAR,
  monetary_amount_value                        BIGINT,
  name                                         VARCHAR,
  service_action_id                            VARCHAR,
  updated                                      TIMESTAMP,
  voided_at                                    TIMESTAMP
);


CREATE TABLE billing_meter_dimensions (
  dimension_payload_key                        VARCHAR,
  meter_id                                     VARCHAR
);

-- Aggregated meter usage per customer over a time window.
CREATE TABLE billing_meter_event_summaries (
  id                                           VARCHAR,
  aggregated_value                             DOUBLE,
  customer_id                                  VARCHAR,
  end_time                                     TIMESTAMP,
  livemode                                     BOOLEAN,
  meter_id                                     VARCHAR,
  segment_hash                                 VARCHAR,
  start_time                                   TIMESTAMP,
  value_grouping_window                        VARCHAR
);


CREATE TABLE billing_meter_event_summary_segments (
  dimension_key                                VARCHAR,
  event_summary_id                             VARCHAR,
  dimension_value                              VARCHAR
);

-- Meter events that failed validation and were not counted toward usage.
CREATE TABLE billing_meter_invalid_events (
  id                                           VARCHAR,
  created                                      TIMESTAMP,
  error_code                                   VARCHAR,
  error_message                                VARCHAR,
  event_name                                   VARCHAR,
  livemode                                     BOOLEAN,
  meter_id                                     VARCHAR,
  received                                     TIMESTAMP
);

-- Key/value payload of each invalid meter event.
CREATE TABLE billing_meter_invalid_events_payload (
  event_id                                     VARCHAR,
  "key"                                        VARCHAR,
  "value"                                      VARCHAR
);

-- Usage-based billing meters that aggregate metered events.
CREATE TABLE billing_meters (
  id                                           VARCHAR,
  created                                      TIMESTAMP,
  customer_mapping_event_payload_key           VARCHAR,
  customer_mapping_type                        VARCHAR,
  deactivated                                  TIMESTAMP,
  default_aggregation_formula                  VARCHAR,
  display_name                                 VARCHAR,
  event_name                                   VARCHAR,
  event_time_window                            VARCHAR,
  livemode                                     BOOLEAN,
  status                                       VARCHAR,
  updated                                      TIMESTAMP,
  value_settings_event_payload_key             VARCHAR
);


CREATE TABLE billing_schedule_applies_tos (
  billing_schedule_key                         VARCHAR,
  parent_id                                    VARCHAR,
  batch_timestamp                              TIMESTAMP,
  price_id                                     VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE billing_schedules (
  "key"                                        VARCHAR,
  parent_id                                    VARCHAR,
  batch_timestamp                              TIMESTAMP,
  bill_until_computed_timestamp                TIMESTAMP,
  bill_until_duration_interval                 VARCHAR,
  bill_until_duration_interval_count           BIGINT,
  bill_until_timestamp                         TIMESTAMP,
  bill_until_type                              VARCHAR
);


CREATE TABLE captures (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR
);

-- card_testing: no column detail published; see sigma_schema.json


CREATE TABLE cardsauth_eight_digit_bins (
  _viewing_compartment                         VARCHAR,
  _viewing_merchant                            VARCHAR,
  account_funding_source                       VARCHAR,
  card_bin                                     VARCHAR,
  card_brand                                   VARCHAR,
  country                                      VARCHAR,
  description                                  VARCHAR,
  issuer_name                                  VARCHAR,
  locality_zone                                VARCHAR
);

-- Card Account Updater fees, charged when Stripe automatically refreshes stored card credentials.
CREATE TABLE cau_fees (
  balance_transaction_id                       VARCHAR,
  billing_amount                               VARCHAR,
  card_id                                      VARCHAR,
  balance_transaction_created_at               TIMESTAMP,
  billing_currency                             VARCHAR,
  customer_id                                  VARCHAR,
  event_type                                   VARCHAR,
  fixed_per_item_amount                        DOUBLE,
  fixed_per_item_count                         BIGINT,
  fx_rate                                      DOUBLE,
  incurred_at                                  TIMESTAMP,
  previous_card_id                             VARCHAR,
  subtotal_amount                              DOUBLE,
  tax_amount                                   DOUBLE,
  tax_rate                                     DOUBLE,
  total_amount                                 DOUBLE
);

-- Groupings that link related charges, such as a retried payment and its original attempt.
CREATE TABLE charge_groups (
  charge_id                                    VARCHAR,
  amount_in_usd                                BIGINT,
  created                                      TIMESTAMP,
  final_charge_id                              VARCHAR
);

-- Per-charge record of which Stripe payment optimizations were applied and what they recovered.
CREATE TABLE charge_optimization_details (
  charge_id                                    VARCHAR  -- unverified
);

-- One row per Charge object. Use for charge-level analysis such as card brand mix, decline reasons and fraud outcomes. For accounting totals use balance
CREATE TABLE charges (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_refunded                              BIGINT,
  application_fee_id                           VARCHAR,
  application_id                               VARCHAR,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  calculated_statement_descriptor              VARCHAR,
  captured                                     BOOLEAN,
  captured_at                                  TIMESTAMP,
  card_address_city                            VARCHAR,
  card_address_country                         VARCHAR,
  card_address_line1                           VARCHAR,
  card_address_line1_check                     VARCHAR,
  card_address_line2                           VARCHAR,
  card_address_state                           VARCHAR,
  card_address_zip                             VARCHAR,
  card_address_zip_check                       VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_currency                                VARCHAR,
  card_customer_id                             VARCHAR,
  card_cvc_check                               VARCHAR,
  card_default_for_currency                    BOOLEAN,
  card_dynamic_last4                           VARCHAR,
  card_exp_month                               BIGINT,
  card_exp_year                                BIGINT,
  card_fingerprint                             VARCHAR,
  card_funding                                 VARCHAR,
  card_id                                      VARCHAR,
  card_last4                                   VARCHAR,
  card_name                                    VARCHAR,
  card_network                                 VARCHAR,
  card_recipient_id                            VARCHAR,
  card_token_type                              VARCHAR,
  card_tokenization_method                     VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  description                                  VARCHAR,
  destination_id                               VARCHAR,
  dispute_id                                   VARCHAR,
  failure_code                                 VARCHAR,
  failure_message                              VARCHAR,
  invoice_id                                   VARCHAR,
  on_behalf_of_id                              VARCHAR,
  order_id                                     VARCHAR,
  outcome_advice_code                          VARCHAR,
  outcome_network_advice_code                  VARCHAR,
  outcome_network_decline_code                 VARCHAR,
  outcome_network_status                       VARCHAR,
  outcome_reason                               VARCHAR,
  outcome_risk_level                           VARCHAR,
  outcome_risk_score                           BIGINT,
  outcome_rule_id                              VARCHAR,
  outcome_seller_message                       VARCHAR,
  outcome_type                                 VARCHAR,
  paid                                         BOOLEAN,
  payment_intent                               VARCHAR,
  payment_method_id                            VARCHAR,
  payment_method_type                          VARCHAR,
  presentment_amount                           BIGINT,
  presentment_currency                         VARCHAR,
  receipt_email                                VARCHAR,
  receipt_number                               VARCHAR,
  refunded                                     BOOLEAN,
  shipping_address_city                        VARCHAR,
  shipping_address_country                     VARCHAR,
  shipping_address_line1                       VARCHAR,
  shipping_address_line2                       VARCHAR,
  shipping_address_postal_code                 VARCHAR,
  shipping_address_state                       VARCHAR,
  source_id                                    VARCHAR,
  source_transfer_id                           VARCHAR,
  statement_descriptor                         VARCHAR,
  statement_descriptor_suffix                  VARCHAR,
  status                                       VARCHAR,
  transfer_group                               VARCHAR,
  transfer_id                                  VARCHAR
);

-- Metadata key/value pairs set on charges. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE charges_metadata (
  charge_id                                    VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Values customers entered into custom fields you configured on a Checkout session.
CREATE TABLE checkout_custom_fields (
  checkout_session_id                          VARCHAR,
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "key"                                        VARCHAR,
  optional                                     BOOLEAN,
  "type"                                       VARCHAR,
  "value"                                      VARCHAR
);

-- Line items on a Checkout session.
CREATE TABLE checkout_line_items (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  checkout_session_id                          VARCHAR,
  created                                      TIMESTAMP,
  description                                  VARCHAR,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  quantity                                     BIGINT
);

-- Stripe Checkout sessions, including abandoned ones. The table to use for hosted-checkout conversion analysis.
CREATE TABLE checkout_sessions (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  client_reference_id                          VARCHAR,
  consent_promotions                           VARCHAR,
  consent_terms_of_service                     VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  invoice_id                                   VARCHAR,
  managed_payments_enabled                     BOOLEAN,
  mode                                         VARCHAR,
  payment_intent_id                            VARCHAR,
  payment_link_id                              VARCHAR,
  shipping_cost_amount_subtotal                BIGINT,
  shipping_cost_amount_tax                     BIGINT,
  shipping_cost_amount_total                   BIGINT,
  status                                       VARCHAR,
  subscription_id                              VARCHAR
);


CREATE TABLE checkout_sessions_metadata (
  checkout_session_id                          VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
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
  activity_end_time                            TIMESTAMP,
  activity_start_time                          TIMESTAMP,
  amount                                       DOUBLE,
  balance_transaction_created                  TIMESTAMP,
  balance_transaction_description              VARCHAR,
  balance_transaction_id                       VARCHAR,
  connected_account_id                         VARCHAR,
  credit_note_number                           VARCHAR,
  currency                                     VARCHAR,
  feature_description                          VARCHAR,
  feature_name                                 VARCHAR,
  fee_category                                 VARCHAR,
  fee_description                              VARCHAR,
  fee_transaction_created                      TIMESTAMP,
  fee_transaction_id                           VARCHAR,
  incurred_at                                  TIMESTAMP,
  incurred_by                                  VARCHAR,
  incurred_by_type                             VARCHAR,
  invoice_number                               VARCHAR,
  platform_id                                  VARCHAR,
  pricing_tier                                 BIGINT,
  product                                      VARCHAR,
  product_feature_description                  VARCHAR,
  settled_at                                   TIMESTAMP,
  settled_via                                  VARCHAR,
  suite                                        VARCHAR,
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


CREATE TABLE connected_account_money_management_adjustments (
  account                                      VARCHAR,
  amount                                       BIGINT,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR
);


CREATE TABLE connected_account_money_management_financial_accounts (
  account                                      VARCHAR,
  country                                      VARCHAR,
  created                                      TIMESTAMP,
  display_name                                 VARCHAR,
  id                                           VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE connected_account_money_management_financial_accounts_metadata (
  account                                      VARCHAR,
  financial_account_id                         VARCHAR,
  "key"                                        VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE connected_account_money_management_financial_addresses (
  account                                      VARCHAR,
  created                                      TIMESTAMP,
  credentials_bank_name                        VARCHAR,
  credentials_bic                              VARCHAR,
  credentials_clabe                            VARCHAR,
  credentials_country                          VARCHAR,
  credentials_crypto_address                   VARCHAR,
  credentials_crypto_memo                      VARCHAR,
  credentials_crypto_network                   VARCHAR,
  credentials_institution_number               VARCHAR,
  credentials_last4                            VARCHAR,
  credentials_routing_number                   VARCHAR,
  credentials_sort_code                        VARCHAR,
  credentials_transit_number                   VARCHAR,
  credentials_type                             VARCHAR,
  currency                                     VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR,
  settlement_currency                          VARCHAR,
  status                                       VARCHAR
);


CREATE TABLE connected_account_money_management_inbound_transfers (
  account                                      VARCHAR,
  created                                      TIMESTAMP,
  credited_amount                              BIGINT,
  credited_currency                            VARCHAR,
  debited_amount                               BIGINT,
  debited_currency                             VARCHAR,
  description                                  VARCHAR,
  from_payment_method_id                       VARCHAR,
  from_payment_method_type                     VARCHAR,
  id                                           VARCHAR,
  status                                       VARCHAR,
  to_financial_account_id                      VARCHAR
);


CREATE TABLE connected_account_money_management_inbound_transfers_history (
  account                                      VARCHAR,
  bank_debit_failure_reason                    VARCHAR,
  bank_debit_return_reason                     VARCHAR,
  created                                      TIMESTAMP,
  effective_at                                 TIMESTAMP,
  id                                           VARCHAR,
  inbound_transfer_id                          VARCHAR,
  level                                        VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE connected_account_money_management_outbound_payments (
  account                                      VARCHAR,
  ach_submission                               VARCHAR,
  ach_transaction_purpose                      VARCHAR,
  canceled_at                                  TIMESTAMP,
  created                                      TIMESTAMP,
  credited_amount                              BIGINT,
  credited_currency                            VARCHAR,
  debited_amount                               BIGINT,
  debited_currency                             VARCHAR,
  delivery_options_bank_account                VARCHAR,
  description                                  VARCHAR,
  expected_arrival_date                        TIMESTAMP,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  from_financial_account_id                    VARCHAR,
  id                                           VARCHAR,
  payout_method_options_bank_account_preferred_networks VARCHAR,
  posted_at                                    TIMESTAMP,
  returned_at                                  TIMESTAMP,
  returned_reason                              VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  to_payout_method_id                          VARCHAR,
  to_recipient_id                              VARCHAR
);


CREATE TABLE connected_account_money_management_outbound_payments_metadata (
  account                                      VARCHAR,
  "key"                                        VARCHAR,
  outbound_payment_id                          VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE connected_account_money_management_outbound_transfers (
  account                                      VARCHAR,
  canceled_at                                  TIMESTAMP,
  created                                      TIMESTAMP,
  credited_amount                              BIGINT,
  credited_currency                            VARCHAR,
  debited_amount                               BIGINT,
  debited_currency                             VARCHAR,
  delivery_options_bank_account                VARCHAR,
  description                                  VARCHAR,
  expected_arrival_date                        TIMESTAMP,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  from_financial_account_id                    VARCHAR,
  id                                           VARCHAR,
  payout_method_options_bank_account_preferred_networks VARCHAR,
  posted_at                                    TIMESTAMP,
  returned_at                                  TIMESTAMP,
  returned_reason                              VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  to_payout_method_id                          VARCHAR
);


CREATE TABLE connected_account_money_management_outbound_transfers_metadata (
  account                                      VARCHAR,
  "key"                                        VARCHAR,
  outbound_transfer_id                         VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE connected_account_money_management_received_credits (
  account                                      VARCHAR,
  amount                                       BIGINT,
  balance_transfer_from_account_id             VARCHAR,
  balance_transfer_id                          VARCHAR,
  balance_transfer_type                        VARCHAR,
  bank_transfer_account_holder_name            VARCHAR,
  bank_transfer_bank_name                      VARCHAR,
  bank_transfer_bic                            VARCHAR,
  bank_transfer_financial_address_id           VARCHAR,
  bank_transfer_last4                          VARCHAR,
  bank_transfer_network                        VARCHAR,
  bank_transfer_origin_type                    VARCHAR,
  bank_transfer_routing_number                 VARCHAR,
  bank_transfer_sort_code                      VARCHAR,
  bank_transfer_statement_descriptor           VARCHAR,
  card_spend_card_id                           VARCHAR,
  card_spend_issuing_dispute                   VARCHAR,
  card_spend_issuing_refund                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR,
  returned_at                                  TIMESTAMP,
  returned_reason                              VARCHAR,
  status                                       VARCHAR,
  succeeded_at                                 TIMESTAMP,
  "type"                                       VARCHAR
);


CREATE TABLE connected_account_money_management_received_debits (
  account                                      VARCHAR,
  amount                                       BIGINT,
  bank_transfer_bank_name                      VARCHAR,
  bank_transfer_financial_address_id           VARCHAR,
  bank_transfer_network                        VARCHAR,
  bank_transfer_routing_number                 VARCHAR,
  bank_transfer_statement_descriptor           VARCHAR,
  canceled_at                                  TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR,
  status                                       VARCHAR,
  succeeded_at                                 TIMESTAMP,
  "type"                                       VARCHAR
);


CREATE TABLE connected_account_money_management_transaction_entries (
  account                                      VARCHAR,
  available_balance_impact                     BIGINT,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  effective_at                                 TIMESTAMP,
  id                                           VARCHAR,
  inbound_pending_balance_impact               BIGINT,
  outbound_pending_balance_impact              BIGINT,
  transaction_id                               VARCHAR
);


CREATE TABLE connected_account_money_management_transactions (
  account                                      VARCHAR,
  amount                                       BIGINT,
  available_balance_impact                     BIGINT,
  category                                     VARCHAR,
  counterparty_name                            VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  financial_account_id                         VARCHAR,
  flow_id                                      VARCHAR,
  flow_type                                    VARCHAR,
  id                                           VARCHAR,
  inbound_pending_balance_impact               BIGINT,
  outbound_pending_balance_impact              BIGINT,
  posted_at                                    TIMESTAMP,
  status                                       VARCHAR,
  void_at                                      TIMESTAMP
);

-- Connect platform view of payment_records for connected accounts.
CREATE TABLE connected_account_payment_records (
  id                                           VARCHAR,
  account                                      VARCHAR,
  amount_authorized_currency                   VARCHAR,
  amount_authorized_value                      BIGINT,
  amount_canceled_currency                     VARCHAR,
  amount_canceled_value                        BIGINT,
  amount_currency                              VARCHAR,
  amount_disputed_currency                     VARCHAR,
  amount_disputed_value                        BIGINT,
  amount_failed_currency                       VARCHAR,
  amount_failed_value                          BIGINT,
  amount_guaranteed_currency                   VARCHAR,
  amount_guaranteed_value                      BIGINT,
  amount_refunded_currency                     VARCHAR,
  amount_refunded_value                        BIGINT,
  amount_requested_currency                    VARCHAR,
  amount_requested_value                       BIGINT,
  amount_value                                 BIGINT,
  application                                  VARCHAR,
  capture_method                               VARCHAR,
  created                                      TIMESTAMP,
  customer_details_customer                    VARCHAR,
  customer_details_email                       VARCHAR,
  customer_details_name                        VARCHAR,
  customer_details_phone                       VARCHAR,
  customer_presence                            VARCHAR,
  description                                  VARCHAR,
  initiated_at                                 TIMESTAMP,
  latest_occurred_at                           TIMESTAMP,
  latest_payment_attempt_record                VARCHAR,
  money_services_transaction_type              VARCHAR,
  payment_method_details_billing_address_city  VARCHAR,
  payment_method_details_billing_address_country VARCHAR,
  payment_method_details_billing_address_line1 VARCHAR,
  payment_method_details_billing_address_line2 VARCHAR,
  payment_method_details_billing_address_postal_code VARCHAR,
  payment_method_details_billing_address_state VARCHAR,
  payment_method_details_billing_email         VARCHAR,
  payment_method_details_billing_name          VARCHAR,
  payment_method_details_billing_phone         VARCHAR,
  payment_method_details_card_brand            VARCHAR,
  payment_method_details_card_capture_before   TIMESTAMP,
  payment_method_details_card_country          VARCHAR,
  payment_method_details_card_exp_month        BIGINT,
  payment_method_details_card_exp_year         BIGINT,
  payment_method_details_card_fingerprint      VARCHAR,
  payment_method_details_card_funding          VARCHAR,
  payment_method_details_card_last4            VARCHAR,
  payment_method_details_card_moto             BOOLEAN,
  payment_method_details_card_network          VARCHAR,
  payment_method_details_card_network_transaction_id VARCHAR,
  payment_method_details_card_payment_account_reference VARCHAR,
  payment_method_details_card_wallet_dynamic_last4 VARCHAR,
  payment_method_details_card_wallet_type      VARCHAR,
  payment_method_details_custom_display_name   VARCHAR,
  payment_method_details_custom_type           VARCHAR,
  payment_method_details_payment_method        VARCHAR,
  payment_method_details_shared_payment_granted_token VARCHAR,
  payment_method_details_shop_pay_external_source_id VARCHAR,
  payment_method_details_type                  VARCHAR,
  processor_adyen_merchant_account             VARCHAR,
  processor_adyen_psp_reference                VARCHAR,
  processor_braintree_merchant_account_id      VARCHAR,
  processor_braintree_transaction_id           VARCHAR,
  processor_custom_payment_reference           VARCHAR,
  processor_stripe_charge                      VARCHAR,
  processor_type                               VARCHAR,
  processor_worldpay_merchant_code             VARCHAR,
  processor_worldpay_order_code                VARCHAR,
  reported_by                                  VARCHAR,
  setup_future_usage                           VARCHAR,
  shipping_address_city                        VARCHAR,
  shipping_address_country                     VARCHAR,
  shipping_address_line1                       VARCHAR,
  shipping_address_line2                       VARCHAR,
  shipping_address_postal_code                 VARCHAR,
  shipping_address_state                       VARCHAR,
  shipping_name                                VARCHAR,
  shipping_phone                               VARCHAR,
  updated                                      TIMESTAMP
);

-- Metadata key/value pairs set on connected_account_payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE connected_account_payment_records_metadata (
  "key"                                        VARCHAR,
  payment_record_id                            VARCHAR,
  account                                      VARCHAR,
  "value"                                      VARCHAR
);

-- Connect platform view of summarized_balance_transactions, per connected account.
CREATE TABLE connected_account_summarized_balance_transactions (
  activity_at_time_bucket                      VARCHAR,
  auto_payout_id                               VARCHAR,
  bt_count                                     VARCHAR,
  bt_effective_at_interval_start               VARCHAR,
  currency                                     VARCHAR,
  gross                                        VARCHAR,
  net                                          VARCHAR,
  payout_is_auto                               VARCHAR,
  reporting_category                           VARCHAR,
  account                                      VARCHAR,
  auto_payout_effective_at_interval_start      TIMESTAMP,
  fee                                          DOUBLE
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
  applies_to_products                          VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  duration                                     VARCHAR,
  duration_in_months                           BIGINT,
  max_redemptions                              BIGINT,
  name                                         VARCHAR,
  percent_off                                  DOUBLE,
  redeem_by                                    TIMESTAMP,
  times_redeemed                               BIGINT,
  valid                                        BOOLEAN
);

-- Per-currency overrides for multi-currency coupons.
CREATE TABLE coupons_currency_options (
  coupon_id                                    VARCHAR,
  currency                                     VARCHAR,
  amount_off                                   BIGINT,
  batch_timestamp                              TIMESTAMP
);

-- Metadata key/value pairs set on coupons. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE coupons_metadata (
  coupon_id                                    VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Discount amounts applied at the credit note level.
CREATE TABLE credit_note_discount_amounts (
  credit_note_id                               VARCHAR,
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  discount                                     VARCHAR
);

-- Discount amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_discount_amounts (
  credit_note_id                               VARCHAR,
  credit_note_line_item_id                     VARCHAR,
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  discount                                     VARCHAR
);

-- Tax amounts applied to individual credit note line items.
CREATE TABLE credit_note_line_item_tax_amounts (
  credit_note_line_item_id                     VARCHAR,
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  inclusive                                    BOOLEAN,
  tax_rate_id                                  VARCHAR
);

-- Line items on a credit note.
CREATE TABLE credit_note_line_items (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  credit_note_id                               VARCHAR,
  description                                  VARCHAR,
  discount_amount                              BIGINT,
  invoice_line_item                            VARCHAR,
  quantity                                     BIGINT,
  "type"                                       VARCHAR,
  unit_amount                                  BIGINT,
  unit_amount_decimal                          VARCHAR
);

-- Tax amounts applied at the credit note level.
CREATE TABLE credit_note_tax_amounts (
  credit_note_id                               VARCHAR,
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  inclusive                                    BOOLEAN,
  tax_rate_id                                  VARCHAR
);

-- Post-issuance adjustments to invoices — the correct way to represent refunds and write-offs against a finalized invoice.
CREATE TABLE credit_notes (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_shipping                              BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_balance_transaction_id              VARCHAR,
  customer_id                                  VARCHAR,
  effective_at                                 TIMESTAMP,
  invoice_id                                   VARCHAR,
  memo                                         VARCHAR,
  number                                       VARCHAR,
  out_of_band_amount                           BIGINT,
  reason                                       VARCHAR,
  refund_id                                    VARCHAR,
  shipping_cost_amount_subtotal                BIGINT,
  shipping_cost_amount_tax                     BIGINT,
  shipping_cost_amount_total                   BIGINT,
  shipping_cost_shipping_rate_id               VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR,
  voided_at                                    TIMESTAMP
);

-- Metadata key/value pairs set on credit_notes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE credit_notes_metadata (
  credit_note_id                               VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Stripe crypto onramp sessions where users bought crypto with fiat.
CREATE TABLE crypto_onramp_sessions (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  consumer_permissible_transaction_amount_tier VARCHAR,
  created                                      TIMESTAMP,
  destination_amount                           DOUBLE,
  destination_currency                         VARCHAR,
  error_reason                                 VARCHAR,
  kyc_level                                    VARCHAR,
  network                                      VARCHAR,
  provided_wallet_address                      VARCHAR,
  source_amount                                DOUBLE,
  source_currency                              VARCHAR,
  state                                        VARCHAR,
  updated                                      TIMESTAMP
);

-- Changes to a customer's account credit balance.
CREATE TABLE customer_balance_transactions (
  id                                           VARCHAR,
  account_id                                   VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  checkout_session_id                          VARCHAR,
  created                                      TIMESTAMP,
  credit_note_id                               VARCHAR,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  description                                  VARCHAR,
  ending_balance                               BIGINT,
  invoice_id                                   VARCHAR,
  merchant_balance_adjustment_id               VARCHAR,
  previous                                     VARCHAR,
  source_id                                    VARCHAR,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on customer_balance_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customer_balance_transactions_metadata (
  customer_balance_transaction_id              VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Changes to a customer's cash balance held at Stripe, used for bank-transfer funding.
CREATE TABLE customer_cash_balance_transactions (
  id                                           VARCHAR,
  amount                                       DOUBLE,
  amount_currency                              VARCHAR,
  applied_to_payment_intent                    VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  customer                                     VARCHAR,
  ending_balance                               DOUBLE,
  ending_balance_currency                      VARCHAR,
  funded_reference                             VARCHAR,
  linked_model_id                              VARCHAR,
  livemode                                     BOOLEAN,
  refund_from                                  VARCHAR,
  "type"                                       VARCHAR,
  unapplied_from_payment_intent                VARCHAR
);


CREATE TABLE customer_change_events (
  customer_id                                  VARCHAR,
  event_timestamp                              VARCHAR,
  event_type                                   VARCHAR,
  active_timestamp                             BIGINT,
  currency                                     VARCHAR,
  local_event_timestamp                        TIMESTAMP,
  mrr_change                                   BIGINT
);

-- Tax identifiers stored against a customer.
CREATE TABLE customer_tax_ids (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  country                                      VARCHAR,
  created                                      TIMESTAMP,
  customer                                     VARCHAR,
  owner_account                                VARCHAR,
  owner_application                            VARCHAR,
  owner_customer                               VARCHAR,
  owner_type                                   VARCHAR,
  "type"                                       VARCHAR,
  "value"                                      VARCHAR,
  verification_status                          VARCHAR,
  verification_verified_address                VARCHAR,
  verification_verified_name                   VARCHAR
);

-- One row per Customer object.
CREATE TABLE customers (
  id                                           VARCHAR,
  account_balance                              BIGINT,
  address_city                                 VARCHAR,
  address_country                              VARCHAR,
  address_line1                                VARCHAR,
  address_line2                                VARCHAR,
  address_postal_code                          VARCHAR,
  address_state                                VARCHAR,
  balance                                      BIGINT,
  batch_timestamp                              TIMESTAMP,
  business_name                                VARCHAR,
  business_vat_id                              VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_account_id                          VARCHAR,
  default_source_id                            VARCHAR,
  deleted                                      BOOLEAN,
  delinquent                                   BOOLEAN,
  description                                  VARCHAR,
  discount_checkout_session                    VARCHAR,
  discount_coupon_id                           VARCHAR,
  discount_customer_id                         VARCHAR,
  discount_end                                 TIMESTAMP,
  discount_invoice                             VARCHAR,
  discount_invoice_item                        VARCHAR,
  discount_promotion_code_id                   VARCHAR,
  discount_schedule_id                         VARCHAR,
  discount_start                               TIMESTAMP,
  discount_subscription                        VARCHAR,
  discount_subscription_item                   VARCHAR,
  email                                        VARCHAR,
  individual_name                              VARCHAR,
  invoice_credit_balance                       VARCHAR,
  invoice_settings_default_payment_method_id   VARCHAR,
  name                                         VARCHAR,
  phone                                        VARCHAR,
  preferred_locales                            VARCHAR,
  shipping_address_city                        VARCHAR,
  shipping_address_country                     VARCHAR,
  shipping_address_line1                       VARCHAR,
  shipping_address_line2                       VARCHAR,
  shipping_address_postal_code                 VARCHAR,
  shipping_address_state                       VARCHAR,
  shipping_name                                VARCHAR,
  shipping_phone                               VARCHAR,
  sources_data_id                              VARCHAR,
  tax_exempt                                   VARCHAR,
  tax_info_tax_id                              VARCHAR,
  tax_info_type                                VARCHAR,
  tax_ip_address                               VARCHAR
);

-- Metadata key/value pairs set on customers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE customers_metadata (
  customer_id                                  VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Applications of a coupon or promotion code to a customer, subscription or invoice.
CREATE TABLE discounts (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  checkout_session_id                          VARCHAR,
  coupon_id                                    VARCHAR,
  created                                      TIMESTAMP,
  customer_id                                  VARCHAR,
  "end"                                        BIGINT,
  invoice_id                                   VARCHAR,
  invoice_item_id                              VARCHAR,
  promotion_code_id                            VARCHAR,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR
);

-- One row per Dispute (chargeback), including any evidence you submitted.
CREATE TABLE disputes (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  evidence_access_activity_log                 VARCHAR,
  evidence_billing_address                     VARCHAR,
  evidence_cancellation_policy_disclosure      VARCHAR,
  evidence_cancellation_policy_id              VARCHAR,
  evidence_cancellation_rebuttal               VARCHAR,
  evidence_customer_communication_id           VARCHAR,
  evidence_customer_email_address              VARCHAR,
  evidence_customer_name                       VARCHAR,
  evidence_customer_purchase_ip                VARCHAR,
  evidence_customer_signature_id               VARCHAR,
  evidence_details_due_by                      TIMESTAMP,
  evidence_details_has_evidence                BOOLEAN,
  evidence_details_past_due                    BOOLEAN,
  evidence_details_submission_count            BIGINT,
  evidence_details_submitted_at                TIMESTAMP,
  evidence_duplicate_charge_documentation_id   VARCHAR,
  evidence_duplicate_charge_id                 VARCHAR,
  evidence_product_description                 VARCHAR,
  evidence_receipt_id                          VARCHAR,
  evidence_refund_policy_disclosure            VARCHAR,
  evidence_refund_policy_id                    VARCHAR,
  evidence_refund_refusal_explanation          VARCHAR,
  evidence_service_date                        VARCHAR,
  evidence_service_documentation_id            VARCHAR,
  evidence_shipping_address                    VARCHAR,
  evidence_shipping_carrier                    VARCHAR,
  evidence_shipping_date                       VARCHAR,
  evidence_shipping_documentation_id           VARCHAR,
  evidence_shipping_tracking_number            VARCHAR,
  evidence_uncategorized_file_id               VARCHAR,
  evidence_uncategorized_text                  VARCHAR,
  is_charge_refundable                         BOOLEAN,
  network_details_type                         VARCHAR,
  network_details_visa_rapid_dispute_resolution BOOLEAN,
  network_reason_code                          VARCHAR,
  partner_processed_at                         TIMESTAMP,
  reason                                       VARCHAR,
  status                                       VARCHAR
);

-- Eligibility of each dispute for enhanced evidence programs such as Visa Compelling Evidence 3.0.
CREATE TABLE disputes_enhanced_eligibility (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      DOUBLE,
  mastercard_compliance_status                 VARCHAR,
  visa_compelling_evidence_3_required_actions  VARCHAR,
  visa_compelling_evidence_3_status            VARCHAR,
  visa_compliance_status                       VARCHAR
);

-- Metadata key/value pairs set on disputes. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE disputes_metadata (
  dispute_id                                   VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE disputes_reporting_v1_itemized (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_in_usd                                BIGINT,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  charge_id                                    VARCHAR,
  currency                                     VARCHAR,
  dispute_amount                               BIGINT,
  dispute_amount_in_usd                        BIGINT,
  dispute_created_day                          TIMESTAMP,
  dispute_id                                   VARCHAR,
  dispute_type                                 VARCHAR,
  gateway_country                              VARCHAR,
  has_early_fraud_warning                      BOOLEAN,
  is_connected_account                         BOOLEAN,
  payment_created_day                          TIMESTAMP,
  representment_product                        VARCHAR,
  responded                                    BOOLEAN,
  status                                       VARCHAR,
  user_facing_reason                           VARCHAR
);


CREATE TABLE draft_tax_forms (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  email                                        VARCHAR,
  filing_requirement                           VARCHAR,
  livemode                                     BOOLEAN,
  payee_account_id                             VARCHAR,
  payee_address_line_1                         VARCHAR,
  payee_address_line_2                         VARCHAR,
  payee_city                                   VARCHAR,
  payee_country                                VARCHAR,
  payee_name_line_1                            VARCHAR,
  payee_name_line_2                            VARCHAR,
  payee_postal_code                            VARCHAR,
  payee_region                                 VARCHAR,
  payee_tin_type                               VARCHAR,
  payee_type                                   VARCHAR,
  payer_override                               VARCHAR,
  postal_delivery                              VARCHAR,
  reporting_year                               BIGINT,
  "type"                                       VARCHAR,
  us_1099_k_numerical_data_by_calculation_type VARCHAR,
  us_1099_k_numerical_deltas                   VARCHAR,
  us_1099_k_selected_calculation_type          VARCHAR,
  us_1099_misc_numerical_data_by_calculation_type VARCHAR,
  us_1099_misc_numerical_deltas                VARCHAR,
  us_1099_misc_selected_calculation_type       VARCHAR,
  us_1099_nec_numerical_data_by_calculation_type VARCHAR,
  us_1099_nec_numerical_deltas                 VARCHAR,
  us_1099_nec_selected_calculation_type        VARCHAR
);

-- Fraud reports issued by the card network before a formal dispute is filed. Leading indicator for card brand monitoring programs such as Visa VAMP.
CREATE TABLE early_fraud_warnings (
  id                                           VARCHAR,
  actionable                                   BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  fraud_type                                   VARCHAR
);

-- Daily currency conversion rates expressed relative to USD. Needed to sum multi-currency amounts into one reporting currency.
CREATE TABLE exchange_rates_from_usd (
  "date"                                       VARCHAR,
  buy_currency_exchange_rates                  VARCHAR,
  sell_currency                                VARCHAR
);


CREATE TABLE external_account_bank_accounts (
  account_id                                   VARCHAR,
  id                                           VARCHAR,
  account_holder_name                          VARCHAR,
  account_holder_type                          VARCHAR,
  account_type                                 VARCHAR,
  available_payout_methods                     VARCHAR,
  bank_name                                    VARCHAR,
  batch_timestamp                              TIMESTAMP,
  country                                      VARCHAR,
  currency                                     VARCHAR,
  default_for_currency                         BOOLEAN,
  fingerprint                                  VARCHAR,
  last4                                        VARCHAR,
  routing_number                               VARCHAR,
  status                                       VARCHAR
);


CREATE TABLE external_account_cards (
  account_id                                   VARCHAR,
  id                                           VARCHAR,
  address_city                                 VARCHAR,
  address_country                              VARCHAR,
  address_line1                                VARCHAR,
  address_line1_check                          VARCHAR,
  address_line2                                VARCHAR,
  address_state                                VARCHAR,
  address_zip                                  VARCHAR,
  address_zip_check                            VARCHAR,
  allow_redisplay                              VARCHAR,
  available_payout_methods                     VARCHAR,
  batch_timestamp                              TIMESTAMP,
  brand                                        VARCHAR,
  country                                      VARCHAR,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  cvc_check                                    VARCHAR,
  default_for_currency                         BOOLEAN,
  dynamic_last4                                VARCHAR,
  exp_month                                    BIGINT,
  exp_year                                     BIGINT,
  fingerprint                                  VARCHAR,
  funding                                      VARCHAR,
  last4                                        VARCHAR,
  name                                         VARCHAR,
  recipient_id                                 VARCHAR,
  regulated_status                             VARCHAR,
  status                                       VARCHAR,
  tokenization_method                          VARCHAR
);


CREATE TABLE fee_credits_activities (
  credit_id                                    VARCHAR,
  transaction_id                               VARCHAR,
  amount_in_minor                              BIGINT,
  attribution_window_end                       TIMESTAMP,
  attribution_window_start                     TIMESTAMP,
  billing_account_id                           VARCHAR,
  created_at                                   TIMESTAMP,
  credit_name                                  VARCHAR,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  owner_account_id                             VARCHAR
);

-- Outstanding Stripe Capital loan balances over time.
CREATE TABLE financing_balances (
  id                                           VARCHAR,
  account_id                                   VARCHAR,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  effective_date_utc                           TIMESTAMP,
  financing_offer                              VARCHAR,
  overdue_payment_amount                       BIGINT,
  pending_payment_amount                       BIGINT,
  premium_outstanding_amount                   BIGINT,
  principal_outstanding_amount                 BIGINT
);

-- Stripe Capital financing offers extended to you or your connected accounts.
CREATE TABLE financing_offers (
  id                                           VARCHAR,
  accepted_advance_amount                      BIGINT,
  accepted_at                                  TIMESTAMP,
  accepted_premium_amount                      BIGINT,
  accepted_terms_repayment_interval_configuration_duration_days BIGINT,
  accepted_terms_repayment_interval_configuration_maximum_amount BIGINT,
  accepted_terms_repayment_interval_configuration_minimum_amount BIGINT,
  accepted_terms_target_payback_days           BIGINT,
  accepted_withhold_rate                       DOUBLE,
  account_id                                   VARCHAR,
  batch_timestamp                              TIMESTAMP,
  campaign_type                                VARCHAR,
  canceled_at                                  TIMESTAMP,
  charged_off_at                               TIMESTAMP,
  created_at                                   TIMESTAMP,
  currency                                     VARCHAR,
  expires_at                                   TIMESTAMP,
  financing_application_status_transitions_accepted_at TIMESTAMP,
  financing_application_status_transitions_initiated_at TIMESTAMP,
  financing_type                               VARCHAR,
  fully_repaid_at                              TIMESTAMP,
  is_first_time_offer                          BOOLEAN,
  max_advance_amount                           BIGINT,
  max_premium_amount                           BIGINT,
  max_withhold_rate                            DOUBLE,
  metadata                                     VARCHAR,
  offered_terms_repayment_interval_configuration_duration_days BIGINT,
  offered_terms_repayment_interval_configuration_maximum_amount BIGINT,
  offered_terms_repayment_interval_configuration_minimum_amount BIGINT,
  offered_terms_target_payback_days            BIGINT,
  paid_out_at                                  TIMESTAMP,
  previous_financing_fee_discount_amount       BIGINT,
  previous_financing_fee_discount_rate         DOUBLE,
  product_type                                 VARCHAR,
  rejected_at                                  TIMESTAMP,
  replacement_for                              VARCHAR,
  replacement_type                             VARCHAR,
  revshare_earned_amount                       BIGINT,
  state                                        VARCHAR
);

-- Repayments and drawdowns against Stripe Capital financing.
CREATE TABLE financing_transactions (
  id                                           VARCHAR,
  advance_amount                               BIGINT,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  effective_time                               TIMESTAMP,
  fee_amount                                   BIGINT,
  financing_offer                              VARCHAR,
  legacy_balance_transaction_source            VARCHAR,
  linked_withholdable_object_id                VARCHAR,
  linked_withholdable_object_type              VARCHAR,
  reason                                       VARCHAR,
  reversed_transaction                         VARCHAR,
  total_amount                                 BIGINT,
  transaction_type                             VARCHAR
);

-- Interchange-plus fee breakdown, splitting each fee into interchange, scheme and Stripe components.
CREATE TABLE icplus_fees (
  balance_transaction_created_at               TIMESTAMP,
  balance_transaction_id                       VARCHAR,
  billing_amount                               BIGINT,
  billing_currency                             VARCHAR,
  charge_id                                    VARCHAR
);


CREATE TABLE iins (
  id                                           VARCHAR,
  bank                                         VARCHAR,
  country_code                                 VARCHAR,
  description                                  VARCHAR
);

-- Custom key/value fields rendered on an invoice.
CREATE TABLE invoice_custom_fields (
  invoice_id                                   VARCHAR,
  name                                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Customer tax identifiers captured on an invoice.
CREATE TABLE invoice_customer_tax_ids (
  invoice_id                                   VARCHAR,
  "value"                                      VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "type"                                       VARCHAR
);


CREATE TABLE invoice_item_discount_amounts (
  discount_id                                  VARCHAR,
  invoice_item_id                              VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP
);

-- One-off charges or credits queued onto a customer's next invoice.
CREATE TABLE invoice_items (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  "date"                                       TIMESTAMP,
  description                                  VARCHAR,
  discountable                                 BOOLEAN,
  discounts                                    VARCHAR,
  invoice_id                                   VARCHAR,
  net_amount                                   BIGINT,
  period_end                                   TIMESTAMP,
  period_start                                 TIMESTAMP,
  plan_id                                      VARCHAR,
  price_id                                     VARCHAR,
  proration                                    BOOLEAN,
  quantity                                     BIGINT,
  quantity_decimal                             VARCHAR,
  subscription_id                              VARCHAR,
  subscription_item                            VARCHAR,
  unit_amount                                  BIGINT,
  unit_amount_decimal                          VARCHAR
);

-- Metadata key/value pairs set on invoice_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoice_items_metadata (
  invoice_item_id                              VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Discount amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_discount_amounts (
  id                                           VARCHAR,
  invoice_id                                   VARCHAR,
  invoice_line_item_id                         VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  discount                                     VARCHAR
);

-- Tax amounts applied to individual invoice line items.
CREATE TABLE invoice_line_item_tax_amounts (
  id                                           VARCHAR,
  invoice_id                                   VARCHAR,
  invoice_line_item_id                         VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  filing_amount                                BIGINT,
  inclusive                                    BOOLEAN,
  tax_rate                                     VARCHAR,
  taxable_amount                               BIGINT
);

-- Individual line items on an invoice.
CREATE TABLE invoice_line_items (
  invoice_id                                   VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  discountable                                 BOOLEAN,
  id                                           VARCHAR,
  invoice_item_id                              VARCHAR,
  line_item_parent_id                          VARCHAR,
  line_item_parent_type                        VARCHAR,
  period_end                                   TIMESTAMP,
  period_start                                 TIMESTAMP,
  plan_id                                      VARCHAR,
  price_id                                     VARCHAR,
  proration                                    BOOLEAN,
  proration_details_credited_items_invoice     VARCHAR,
  proration_details_credited_items_invoice_line_items VARCHAR,
  quantity                                     BIGINT,
  quantity_decimal                             VARCHAR,
  source_id                                    VARCHAR,
  source_type                                  VARCHAR,
  subscription                                 VARCHAR,
  subscription_item_id                         VARCHAR,
  total_discount                               BIGINT,
  total_exclusive_tax                          BIGINT
);

-- Payment attempts against an invoice, linking invoices to the charges or payment intents that settled them.
CREATE TABLE invoice_payments (
  id                                           VARCHAR,
  amount_overpaid                              BIGINT,
  amount_paid                                  BIGINT,
  amount_requested                             BIGINT,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  invoice                                      VARCHAR,
  is_default                                   BOOLEAN,
  payment_id                                   VARCHAR,
  payment_intent                               VARCHAR,
  payment_type                                 VARCHAR,
  status                                       VARCHAR,
  status_transitions_canceled_at               TIMESTAMP,
  status_transitions_paid_at                   TIMESTAMP
);

-- Tax applied to shipping costs on an invoice.
CREATE TABLE invoice_shipping_cost_taxes (
  id                                           VARCHAR,
  invoice_id                                   VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  filing_amount                                BIGINT,
  inclusive                                    BOOLEAN,
  tax_rate                                     VARCHAR,
  taxable_amount                               BIGINT
);

-- One row per Invoice object. Each subscription generates invoices on a recurring basis covering the subscription amount plus any invoice items.
CREATE TABLE invoices (
  id                                           VARCHAR,
  amount_due                                   BIGINT,
  amount_paid                                  BIGINT,
  amount_remaining                             BIGINT,
  amount_shipping                              BIGINT,
  application_fee                              BIGINT,
  application_id                               VARCHAR,
  attempt_count                                BIGINT,
  attempted                                    BOOLEAN,
  auto_advance                                 BOOLEAN,
  automatic_tax_enabled                        BOOLEAN,
  automatic_tax_provider                       VARCHAR,
  automatic_tax_status                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  billing_reason                               VARCHAR,
  charge_id                                    VARCHAR,
  collection_method                            VARCHAR,
  currency                                     VARCHAR,
  customer_address_city                        VARCHAR,
  customer_address_country                     VARCHAR,
  customer_address_line1                       VARCHAR,
  customer_address_line2                       VARCHAR,
  customer_address_postal_code                 VARCHAR,
  customer_address_state                       VARCHAR,
  customer_description                         VARCHAR,
  customer_email                               VARCHAR,
  customer_id                                  VARCHAR,
  customer_name                                VARCHAR,
  customer_phone                               VARCHAR,
  customer_shipping_address_city               VARCHAR,
  customer_shipping_address_country            VARCHAR,
  customer_shipping_address_line1              VARCHAR,
  customer_shipping_address_line2              VARCHAR,
  customer_shipping_address_postal_code        VARCHAR,
  customer_shipping_address_state              VARCHAR,
  customer_shipping_name                       VARCHAR,
  customer_shipping_phone                      VARCHAR,
  customer_tax_exempt                          VARCHAR,
  "date"                                       TIMESTAMP,
  default_payment_method_id                    VARCHAR,
  description                                  VARCHAR,
  discount_checkout_session                    VARCHAR,
  discount_coupon_id                           VARCHAR,
  discount_customer_id                         VARCHAR,
  discount_end                                 TIMESTAMP,
  discount_invoice                             VARCHAR,
  discount_invoice_item                        VARCHAR,
  discount_promotion_code_id                   VARCHAR,
  discount_schedule_id                         VARCHAR,
  discount_start                               TIMESTAMP,
  discount_subscription                        VARCHAR,
  discount_subscription_item                   VARCHAR,
  discounts                                    VARCHAR,
  due_date                                     TIMESTAMP,
  effective_at                                 TIMESTAMP,
  ending_balance                               BIGINT,
  footer                                       VARCHAR,
  next_payment_attempt                         TIMESTAMP,
  number                                       VARCHAR,
  on_behalf_of_id                              VARCHAR,
  paid                                         BOOLEAN,
  paid_out_of_band                             BOOLEAN,
  parent_id                                    VARCHAR,
  parent_type                                  VARCHAR,
  period_end                                   TIMESTAMP,
  period_start                                 TIMESTAMP,
  post_payment_credit_notes_amount             BIGINT,
  pre_payment_credit_notes_amount              BIGINT,
  quote_id                                     VARCHAR,
  receipt_number                               VARCHAR,
  shipping_cost_amount_subtotal                BIGINT,
  shipping_cost_amount_tax                     BIGINT,
  shipping_cost_amount_total                   BIGINT,
  shipping_cost_shipping_rate_id               VARCHAR,
  shipping_details_address_city                VARCHAR,
  shipping_details_address_country             VARCHAR,
  shipping_details_address_line1               VARCHAR,
  shipping_details_address_line2               VARCHAR,
  shipping_details_address_postal_code         VARCHAR,
  shipping_details_address_state               VARCHAR,
  shipping_details_name                        VARCHAR,
  shipping_details_phone                       VARCHAR,
  starting_balance                             BIGINT,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  status_transitions_finalized_at              TIMESTAMP,
  status_transitions_marked_uncollectible_at   TIMESTAMP,
  status_transitions_paid_at                   TIMESTAMP,
  status_transitions_voided_at                 TIMESTAMP,
  subscription_id                              VARCHAR,
  subscription_proration_date                  TIMESTAMP,
  subtotal                                     BIGINT,
  tax                                          BIGINT,
  tax_percent                                  DOUBLE,
  total                                        BIGINT,
  transfer_data_amount                         BIGINT,
  transfer_data_destination_id                 VARCHAR,
  webhooks_delivered_at                        TIMESTAMP
);

-- Metadata key/value pairs set on invoices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE invoices_metadata (
  invoice_id                                   VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Authorization requests created whenever an issued card is used. Includes declined attempts.
CREATE TABLE issuing_authorizations (
  id                                           VARCHAR,
  amount                                       BIGINT,
  approved                                     BOOLEAN,
  authorization_method                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  card_id                                      VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  fraud_disputability_likelihood               VARCHAR,
  merchant_amount                              BIGINT,
  merchant_currency                            VARCHAR,
  merchant_data_category                       VARCHAR,
  merchant_data_category_code                  VARCHAR,
  merchant_data_city                           VARCHAR,
  merchant_data_country                        VARCHAR,
  merchant_data_name                           VARCHAR,
  merchant_data_network_id                     VARCHAR,
  merchant_data_postal_code                    VARCHAR,
  merchant_data_state                          VARCHAR,
  network_data_acquiring_institution_id        VARCHAR,
  risk_assessment_card_testing_risk_invalid_account_number_decline_rate_past_hour BIGINT,
  risk_assessment_card_testing_risk_invalid_credentials_decline_rate_past_hour BIGINT,
  risk_assessment_card_testing_risk_level      VARCHAR,
  risk_assessment_fraud_risk_level             VARCHAR,
  risk_assessment_fraud_risk_score             DOUBLE,
  risk_assessment_merchant_dispute_risk_dispute_rate BIGINT,
  risk_assessment_merchant_dispute_risk_level  VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR,
  verification_data_address_line1_check        VARCHAR,
  verification_data_address_postal_code_check  VARCHAR,
  verification_data_cvc_check                  VARCHAR,
  verification_data_expiry_check               VARCHAR,
  verification_data_postal_code                VARCHAR,
  wallet                                       VARCHAR
);

-- Metadata key/value pairs set on issuing_authorizations. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_authorizations_metadata (
  issuing_authorization_id                     VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE issuing_authorizations_request_history (
  issuing_authorization_id                     VARCHAR,
  amount                                       BIGINT,
  amount_details_atm_fee                       BIGINT,
  amount_details_cashback_amount               BIGINT,
  approved                                     BOOLEAN,
  authorization_code                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  merchant_amount                              BIGINT,
  merchant_currency                            VARCHAR,
  network_risk_score                           BIGINT,
  reason                                       VARCHAR,
  reason_message                               VARCHAR,
  requested_at                                 TIMESTAMP
);

-- People or businesses that hold cards you have issued.
CREATE TABLE issuing_cardholders (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  billing_address_city                         VARCHAR,
  billing_address_country                      VARCHAR,
  billing_address_line1                        VARCHAR,
  billing_address_line2                        VARCHAR,
  billing_address_postal_code                  VARCHAR,
  billing_address_state                        VARCHAR,
  company_tax_id_provided                      BOOLEAN,
  created                                      TIMESTAMP,
  email                                        VARCHAR,
  individual_dob_day                           BIGINT,
  individual_dob_month                         BIGINT,
  individual_dob_year                          BIGINT,
  individual_first_name                        VARCHAR,
  individual_last_name                         VARCHAR,
  individual_verification_document_back_id     VARCHAR,
  individual_verification_document_front_id    VARCHAR,
  name                                         VARCHAR,
  phone_number                                 VARCHAR,
  requirements_disabled_reason                 VARCHAR,
  requirements_past_due                        VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on issuing_cardholders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cardholders_metadata (
  issuing_cardholder_id                        VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Cards you have issued.
CREATE TABLE issuing_cards (
  id                                           VARCHAR,
  allowed_authorization_period_ends_at         TIMESTAMP,
  allowed_authorization_period_starts_at       TIMESTAMP,
  batch_timestamp                              TIMESTAMP,
  brand                                        VARCHAR,
  cancellation_reason                          VARCHAR,
  cardholder_id                                VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  exp_month                                    BIGINT,
  exp_year                                     BIGINT,
  last4                                        VARCHAR,
  latest_fraud_warning_started_at              TIMESTAMP,
  latest_fraud_warning_type                    VARCHAR,
  lifecycle_controls_cancel_after_payment_count BIGINT,
  mcc_groups_allowed_categories                VARCHAR,
  mcc_groups_blocked_categories                VARCHAR,
  personalization_design_id                    VARCHAR,
  program_id                                   VARCHAR,
  replaced_by_id                               VARCHAR,
  replacement_for_id                           VARCHAR,
  shipping_address_city                        VARCHAR,
  shipping_address_country                     VARCHAR,
  shipping_address_line1                       VARCHAR,
  shipping_address_line2                       VARCHAR,
  shipping_address_postal_code                 VARCHAR,
  shipping_address_state                       VARCHAR,
  shipping_address_validation_mode             VARCHAR,
  shipping_address_validation_normalized_address_city VARCHAR,
  shipping_address_validation_normalized_address_country VARCHAR,
  shipping_address_validation_normalized_address_line1 VARCHAR,
  shipping_address_validation_normalized_address_line2 VARCHAR,
  shipping_address_validation_normalized_address_postal_code VARCHAR,
  shipping_address_validation_normalized_address_state VARCHAR,
  shipping_address_validation_result           VARCHAR,
  shipping_carrier                             VARCHAR,
  shipping_eta                                 TIMESTAMP,
  shipping_name                                VARCHAR,
  shipping_service                             VARCHAR,
  shipping_status                              VARCHAR,
  shipping_tracking_number                     VARCHAR,
  shipping_tracking_url                        VARCHAR,
  shipping_type                                VARCHAR,
  spending_limits                              VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on issuing_cards. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_cards_metadata (
  issuing_card_id                              VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE issuing_credit_ledger_adjustments (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  livemode                                     BOOLEAN,
  merchant                                     VARCHAR,
  reason                                       VARCHAR,
  reason_description                           VARCHAR
);


CREATE TABLE issuing_credit_ledger_entries (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  livemode                                     BOOLEAN,
  source_id                                    VARCHAR,
  source_type                                  VARCHAR
);


CREATE TABLE issuing_credit_policies (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  credit_limit_amount                          BIGINT,
  credit_limit_currency                        VARCHAR,
  credit_period_ends_on_days                   VARCHAR,
  credit_period_interval                       VARCHAR,
  credit_period_interval_count                 BIGINT,
  days_until_due                               BIGINT,
  last_effective_attributes_credit_limit_amount_amount BIGINT,
  last_effective_attributes_credit_limit_amount_currency VARCHAR,
  last_effective_attributes_credit_period_ends_on_days VARCHAR,
  last_effective_attributes_credit_period_interval VARCHAR,
  last_effective_attributes_credit_period_interval_count BIGINT,
  last_effective_attributes_effective_until    TIMESTAMP,
  livemode                                     BOOLEAN,
  status                                       VARCHAR,
  upcoming_attributes_credit_limit_amount_amount BIGINT,
  upcoming_attributes_credit_limit_amount_currency VARCHAR,
  upcoming_attributes_credit_period_ends_on_days VARCHAR,
  upcoming_attributes_credit_period_interval   VARCHAR,
  upcoming_attributes_credit_period_interval_count BIGINT,
  upcoming_attributes_effective_at             TIMESTAMP
);


CREATE TABLE issuing_credit_policy_archive (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  credit_limit_amount                          BIGINT,
  credit_limit_currency                        VARCHAR,
  credit_period_ends_on_days                   VARCHAR,
  credit_period_interval                       VARCHAR,
  credit_period_interval_count                 BIGINT,
  credit_policy_id                             VARCHAR,
  days_until_due                               BIGINT,
  last_effective_attributes_credit_limit_amount_amount BIGINT,
  last_effective_attributes_credit_limit_amount_currency VARCHAR,
  last_effective_attributes_credit_period_ends_on_days VARCHAR,
  last_effective_attributes_credit_period_interval VARCHAR,
  last_effective_attributes_credit_period_interval_count BIGINT,
  last_effective_attributes_effective_until    TIMESTAMP,
  livemode                                     BOOLEAN,
  status                                       VARCHAR,
  upcoming_attributes_credit_limit_amount_amount BIGINT,
  upcoming_attributes_credit_limit_amount_currency VARCHAR,
  upcoming_attributes_credit_period_ends_on_days VARCHAR,
  upcoming_attributes_credit_period_interval   VARCHAR,
  upcoming_attributes_credit_period_interval_count BIGINT,
  upcoming_attributes_effective_at             TIMESTAMP
);


CREATE TABLE issuing_credit_repayments (
  id                                           VARCHAR,
  allocation_fees                              BIGINT,
  allocation_interest                          BIGINT,
  allocation_principal                         BIGINT,
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  connected_account                            VARCHAR,
  created                                      TIMESTAMP,
  credit_statement_descriptor                  VARCHAR,
  currency                                     VARCHAR,
  destination                                  VARCHAR,
  destination_balance_type                     VARCHAR,
  failure_balance_transaction_id               VARCHAR,
  merchant                                     VARCHAR,
  status                                       VARCHAR,
  status_transitions_canceled_at               TIMESTAMP,
  status_transitions_failed_at                 TIMESTAMP,
  status_transitions_processing_at             TIMESTAMP,
  status_transitions_reversed_at               TIMESTAMP,
  status_transitions_succeeded_at              TIMESTAMP
);


CREATE TABLE issuing_credit_underwriting_records (
  id                                           VARCHAR,
  application_application_method               VARCHAR,
  application_purpose                          VARCHAR,
  application_submitted_at                     BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      DOUBLE,
  created_from                                 VARCHAR,
  credit_user_email                            VARCHAR,
  credit_user_name                             VARCHAR,
  decided_at                                   BIGINT,
  decision_application_rejected_reason_other_explanation VARCHAR,
  decision_application_rejected_reasons        VARCHAR,
  decision_credit_limit_approved_amount_amount BIGINT,
  decision_credit_limit_approved_amount_currency VARCHAR,
  decision_credit_limit_decreased_amount_amount BIGINT,
  decision_credit_limit_decreased_amount_currency VARCHAR,
  decision_credit_limit_decreased_reasons      VARCHAR,
  decision_credit_line_closed_reasons          VARCHAR,
  decision_deadline                            BIGINT,
  decision_type                                VARCHAR,
  livemode                                     BOOLEAN,
  merchant                                     VARCHAR,
  regulatory_reporting_file                    VARCHAR,
  underwriting_exception_reason                VARCHAR
);


CREATE TABLE issuing_credit_underwriting_records_metadata (
  credit_underwriting_record_id                VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Disputes you filed on behalf of cardholders against merchants.
CREATE TABLE issuing_disputes (
  id                                           VARCHAR,
  amount                                       DOUBLE,
  batch_timestamp                              TIMESTAMP,
  card                                         VARCHAR,
  cardholder                                   VARCHAR,
  created                                      DOUBLE,
  currency                                     VARCHAR,
  evidence_additional_documentation            VARCHAR,
  evidence_canceled_at                         BIGINT,
  evidence_cancellation_policy_provided        BOOLEAN,
  evidence_cancellation_reason                 VARCHAR,
  evidence_card_statement                      VARCHAR,
  evidence_cash_receipt                        VARCHAR,
  evidence_check_image                         VARCHAR,
  evidence_expected_at                         BIGINT,
  evidence_explanation                         VARCHAR,
  evidence_original_transaction                VARCHAR,
  evidence_product_description                 VARCHAR,
  evidence_product_type                        VARCHAR,
  evidence_received_at                         BIGINT,
  evidence_return_description                  VARCHAR,
  evidence_return_status                       VARCHAR,
  evidence_returned_at                         BIGINT,
  internal_reason                              VARCHAR,
  loss_reason                                  VARCHAR,
  merchant                                     VARCHAR,
  reason                                       VARCHAR,
  status                                       VARCHAR,
  transaction                                  VARCHAR,
  updated                                      DOUBLE
);


CREATE TABLE issuing_disputes_metadata (
  dispute_id                                   VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE issuing_funding_obligations (
  id                                           VARCHAR,
  amount_outstanding                           BIGINT,
  amount_paid                                  BIGINT,
  amount_paid_from_reserve                     BIGINT,
  amount_total                                 BIGINT,
  balance_type                                 VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      DOUBLE,
  credit_period_ends_at                        BIGINT,
  credit_period_starts_at                      BIGINT,
  currency                                     VARCHAR,
  due_at                                       BIGINT,
  finalized_at                                 BIGINT,
  grace_period_ends_at                         BIGINT,
  livemode                                     BOOLEAN,
  merchant                                     VARCHAR,
  owed_to                                      VARCHAR,
  paid_at                                      BIGINT,
  status                                       VARCHAR,
  transaction_period_ends_at                   BIGINT,
  transaction_period_starts_at                 BIGINT
);


CREATE TABLE issuing_funding_obligations_metadata (
  funding_obligation_id                        VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Network tokens provisioned for issued cards, such as those created when a card is added to a mobile wallet.
CREATE TABLE issuing_network_tokens (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  card                                         VARCHAR,
  created                                      DOUBLE,
  device_fingerprint                           VARCHAR,
  last4                                        VARCHAR,
  merchant                                     VARCHAR,
  network                                      VARCHAR,
  network_updated_at                           DOUBLE,
  status                                       VARCHAR,
  wallet_provider                              VARCHAR
);


CREATE TABLE issuing_personalization_designs (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  card_logo                                    VARCHAR,
  carrier_text_footer_body                     VARCHAR,
  carrier_text_footer_title                    VARCHAR,
  carrier_text_header_body                     VARCHAR,
  carrier_text_header_title                    VARCHAR,
  created                                      TIMESTAMP,
  livemode                                     BOOLEAN,
  lookup_key                                   VARCHAR,
  name                                         VARCHAR,
  physical_bundle                              VARCHAR,
  preferences_is_default                       BOOLEAN,
  preferences_is_platform_default              BOOLEAN,
  rejection_reasons_card_logo                  VARCHAR,
  rejection_reasons_carrier_text               VARCHAR,
  status                                       VARCHAR
);


CREATE TABLE issuing_personalization_designs_metadata (
  card_design_id                               VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE issuing_programs (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  is_default                                   BOOLEAN,
  platform_program_id                          VARCHAR
);


CREATE TABLE issuing_programs_metadata (
  issuing_program_id                           VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE issuing_transaction_amount_details_tax (
  issuing_transaction_id                       VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  behavior                                     VARCHAR,
  jurisdiction                                 VARCHAR
);

-- Uses of an issued card that actually moved funds, such as completed purchases and refunds.
CREATE TABLE issuing_transactions (
  id                                           VARCHAR,
  amount                                       BIGINT,
  authorization_id                             VARCHAR,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  card_id                                      VARCHAR,
  cardholder_id                                VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  interchange_amount_decimal                   VARCHAR,
  interchange_enhanced_data_interchange_amount_decimal VARCHAR,
  interchange_enhanced_data_interchange_received_on TIMESTAMP,
  merchant_amount                              BIGINT,
  merchant_currency                            VARCHAR,
  merchant_data_category                       VARCHAR,
  merchant_data_category_code                  VARCHAR,
  merchant_data_city                           VARCHAR,
  merchant_data_country                        VARCHAR,
  merchant_data_name                           VARCHAR,
  merchant_data_network_id                     VARCHAR,
  merchant_data_postal_code                    VARCHAR,
  merchant_data_state                          VARCHAR,
  network_data_authorization_code              VARCHAR,
  network_data_processing_date                 VARCHAR,
  network_data_transaction_id                  VARCHAR,
  purchase_details_flight_departure_at         BIGINT,
  purchase_details_flight_passenger_name       VARCHAR,
  purchase_details_flight_refundable           BOOLEAN,
  purchase_details_flight_travel_agency        VARCHAR,
  purchase_details_fuel_type                   VARCHAR,
  purchase_details_fuel_unit                   VARCHAR,
  purchase_details_fuel_unit_cost              BIGINT,
  purchase_details_fuel_unit_cost_decimal      VARCHAR,
  purchase_details_fuel_volume                 BIGINT,
  purchase_details_fuel_volume_decimal         VARCHAR,
  purchase_details_lodging_check_in_at         BIGINT,
  purchase_details_lodging_nights              BIGINT,
  purchase_details_reference                   VARCHAR,
  token_id                                     VARCHAR,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on issuing_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE issuing_transactions_metadata (
  issuing_transaction_id                       VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Granular breakdown of every fee charged or deducted from your Stripe balance, one row per fee component.
CREATE TABLE itemized_fees (
  activity_end_time                            TIMESTAMP,
  activity_start_time                          TIMESTAMP,
  amount                                       DOUBLE,
  balance_transaction_created                  TIMESTAMP,
  balance_transaction_description              VARCHAR,
  balance_transaction_id                       VARCHAR,
  connected_account_id                         VARCHAR,
  credit_note_number                           VARCHAR,
  currency                                     VARCHAR,
  feature_description                          VARCHAR,
  feature_name                                 VARCHAR,
  fee_category                                 VARCHAR,
  fee_description                              VARCHAR,
  fee_transaction_created                      TIMESTAMP,
  fee_transaction_id                           VARCHAR,
  incurred_at                                  TIMESTAMP,
  incurred_by                                  VARCHAR,
  incurred_by_type                             VARCHAR,
  invoice_number                               VARCHAR,
  platform_id                                  VARCHAR,
  pricing_tier                                 BIGINT,
  product                                      VARCHAR,
  product_feature_description                  VARCHAR,
  settled_at                                   TIMESTAMP,
  settled_via                                  VARCHAR,
  suite                                        VARCHAR,
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


CREATE TABLE mandates (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  customer_acceptance_accepted_at              DOUBLE,
  customer_acceptance_online_ip_address        VARCHAR,
  customer_acceptance_online_user_agent        VARCHAR,
  customer_acceptance_type                     VARCHAR,
  on_behalf_of                                 VARCHAR,
  payment_method                               VARCHAR,
  payment_method_details_acss_debit_interval_description VARCHAR,
  payment_method_details_acss_debit_payment_schedule VARCHAR,
  payment_method_details_acss_debit_transaction_type VARCHAR,
  payment_method_details_au_becs_debit_url     VARCHAR,
  payment_method_details_bacs_debit_network_status VARCHAR,
  payment_method_details_bacs_debit_reference  VARCHAR,
  payment_method_details_bacs_debit_revocation_reason VARCHAR,
  payment_method_details_bacs_debit_url        VARCHAR,
  payment_method_details_paypal_billing_agreement_id VARCHAR,
  payment_method_details_payto_amount          BIGINT,
  payment_method_details_payto_amount_type     VARCHAR,
  payment_method_details_payto_end_date        VARCHAR,
  payment_method_details_payto_payment_schedule VARCHAR,
  payment_method_details_payto_payments_per_period BIGINT,
  payment_method_details_payto_purpose         VARCHAR,
  payment_method_details_payto_start_date      VARCHAR,
  payment_method_details_sepa_debit_reference  VARCHAR,
  payment_method_details_sepa_debit_url        VARCHAR,
  payment_method_details_type                  VARCHAR,
  payment_method_details_upi_amount            BIGINT,
  payment_method_details_upi_amount_type       VARCHAR,
  payment_method_details_upi_description       VARCHAR,
  payment_method_details_upi_end_date          BIGINT,
  payment_method_details_us_bank_account_collection_method VARCHAR,
  single_use_amount                            BIGINT,
  single_use_currency                          VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE metered_items_beta (
  id                                           VARCHAR,
  created_at                                   BIGINT,
  display_name                                 VARCHAR,
  invoice_presentation_dimensions              VARCHAR,
  locality_zone                                VARCHAR,
  lookup_key                                   VARCHAR,
  metadata                                     VARCHAR,
  meter                                        VARCHAR,
  object                                       VARCHAR,
  tax_details_tax_code                         VARCHAR,
  unit_label                                   VARCHAR
);


CREATE TABLE money_management_adjustments (
  amount                                       BIGINT,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR
);


CREATE TABLE money_management_financial_accounts (
  country                                      VARCHAR,
  created                                      TIMESTAMP,
  display_name                                 VARCHAR,
  id                                           VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE money_management_financial_accounts_metadata (
  financial_account_id                         VARCHAR,
  "key"                                        VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE money_management_financial_addresses (
  created                                      TIMESTAMP,
  credentials_bank_name                        VARCHAR,
  credentials_bic                              VARCHAR,
  credentials_clabe                            VARCHAR,
  credentials_country                          VARCHAR,
  credentials_crypto_address                   VARCHAR,
  credentials_crypto_memo                      VARCHAR,
  credentials_crypto_network                   VARCHAR,
  credentials_institution_number               VARCHAR,
  credentials_last4                            VARCHAR,
  credentials_routing_number                   VARCHAR,
  credentials_sort_code                        VARCHAR,
  credentials_transit_number                   VARCHAR,
  credentials_type                             VARCHAR,
  currency                                     VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR,
  settlement_currency                          VARCHAR,
  status                                       VARCHAR
);


CREATE TABLE money_management_inbound_transfers (
  created                                      TIMESTAMP,
  credited_amount                              BIGINT,
  credited_currency                            VARCHAR,
  debited_amount                               BIGINT,
  debited_currency                             VARCHAR,
  description                                  VARCHAR,
  from_payment_method_id                       VARCHAR,
  from_payment_method_type                     VARCHAR,
  id                                           VARCHAR,
  status                                       VARCHAR,
  to_financial_account_id                      VARCHAR
);


CREATE TABLE money_management_inbound_transfers_history (
  bank_debit_failure_reason                    VARCHAR,
  bank_debit_return_reason                     VARCHAR,
  created                                      TIMESTAMP,
  effective_at                                 TIMESTAMP,
  id                                           VARCHAR,
  inbound_transfer_id                          VARCHAR,
  level                                        VARCHAR,
  "type"                                       VARCHAR
);


CREATE TABLE money_management_outbound_payments (
  ach_submission                               VARCHAR,
  ach_transaction_purpose                      VARCHAR,
  canceled_at                                  TIMESTAMP,
  created                                      TIMESTAMP,
  credited_amount                              BIGINT,
  credited_currency                            VARCHAR,
  debited_amount                               BIGINT,
  debited_currency                             VARCHAR,
  delivery_options_bank_account                VARCHAR,
  description                                  VARCHAR,
  expected_arrival_date                        TIMESTAMP,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  from_financial_account_id                    VARCHAR,
  id                                           VARCHAR,
  payout_method_options_bank_account_preferred_networks VARCHAR,
  posted_at                                    TIMESTAMP,
  returned_at                                  TIMESTAMP,
  returned_reason                              VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  to_payout_method_id                          VARCHAR,
  to_recipient_id                              VARCHAR
);


CREATE TABLE money_management_outbound_payments_metadata (
  "key"                                        VARCHAR,
  outbound_payment_id                          VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE money_management_outbound_transfers (
  canceled_at                                  TIMESTAMP,
  created                                      TIMESTAMP,
  credited_amount                              BIGINT,
  credited_currency                            VARCHAR,
  debited_amount                               BIGINT,
  debited_currency                             VARCHAR,
  delivery_options_bank_account                VARCHAR,
  description                                  VARCHAR,
  expected_arrival_date                        TIMESTAMP,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  from_financial_account_id                    VARCHAR,
  id                                           VARCHAR,
  payout_method_options_bank_account_preferred_networks VARCHAR,
  posted_at                                    TIMESTAMP,
  returned_at                                  TIMESTAMP,
  returned_reason                              VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  to_payout_method_id                          VARCHAR
);


CREATE TABLE money_management_outbound_transfers_metadata (
  "key"                                        VARCHAR,
  outbound_transfer_id                         VARCHAR,
  "value"                                      VARCHAR
);


CREATE TABLE money_management_received_credits (
  amount                                       BIGINT,
  balance_transfer_from_account_id             VARCHAR,
  balance_transfer_id                          VARCHAR,
  balance_transfer_type                        VARCHAR,
  bank_transfer_account_holder_name            VARCHAR,
  bank_transfer_bank_name                      VARCHAR,
  bank_transfer_bic                            VARCHAR,
  bank_transfer_financial_address_id           VARCHAR,
  bank_transfer_last4                          VARCHAR,
  bank_transfer_network                        VARCHAR,
  bank_transfer_origin_type                    VARCHAR,
  bank_transfer_routing_number                 VARCHAR,
  bank_transfer_sort_code                      VARCHAR,
  bank_transfer_statement_descriptor           VARCHAR,
  card_spend_card_id                           VARCHAR,
  card_spend_issuing_dispute                   VARCHAR,
  card_spend_issuing_refund                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR,
  returned_at                                  TIMESTAMP,
  returned_reason                              VARCHAR,
  status                                       VARCHAR,
  succeeded_at                                 TIMESTAMP,
  "type"                                       VARCHAR
);


CREATE TABLE money_management_received_debits (
  amount                                       BIGINT,
  bank_transfer_bank_name                      VARCHAR,
  bank_transfer_financial_address_id           VARCHAR,
  bank_transfer_network                        VARCHAR,
  bank_transfer_routing_number                 VARCHAR,
  bank_transfer_statement_descriptor           VARCHAR,
  canceled_at                                  TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failed_at                                    TIMESTAMP,
  failed_reason                                VARCHAR,
  financial_account_id                         VARCHAR,
  id                                           VARCHAR,
  status                                       VARCHAR,
  succeeded_at                                 TIMESTAMP,
  "type"                                       VARCHAR
);


CREATE TABLE money_management_transaction_entries (
  available_balance_impact                     BIGINT,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  effective_at                                 TIMESTAMP,
  id                                           VARCHAR,
  inbound_pending_balance_impact               BIGINT,
  outbound_pending_balance_impact              BIGINT,
  transaction_id                               VARCHAR
);


CREATE TABLE money_management_transactions (
  amount                                       BIGINT,
  available_balance_impact                     BIGINT,
  category                                     VARCHAR,
  counterparty_name                            VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  financial_account_id                         VARCHAR,
  flow_id                                      VARCHAR,
  flow_type                                    VARCHAR,
  id                                           VARCHAR,
  inbound_pending_balance_impact               BIGINT,
  outbound_pending_balance_impact              BIGINT,
  posted_at                                    TIMESTAMP,
  status                                       VARCHAR,
  void_at                                      TIMESTAMP
);

-- network_cost_insights_report: no column detail published; see sigma_schema.json


CREATE TABLE payins_insights_lightning_astro_deduped_aggregated_with_attempts_v2 (
  attributable_optimization                    VARCHAR,
  blocked_reason                               VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  cof                                          VARCHAR,
  currency                                     VARCHAR,
  decline_reason                               VARCHAR,
  gateway_conversation_avs_outcome             VARCHAR,
  gateway_conversation_cvc_outcome             VARCHAR,
  is_connected_account                         VARCHAR,
  outcome_type                                 VARCHAR,
  transaction_initiator                        VARCHAR,
  used_network_tokens                          VARCHAR,
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  created_hour                                 TIMESTAMP,
  transaction_amount                           BIGINT,
  transaction_amount_in_usd                    BIGINT,
  transaction_count                            BIGINT
);


CREATE TABLE payins_insights_lightning_astro_raw_aggregated_with_attempts_v2 (
  attributable_optimization                    VARCHAR,
  blocked_reason                               VARCHAR,
  card_brand                                   VARCHAR,
  card_country                                 VARCHAR,
  card_input_method                            VARCHAR,
  card_type                                    VARCHAR,
  cof                                          VARCHAR,
  currency                                     VARCHAR,
  decline_reason                               VARCHAR,
  gateway_conversation_avs_outcome             VARCHAR,
  gateway_conversation_cvc_outcome             VARCHAR,
  is_connected_account                         VARCHAR,
  outcome_type                                 VARCHAR,
  transaction_initiator                        VARCHAR,
  used_network_tokens                          VARCHAR,
  accepted_amount                              BIGINT,
  accepted_amount_in_usd                       BIGINT,
  accepted_count                               BIGINT,
  created_hour                                 TIMESTAMP,
  transaction_amount                           BIGINT,
  transaction_amount_in_usd                    BIGINT,
  transaction_count                            BIGINT
);


CREATE TABLE payment_evaluations (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  billing_email                                VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_email                               VARCHAR,
  early_fraud_warning_risk_level               VARCHAR,
  early_fraud_warning_score                    DOUBLE,
  fraudulent_dispute_risk_level                VARCHAR,
  fraudulent_dispute_score                     DOUBLE,
  fraudulent_payment_risk_level                VARCHAR,
  fraudulent_payment_score                     DOUBLE,
  payment_method_id                            VARCHAR,
  recommended_action                           VARCHAR,
  risk_recommended_action                      VARCHAR,
  risk_score                                   BIGINT
);


CREATE TABLE payment_intent_line_items (
  id                                           VARCHAR,
  payment_intent_id                            VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      DOUBLE,
  discount_amount                              BIGINT,
  livemode                                     BOOLEAN,
  merchant                                     VARCHAR,
  payment_method_options_klarna_image_url      VARCHAR,
  payment_method_options_klarna_product_url    VARCHAR,
  payment_method_options_paypal_category       VARCHAR,
  payment_method_options_paypal_description    VARCHAR,
  payment_method_options_paypal_sold_by        VARCHAR,
  product_code                                 VARCHAR,
  product_name                                 VARCHAR,
  quantity                                     BIGINT,
  total_tax_amount                             BIGINT,
  unit_cost                                    BIGINT
);

-- One row per PaymentIntent. Represents the full lifecycle of collecting a payment, including attempts that never produced a charge.
CREATE TABLE payment_intents (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_capturable                            BIGINT,
  amount_details_discount_amount               BIGINT,
  amount_details_shipping_amount               BIGINT,
  amount_details_shipping_from_postal_code     VARCHAR,
  amount_details_shipping_to_postal_code       VARCHAR,
  amount_details_surcharge_amount              BIGINT,
  amount_details_tax_total_tax_amount          BIGINT,
  amount_details_tip_amount                    BIGINT,
  application_fee_amount                       BIGINT,
  application_id                               VARCHAR,
  batch_timestamp                              TIMESTAMP,
  canceled_at                                  TIMESTAMP,
  cancellation_reason                          VARCHAR,
  capture_method                               VARCHAR,
  card_request_three_d_secure                  VARCHAR,
  confirmation_method                          VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  description                                  VARCHAR,
  invoice_id                                   VARCHAR,
  last_payment_error_charge                    VARCHAR,
  last_payment_error_source                    VARCHAR,
  last_payment_error_type                      VARCHAR,
  managed_payments_enabled                     BOOLEAN,
  on_behalf_of_id                              VARCHAR,
  payment_details_customer_reference           VARCHAR,
  payment_details_order_reference              VARCHAR,
  payment_method_id                            VARCHAR,
  payment_method_types                         VARCHAR,
  presentment_amount                           BIGINT,
  presentment_currency                         VARCHAR,
  receipt_email                                VARCHAR,
  review_id                                    VARCHAR,
  setup_future_usage                           VARCHAR,
  statement_descriptor                         VARCHAR,
  statement_descriptor_suffix                  VARCHAR,
  status                                       VARCHAR
);

-- Metadata key/value pairs set on payment_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_intents_metadata (
  "key"                                        VARCHAR,
  payment_intent_id                            VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Reusable shareable links that open a Checkout session.
CREATE TABLE payment_links (
  id                                           VARCHAR,
  active                                       BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP
);

-- Per-charge payment method detail that does not fit in the flattened card_* columns on charges, including 3D Secure results and wallet information.
CREATE TABLE payment_method_details (
  charge_id                                    VARCHAR,
  ach_debit_account_holder_type                VARCHAR,
  ach_debit_bank_name                          VARCHAR,
  ach_debit_country                            VARCHAR,
  ach_debit_fingerprint                        VARCHAR,
  ach_debit_last4                              VARCHAR,
  ach_debit_routing_number                     VARCHAR,
  acss_debit_fingerprint                       VARCHAR,
  acss_debit_institution_number                VARCHAR,
  acss_debit_last4                             VARCHAR,
  acss_debit_mandate_id                        VARCHAR,
  acss_debit_transit_number                    VARCHAR,
  alipay_fingerprint                           VARCHAR,
  alipay_transaction_id                        VARCHAR,
  au_becs_debit_bsb_number                     VARCHAR,
  au_becs_debit_fingerprint                    VARCHAR,
  au_becs_debit_last4                          VARCHAR,
  au_becs_debit_mandate_id                     VARCHAR,
  bacs_debit_fingerprint                       VARCHAR,
  bacs_debit_last4                             VARCHAR,
  bacs_debit_mandate_id                        VARCHAR,
  bacs_debit_sort_code                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  bizum_buyer_id                               VARCHAR,
  bizum_transaction_id                         VARCHAR,
  boleto_expires_at                            BIGINT,
  boleto_number                                VARCHAR,
  card_3ds_authenticated                       BOOLEAN,
  card_3ds_succeeded                           BOOLEAN,
  card_3ds_version                             VARCHAR,
  card_address_line1_check                     VARCHAR,
  card_address_postal_code_check               VARCHAR,
  card_amount_authorized                       BIGINT,
  card_authorization_code                      VARCHAR,
  card_brand                                   VARCHAR,
  card_brand_product                           VARCHAR,
  card_country                                 VARCHAR,
  card_cvc_check                               VARCHAR,
  card_exp_month                               BIGINT,
  card_exp_year                                BIGINT,
  card_fingerprint                             VARCHAR,
  card_funding                                 VARCHAR,
  card_generated_card                          VARCHAR,
  card_iin                                     VARCHAR,
  card_installments_plan_count                 BIGINT,
  card_installments_plan_interval              VARCHAR,
  card_installments_plan_type                  VARCHAR,
  card_last4                                   VARCHAR,
  card_mandate                                 VARCHAR,
  card_moto                                    BOOLEAN,
  card_network                                 VARCHAR,
  card_network_token_used                      BOOLEAN,
  card_network_transaction_id                  VARCHAR,
  card_present_dynamic_currency_conversion_cardholder_rate DOUBLE,
  card_present_dynamic_currency_conversion_markup_percent DOUBLE,
  card_present_dynamic_currency_conversion_original_amount BIGINT,
  card_present_dynamic_currency_conversion_original_currency VARCHAR,
  card_present_dynamic_currency_conversion_status VARCHAR,
  card_present_dynamic_currency_conversion_transaction_fx_rate DOUBLE,
  card_read_method                             VARCHAR,
  card_regulated_status                        VARCHAR,
  card_transaction_link_id                     VARCHAR,
  card_wallet_apple_pay_type                   VARCHAR,
  card_wallet_type                             VARCHAR,
  cashapp_buyer_id                             VARCHAR,
  cashapp_cashtag                              VARCHAR,
  cashapp_transaction_id                       VARCHAR,
  customer_balance_bank_transfer_type          VARCHAR,
  customer_balance_funding_type                VARCHAR,
  eps_bank                                     VARCHAR,
  eps_verified_name                            VARCHAR,
  fpx_account_holder_type                      VARCHAR,
  fpx_bank                                     VARCHAR,
  fpx_transaction_id                           VARCHAR,
  giropay_bank_code                            VARCHAR,
  giropay_bank_name                            VARCHAR,
  giropay_bic                                  VARCHAR,
  giropay_verified_name                        VARCHAR,
  ideal_bank                                   VARCHAR,
  ideal_bic                                    VARCHAR,
  ideal_generated_sepa_debit_id                VARCHAR,
  ideal_generated_sepa_debit_mandate_id        VARCHAR,
  ideal_iban_last4                             VARCHAR,
  ideal_transaction_id                         VARCHAR,
  ideal_verified_name                          VARCHAR,
  klarna_payer_details_address_country         VARCHAR,
  klarna_payment_method_category               VARCHAR,
  klarna_preferred_locale                      VARCHAR,
  konbini_store_chain                          VARCHAR,
  link_country                                 VARCHAR,
  multibanco_entity                            VARCHAR,
  multibanco_reference                         VARCHAR,
  naver_buyer_id                               VARCHAR,
  naver_transaction_id                         VARCHAR,
  nz_bank_account_account_holder_name          VARCHAR,
  nz_bank_account_bank_code                    VARCHAR,
  nz_bank_account_bank_name                    VARCHAR,
  nz_bank_account_branch_code                  VARCHAR,
  nz_bank_account_last4                        VARCHAR,
  nz_bank_account_suffix                       VARCHAR,
  oxxo_number                                  VARCHAR,
  p24_bank                                     VARCHAR,
  p24_reference                                VARCHAR,
  p24_verified_name                            VARCHAR,
  paynow_transaction_id                        VARCHAR,
  payto_account_number                         VARCHAR,
  payto_bsb_number                             VARCHAR,
  payto_last4                                  VARCHAR,
  payto_mandate                                VARCHAR,
  payto_pay_id                                 VARCHAR,
  pix_bank_transaction_id                      VARCHAR,
  pix_fingerprint                              VARCHAR,
  promptpay_transaction_id                     VARCHAR,
  sepa_debit_bank_code                         VARCHAR,
  sepa_debit_branch_code                       VARCHAR,
  sepa_debit_country                           VARCHAR,
  sepa_debit_fingerprint                       VARCHAR,
  sepa_debit_last4                             VARCHAR,
  sepa_debit_mandate_id                        VARCHAR,
  sofort_bank_code                             VARCHAR,
  sofort_bank_name                             VARCHAR,
  sofort_bic                                   VARCHAR,
  sofort_country                               VARCHAR,
  sofort_iban_last4                            VARCHAR,
  sofort_preferred_language                    VARCHAR,
  sofort_verified_name                         VARCHAR,
  swish_fingerprint                            VARCHAR,
  swish_payment_reference                      VARCHAR,
  swish_verified_phone_last4                   VARCHAR,
  terminal_location_id                         VARCHAR,
  terminal_reader_id                           VARCHAR,
  "type"                                       VARCHAR,
  us_bank_account_account_holder_type          VARCHAR,
  us_bank_account_account_type                 VARCHAR,
  us_bank_account_bank_name                    VARCHAR,
  us_bank_account_fingerprint                  VARCHAR,
  us_bank_account_last4                        VARCHAR,
  us_bank_account_mandate_id                   VARCHAR,
  us_bank_account_payment_reference            VARCHAR,
  us_bank_account_routing_number               VARCHAR
);

-- Saved payment instruments attached to customers.
CREATE TABLE payment_methods (
  id                                           VARCHAR,
  acss_debit_fingerprint                       VARCHAR,
  acss_debit_institution_number                VARCHAR,
  acss_debit_last4                             VARCHAR,
  acss_debit_transit_number                    VARCHAR,
  au_becs_debit_bsb_number                     VARCHAR,
  au_becs_debit_fingerprint                    VARCHAR,
  au_becs_debit_last4                          VARCHAR,
  bacs_debit_fingerprint                       VARCHAR,
  bacs_debit_last4                             VARCHAR,
  bacs_debit_sort_code                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  billing_details_address_city                 VARCHAR,
  billing_details_address_country              VARCHAR,
  billing_details_address_line1                VARCHAR,
  billing_details_address_line2                VARCHAR,
  billing_details_address_postal_code          VARCHAR,
  billing_details_address_state                VARCHAR,
  billing_details_email                        VARCHAR,
  billing_details_name                         VARCHAR,
  billing_details_phone                        VARCHAR,
  bizum_buyer_id                               VARCHAR,
  boleto_tax_id                                VARCHAR,
  card_address_line1_check                     VARCHAR,
  card_address_postal_code_check               VARCHAR,
  card_brand                                   VARCHAR,
  card_brand_product                           VARCHAR,
  card_country                                 VARCHAR,
  card_cvc_check                               VARCHAR,
  card_exp_month                               BIGINT,
  card_exp_year                                BIGINT,
  card_fingerprint                             VARCHAR,
  card_funding                                 VARCHAR,
  card_generated_from_charge_id                VARCHAR,
  card_iin                                     VARCHAR,
  card_last4                                   VARCHAR,
  card_regulated_status                        VARCHAR,
  card_three_d_secure_supported                BOOLEAN,
  card_wallet_apple_pay_type                   VARCHAR,
  card_wallet_type                             VARCHAR,
  cashapp_buyer_id                             VARCHAR,
  cashapp_cashtag                              VARCHAR,
  created                                      TIMESTAMP,
  custom_type                                  VARCHAR,
  customer_id                                  VARCHAR,
  eps_bank                                     VARCHAR,
  fpx_account_holder_type                      VARCHAR,
  fpx_bank                                     VARCHAR,
  ideal_bank                                   VARCHAR,
  ideal_bic                                    VARCHAR,
  klarna_dob_day                               BIGINT,
  klarna_dob_month                             BIGINT,
  klarna_dob_year                              BIGINT,
  link_email                                   VARCHAR,
  naver_buyer_id                               VARCHAR,
  naver_funding                                VARCHAR,
  nz_bank_account_account_holder_name          VARCHAR,
  nz_bank_account_bank_code                    VARCHAR,
  nz_bank_account_bank_name                    VARCHAR,
  nz_bank_account_branch_code                  VARCHAR,
  nz_bank_account_last4                        VARCHAR,
  nz_bank_account_suffix                       VARCHAR,
  p24_bank                                     VARCHAR,
  paypal_country                               VARCHAR,
  paypal_payer_email                           VARCHAR,
  paypal_payer_id                              VARCHAR,
  payto_account_number                         VARCHAR,
  payto_bsb_number                             VARCHAR,
  payto_last4                                  VARCHAR,
  payto_pay_id                                 VARCHAR,
  pix_fingerprint                              VARCHAR,
  sepa_debit_bank_code                         VARCHAR,
  sepa_debit_branch_code                       VARCHAR,
  sepa_debit_country                           VARCHAR,
  sepa_debit_fingerprint                       VARCHAR,
  sepa_debit_generated_from_charge_id          VARCHAR,
  sepa_debit_generated_from_setup_attempt_id   VARCHAR,
  sepa_debit_last4                             VARCHAR,
  sofort_country                               VARCHAR,
  "type"                                       VARCHAR,
  upi_vpa                                      VARCHAR,
  us_bank_account_account_holder_type          VARCHAR,
  us_bank_account_account_type                 VARCHAR,
  us_bank_account_fingerprint                  VARCHAR,
  us_bank_account_last4                        VARCHAR,
  us_bank_account_linked_account               VARCHAR,
  us_bank_account_routing_number               VARCHAR
);

-- Metadata key/value pairs set on payment_methods. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_methods_metadata (
  "key"                                        VARCHAR,
  payment_method_id                            VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Unified payment records spanning Stripe and externally processed payments.
CREATE TABLE payment_records (
  id                                           VARCHAR,
  amount_authorized_currency                   VARCHAR,
  amount_authorized_value                      BIGINT,
  amount_canceled_currency                     VARCHAR,
  amount_canceled_value                        BIGINT,
  amount_currency                              VARCHAR,
  amount_disputed_currency                     VARCHAR,
  amount_disputed_value                        BIGINT,
  amount_failed_currency                       VARCHAR,
  amount_failed_value                          BIGINT,
  amount_guaranteed_currency                   VARCHAR,
  amount_guaranteed_value                      BIGINT,
  amount_refunded_currency                     VARCHAR,
  amount_refunded_value                        BIGINT,
  amount_requested_currency                    VARCHAR,
  amount_requested_value                       BIGINT,
  amount_value                                 BIGINT,
  application                                  VARCHAR,
  capture_method                               VARCHAR,
  created                                      TIMESTAMP,
  customer_details_customer                    VARCHAR,
  customer_details_email                       VARCHAR,
  customer_details_name                        VARCHAR,
  customer_details_phone                       VARCHAR,
  customer_presence                            VARCHAR,
  description                                  VARCHAR,
  initiated_at                                 TIMESTAMP,
  latest_occurred_at                           TIMESTAMP,
  latest_payment_attempt_record                VARCHAR,
  money_services_transaction_type              VARCHAR,
  payment_method_details_billing_address_city  VARCHAR,
  payment_method_details_billing_address_country VARCHAR,
  payment_method_details_billing_address_line1 VARCHAR,
  payment_method_details_billing_address_line2 VARCHAR,
  payment_method_details_billing_address_postal_code VARCHAR,
  payment_method_details_billing_address_state VARCHAR,
  payment_method_details_billing_email         VARCHAR,
  payment_method_details_billing_name          VARCHAR,
  payment_method_details_billing_phone         VARCHAR,
  payment_method_details_card_brand            VARCHAR,
  payment_method_details_card_capture_before   TIMESTAMP,
  payment_method_details_card_country          VARCHAR,
  payment_method_details_card_exp_month        BIGINT,
  payment_method_details_card_exp_year         BIGINT,
  payment_method_details_card_fingerprint      VARCHAR,
  payment_method_details_card_funding          VARCHAR,
  payment_method_details_card_last4            VARCHAR,
  payment_method_details_card_moto             BOOLEAN,
  payment_method_details_card_network          VARCHAR,
  payment_method_details_card_network_transaction_id VARCHAR,
  payment_method_details_card_payment_account_reference VARCHAR,
  payment_method_details_card_wallet_dynamic_last4 VARCHAR,
  payment_method_details_card_wallet_type      VARCHAR,
  payment_method_details_custom_display_name   VARCHAR,
  payment_method_details_custom_type           VARCHAR,
  payment_method_details_payment_method        VARCHAR,
  payment_method_details_shared_payment_granted_token VARCHAR,
  payment_method_details_shop_pay_external_source_id VARCHAR,
  payment_method_details_type                  VARCHAR,
  processor_adyen_merchant_account             VARCHAR,
  processor_adyen_psp_reference                VARCHAR,
  processor_braintree_merchant_account_id      VARCHAR,
  processor_braintree_transaction_id           VARCHAR,
  processor_custom_payment_reference           VARCHAR,
  processor_stripe_charge                      VARCHAR,
  processor_type                               VARCHAR,
  processor_worldpay_merchant_code             VARCHAR,
  processor_worldpay_order_code                VARCHAR,
  reported_by                                  VARCHAR,
  setup_future_usage                           VARCHAR,
  shipping_address_city                        VARCHAR,
  shipping_address_country                     VARCHAR,
  shipping_address_line1                       VARCHAR,
  shipping_address_line2                       VARCHAR,
  shipping_address_postal_code                 VARCHAR,
  shipping_address_state                       VARCHAR,
  shipping_name                                VARCHAR,
  shipping_phone                               VARCHAR,
  updated                                      TIMESTAMP
);

-- Metadata key/value pairs set on payment_records. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE payment_records_metadata (
  "key"                                        VARCHAR,
  payment_record_id                            VARCHAR,
  "value"                                      VARCHAR
);

-- Payments flagged by Radar for manual review, and how they were resolved.
CREATE TABLE payment_reviews (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  early_fraud_warning_id                       VARCHAR,
  open                                         BOOLEAN,
  payment_intent_id                            VARCHAR,
  reason                                       VARCHAR,
  recommended_refund_confidence_level          VARCHAR,
  recommended_refund_created_at                TIMESTAMP
);


CREATE TABLE payout_minimum_balance_settings (
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR
);

-- Legacy recurring pricing objects, superseded by prices. Retained for older integrations.
CREATE TABLE plans (
  id                                           VARCHAR,
  aggregate_usage                              VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  billing_scheme                               VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  "interval"                                   VARCHAR,
  interval_count                               BIGINT,
  nickname                                     VARCHAR,
  product_id                                   VARCHAR,
  tiers_mode                                   VARCHAR,
  transform_usage_divide_by                    BIGINT,
  transform_usage_round                        VARCHAR,
  trial_period_days                            BIGINT,
  unit_amount_decimal                          VARCHAR,
  usage_type                                   VARCHAR
);

-- Metadata key/value pairs set on plans. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE plans_metadata (
  "key"                                        VARCHAR,
  plan_id                                      VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE platform_tax_settings (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  default_form_type                            VARCHAR,
  k_default_calculation_type                   VARCHAR,
  livemode                                     BOOLEAN,
  merchant                                     VARCHAR,
  misc_default_calculation_type                VARCHAR,
  nec_default_calculation_type                 VARCHAR,
  reporting_year                               BIGINT,
  "year"                                       BIGINT
);

-- Tier definitions for prices using tiered billing.
CREATE TABLE price_tiers (
  price_id                                     VARCHAR,
  upto                                         VARCHAR,
  amount                                       BIGINT,
  amount_decimal                               VARCHAR,
  batch_timestamp                              TIMESTAMP,
  flat_amount                                  BIGINT,
  flat_amount_decimal                          VARCHAR
);

-- How much and how often to charge for a product.
CREATE TABLE prices (
  id                                           VARCHAR,
  active                                       BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  billing_scheme                               VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  custom_unit_amount_default                   BIGINT,
  custom_unit_amount_maximum                   BIGINT,
  custom_unit_amount_minimum                   BIGINT,
  lookup_key                                   VARCHAR,
  nickname                                     VARCHAR,
  product_id                                   VARCHAR,
  recurring_aggregate_usage                    VARCHAR,
  recurring_interval                           VARCHAR,
  recurring_interval_count                     BIGINT,
  recurring_meter_id                           VARCHAR,
  recurring_trial_period_days                  BIGINT,
  recurring_usage_type                         VARCHAR,
  tax_behavior                                 VARCHAR,
  tiers_mode                                   VARCHAR,
  transform_quantity_divide_by                 BIGINT,
  transform_quantity_round                     VARCHAR,
  "type"                                       VARCHAR,
  unit_amount                                  BIGINT,
  unit_amount_decimal                          VARCHAR
);

-- Per-currency overrides for multi-currency prices.
CREATE TABLE prices_currency_options (
  currency                                     VARCHAR,
  price_id                                     VARCHAR,
  batch_timestamp                              TIMESTAMP,
  unit_amount                                  BIGINT,
  unit_amount_decimal                          VARCHAR
);

-- Metadata key/value pairs set on prices. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE prices_metadata (
  "key"                                        VARCHAR,
  price_id                                     VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Goods or services you sell.
CREATE TABLE products (
  id                                           VARCHAR,
  active                                       BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  caption                                      VARCHAR,
  created                                      TIMESTAMP,
  deactivate_on                                VARCHAR,
  description                                  VARCHAR,
  name                                         VARCHAR,
  shippable                                    BOOLEAN,
  statement_descriptor                         VARCHAR,
  "type"                                       VARCHAR,
  unit_label                                   VARCHAR,
  url                                          VARCHAR
);

-- Metadata key/value pairs set on products. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE products_metadata (
  "key"                                        VARCHAR,
  product_id                                   VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Customer-facing codes that map to a coupon.
CREATE TABLE promotion_codes (
  id                                           VARCHAR,
  active                                       BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  code                                         VARCHAR,
  coupon_id                                    VARCHAR,
  created                                      TIMESTAMP,
  customer_id                                  VARCHAR,
  expires_at                                   BIGINT,
  max_redemptions                              BIGINT,
  restrictions_first_time_transaction          BOOLEAN,
  restrictions_minium_amount                   BIGINT,
  restrictions_minium_amount_currency          VARCHAR,
  times_redeemed                               BIGINT
);


CREATE TABLE purchase_details_receipts (
  issuing_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  description                                  VARCHAR,
  quantity                                     DOUBLE,
  total                                        BIGINT,
  unit_cost                                    BIGINT
);


CREATE TABLE quote_metadata (
  "key"                                        VARCHAR,
  quote_id                                     VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Sales quotes that can be accepted to create an invoice or subscription.
CREATE TABLE quotes (
  id                                           VARCHAR,
  accepted_at                                  TIMESTAMP,
  amount_subtotal                              BIGINT,
  amount_total                                 BIGINT,
  application_fee_amount                       BIGINT,
  application_fee_percent                      BIGINT,
  automatic_tax_enabled                        BOOLEAN,
  automatic_tax_status                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  canceled_at                                  TIMESTAMP,
  cloned_from                                  VARCHAR,
  collection_method                            VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  default_tax_rates                            VARCHAR,
  description                                  VARCHAR,
  expires_at                                   TIMESTAMP,
  finalized_at                                 TIMESTAMP,
  footer                                       VARCHAR,
  header                                       VARCHAR,
  invoice_id                                   VARCHAR,
  invoice_settings_days_until_due              DOUBLE,
  is_revision                                  BOOLEAN,
  line_item_group                              VARCHAR,
  number                                       VARCHAR,
  on_behalf_of_id                              VARCHAR,
  recurring_line_item_group                    VARCHAR,
  status                                       VARCHAR,
  subscription_data_billing_mode_type          VARCHAR,
  subscription_data_description                VARCHAR,
  subscription_data_effective_date             BIGINT,
  subscription_data_proration_discounts        VARCHAR,
  subscription_data_trial_period_days          BIGINT,
  subscription_id                              VARCHAR,
  transfer_data_amount                         BIGINT,
  transfer_data_destination_amount_percent     DOUBLE,
  transfer_data_destination_id                 VARCHAR,
  upcoming_line_item_group                     VARCHAR
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
  rule_id                                      VARCHAR,
  action                                       VARCHAR,
  predicate                                    VARCHAR
);


CREATE TABLE rate_card_rates_beta (
  id                                           VARCHAR,
  created_at                                   BIGINT,
  custom_pricing_unit_amount_custom_pricing_unit_id VARCHAR,
  custom_pricing_unit_amount_value             VARCHAR,
  locality_zone                                VARCHAR,
  metadata                                     VARCHAR,
  metered_item_id                              VARCHAR,
  object                                       VARCHAR,
  rate_card_id                                 VARCHAR,
  rate_card_version_id                         VARCHAR,
  tiering_mode                                 VARCHAR,
  transform_quantity_divide_by                 BIGINT,
  transform_quantity_round                     VARCHAR,
  unit_amount                                  VARCHAR
);

-- Smart Retries and dunning outcomes — revenue recovered after a failed subscription payment.
CREATE TABLE recoveries (
  id                                           VARCHAR,
  amount_due                                   BIGINT,
  amount_paid                                  BIGINT,
  attempt_count                                BIGINT,
  initial_failed_amount                        BIGINT,
  initial_payment_decline_reason               VARCHAR,
  initial_payment_failed_at                    TIMESTAMP,
  next_payment_attempt                         TIMESTAMP,
  on_behalf_of_id                              VARCHAR,
  paid_at                                      TIMESTAMP,
  recovered_amount                             BIGINT,
  recovered_at                                 TIMESTAMP,
  recovery_method                              VARCHAR,
  reporting_currency                           VARCHAR,
  retries_exhausted                            BOOLEAN,
  retry_attempt_count                          BIGINT,
  source_id                                    VARCHAR,
  source_type                                  VARCHAR
);

-- One row per Refund object. Refunds are separate objects from charges; refunding a charge creates a row here and a matching balance transaction.
CREATE TABLE refunds (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  failure_balance_transaction_id               VARCHAR,
  failure_reason                               VARCHAR,
  reason                                       VARCHAR,
  receipt_number                               VARCHAR,
  refund_description                           VARCHAR,
  refund_payment_intent                        VARCHAR,
  refund_transfer_reversal_id                  VARCHAR,
  source_transfer_reversal_id                  VARCHAR,
  status                                       VARCHAR
);

-- Metadata key/value pairs set on refunds. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE refunds_metadata (
  "key"                                        VARCHAR,
  refund_id                                    VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Double-entry debits and credits produced by Stripe Revenue Recognition, for building deferred revenue and recognized revenue schedules.
CREATE TABLE revenue_recognition_debits_and_credits (
  id                                           VARCHAR,
  accounting_period_date                       TIMESTAMP,
  adjustment_id                                VARCHAR,
  amount                                       DOUBLE,
  booked_date                                  TIMESTAMP,
  charge_id                                    VARCHAR,
  credit                                       VARCHAR,
  credit_account_type                          VARCHAR,
  credit_gl_code                               VARCHAR,
  credit_note_id                               VARCHAR,
  currency                                     VARCHAR,
  customer_balance_transaction_id              VARCHAR,
  customer_id                                  VARCHAR,
  debit                                        VARCHAR,
  debit_account_type                           VARCHAR,
  debit_gl_code                                VARCHAR,
  dispute_id                                   VARCHAR,
  event_type                                   VARCHAR,
  external_transaction_source                  VARCHAR,
  invoice_id                                   VARCHAR,
  invoice_item_id                              VARCHAR,
  is_accounting_period_open                    BOOLEAN,
  line_item_id                                 VARCHAR,
  livemode                                     BOOLEAN,
  manual_journal_entry_model_id                VARCHAR,
  original_accounting_period_date              TIMESTAMP,
  plan_type                                    VARCHAR,
  presentment_amount                           DOUBLE,
  presentment_currency                         VARCHAR,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  product_type                                 VARCHAR,
  refund_id                                    VARCHAR,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR,
  subscription_type                            VARCHAR
);


CREATE TABLE revenue_recognition_exclusions (
  transaction_id                               VARCHAR,
  created_at                                   TIMESTAMP,
  deleted_at                                   TIMESTAMP
);


CREATE TABLE revenue_recognition_manual_journal_entries (
  id                                           VARCHAR,
  accounting_period_date                       TIMESTAMP,
  created                                      TIMESTAMP,
  credit_account                               VARCHAR,
  credit_account_gl_name                       VARCHAR,
  debit_account                                VARCHAR,
  debit_account_gl_name                        VARCHAR,
  deleted_at                                   TIMESTAMP,
  description                                  VARCHAR,
  email                                        VARCHAR,
  livemode                                     BOOLEAN,
  presentment_amount                           DOUBLE,
  presentment_currency                         VARCHAR,
  settlement_amount                            DOUBLE,
  settlement_currency                          VARCHAR,
  transaction_id                               VARCHAR
);


CREATE TABLE revenue_recognition_month_summary (
  id                                           VARCHAR,
  accounting_period_date                       TIMESTAMP,
  billing_interval                             VARCHAR,
  billing_interval_count                       BIGINT,
  charge_id                                    VARCHAR,
  credit_note_id                               VARCHAR,
  customer_balance_transaction_id              VARCHAR,
  customer_id                                  VARCHAR,
  dispute_id                                   VARCHAR,
  external_transaction_source                  VARCHAR,
  invoice_id                                   VARCHAR,
  invoice_item_id                              VARCHAR,
  line_item_id                                 VARCHAR,
  livemode                                     BOOLEAN,
  locality_zone                                VARCHAR,
  month_summary_entry_type                     VARCHAR,
  plan_id                                      VARCHAR,
  presentment_currency                         VARCHAR,
  presentment_net_amount                       BIGINT,
  product_id                                   VARCHAR,
  refund_id                                    VARCHAR,
  settlement_currency                          VARCHAR,
  settlement_net_amount                        BIGINT,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR,
  transaction_type                             VARCHAR
);

-- Every Radar rule evaluation, including 3DS rules triggered on PaymentIntents and SetupIntents.
CREATE TABLE rule_decisions (
  id                                           VARCHAR,
  action                                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  charge_id                                    VARCHAR,
  created                                      TIMESTAMP,
  payment_intent_id                            VARCHAR,
  rule_id                                      VARCHAR,
  rule_override_by_allow_rule                  BOOLEAN,
  setup_intent_id                              VARCHAR
);

-- Individual attempts to confirm a SetupIntent, including failures.
CREATE TABLE setup_attempts (
  id                                           VARCHAR,
  application_id                               VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  customer_id                                  VARCHAR,
  flow_directions                              VARCHAR,
  on_behalf_of_id                              VARCHAR,
  payment_method_id                            VARCHAR,
  setup_error_advice_code                      VARCHAR,
  setup_error_code                             VARCHAR,
  setup_error_decline_code                     VARCHAR,
  setup_error_doc_url                          VARCHAR,
  setup_error_message                          VARCHAR,
  setup_error_network_advice_code              VARCHAR,
  setup_error_network_decline_code             VARCHAR,
  setup_error_param                            VARCHAR,
  setup_error_payment_method_id                VARCHAR,
  setup_error_type                             VARCHAR,
  setup_intent_id                              VARCHAR,
  status                                       VARCHAR,
  usage                                        VARCHAR
);

-- Attempts to save a payment method for future use without charging it immediately.
CREATE TABLE setup_intents (
  id                                           VARCHAR,
  application_id                               VARCHAR,
  batch_timestamp                              TIMESTAMP,
  cancellation_reason                          VARCHAR,
  card_request_three_d_secure                  VARCHAR,
  created                                      TIMESTAMP,
  customer_id                                  VARCHAR,
  description                                  VARCHAR,
  flow_directions                              VARCHAR,
  last_setup_error_advice_code                 VARCHAR,
  last_setup_error_code                        VARCHAR,
  last_setup_error_decline_code                VARCHAR,
  last_setup_error_doc_url                     VARCHAR,
  last_setup_error_message                     VARCHAR,
  last_setup_error_network_advice_code         VARCHAR,
  last_setup_error_network_decline_code        VARCHAR,
  last_setup_error_param                       VARCHAR,
  last_setup_error_payment_method_id           VARCHAR,
  last_setup_error_type                        VARCHAR,
  latest_attempt_id                            VARCHAR,
  managed_payments_enabled                     BOOLEAN,
  mandate_id                                   VARCHAR,
  on_behalf_of_id                              VARCHAR,
  payment_method_id                            VARCHAR,
  payment_method_types                         VARCHAR,
  single_use_mandate_id                        VARCHAR,
  status                                       VARCHAR,
  usage                                        VARCHAR
);

-- Metadata key/value pairs set on setup_intents. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE setup_intents_metadata (
  "key"                                        VARCHAR,
  setup_intent_id                              VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Legacy payment sources, superseded by payment_methods. Present for older integrations.
CREATE TABLE sources (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  client_secret                                VARCHAR,
  code_verification_attempts_remaining         BIGINT,
  code_verification_status                     VARCHAR,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  flow                                         VARCHAR,
  owner_address_city                           VARCHAR,
  owner_address_country                        VARCHAR,
  owner_address_line1                          VARCHAR,
  owner_address_line2                          VARCHAR,
  owner_address_postal_code                    VARCHAR,
  owner_address_state                          VARCHAR,
  owner_email                                  VARCHAR,
  owner_name                                   VARCHAR,
  owner_phone                                  VARCHAR,
  owner_verified_address_city                  VARCHAR,
  owner_verified_address_country               VARCHAR,
  owner_verified_address_line1                 VARCHAR,
  owner_verified_address_line2                 VARCHAR,
  owner_verified_address_postal_code           VARCHAR,
  owner_verified_address_state                 VARCHAR,
  owner_verified_email                         VARCHAR,
  owner_verified_name                          VARCHAR,
  owner_verified_phone                         VARCHAR,
  receiver_address                             VARCHAR,
  receiver_amount_charged                      BIGINT,
  receiver_amount_received                     BIGINT,
  receiver_amount_returned                     BIGINT,
  redirect_failure_reason                      VARCHAR,
  redirect_return_url                          VARCHAR,
  redirect_status                              VARCHAR,
  redirect_url                                 VARCHAR,
  status                                       VARCHAR,
  "type"                                       VARCHAR,
  usage                                        VARCHAR
);

-- Metadata key/value pairs set on sources. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE sources_metadata (
  "key"                                        VARCHAR,
  source_id                                    VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Pre-computed MRR movement events. Stripe's recommended basis for MRR, churn and expansion reporting — far more reliable than deriving movements from s
CREATE TABLE subscription_item_change_events (
  event_timestamp                              VARCHAR,
  event_type                                   VARCHAR,
  subscription_item_id                         VARCHAR,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  local_event_timestamp                        TIMESTAMP,
  mrr_change                                   BIGINT,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  quantity_change                              BIGINT,
  subscription_id                              VARCHAR
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
  event_timestamp                              VARCHAR,
  event_type                                   VARCHAR,
  subscription_item_id                         VARCHAR,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  local_event_timestamp                        TIMESTAMP,
  mrr_change                                   BIGINT,
  price_id                                     VARCHAR,
  product_id                                   VARCHAR,
  quantity_change                              BIGINT,
  subscription_id                              VARCHAR
);

-- Individual priced items on a subscription. A subscription with multiple products has one row per product here.
CREATE TABLE subscription_items (
  id                                           VARCHAR,
  subscription_id                              VARCHAR,
  batch_timestamp                              TIMESTAMP,
  billing_thresholds_usage_gte                 BIGINT,
  created                                      BIGINT,
  discounts                                    VARCHAR,
  item_current_period_end                      TIMESTAMP,
  item_current_period_start                    TIMESTAMP,
  plan_amount                                  BIGINT,
  plan_created                                 TIMESTAMP,
  plan_currency                                VARCHAR,
  plan_id                                      VARCHAR,
  plan_interval                                VARCHAR,
  plan_interval_count                          BIGINT,
  plan_nickname                                VARCHAR,
  plan_product_id                              VARCHAR,
  plan_trial_period_days                       BIGINT,
  price_created                                TIMESTAMP,
  price_currency                               VARCHAR,
  price_id                                     VARCHAR,
  price_nickname                               VARCHAR,
  price_product_id                             VARCHAR,
  price_recurring_interval                     VARCHAR,
  price_recurring_interval_count               BIGINT,
  price_recurring_trial_period_days            BIGINT,
  price_unit_amount                            BIGINT,
  quantity                                     BIGINT,
  subscription                                 VARCHAR
);

-- Metadata key/value pairs set on subscription_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_items_metadata (
  "key"                                        VARCHAR,
  subscription_id                              VARCHAR,
  subscription_item_id                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- One-off invoice items attached to a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_add_invoice_items (
  phase_id                                     VARCHAR,
  price                                        VARCHAR,
  schedule_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  period_end_timestamp                         BIGINT,
  period_end_type                              VARCHAR,
  period_start_timestamp                       BIGINT,
  period_start_type                            VARCHAR,
  quantity                                     BIGINT
);


CREATE TABLE subscription_schedule_phase_add_invoice_items_metadata (
  "key"                                        VARCHAR,
  phase_id                                     VARCHAR,
  price                                        VARCHAR,
  schedule_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Priced items configured within a subscription schedule phase.
CREATE TABLE subscription_schedule_phase_configuration_items (
  phase_id                                     VARCHAR,
  price                                        VARCHAR,
  schedule_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  billing_thresholds_usage_gte                 BIGINT,
  quantity                                     BIGINT,
  trial_offer_id                               VARCHAR
);


CREATE TABLE subscription_schedule_phase_configuration_items_metadata (
  "key"                                        VARCHAR,
  phase_id                                     VARCHAR,
  price                                        VARCHAR,
  schedule_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Individual phases of a subscription schedule.
CREATE TABLE subscription_schedule_phases (
  id                                           VARCHAR,
  application_fee_percent                      DOUBLE,
  automatic_tax_enabled                        BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  billing_cycle_anchor                         VARCHAR,
  billing_thresholds_amount_gte                BIGINT,
  billing_thresholds_reset_billing_cycle_anchor BOOLEAN,
  collection_method                            VARCHAR,
  coupon_id                                    VARCHAR,
  currency                                     VARCHAR,
  default_payment_method                       VARCHAR,
  description                                  VARCHAR,
  end_date                                     TIMESTAMP,
  invoice_settings_days_until_due              DOUBLE,
  on_behalf_of                                 VARCHAR,
  proration_behavior                           VARCHAR,
  schedule_id                                  VARCHAR,
  start_date                                   TIMESTAMP,
  transfer_data_amount_percent                 DOUBLE,
  transfer_data_destination                    VARCHAR,
  trial_end                                    BIGINT
);

-- Metadata key/value pairs set on subscription_schedule_phases. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedule_phases_metadata (
  "key"                                        VARCHAR,
  phase_id                                     VARCHAR,
  schedule_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Planned sequences of subscription phases, used for scheduled price or term changes.
CREATE TABLE subscription_schedules (
  id                                           VARCHAR,
  application_id                               VARCHAR,
  batch_timestamp                              TIMESTAMP,
  billing_mode_type                            VARCHAR,
  canceled_at                                  TIMESTAMP,
  completed_at                                 TIMESTAMP,
  created                                      TIMESTAMP,
  customer                                     VARCHAR,
  default_settings_application_fee_percent     DOUBLE,
  default_settings_automatic_tax_enabled       BOOLEAN,
  default_settings_billing_cycle_anchor        VARCHAR,
  default_settings_collection_method           VARCHAR,
  default_settings_default_payment_method      VARCHAR,
  default_settings_default_source              VARCHAR,
  default_settings_description                 VARCHAR,
  default_settings_invoice_settings_days_until_due DOUBLE,
  default_settings_on_behalf_of                VARCHAR,
  default_settings_transfer_data_amount_percent DOUBLE,
  default_settings_transfer_data_destination   VARCHAR,
  end_behavior                                 VARCHAR,
  proration_discounts                          VARCHAR,
  released_at                                  TIMESTAMP,
  released_subscription                        VARCHAR,
  renewal_interval                             VARCHAR,
  renewal_interval_length                      BIGINT,
  subscription                                 VARCHAR
);

-- Metadata key/value pairs set on subscription_schedules. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscription_schedules_metadata (
  "key"                                        VARCHAR,
  schedule_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- One row per Subscription object. The primary Billing table alongside invoices.
CREATE TABLE subscriptions (
  id                                           VARCHAR,
  application_fee_percent                      DOUBLE,
  application_id                               VARCHAR,
  automatic_tax_enabled                        BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  billing                                      VARCHAR,
  billing_cycle_anchor                         TIMESTAMP,
  billing_mode_type                            VARCHAR,
  billing_mode_updated_at                      TIMESTAMP,
  billing_thresholds_amount_gte                BIGINT,
  billing_thresholds_reset_billing_cycle_anchor BOOLEAN,
  cancel_at                                    TIMESTAMP,
  cancel_at_period_end                         BOOLEAN,
  canceled_at                                  TIMESTAMP,
  cancellation_details_comment                 VARCHAR,
  cancellation_details_feedback                VARCHAR,
  cancellation_details_reason                  VARCHAR,
  cancellation_reason                          VARCHAR,
  cancellation_reason_text                     VARCHAR,
  created                                      TIMESTAMP,
  current_period_end                           TIMESTAMP,
  current_period_start                         TIMESTAMP,
  customer_id                                  VARCHAR,
  days_until_due                               BIGINT,
  default_payment_method_id                    VARCHAR,
  default_source_id                            VARCHAR,
  description                                  VARCHAR,
  discount_checkout_session                    VARCHAR,
  discount_coupon_id                           VARCHAR,
  discount_customer_id                         VARCHAR,
  discount_end                                 TIMESTAMP,
  discount_invoice                             VARCHAR,
  discount_invoice_item                        VARCHAR,
  discount_promotion_code_id                   VARCHAR,
  discount_schedule_id                         VARCHAR,
  discount_start                               TIMESTAMP,
  discount_subscription                        VARCHAR,
  discount_subscription_item                   VARCHAR,
  discounts                                    VARCHAR,
  ended_at                                     TIMESTAMP,
  latest_invoice_id                            VARCHAR,
  managed_payments_enabled                     BOOLEAN,
  next_pending_invoice_item_invoice            TIMESTAMP,
  on_behalf_of_id                              VARCHAR,
  pause_collection_behavior                    VARCHAR,
  pause_collection_resumes_at                  TIMESTAMP,
  payment_settings_payment_method_options_acss_debit_mandate_options_transaction_type VARCHAR,
  payment_settings_payment_method_options_acss_debit_verification_method VARCHAR,
  payment_settings_payment_method_options_bancontact_preferred_language VARCHAR,
  payment_settings_payment_method_options_card_mandate_options_amount BIGINT,
  payment_settings_payment_method_options_card_mandate_options_amount_type VARCHAR,
  payment_settings_payment_method_options_card_mandate_options_description VARCHAR,
  payment_settings_payment_method_options_card_network VARCHAR,
  payment_settings_payment_method_options_card_request_three_d_secure VARCHAR,
  payment_settings_payment_method_options_customer_balance_bank_transfer_eu_bank_transfer_country VARCHAR,
  payment_settings_payment_method_options_customer_balance_bank_transfer_id_bank_transfer_bank VARCHAR,
  payment_settings_payment_method_options_customer_balance_bank_transfer_type VARCHAR,
  payment_settings_payment_method_options_customer_balance_funding_type VARCHAR,
  payment_settings_payment_method_options_us_bank_account_verification_method VARCHAR,
  payment_settings_save_default_payment_method VARCHAR,
  pending_invoice_item_interval                VARCHAR,
  pending_invoice_item_interval_count          BIGINT,
  pending_setup_intent_id                      VARCHAR,
  pending_update_billing_cycle_anchor          TIMESTAMP,
  pending_update_discount_checkout_session     VARCHAR,
  pending_update_discount_coupon_id            VARCHAR,
  pending_update_discount_customer_id          VARCHAR,
  pending_update_discount_end                  TIMESTAMP,
  pending_update_discount_invoice              VARCHAR,
  pending_update_discount_invoice_item         VARCHAR,
  pending_update_discount_promotion_code_id    VARCHAR,
  pending_update_discount_schedule_id          VARCHAR,
  pending_update_discount_start                TIMESTAMP,
  pending_update_discount_subscription         VARCHAR,
  pending_update_discount_subscription_item    VARCHAR,
  pending_update_expires_at                    TIMESTAMP,
  pending_update_trial_end                     TIMESTAMP,
  pending_update_trial_from_plan               BOOLEAN,
  plan_id                                      VARCHAR,
  price_id                                     VARCHAR,
  proration_discounts                          VARCHAR,
  quantity                                     BIGINT,
  schedule_id                                  VARCHAR,
  "start"                                      TIMESTAMP,
  start_date                                   TIMESTAMP,
  status                                       VARCHAR,
  status_details                               VARCHAR,
  tax_percent                                  DOUBLE,
  transfer_data_amount_percent                 DOUBLE,
  transfer_data_destination_id                 VARCHAR,
  trial_end                                    TIMESTAMP,
  trial_settings_end_behavior_missing_payment_method VARCHAR,
  trial_start                                  TIMESTAMP
);

-- Metadata key/value pairs set on subscriptions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE subscriptions_metadata (
  "key"                                        VARCHAR,
  subscription_id                              VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE subscriptions_paid_usage_beta (
  billable_item_source_id                      VARCHAR,
  billing_meter_id                             VARCHAR,
  customer_id                                  VARCHAR,
  start_time                                   VARCHAR,
  billable_item_type                           VARCHAR,
  currency                                     VARCHAR,
  gross_amount                                 BIGINT,
  price_source_id                              VARCHAR,
  price_type                                   VARCHAR,
  segment                                      VARCHAR
);

-- Pre-aggregated balance transaction totals, grouped by period and reporting category. Much cheaper than aggregating balance_transactions yourself.
CREATE TABLE summarized_balance_transactions (
  activity_at_time_bucket                      VARCHAR,
  auto_payout_id                               VARCHAR,
  bt_count                                     VARCHAR,
  bt_effective_at_interval_start               VARCHAR,
  currency                                     VARCHAR,
  gross                                        VARCHAR,
  net                                          VARCHAR,
  payout_is_auto                               VARCHAR,
  reporting_category                           VARCHAR,
  auto_payout_effective_at_interval_start      TIMESTAMP,
  fee                                          DOUBLE
);

-- Product categories Stripe Tax uses to determine tax treatment. Contains all generally available tax codes, not just ones you use.
CREATE TABLE tax_codes (
  id                                           VARCHAR,
  description                                  VARCHAR,
  name                                         VARCHAR
);


CREATE TABLE tax_form_filing_statuses (
  tax_form_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  effective_at                                 TIMESTAMP,
  jurisdiction_country                         VARCHAR,
  jurisdiction_level                           VARCHAR,
  jurisdiction_state                           VARCHAR,
  "value"                                      VARCHAR
);

-- Tax forms (such as 1099s) generated for your connected accounts.
CREATE TABLE tax_forms (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  livemode                                     BOOLEAN,
  payee_account_id                             VARCHAR,
  payee_type                                   VARCHAR,
  "type"                                       VARCHAR,
  us_1099_k_april_volume                       BIGINT,
  us_1099_k_august_volume                      BIGINT,
  us_1099_k_card_not_present_volume            BIGINT,
  us_1099_k_december_volume                    BIGINT,
  us_1099_k_february_volume                    BIGINT,
  us_1099_k_federal_income_tax_withheld        BIGINT,
  us_1099_k_january_volume                     BIGINT,
  us_1099_k_july_volume                        BIGINT,
  us_1099_k_june_volume                        BIGINT,
  us_1099_k_march_volume                       BIGINT,
  us_1099_k_may_volume                         BIGINT,
  us_1099_k_november_volume                    BIGINT,
  us_1099_k_october_volume                     BIGINT,
  us_1099_k_reporting_year                     BIGINT,
  us_1099_k_september_volume                   BIGINT,
  us_1099_k_state_income_tax_withheld          BIGINT,
  us_1099_k_transactions_count                 BIGINT,
  us_1099_misc_crop_insurance_proceeds         BIGINT,
  us_1099_misc_excess_golden_parachute_payments BIGINT,
  us_1099_misc_federal_income_tax_withheld     BIGINT,
  us_1099_misc_fish_purchased_for_resale       BIGINT,
  us_1099_misc_fishing_boat_proceeds           BIGINT,
  us_1099_misc_medical_and_health_care_payments BIGINT,
  us_1099_misc_non_qualified_deferred_compensation BIGINT,
  us_1099_misc_other_income                    BIGINT,
  us_1099_misc_payments_in_lieu_of_dividends_or_interest BIGINT,
  us_1099_misc_payments_to_attorney            BIGINT,
  us_1099_misc_rents                           BIGINT,
  us_1099_misc_reporting_year                  BIGINT,
  us_1099_misc_royalties                       BIGINT,
  us_1099_misc_section_409a_deferrals          BIGINT,
  us_1099_misc_state_income                    BIGINT,
  us_1099_misc_state_tax_withheld              BIGINT,
  us_1099_nec_federal_income_tax_withheld      BIGINT,
  us_1099_nec_nonemployee_compensation         BIGINT,
  us_1099_nec_reporting_year                   BIGINT,
  us_1099_nec_state_income                     BIGINT,
  us_1099_nec_state_income_tax_withheld        BIGINT
);

-- Manually defined tax rates used on invoices and subscriptions. Distinct from Stripe Tax's automatic calculations.
CREATE TABLE tax_rates (
  id                                           VARCHAR,
  active                                       BOOLEAN,
  batch_timestamp                              TIMESTAMP,
  country                                      VARCHAR,
  created                                      TIMESTAMP,
  description                                  VARCHAR,
  display_name                                 VARCHAR,
  effective_percentage                         DOUBLE,
  inclusive                                    BOOLEAN,
  jurisdiction                                 VARCHAR,
  jurisdiction_level                           VARCHAR,
  percentage                                   DOUBLE,
  state                                        VARCHAR,
  tax_type                                     VARCHAR
);

-- Metadata key/value pairs set on tax_rates. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_rates_metadata (
  "key"                                        VARCHAR,
  tax_rate_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE tax_transaction_customer_tax_ids (
  tax_transaction_id                           VARCHAR,
  "type"                                       VARCHAR,
  country                                      VARCHAR,
  "value"                                      VARCHAR
);

-- Per-jurisdiction breakdown of the tax liability for a tax transaction item.
CREATE TABLE tax_transaction_jurisdiction_details (
  tax_transaction_id                           VARCHAR,
  tax_transaction_item_id                      VARCHAR,
  amount_non_taxable                           BIGINT,
  amount_tax                                   BIGINT,
  amount_taxable                               BIGINT,
  currency                                     VARCHAR,
  filing_amount_non_taxable                    BIGINT,
  filing_amount_tax                            BIGINT,
  filing_amount_taxable                        BIGINT,
  filing_currency                              VARCHAR,
  filing_exchange_rate                         DOUBLE,
  jurisdiction_country                         VARCHAR,
  jurisdiction_id                              VARCHAR,
  jurisdiction_level                           VARCHAR,
  jurisdiction_name                            VARCHAR,
  jurisdiction_state                           VARCHAR,
  tax_rate_percentage                          DOUBLE,
  tax_transaction_item_type                    VARCHAR,
  tax_type                                     VARCHAR,
  tax_type_display_name                        VARCHAR,
  taxability                                   VARCHAR,
  taxability_reason                            VARCHAR
);

-- Line items contributing to the sale of goods for a tax transaction.
CREATE TABLE tax_transaction_line_items (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_tax                                   BIGINT,
  currency                                     VARCHAR,
  determined_destination_address_city          VARCHAR,
  determined_destination_address_country       VARCHAR,
  determined_destination_address_line1         VARCHAR,
  determined_destination_address_line2         VARCHAR,
  determined_destination_address_postal_code   VARCHAR,
  determined_destination_address_state         VARCHAR,
  determined_origin_address_city               VARCHAR,
  determined_origin_address_country            VARCHAR,
  determined_origin_address_line1              VARCHAR,
  determined_origin_address_line2              VARCHAR,
  determined_origin_address_postal_code        VARCHAR,
  determined_origin_address_state              VARCHAR,
  determined_tax_location_address_city         VARCHAR,
  determined_tax_location_address_country      VARCHAR,
  determined_tax_location_address_line1        VARCHAR,
  determined_tax_location_address_line2        VARCHAR,
  determined_tax_location_address_postal_code  VARCHAR,
  determined_tax_location_address_state        VARCHAR,
  product_id                                   VARCHAR,
  quantity_decimal                             VARCHAR,
  reference                                    VARCHAR,
  reversal_original_tax_transaction_line_item_id VARCHAR,
  source_line_item_id                          VARCHAR,
  tax_behavior                                 VARCHAR,
  tax_code                                     VARCHAR,
  tax_transaction_id                           VARCHAR
);

-- Metadata key/value pairs set on tax_transaction_line_items. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transaction_line_items_metadata (
  "key"                                        VARCHAR,
  tax_transaction_line_item_id                 VARCHAR,
  "value"                                      VARCHAR
);

-- Shipping costs contributing to a tax transaction. Structurally parallel to tax_transaction_line_items.
CREATE TABLE tax_transaction_shipping_costs (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_tax                                   BIGINT,
  currency                                     VARCHAR,
  determined_destination_address_city          VARCHAR,
  determined_destination_address_country       VARCHAR,
  determined_destination_address_line1         VARCHAR,
  determined_destination_address_line2         VARCHAR,
  determined_destination_address_postal_code   VARCHAR,
  determined_destination_address_state         VARCHAR,
  determined_origin_address_city               VARCHAR,
  determined_origin_address_country            VARCHAR,
  determined_origin_address_line1              VARCHAR,
  determined_origin_address_line2              VARCHAR,
  determined_origin_address_postal_code        VARCHAR,
  determined_origin_address_state              VARCHAR,
  determined_tax_location_address_city         VARCHAR,
  determined_tax_location_address_country      VARCHAR,
  determined_tax_location_address_line1        VARCHAR,
  determined_tax_location_address_line2        VARCHAR,
  determined_tax_location_address_postal_code  VARCHAR,
  determined_tax_location_address_state        VARCHAR,
  shipping_rate_id                             VARCHAR,
  tax_behavior                                 VARCHAR,
  tax_code                                     VARCHAR,
  tax_transaction_id                           VARCHAR
);

-- Records of assumed or reduced tax liability. The recommended starting point for tax reporting, and the bridge between tax tables and invoices or check
CREATE TABLE tax_transactions (
  id                                           VARCHAR,
  created                                      TIMESTAMP,
  customer_details_address_city                VARCHAR,
  customer_details_address_country             VARCHAR,
  customer_details_address_line1               VARCHAR,
  customer_details_address_line2               VARCHAR,
  customer_details_address_postal_code         VARCHAR,
  customer_details_address_source              VARCHAR,
  customer_details_address_state               VARCHAR,
  customer_details_ip_address                  VARCHAR,
  customer_details_taxability_override         VARCHAR,
  customer_id                                  VARCHAR,
  posted_at                                    TIMESTAMP,
  provider                                     VARCHAR,
  reference                                    VARCHAR,
  reversal_original_tax_transaction_id         VARCHAR,
  source_id                                    VARCHAR,
  source_type                                  VARCHAR,
  tax_date                                     TIMESTAMP,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on tax_transactions. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE tax_transactions_metadata (
  "key"                                        VARCHAR,
  tax_transaction_id                           VARCHAR,
  "value"                                      VARCHAR
);

-- Line items on a Terminal hardware order.
CREATE TABLE terminal_hardware_order_items (
  terminal_hardware_order_id                   VARCHAR,
  terminal_hardware_sku_id                     VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  currency                                     VARCHAR,
  quantity                                     BIGINT,
  terminal_hardware_sku_amount                 BIGINT,
  terminal_hardware_sku_country                VARCHAR,
  terminal_hardware_sku_currency               VARCHAR,
  terminal_hardware_sku_product_id             VARCHAR,
  terminal_hardware_sku_product_type           VARCHAR
);

-- Metadata key/value pairs set on terminal_hardware_orders. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE terminal_hardware_order_metadata (
  "key"                                        VARCHAR,
  terminal_hardware_order_id                   VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Shipment tracking information for Terminal hardware orders.
CREATE TABLE terminal_hardware_order_shipment_tracking (
  carrier                                      VARCHAR,
  terminal_hardware_order_id                   VARCHAR,
  tracking_number                              VARCHAR,
  batch_timestamp                              TIMESTAMP
);

-- Tax applied to a Terminal hardware order.
CREATE TABLE terminal_hardware_order_tax_amounts (
  rate_display_name                            VARCHAR,
  rate_jurisdiction                            VARCHAR,
  terminal_hardware_order_id                   VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  inclusive                                    BOOLEAN,
  rate_percentage                              DOUBLE
);

-- Orders you placed for Terminal reader hardware.
CREATE TABLE terminal_hardware_orders (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  livemode                                     BOOLEAN,
  payment_type                                 VARCHAR,
  po_number                                    VARCHAR,
  shipping_address_city                        VARCHAR,
  shipping_address_country                     VARCHAR,
  shipping_address_line1                       VARCHAR,
  shipping_address_line2                       VARCHAR,
  shipping_address_postal_code                 VARCHAR,
  shipping_address_state                       VARCHAR,
  shipping_amount                              BIGINT,
  shipping_company                             VARCHAR,
  shipping_currency                            VARCHAR,
  shipping_email                               VARCHAR,
  shipping_method_name                         VARCHAR,
  shipping_name                                VARCHAR,
  shipping_phone                               VARCHAR,
  status                                       VARCHAR,
  tax                                          BIGINT,
  updated                                      TIMESTAMP
);

-- Physical locations where you operate Terminal card readers.
CREATE TABLE terminal_locations (
  address_city                                 VARCHAR,
  address_country                              VARCHAR,
  address_kana_city                            VARCHAR,
  address_kana_country                         VARCHAR,
  address_kana_line1                           VARCHAR,
  address_kana_line2                           VARCHAR,
  address_kana_postal_code                     VARCHAR,
  address_kana_state                           VARCHAR,
  address_kana_town                            VARCHAR,
  address_kanji_city                           VARCHAR,
  address_kanji_country                        VARCHAR,
  address_kanji_line1                          VARCHAR,
  address_kanji_line2                          VARCHAR,
  address_kanji_postal_code                    VARCHAR,
  address_kanji_state                          VARCHAR,
  address_kanji_town                           VARCHAR,
  address_line1                                VARCHAR,
  address_line2                                VARCHAR,
  address_postal_code                          VARCHAR,
  address_state                                VARCHAR,
  id                                           VARCHAR,
  livemode                                     BOOLEAN,
  metadata                                     VARCHAR,
  name                                         VARCHAR,
  name_kana                                    VARCHAR,
  name_kanji                                   VARCHAR,
  phone                                        VARCHAR,
  zone_id                                      VARCHAR
);

-- Terminal card reader devices registered to your account.
CREATE TABLE terminal_readers (
  device_type                                  VARCHAR,
  id                                           VARCHAR,
  label                                        VARCHAR,
  livemode                                     BOOLEAN,
  location_id                                  VARCHAR,
  metadata                                     VARCHAR,
  serial_number                                VARCHAR
);


CREATE TABLE topups (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_transaction                          VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failure_code                                 VARCHAR,
  failure_message                              VARCHAR,
  initiated_by                                 VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  transfer_group                               VARCHAR
);


CREATE TABLE topups_metadata (
  "key"                                        VARCHAR,
  topup_id                                     VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Reversals of manually created transfers or payouts. Automatic payouts cannot be reversed.
CREATE TABLE transfer_reversals (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  destination_payment_refund_id                VARCHAR,
  source_refund_id                             VARCHAR,
  transfer_id                                  VARCHAR
);

-- Metadata key/value pairs set on transfer_reversals. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfer_reversals_metadata (
  "key"                                        VARCHAR,
  transfer_reversal_id                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Payouts from your Stripe balance to your bank account, and — for Connect platforms — transfers of funds to connected accounts.
CREATE TABLE transfers (
  id                                           VARCHAR,
  amount                                       BIGINT,
  amount_reversed                              BIGINT,
  application_fee_amount                       BIGINT,
  application_fee_id                           VARCHAR,
  automatic                                    BOOLEAN,
  balance_transaction_id                       VARCHAR,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  "date"                                       TIMESTAMP,
  description                                  VARCHAR,
  destination_id                               VARCHAR,
  destination_payment_id                       VARCHAR,
  failure_code                                 VARCHAR,
  failure_message                              VARCHAR,
  kind                                         VARCHAR,
  original_payout                              VARCHAR,
  payout_method                                VARCHAR,
  reversed                                     BOOLEAN,
  reversed_by                                  VARCHAR,
  source_transaction_id                        VARCHAR,
  source_type                                  VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  trace_id                                     VARCHAR,
  trace_id_status                              VARCHAR,
  transfer_group                               VARCHAR,
  transfer_instruction                         VARCHAR,
  "type"                                       VARCHAR
);

-- Metadata key/value pairs set on transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE transfers_metadata (
  "key"                                        VARCHAR,
  transfer_id                                  VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE treasury_credit_reversals (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  financial_account_id                         VARCHAR,
  network                                      VARCHAR,
  received_credit_id                           VARCHAR,
  status                                       VARCHAR,
  status_transitions_posted_at                 TIMESTAMP,
  transaction_id                               VARCHAR
);


CREATE TABLE treasury_credit_reversals_metadata (
  credit_reversal_id                           VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE treasury_debit_reversals (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  financial_account_id                         VARCHAR,
  linked_flows_issuing_dispute_id              VARCHAR,
  network                                      VARCHAR,
  received_debit_id                            VARCHAR,
  status                                       VARCHAR,
  status_transitions_completed_at              TIMESTAMP,
  transaction_id                               VARCHAR
);


CREATE TABLE treasury_debit_reversals_metadata (
  debit_reversal_id                            VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Treasury financial accounts that store funds for your platform's users.
CREATE TABLE treasury_financial_accounts (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  country                                      VARCHAR,
  created                                      TIMESTAMP,
  status                                       VARCHAR,
  status_details_closed_reasons                VARCHAR
);

-- Metadata key/value pairs set on treasury_financial_accounts. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_financial_accounts_metadata (
  financial_account_id                         VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Money pulled into a Treasury financial account from an external bank account.
CREATE TABLE treasury_inbound_transfers (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  cancelable                                   BOOLEAN,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failure_details_code                         VARCHAR,
  financial_account_id                         VARCHAR,
  linked_flows_received_debit_id               VARCHAR,
  origin_payment_method_details_us_bank_account_network VARCHAR,
  origin_payment_method_id                     VARCHAR,
  returned                                     BOOLEAN,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  status_transitions_canceled_at               TIMESTAMP,
  status_transitions_failed_at                 TIMESTAMP,
  status_transitions_succeeded_at              TIMESTAMP,
  transaction_id                               VARCHAR
);

-- Metadata key/value pairs set on treasury_inbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_inbound_transfers_metadata (
  inbound_transfer_id                          VARCHAR,
  "key"                                        VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Money sent from a Treasury financial account to a third party.
CREATE TABLE treasury_outbound_payments (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  cancelable                                   BOOLEAN,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  customer_id                                  VARCHAR,
  description                                  VARCHAR,
  destination_payment_method_details_financial_account_id VARCHAR,
  destination_payment_method_details_type      VARCHAR,
  destination_payment_method_details_us_bank_account_network VARCHAR,
  destination_payment_method_id                VARCHAR,
  end_user_details_ip_address                  VARCHAR,
  end_user_details_present                     BOOLEAN,
  expected_arrival_date                        TIMESTAMP,
  financial_account_id                         VARCHAR,
  returned_details_code                        VARCHAR,
  returned_details_transaction_id              VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  status_transitions_canceled_at               TIMESTAMP,
  status_transitions_failed_at                 TIMESTAMP,
  status_transitions_posted_at                 TIMESTAMP,
  status_transitions_returned_at               TIMESTAMP,
  tracking_details_ach_trace_id                VARCHAR,
  tracking_details_us_domestic_wire_imad       VARCHAR,
  tracking_details_us_domestic_wire_omad       VARCHAR,
  transaction_id                               VARCHAR
);

-- Metadata key/value pairs set on treasury_outbound_payments. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_payments_metadata (
  "key"                                        VARCHAR,
  outbound_payment_id                          VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);

-- Money sent from a Treasury financial account to an external bank account you own.
CREATE TABLE treasury_outbound_transfers (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  cancelable                                   BOOLEAN,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  destination_payment_method_details_type      VARCHAR,
  destination_payment_method_details_us_bank_account_ach_submission VARCHAR,
  destination_payment_method_details_us_bank_account_network VARCHAR,
  destination_payment_method_id                VARCHAR,
  expected_arrival_date                        TIMESTAMP,
  financial_account_id                         VARCHAR,
  returned_details_code                        VARCHAR,
  returned_details_transaction_id              VARCHAR,
  statement_descriptor                         VARCHAR,
  status                                       VARCHAR,
  status_transitions_canceled_at               TIMESTAMP,
  status_transitions_failed_at                 TIMESTAMP,
  status_transitions_posted_at                 TIMESTAMP,
  status_transitions_returned_at               TIMESTAMP,
  tracking_details_ach_trace_id                VARCHAR,
  tracking_details_us_domestic_wire_imad       VARCHAR,
  tracking_details_us_domestic_wire_omad       VARCHAR,
  transaction_id                               VARCHAR
);

-- Metadata key/value pairs set on treasury_outbound_transfers. One row per (object, metadata key) pair. Objects with no metadata have no rows.
CREATE TABLE treasury_outbound_transfers_metadata (
  "key"                                        VARCHAR,
  outbound_transfer_id                         VARCHAR,
  batch_timestamp                              TIMESTAMP,
  "value"                                      VARCHAR
);


CREATE TABLE treasury_received_credits (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failure_code                                 VARCHAR,
  financial_account_id                         VARCHAR,
  initiating_payment_method_details_financial_account_id VARCHAR,
  initiating_payment_method_details_issuing_card_id VARCHAR,
  initiating_payment_method_details_type       VARCHAR,
  initiating_payment_method_details_us_bank_account_last_4 VARCHAR,
  initiating_payment_method_details_us_bank_account_routing_number VARCHAR,
  linked_flows_credit_reversal_id              VARCHAR,
  linked_flows_issuing_authorization_id        VARCHAR,
  linked_flows_issuing_transaction_id          VARCHAR,
  linked_flows_source_flow_id                  VARCHAR,
  linked_flows_source_flow_type                VARCHAR,
  network                                      VARCHAR,
  reversal_details_deadline                    TIMESTAMP,
  reversal_details_restricted_reason           VARCHAR,
  status                                       VARCHAR,
  transaction_id                               VARCHAR
);


CREATE TABLE treasury_received_debits (
  id                                           VARCHAR,
  amount                                       BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  failure_code                                 VARCHAR,
  financial_account_id                         VARCHAR,
  initiating_payment_method_details_financial_account_id VARCHAR,
  initiating_payment_method_details_issuing_card_id VARCHAR,
  initiating_payment_method_details_type       VARCHAR,
  initiating_payment_method_details_us_bank_account_last_4 VARCHAR,
  initiating_payment_method_details_us_bank_account_routing_number VARCHAR,
  linked_flows_debit_reversal_id               VARCHAR,
  linked_flows_inbound_transfer_id             VARCHAR,
  linked_flows_issuing_authorization_id        VARCHAR,
  linked_flows_issuing_transaction_id          VARCHAR,
  linked_flows_payout_id                       VARCHAR,
  network                                      VARCHAR,
  reversal_details_deadline                    TIMESTAMP,
  reversal_details_restricted_reason           VARCHAR,
  status                                       VARCHAR,
  transaction_id                               VARCHAR
);

-- Individual ledger entries making up a Treasury transaction.
CREATE TABLE treasury_transaction_entries (
  id                                           VARCHAR,
  balance_impact_cash                          BIGINT,
  balance_impact_inbound_pending               BIGINT,
  balance_impact_outbound_pending              BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  effective_at                                 TIMESTAMP,
  financial_account_id                         VARCHAR,
  flow_id                                      VARCHAR,
  flow_type                                    VARCHAR,
  transaction_id                               VARCHAR,
  "type"                                       VARCHAR
);

-- Ledger of all money movement on Treasury financial accounts.
CREATE TABLE treasury_transactions (
  id                                           VARCHAR,
  amount                                       BIGINT,
  balance_impact_cash                          BIGINT,
  balance_impact_inbound_pending               BIGINT,
  balance_impact_outbound_pending              BIGINT,
  batch_timestamp                              TIMESTAMP,
  created                                      TIMESTAMP,
  currency                                     VARCHAR,
  description                                  VARCHAR,
  financial_account_id                         VARCHAR,
  flow_id                                      VARCHAR,
  flow_type                                    VARCHAR,
  status                                       VARCHAR,
  status_transitions_posted_at                 TIMESTAMP,
  status_transitions_void_at                   TIMESTAMP
);

-- Reported usage quantities for metered subscription items. Legacy path; newer integrations use billing meters.
CREATE TABLE usage_records (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  quantity                                     BIGINT,
  subscription_item                            VARCHAR,
  timestamp                                    TIMESTAMP
);


CREATE TABLE verification_reports (
  id                                           VARCHAR,
  address_error_code                           VARCHAR,
  address_status                               VARCHAR,
  batch_timestamp                              TIMESTAMP,
  client_reference_id                          VARCHAR,
  created                                      TIMESTAMP,
  document_error_code                          VARCHAR,
  document_error_reason                        VARCHAR,
  document_files                               VARCHAR,
  document_issuing_country                     VARCHAR,
  document_status                              VARCHAR,
  document_type                                VARCHAR,
  email_error_code                             VARCHAR,
  email_error_reason                           VARCHAR,
  email_status                                 VARCHAR,
  id_number_error_code                         VARCHAR,
  id_number_error_reason                       VARCHAR,
  id_number_status                             VARCHAR,
  matching_error_code                          VARCHAR,
  matching_status                              VARCHAR,
  options_document_allowed_types               VARCHAR,
  options_document_require_id_number           BOOLEAN,
  options_document_require_live_capture        BOOLEAN,
  options_document_require_matching_selfie     BOOLEAN,
  options_email_require_verification           BOOLEAN,
  options_phone_require_verification           BOOLEAN,
  phone_error_code                             VARCHAR,
  phone_error_reason                           VARCHAR,
  phone_otp_error_code                         VARCHAR,
  phone_otp_status                             VARCHAR,
  phone_records_error_code                     VARCHAR,
  phone_records_status                         VARCHAR,
  phone_status                                 VARCHAR,
  selfie_document_file                         VARCHAR,
  selfie_error_code                            VARCHAR,
  selfie_error_reason                          VARCHAR,
  selfie_file                                  VARCHAR,
  selfie_status                                VARCHAR,
  tax_id_error_code                            VARCHAR,
  tax_id_status                                VARCHAR,
  "type"                                       VARCHAR,
  verification_flow_id                         VARCHAR,
  verification_session_id                      VARCHAR
);


CREATE TABLE verification_sessions (
  id                                           VARCHAR,
  batch_timestamp                              TIMESTAMP,
  client_reference_id                          VARCHAR,
  created                                      TIMESTAMP,
  last_verification_report_id                  VARCHAR,
  options_document_allowed_types               VARCHAR,
  options_document_require_id_number           BOOLEAN,
  options_document_require_live_capture        BOOLEAN,
  options_document_require_matching_selfie     BOOLEAN,
  options_email_require_verification           BOOLEAN,
  options_matching_dob                         VARCHAR,
  options_matching_name                        VARCHAR,
  options_phone_require_verification           BOOLEAN,
  provided_details_email                       VARCHAR,
  provided_details_phone                       VARCHAR,
  redaction_status                             VARCHAR,
  related_customer_account_id                  VARCHAR,
  related_customer_id                          VARCHAR,
  related_person_account_id                    VARCHAR,
  related_person_id                            VARCHAR,
  started_at                                   TIMESTAMP,
  status                                       VARCHAR,
  submitted_at                                 TIMESTAMP,
  "type"                                       VARCHAR,
  verification_flow_id                         VARCHAR,
  verified_at                                  TIMESTAMP,
  visited_at                                   TIMESTAMP
);

