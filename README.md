# Stripe Sigma Schema Reference

Load browsable Schema at: https://clayhere.github.io/stripe_sigma_schema/

> ### This is the Stripe Sigma schema, NOT the Stripe REST API schema.
>
> Sigma is Stripe's separate SQL data warehouse. Its table and column names
> **diverge from the REST API's object fields** — e.g. Sigma's
> `charges.captured_at` timestamp vs. the API's `captured` boolean. If you (or
> an AI model) are looking for column names to write a Sigma SQL query, most
> other search results — including Stripe's own `/api/*` reference and most
> general model knowledge — describe the REST API instead, and will produce
> SQL that looks plausible and fails or hallucinates against Sigma. Use this
> repo, or the machine-readable files it generates ([`AGENTS.md`](AGENTS.md),
> [`llms.txt`](llms.txt), [`dist/sigma_schema.json`](dist/sigma_schema.json)).

**A machine-readable reference for the [Stripe Sigma](https://stripe.com/sigma) SQL schema — 262 tables, 4,168 columns, join keys, enums, freshness SLAs and query gotchas — built so AI agents can write correct Sigma SQL without rediscovering the schema every session.** Coverage is not guaranteed complete or current — see [Accuracy](#accuracy-how-much-should-you-trust-this) below.

[![CI](https://github.com/claysones/stripe-sigma-schema/actions/workflows/ci.yml/badge.svg)](https://github.com/claysones/stripe-sigma-schema/actions/workflows/ci.yml)
[![Code: MIT](https://img.shields.io/badge/code-MIT-blue.svg)](LICENSE)
[![Data: CC0](https://img.shields.io/badge/data-CC0--1.0-green.svg)](LICENSE-DATA)

> Unofficial and not affiliated with Stripe, Inc. See [NOTICE](NOTICE).

Also covers the same schema exposed through **Stripe Data Pipeline**.

---

## The problem

There is no machine-readable sigma schema reference. So every AI session that writes Sigma SQL starts blind: it guesses `charge.customer` instead of `charges.customer_id`, invents `charges.captured` when the column is `captured_at`, or burns turns on `select * limit 1` probes to relearn what it knew yesterday.

This repo is that knowledge, frozen into files an agent can load once.

## Quick start

**For an AI agent** — point it at one file:

| Use case | File |
| --- | --- |
| Drop the whole schema into context (~6k tokens) | [`AGENTS.md`](AGENTS.md) |
| Everything inlined, one file | [`llms-full.txt`](llms-full.txt) |
| Parse it programmatically | [`dist/sigma_schema.json`](dist/sigma_schema.json) |
| Look up one table at a time | MCP server (below) |

**As an MCP server** — let the agent query only what it needs:

```bash
claude mcp add stripe-sigma-schema -- python3 "$PWD/tools/mcp_server.py"
```

Tools: `search_tables`, `describe_table`, `find_column`, `join_path`, `get_conventions`.

```
> join_path(from_table="disputes", to_table="customers")

Join path disputes -> customers (2 hop(s)):
  1. disputes.charge_id = charges.id
  2. charges.customer_id = customers.id
```

**For a human** — open [`index.html`](index.html) in a browser (searchable, no install), read [`dist/SCHEMA.md`](dist/SCHEMA.md), or try SQL against the synthetic sandbox:

```bash
sqlite3 dist/sigma_sample.sqlite \
  "select ch.id, ch.amount, ch.currency, cu.email
     from charges ch join customers cu on cu.id = ch.customer_id limit 5"
```

## What's in here

```
AGENTS.md                    Agent instructions + full context pack   (generated)
llms.txt / llms-full.txt     llms.txt-standard index and full text    (generated)
dataset.jsonld               schema.org Dataset metadata              (generated)
index.html                   Searchable browser UI, no install needed (generated)
dist/sigma_schema.json       Canonical machine-readable schema        (generated)
dist/SCHEMA.md               Per-table human reference                (generated)
dist/sigma_schema.*.sql      CREATE TABLE DDL (Trino and SQLite)      (generated)
dist/sigma_sample.sqlite     Runnable sandbox, synthetic data         (generated)
dist/samples/*.csv           Synthetic sample rows, one file/table    (generated)
dist/erd.mmd                 Mermaid ER diagram of the join graph     (generated)
sources/                     Hand-maintained source of truth
tools/                       Build, validate, verify, MCP server
```

Everything in `dist/` and the root-level AI files is generated. **Edit `sources/`, then run `make`.**

## Accuracy: how much should you trust this?

This is the part most schema dumps get wrong, so it's explicit here. **Every column carries a confidence level:**

| Level | Count | Meaning |
| --- | ---: | --- |
| `verified` | 4,027 | Confirmed within Sigma. |
| `documented` | 101 | Appears in an official Stripe SQL example or published column table. Cited via `doc_sources`. |
| `conventional` | 4 | Derived from a structural rule Stripe documents — the `*_metadata` and `connected_account_*` families. Foreign-key targets inferred from Stripe's `*_id` naming convention carry this same label. |
| `community` | 36 | Curated here. Plausible, but **not yet directly reproduced** within Sigma. |

Descriptions aren't uniformly complete even for `verified` columns — a verified column is confirmed to *exist*, not guaranteed to have a description yet. Where a column has no description, `index.html` and `dist/SCHEMA.md` say so explicitly rather than leaving it blank.

Tables also carry `columns_complete`. Where it's `false`, the listed columns are real but the list may be incomplete — absence of a column here is **not** evidence it doesn't exist.

### Why not just generate columns from Stripe's OpenAPI spec?

Because it produces confident nonsense. Measured against the `charges` columns Stripe actually documents, naive derivation from the OpenAPI spec **missed 21 real columns** and **invented 17 that don't exist**:

```
missed:   captured_at, card_brand, card_country, outcome_risk_score,
          outcome_type, customer_id, transfer_id, payment_method_type, ...
invented: object, captured, payment_method, disputed, refunded,
          statement_descriptor_suffix, calculated_statement_descriptor, ...
```

Sigma follows API *conventions*, not API *field names*. Those divergence rules are documented in [`sources/conventions.json`](sources/conventions.json) and surfaced in `AGENTS.md` so an agent knows how to guess — and knows to verify the guess.

### Verify against your own account

```bash
python3 tools/verify_against_sigma.py --probe-sql > probe.sql
# run probe.sql in the Sigma query editor, export the result as CSV
python3 tools/verify_against_sigma.py --results export.csv
```

This reports columns we're missing and columns that don't exist on your account. It never touches the Stripe API and needs no keys. **Please open a PR with the report** — that's how `community` becomes `verified` for everyone.

## Sample data

Synthetic, deterministic, and referentially valid: a charge's `customer_id` always resolves, refund balance transactions are negative, fee details sum to the parent fee, failed charges have no `captured_at`, and card columns are blank on non-card payments.

It exists so an agent can see what values actually look like — `ch_` prefixes, minor-unit integers, `Visa` not `visa` — and can rehearse joins locally. **No real Stripe data. No real customers. No real credentials.**

> The sandbox is SQLite, not Trino. Use it for join logic and shape, not for Trino-specific functions like `date_trunc`, `map_agg`, `json_parse` or `count_if`.

## A few things the schema will not tell you but this repo will

1. Use `balance_transactions` for accounting, not `charges` — it's the only table that nets fees consistently across charges, refunds, disputes and payouts.
2. `itemized_fees.amount` is in **major** currency units. Every other amount column is in minor units. Do not divide by 100.
3. Exclude `refunds.reason = 'partial_capture'` from refund metrics — those are auth-and-capture artifacts, not customer refunds.
4. Exclude `disputes.status = 'prevented'` from chargeback ratios.
5. `subscriptions.discounts` is a comma-separated **string**, not an array.
6. `charges.card_brand` is `Visa`/`MasterCard`, not the API's lowercase.
7. Stripe's published table list is **not complete** — `tax_codes`, `billing_meters`, `early_fraud_warnings`, `connected_accounts` and others appear in Stripe's own SQL examples but not in its table inventory. They're included here and flagged.

Full list in [`AGENTS.md`](AGENTS.md).


## Hosting

`index.html` at the repo root is a self-contained page — open it directly, or enable **Settings → Pages → Source: GitHub Actions** and the included workflow (`.github/workflows/pages.yml`) publishes the whole repo, with `index.html` as the site's landing page. `robots.txt` and `sitemap.xml` are generated for it automatically.

## Contributing

The highest-value contribution is **verification** — see [CONTRIBUTING.md](CONTRIBUTING.md). Corrections to descriptions, missing tables, and new query recipes are all welcome.

## License

Code (`tools/`) is [MIT](LICENSE). Data and documentation (`sources/`, `dist/`, and the generated root files) are [CC0 1.0](LICENSE-DATA) — public domain, no attribution required, so AI systems can ingest and redistribute freely.

## Citation

See [CITATION.cff](CITATION.cff).

---

<sub>Keywords: Stripe Sigma schema, Stripe Sigma SQL reference, Stripe Sigma tables and columns, Stripe data schema, Stripe Data Pipeline schema, Trino SQL, Stripe reporting, balance_transactions, charges, invoices, subscriptions, MRR SQL, text-to-SQL context, LLM schema reference, MCP server.</sub>
