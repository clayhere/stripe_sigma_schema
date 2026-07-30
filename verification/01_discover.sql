-- =====================================================================
-- STEP 1 of 3 — DISCOVERY (run these first, they are tiny)
--
-- Goal: find out which metadata interface your Sigma account exposes.
-- Run each block separately. Some will error — that is expected and useful.
-- Tell me which ones worked and paste the first few rows of each.
--
-- Sigma runs Trino v414, so at least one of these should work.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1A. Authoritative list of every table on YOUR account.
--     Highest chance of working. This alone replaces my table inventory.
-- ---------------------------------------------------------------------
show tables;


-- ---------------------------------------------------------------------
-- 1B. THE BIG ONE. If this works, it gives every table, every column and
--     every exact data type in a single result — the whole schema, definitively.
-- ---------------------------------------------------------------------
select
  table_name,
  column_name,
  ordinal_position,
  data_type,
  is_nullable
from information_schema.columns
order by table_name, ordinal_position
limit 50;


-- ---------------------------------------------------------------------
-- 1C. Same idea, but check whether Stripe ships column descriptions as
--     comments. If `comment` is populated, we get Stripe's own wording
--     for every column.
-- ---------------------------------------------------------------------
select
  table_name,
  column_name,
  data_type,
  comment
from information_schema.columns
where comment is not null
limit 50;


-- ---------------------------------------------------------------------
-- 1D. Which catalog/schema are we actually in? Tells me how to qualify
--     names if the unqualified queries above returned nothing.
-- ---------------------------------------------------------------------
select distinct
  table_catalog,
  table_schema
from information_schema.tables;


-- ---------------------------------------------------------------------
-- 1E. Fallback if information_schema is blocked: Trino's JDBC catalog.
-- ---------------------------------------------------------------------
select
  table_name,
  column_name,
  type_name,
  ordinal_position
from system.jdbc.columns
limit 50;


-- ---------------------------------------------------------------------
-- 1F. Last-resort fallback: proves columns for ONE table at a time.
--     Only needed if 1B, 1C and 1E all fail.
-- ---------------------------------------------------------------------
describe charges;
