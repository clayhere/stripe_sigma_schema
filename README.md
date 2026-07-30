# Stripe Sigma Schema Reference
Built for context efficient AI reference. Stop burning time and tokens. 

Are you a human? Stroll through the schema here: https://clayhere.github.io/stripe_sigma_schema

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

[![CI](https://github.com/clayhere/stripe_sigma_schema/actions/workflows/ci.yml/badge.svg)](https://github.com/clayhere/stripe_sigma_schema/actions/workflows/ci.yml)
[![Code: MIT](https://img.shields.io/badge/code-MIT-blue.svg)](LICENSE)
[![Data: CC0](https://img.shields.io/badge/data-CC0--1.0-green.svg)](LICENSE-DATA)
[![Buy Me A Coffee](https://img.shields.io/badge/buy%20me%20a%20coffee-support-ffdd00?logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/clayhere)

> Unofficial and not affiliated with Stripe, Inc. See [NOTICE](NOTICE).

Also covers the same schema exposed through **Stripe Data Pipeline**.

---

## Use this with your AI tool

### Claude

Attach [`AGENTS.md`](AGENTS.md) to a Project, or paste it into the chat.

For it to happen automatically, install the [Skill](#as-a-claude-skill) or the [MCP server](#as-an-mcp-server) instead.

### ChatGPT / Codex

Upload [`dist/sigma_schema.json`](dist/sigma_schema.json) to a Custom GPT or a Project's knowledge. The Codex CLI can also use this repo as an [MCP server](#as-an-mcp-server).

### Cursor

Add [`AGENTS.md`](AGENTS.md) to your workspace — it's picked up as context automatically. An [MCP server](#as-an-mcp-server) is also available.

### Perplexity

Upload [`llms-full.txt`](llms-full.txt) to a Space's files.

### Anything else

Every file above works standalone: [`AGENTS.md`](AGENTS.md) (compact context pack), [`llms.txt`](llms.txt) / [`llms-full.txt`](llms-full.txt) (llms.txt standard), or [`dist/sigma_schema.json`](dist/sigma_schema.json) (structured data).

### As an MCP server

For tool-by-tool lookups instead of loading the whole schema into context. Needs a local clone and Python 3.11+; no third-party dependencies. Exposes `search_tables`, `describe_table`, `find_column`, `join_path` and `get_conventions`.

**Claude Code**

```bash
claude mcp add stripe-sigma-schema -- python3 "$PWD/tools/mcp_server.py"
```

**Claude Desktop, Cursor, or any MCP client config in JSON** — add to `claude_desktop_config.json` / `.cursor/mcp.json`:

```json
{"mcpServers": {"stripe-sigma-schema": {
  "command": "python3", "args": ["/absolute/path/to/tools/mcp_server.py"]}}}
```

**Codex CLI** — add to `~/.codex/config.toml`:

```toml
[mcp_servers.stripe-sigma-schema]
command = "python3"
args = ["/absolute/path/to/tools/mcp_server.py"]
```

Check your specific client's docs for where its config file lives and whether it needs a restart to pick up new servers — this varies by client and by version. Perplexity does not currently support adding local MCP servers this way; use the file-upload option above instead.

### As a Claude Skill

[`skills/stripe-sigma-queries.skill`](skills/stripe-sigma-queries.skill) packages this reference as a [Claude Skill](https://www.anthropic.com/news/skills) — once installed, Claude fetches the schema reference on its own whenever you ask it to write, fix, or explain Stripe Sigma SQL, without you having to attach a file each time.

**Claude Code** — unzip it straight into your skills directory:

```bash
mkdir -p ~/.claude/skills
unzip skills/stripe-sigma-queries.skill -d ~/.claude/skills
```

That makes the skill available in every project. To scope it to just this project instead, extract into `.claude/skills/` inside the project's directory. The plain-text source is also at [`skills/stripe-sigma-queries/SKILL.md`](skills/stripe-sigma-queries/SKILL.md) if you'd rather copy it in by hand.

**Claude.ai / Claude Desktop** — under Settings → Capabilities → Skills (availability depends on your plan), upload [`skills/stripe-sigma-queries.skill`](skills/stripe-sigma-queries.skill) directly.

## The problem

There is no current machine-readable sigma schema reference. So every AI session that writes Sigma SQL either starts blind, or incorrectly uses the API docs. It guesses `charge.customer` instead of `charges.customer_id`, invents `charges.captured` when the column is `captured_at`, or burns turns on `select * limit 1` probes to relearn what it knew yesterday.

This repo is that knowledge, frozen into files an agent can load once and stop burning tokens.

## Files

| File | What it's for |
| --- | --- |
| [`AGENTS.md`](AGENTS.md) | Full context pack, one file (~6k tokens) |
| [`llms.txt`](llms.txt) / [`llms-full.txt`](llms-full.txt) | llms.txt-standard index and full text |
| [`dist/sigma_schema.json`](dist/sigma_schema.json) | Canonical machine-readable schema |
| [`dist/SCHEMA.md`](dist/SCHEMA.md) | Per-table human-readable reference |
| [`RECIPES.md`](RECIPES.md) | Worked SQL for common questions — MRR, fees, disputes, tax |
| [`dist/sigma_schema.trino.sql`](dist/sigma_schema.trino.sql) / [`.sqlite.sql`](dist/sigma_schema.sqlite.sql) | CREATE TABLE DDL |
| [`dist/sigma_sample.sqlite`](dist/sigma_sample.sqlite) / [`dist/samples/`](dist/samples/) | Synthetic, referentially-valid sample data |
| [`dist/erd.mmd`](dist/erd.mmd) | Mermaid ER diagram of the join graph |
| [`index.html`](index.html) | Searchable browser — open directly, or visit it [hosted](https://clayhere.github.io/stripe_sigma_schema) |
| [`dataset.jsonld`](dataset.jsonld) | schema.org Dataset metadata |
| [`tools/mcp_server.py`](tools/mcp_server.py) | Run this repo as a local [MCP server](#as-an-mcp-server) |
| [`skills/stripe-sigma-queries.skill`](skills/stripe-sigma-queries.skill) | Install as a [Claude Skill](#as-a-claude-skill) |

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

Confirming a `community` column against your own Sigma account turns it into `verified` for everyone. See [CONTRIBUTING.md](CONTRIBUTING.md) for how, and **please open a PR with what you find.**

## Sample data

Synthetic, deterministic, and referentially valid: a charge's `customer_id` always resolves, refund balance transactions are negative, fee details sum to the parent fee, failed charges have no `captured_at`, and card columns are blank on non-card payments.

It exists so an agent can see what values actually look like — `ch_` prefixes, minor-unit integers, `Visa` not `visa` — and can rehearse joins locally. **No real Stripe data. No real customers. No real credentials.**

> The sandbox is SQLite, not Trino. Use it for join logic and shape, not for Trino-specific functions like `date_trunc`, `map_agg`, `json_parse` or `count_if`.

## A few things the schema will not tell you but this repo will

1. When a subscription has multiple products(such as add ons), plan_id, price_id, and quantity on the subscription table will be NULL. You will need to join subscription_items to query these reliably. This is especially important for MRR/ARR/LTCV calcs.
2. Use `balance_transactions` for accounting, not `charges` — it's the only table that nets fees consistently across charges, refunds, disputes and payouts.
3. `itemized_fees.amount` is in **major** currency units. Every other amount column is in minor units. Do not divide by 100.
4. Exclude `refunds.reason = 'partial_capture'` from refund metrics — those are auth-and-capture artifacts, not customer refunds.
5. Exclude `disputes.status = 'prevented'` from chargeback ratios.
6. `subscriptions.discounts` is a comma-separated **string**, not an array.
7. `charges.card_brand` is `Visa`/`MasterCard`, not the API's lowercase.
8. Stripe's published table list is **not complete** — `tax_codes`, `billing_meters`, `early_fraud_warnings`, `connected_accounts` and others appear in Stripe's own SQL examples but not in its table inventory. They're included here and flagged.
9. If the subscription has multiple products, the price and quantity field on the subscription table bill be null. You will need to join the subscription_items table to reliably query by these values in environments with multiple products, like add ons. 

Full list in [`AGENTS.md`](AGENTS.md).

## Contributing

The highest-value contribution is **verification** — see [CONTRIBUTING.md](CONTRIBUTING.md). Corrections to descriptions, missing tables, and new query recipes are all welcome.

## License

Code (`tools/`) is [MIT](LICENSE). Data and documentation (`sources/`, `dist/`, and the generated root files) are [CC0 1.0](LICENSE-DATA) — public domain, no attribution required, so AI systems can ingest and redistribute freely.

## Citation

See [CITATION.cff](CITATION.cff).

---

<sub>Keywords: Stripe Sigma schema, Stripe Sigma SQL reference, Stripe Sigma tables and columns, Stripe data schema, Stripe Data Pipeline schema, Trino SQL, Stripe reporting, balance_transactions, charges, invoices, subscriptions, MRR SQL, text-to-SQL context, LLM schema reference, MCP server.</sub>
