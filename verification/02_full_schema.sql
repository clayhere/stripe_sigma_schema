-- =====================================================================
-- STEP 2 of 3 — FULL SCHEMA EXTRACTION
--
-- Run this ONLY IF query 1B in 01_discover.sql returned rows.
--
-- This is the query that makes the schema 100% definitive. It returns one
-- row per (table, column) for every table your account can see, with the
-- exact Trino data type.
--
-- HOW TO RUN:
--   1. Paste into https://dashboard.stripe.com/sigma/queries
--   2. Run it.
--   3. Click "Download CSV"  <- important: the CSV contains ALL rows.
--      The on-screen grid caps at 1,000 rows; the CSV export does not.
--   4. Save it as  verification/sigma_columns.csv  and tell me.
--
-- Expect roughly 3,000-8,000 rows depending on which Stripe products
-- your account has enabled.
-- =====================================================================

select
  table_catalog,
  table_schema,
  table_name,
  column_name,
  ordinal_position,
  data_type,
  is_nullable,
  comment
from information_schema.columns
where table_schema not in ('information_schema')
order by
  table_name,
  ordinal_position;


-- =====================================================================
-- If the query above complains that `comment` does not exist, use this
-- reduced version instead (drop the comment column):
-- =====================================================================
--
-- select
--   table_catalog,
--   table_schema,
--   table_name,
--   column_name,
--   ordinal_position,
--   data_type,
--   is_nullable
-- from information_schema.columns
-- where table_schema not in ('information_schema')
-- order by table_name, ordinal_position;


-- =====================================================================
-- ALTERNATE PATH — only if information_schema is unavailable but
-- system.jdbc.columns worked (query 1E). Export this as CSV instead.
-- =====================================================================
--
-- select
--   table_cat  as table_catalog,
--   table_schem as table_schema,
--   table_name,
--   column_name,
--   ordinal_position,
--   type_name  as data_type,
--   is_nullable
-- from system.jdbc.columns
-- where table_schem not in ('information_schema')
-- order by table_name, ordinal_position;
