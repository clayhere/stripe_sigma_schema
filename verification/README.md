# Verification — making this schema 100% definitive

Everything in this repo that isn't marked `verified` is inference. This directory
is how that becomes fact.

The goal: **an agent using this repo should never reference a table or column
that doesn't exist.** That is achievable, because Trino — which Sigma runs on —
can describe its own schema. One query, and the guessing ends.

---

## Run order

### Step 1 — Discovery (2 minutes)

Open [`01_discover.sql`](01_discover.sql) and run each block **separately** in the
[Sigma query editor](https://dashboard.stripe.com/sigma/queries).

Some blocks will error. That is expected and still informative. Report which ones
worked and paste a few rows from each.

The two that matter most:

- **`show tables`** — the authoritative list of every table on your account.
- **`select ... from information_schema.columns`** — if this works, we're done in
  one more step.

### Step 2 — Full extraction (2 minutes)

If the `information_schema.columns` block returned rows, run
[`02_full_schema.sql`](02_full_schema.sql).

> **Use "Download CSV", not the on-screen results.** The results grid caps at
> 1,000 rows. The CSV export does not, and this query returns several thousand.

Save the export as `verification/sigma_columns.csv`.

```bash
python3 tools/ingest_verification.py verification/sigma_columns.csv --emit-enum-sql
make build emit samples validate
```

That prints exactly what was wrong — which columns I invented, which real ones I
missed, which tables I didn't know existed — and rebuilds every artifact with
`confidence: verified` and exact Trino types.

### Step 3 — Enum values (optional, high value)

`--emit-enum-sql` generates `03_enums.sql`, which returns the real distinct values
of every status/type/reason column. This is what stops an agent writing
`where card_brand = 'visa'` when the value is `Visa`, or
`where status = 'ACTIVE'` when it's `active`.

Run it, export the CSV, and send it back.

---

## What each step buys

| Step | Eliminates |
| --- | --- |
| `show tables` | Referencing tables that don't exist on your account |
| `information_schema.columns` | Referencing columns that don't exist; wrong types |
| `comment` column (if populated) | Wrong assumptions about what a column *means* |
| Enum probe | Wrong literal values in `WHERE` clauses |

Together those are the four ways a generated Sigma query fails. Semantic choices
— *which* table answers a question — stay in the curated notes and
[`RECIPES.md`](../RECIPES.md).

---

## Privacy

- `01_discover.sql` and `02_full_schema.sql` return **only schema metadata** —
  table names, column names, types. No customer data, no amounts, no identifiers.
- `03_enums.sql` returns **distinct values and row counts** of low-cardinality
  status-like columns. Skim it before sharing: if any column turns out to hold
  free-text or identifiers rather than a fixed set of states, drop those rows.
- Nothing here touches the Stripe API, and no API keys are involved.

---

## If `information_schema` isn't available

Then we fall back to per-table probes. `tools/verify_against_sigma.py --probe-sql`
generates one `select <columns> from <table> limit 0;` per table:

- a block that **parses and returns 0 rows** confirms every column in it,
- a block that **errors** names the first bad column.

Slower, but equally definitive. Run Step 1 first — we probably won't need this.

---

## Keeping it true

Stripe adds columns. Re-run Step 2 periodically and re-ingest; the diff shows
what changed. The weekly `upstream-drift` CI job watches Stripe's published table
list for additions in the meantime.

Account coverage matters: a table absent from your account may exist on another
(Issuing, Treasury, Terminal and Capital tables only appear when those products
are enabled). Those keep `verified_against_account: false` rather than being
deleted — so please send exports from more than one account if you have them.
