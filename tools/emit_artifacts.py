#!/usr/bin/env python3
"""Render the canonical schema into the formats consumers actually use.

This project is AI-first: the primary consumer is an agent writing Sigma SQL, so
the agent-facing files live at the repository root where they are found without
being looked for, and the human/tooling formats live under dist/.

Root (AI entry points, conventional filenames):
  AGENTS.md                     canonical agent instructions + full context pack
  llms.txt                      llms.txt-standard index of this repo
  llms-full.txt                 entire reference inlined, single file

dist/ (derived formats):
  sigma_schema.trino.sql        CREATE TABLE DDL in Trino types
  sigma_schema.sqlite.sql       same shape in SQLite types (local sandbox)
  SCHEMA.md                     browsable reference for humans
  sigma-schema.context.md       the context pack on its own
  erd.mmd                       Mermaid ER diagram of the join graph

The context pack is the point of the project: one file small enough to drop into
a prompt that still answers "what tables exist, what columns, how do they join,
and what will bite me".

Usage:
    python3 tools/emit_artifacts.py --schema dist/sigma_schema.json --out dist
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

SQLITE_TYPES = {
    "varchar": "TEXT",
    "bigint": "INTEGER",
    "double": "REAL",
    "boolean": "INTEGER",
    "timestamp": "TEXT",
    "date": "TEXT",
    "unknown": "TEXT",
}

# Tables worth spelling out in full in the compact context pack. Everything else
# is listed by name so the agent knows it exists and can look it up.
CORE_TABLES = [
    "balance_transactions", "balance_transaction_fee_details", "charges", "refunds",
    "disputes", "customers", "payment_intents", "payment_method_details", "transfers",
    "invoices", "invoice_line_items", "subscriptions", "subscription_items",
    "products", "prices", "subscription_item_change_events", "itemized_fees",
    "connected_accounts", "checkout_sessions", "tax_transactions",
    "tax_transaction_line_items", "exchange_rates_from_usd",
]

CONFIDENCE_MARK = {"verified": "", "documented": "", "conventional": "~", "community": "?"}


def load(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def quote_if_reserved(name: str) -> str:
    reserved = {"end", "interval", "current_date", "order", "group", "date", "time",
                "value", "key", "type", "start", "period", "day", "month", "year"}
    return f'"{name}"' if name in reserved else name


# --------------------------------------------------------------------------- DDL
def emit_ddl(schema: dict, dialect: str) -> str:
    lines = [
        f"-- Stripe Sigma schema as {dialect} DDL",
        f"-- Generated from sigma_schema.json v{schema['schema_version']} by tools/emit_artifacts.py",
        "-- Sigma itself is read-only; this DDL exists for tooling, docs and local sandboxes.",
        "-- Columns marked (?) are unverified - see the confidence field in sigma_schema.json.",
        "",
    ]
    for table in schema["tables"]:
        if not table["columns"]:
            lines.append(f"-- {table['name']}: no column detail published; see sigma_schema.json")
            lines.append("")
            continue

        lines.append(f"-- {table['description'][:150]}" if table["description"] else "")
        col_lines = []
        for col in table["columns"]:
            ctype = (
                SQLITE_TYPES.get(col["type"], "TEXT")
                if dialect == "SQLite"
                else col["type"].upper().replace("UNKNOWN", "VARCHAR")
            )
            mark = "" if col["confidence"] in ("documented", "verified") else "  -- unverified"
            col_lines.append(f"  {quote_if_reserved(col['name']):<44} {ctype}{mark}")

        lines.append(f"CREATE TABLE {table['name']} (")
        lines.append(",\n".join(col_lines))
        lines.append(");")
        lines.append("")
    return "\n".join(lines) + "\n"


# ----------------------------------------------------------------- human reference
def emit_markdown(schema: dict) -> str:
    by_dataset: dict[str, list[dict]] = defaultdict(list)
    for table in schema["tables"]:
        by_dataset[table["dataset"]].append(table)

    out = [
        "# Stripe Sigma schema reference",
        "",
        f"`{schema['stats']['tables']}` tables, `{schema['stats']['columns']}` documented columns.",
        "",
        "> **Read this first.** Column lists are complete only where noted. Stripe publishes",
        "> the authoritative column list solely inside the Dashboard schema browser, so this",
        "> file combines what Stripe documents publicly with curated detail. Each column",
        "> carries a confidence level:",
        "",
        "| Confidence | Meaning |",
        "| --- | --- |",
    ]
    for level, meaning in schema["confidence_levels"].items():
        out.append(f"| `{level}` | {meaning} |")
    out += ["", "---", ""]

    for dataset in sorted(by_dataset):
        out.append(f"## {dataset}")
        out.append("")
        for table in sorted(by_dataset[dataset], key=lambda t: t["name"]):
            fresh = (
                f"{table['freshness_hours']}h"
                if table.get("freshness_hours") is not None
                else "unpublished"
            )
            flags = []
            if table.get("preview"):
                flags.append("preview")
            if not table.get("listed_in_stripe_freshness_table", True):
                flags.append("not in Stripe's published table list")
            suffix = f" _({', '.join(flags)})_" if flags else ""

            out.append(f"### `{table['name']}`{suffix}")
            out.append("")
            if table["description"]:
                out.append(table["description"])
                out.append("")
            meta = [f"**Freshness:** {fresh}", f"**Source:** {table['source']}"]
            if table.get("grain"):
                meta.append(f"**Grain:** {table['grain']}")
            if table["primary_key"]:
                meta.append(f"**Primary key:** `{', '.join(table['primary_key'])}`")
            out.append("  \n".join(meta))
            out.append("")

            if table["columns"]:
                complete = "complete" if table["columns_complete"] else "partial - may be missing columns"
                out.append(f"<details><summary>Columns ({len(table['columns'])}, {complete})</summary>")
                out.append("")
                out.append("| Column | Type | Key | Confidence | Description |")
                out.append("| --- | --- | --- | --- | --- |")
                for col in table["columns"]:
                    enum = ""
                    if col.get("enum"):
                        enum = " Values: " + ", ".join(f"`{v}`" for v in col["enum"]) + "."
                    desc = (col.get("description", "") + enum).replace("|", "\\|")
                    out.append(
                        f"| `{col['name']}` | {col['type']} | {col.get('key', '')} "
                        f"| {col['confidence']} | {desc} |"
                    )
                out.append("")
                out.append("</details>")
                out.append("")

            if table["foreign_keys"]:
                out.append("**Joins**")
                out.append("")
                for fk in table["foreign_keys"]:
                    ref = fk["references"]
                    out.append(
                        f"- `{table['name']}.{', '.join(fk['columns'])}` "
                        f"→ `{ref['table']}.{', '.join(ref['columns'])}`"
                    )
                out.append("")

            for note in table.get("notes", []):
                out.append(f"> {note}")
                out.append("")
    return "\n".join(out) + "\n"


# ------------------------------------------------------------------- context pack
def emit_context_pack(schema: dict) -> str:
    by_name = {t["name"]: t for t in schema["tables"]}
    conv = schema["conventions"]

    out = [
        "# Stripe Sigma schema — agent context pack",
        "",
        f"Schema v{schema['schema_version']}. {schema['stats']['tables']} tables. "
        "Load this instead of probing Sigma with exploratory queries.",
        "",
        "## Ground rules",
        "",
        f"- Engine is **{conv['dialect']['engine']} v{conv['dialect']['version']}** "
        f"(migrated from {conv['dialect']['previous_engine']}). Read-only ANSI SQL — no DDL or DML.",
        f"- {conv['amount_units']['default']}",
    ]
    for exc in conv["amount_units"]["exceptions"]:
        out.append(f"  - **Exception:** {', '.join('`'+t+'`' for t in exc['tables'])} — {exc['note']}")
    out += [
        f"- `data_load_time` is a query-scoped constant, not a column: "
        f"{conv['special_values']['data_load_time']['description']}",
        "- Timestamps are UTC. Convert with `AT TIME ZONE 'America/New_York'` "
        "(IANA casing — `AMERICA/NEW_YORK` errors).",
        "- Sigma column names are **not** the API's field names. See 'API vs Sigma' below.",
        "- Confidence marks below: no mark = documented by Stripe, `~` = derived from a "
        "documented convention, `?` = unverified. Verify `?` columns before relying on them.",
        "",
        "## API vs Sigma naming",
        "",
    ]
    for rule in conv["api_to_sigma_divergence"]["rules"]:
        out.append(f"- {rule['rule']} _{rule['example']}_")
    out += [
        "",
        "Do not invent a column by translating an API field. Guess, then verify with "
        "`select <col> from <table> limit 1`.",
        "",
        "## Object id prefixes",
        "",
        ", ".join(
            f"`{p}_` {t}"
            for p, t in sorted(conv["id_prefixes"].items())
            if not p.startswith("$")
        ),
        "",
        "## Table families",
        "",
        f"- **`*_metadata`** — {conv['metadata_tables']['rule']} "
        f"Pivot with `{conv['metadata_tables']['pivot_recipe']}`",
        f"- **`connected_account_*`** — {conv['connect_mirror_tables']['rule']}",
        "",
        "## Core tables",
        "",
    ]

    for name in CORE_TABLES:
        table = by_name.get(name)
        if not table:
            continue
        out.append(f"### {name}")
        if table.get("grain"):
            out.append(f"_{table['grain']}_")
        out.append("")
        cols = []
        for col in table["columns"]:
            mark = CONFIDENCE_MARK.get(col["confidence"], "?")
            enum = f" [{('|'.join(col['enum']))}]" if col.get("enum") else ""
            cols.append(f"{col['name']}:{col['type']}{mark}{enum}")
        out.append("`" + "`, `".join(cols) + "`")
        out.append("")
        if table["foreign_keys"]:
            joins = [
                f"{', '.join(fk['columns'])} → {fk['references']['table']}.{', '.join(fk['references']['columns'])}"
                for fk in table["foreign_keys"]
            ]
            out.append("Joins: " + "; ".join(joins))
            out.append("")
        for note in table.get("notes", []):
            out.append(f"- ⚠ {note}")
        if table.get("notes"):
            out.append("")

    out += ["## All other tables", ""]
    by_dataset: dict[str, list[str]] = defaultdict(list)
    for table in schema["tables"]:
        if table["name"] not in CORE_TABLES:
            by_dataset[table["dataset"]].append(table["name"])
    for dataset in sorted(by_dataset):
        out.append(f"**{dataset}**: " + ", ".join(f"`{n}`" for n in sorted(by_dataset[dataset])))
        out.append("")

    out += [
        "Full column detail for these is in `sigma_schema.json` / `SCHEMA.md`.",
        "",
        "## Traps that cause wrong answers",
        "",
        "1. Use `balance_transactions` for accounting, not `charges` — it is the only table "
        "that nets fees consistently across charges, refunds, disputes and payouts.",
        "2. Exclude `refunds.reason = 'partial_capture'` from refund metrics; those are "
        "auth-and-capture artifacts, not customer refunds.",
        "3. Exclude `disputes.status = 'prevented'` from chargeback ratios.",
        "4. `charges.card_brand` is display-cased (`Visa`, `MasterCard`), not the API's lowercase.",
        "5. `subscriptions.discounts` and `connected_accounts.requirements_*` are "
        "comma-separated strings, not arrays — `split()` and `unnest()` them.",
        "6. `exchange_rates_from_usd.buy_currency_exchange_rates` is a JSON string — "
        "`cast(json_parse(...) as map(varchar, double))` before use.",
        "7. Summing `tax_transaction_jurisdiction_details.amount_taxable` across jurisdictions "
        "does not equal the item amount; only `amount_tax` sums correctly.",
        "8. Recent-period dispute and fraud data undercounts — those events arrive weeks late.",
        "9. Sort by a unique id alongside your ordering key; Trino top-N and window functions "
        "are otherwise non-deterministic on ties.",
        "10. `end`, `interval`, `type`, `value`, `key`, `date` are reserved words — quote them.",
        "",
    ]
    return "\n".join(out) + "\n"


# --------------------------------------------------------------------------- ERD
def emit_erd(schema: dict) -> str:
    core = set(CORE_TABLES)
    lines = ["erDiagram"]
    seen = set()
    for table in schema["tables"]:
        if table["name"] not in core:
            continue
        for fk in table["foreign_keys"]:
            target = fk["references"]["table"]
            if target not in core:
                continue
            edge = (table["name"], target, fk["columns"][0])
            if edge in seen:
                continue
            seen.add(edge)
            lines.append(f'    {target} ||--o{{ {table["name"]} : "{fk["columns"][0]}"')
    return "\n".join(lines) + "\n"


# ------------------------------------------------------- AI-first entry points
AGENTS_HEADER = """<!-- Generated by tools/emit_artifacts.py. Do not edit by hand. -->
# AGENTS.md — Stripe Sigma SQL schema reference

**What this is:** a complete, machine-readable reference for the **Stripe Sigma**
data warehouse schema — every table, column, join key, enum and gotcha needed to
write correct Sigma SQL.

**Use this instead of guessing table or column names, and instead of running
exploratory `select * limit 1` queries to rediscover the schema each session.**

## If you are an agent, start here

| You want | Read |
| --- | --- |
| Everything, in one prompt-sized file | this file (below) or `llms-full.txt` |
| Machine-readable schema to parse | `dist/sigma_schema.json` |
| A specific table's full column list | `dist/SCHEMA.md` |
| To run practice SQL locally | `dist/sigma_sample.sqlite` (synthetic data) |
| Realistic example values | `dist/samples/<table>.csv` |
| DDL for tooling | `dist/sigma_schema.trino.sql` |
| The join graph as a diagram | `dist/erd.mmd` |
| Worked query patterns (MRR, fees, disputes, tax) | `docs/RECIPES.md` |

## Rules for using this reference

1. **Sigma is read-only.** Never emit `INSERT`, `UPDATE`, `DELETE`, or DDL.
2. **Respect the confidence marks.** A column marked `?` is unverified — it may
   not exist. Prefer unmarked columns; if you must use a `?` column, tell the
   user it needs verification. `verification/README.md` explains how to remove
   every `?` by extracting ground truth from a live Sigma account.
3. **Never invent a column** by translating a Stripe API field name. Sigma's
   naming diverges from the API in specific ways documented below.
4. **`columns_complete: false`** on a table means the list here is partial, not
   that the missing column doesn't exist. Say so rather than asserting absence.
5. The local SQLite sandbox is **SQLite, not Trino**. Use it to check join logic
   and shape; Trino-specific functions (`date_trunc`, `map_agg`, `json_parse`,
   `count_if`, `try`) will not run there.

---

"""


def emit_agents_md(schema: dict) -> str:
    return AGENTS_HEADER + emit_context_pack(schema).split("\n", 1)[1].lstrip("\n")


def emit_llms_txt(schema: dict) -> str:
    stats = schema["stats"]
    return f"""# Stripe Sigma Schema Reference

> Complete, machine-readable reference for the Stripe Sigma SQL data warehouse
> schema: {stats['tables']} tables, {stats['columns']} columns, join keys, enums,
> freshness SLAs and query gotchas. Built for AI agents writing Sigma SQL so they
> do not have to rediscover the schema through exploratory queries each session.
> Unofficial and not affiliated with Stripe, Inc.

Keywords: Stripe Sigma, Stripe Sigma schema, Stripe Sigma SQL, Stripe data
schema, Stripe Data Pipeline, Trino, Stripe reporting tables, balance_transactions,
charges, invoices, subscriptions, MRR SQL.

## Start here

- [AGENTS.md](AGENTS.md): Full context pack — every rule, convention and core table. Read this first.
- [llms-full.txt](llms-full.txt): The entire reference inlined in one file.

## Machine-readable schema

- [dist/sigma_schema.json](dist/sigma_schema.json): Canonical schema. Every table with dataset, freshness, primary key, foreign keys, columns, types, enums and per-column confidence.
- [dist/sigma_schema.trino.sql](dist/sigma_schema.trino.sql): CREATE TABLE DDL in Trino types.
- [dist/sigma_schema.sqlite.sql](dist/sigma_schema.sqlite.sql): Same shape in SQLite types.
- [dataset.jsonld](dataset.jsonld): schema.org Dataset metadata.

## Human-readable reference

- [dist/SCHEMA.md](dist/SCHEMA.md): Per-table reference grouped by dataset, with full column tables.
- [docs/RECIPES.md](docs/RECIPES.md): Working Sigma SQL for common questions - net revenue, MRR movement, payout reconciliation, dispute rate, tax liability, metadata pivots, multi-currency conversion.
- [dist/erd.mmd](dist/erd.mmd): Mermaid ER diagram of the core join graph.
- [README.md](README.md): Project overview, accuracy model and how to contribute.

## Sample data

- [dist/sigma_sample.sqlite](dist/sigma_sample.sqlite): Runnable sandbox with referentially-valid synthetic rows.
- [dist/samples/](dist/samples/): One CSV per table, synthetic, showing realistic value shapes.

## Optional

- [CONTRIBUTING.md](CONTRIBUTING.md): How to verify columns against a real account and contribute fixes.
- [NOTICE](NOTICE): Trademark, sourcing and accuracy disclosures.
"""


def emit_llms_full(schema: dict) -> str:
    parts = [
        emit_agents_md(schema),
        "\n\n---\n\n# Full per-table reference\n\n",
        emit_markdown(schema).split("\n", 1)[1],
    ]
    return "".join(parts)


def emit_jsonld(schema: dict, repo_url: str) -> str:
    """schema.org Dataset metadata, so search engines and dataset indexes can find this."""
    stats = schema["stats"]
    doc = {
        "@context": "https://schema.org/",
        "@type": "Dataset",
        "name": "Stripe Sigma Schema Reference",
        "alternateName": [
            "Stripe Sigma schema",
            "Stripe Sigma SQL table reference",
            "Stripe data schema for Sigma and Data Pipeline",
        ],
        "description": (
            f"Complete machine-readable reference for the Stripe Sigma SQL data warehouse "
            f"schema: {stats['tables']} tables and {stats['columns']} columns with types, "
            "primary and foreign keys, enum values, data-freshness SLAs, Trino dialect notes "
            "and query pitfalls. Includes referentially-valid synthetic sample data and a "
            "runnable SQLite sandbox. Designed as a context source for AI agents writing "
            "Stripe Sigma SQL. Unofficial; not affiliated with Stripe, Inc."
        ),
        "keywords": [
            "Stripe Sigma", "Stripe Sigma schema", "Stripe Sigma SQL", "Stripe data schema",
            "Stripe Data Pipeline", "Trino", "Presto", "SQL schema", "data warehouse",
            "payments analytics", "MRR", "balance_transactions", "charges", "invoices",
            "subscriptions", "LLM context", "AI agent reference", "text-to-SQL",
        ],
        "license": "https://creativecommons.org/publicdomain/zero/1.0/",
        "version": schema["schema_version"],
        "isAccessibleForFree": True,
        "creativeWorkStatus": "Published",
        "url": repo_url,
        "codeRepository": repo_url,
        "measurementTechnique": (
            "Derived from Stripe's public documentation at docs.stripe.com/data, with "
            "per-column provenance and confidence levels; verifiable against a live "
            "Stripe Sigma account."
        ),
        "variableMeasured": [
            {"@type": "PropertyValue", "name": "tables", "value": stats["tables"]},
            {"@type": "PropertyValue", "name": "columns", "value": stats["columns"]},
        ],
        "distribution": [
            {
                "@type": "DataDownload",
                "name": "Canonical schema (JSON)",
                "encodingFormat": "application/json",
                "contentUrl": f"{repo_url}/blob/main/dist/sigma_schema.json",
            },
            {
                "@type": "DataDownload",
                "name": "Agent context pack (Markdown)",
                "encodingFormat": "text/markdown",
                "contentUrl": f"{repo_url}/blob/main/AGENTS.md",
            },
            {
                "@type": "DataDownload",
                "name": "Trino DDL",
                "encodingFormat": "application/sql",
                "contentUrl": f"{repo_url}/blob/main/dist/sigma_schema.trino.sql",
            },
            {
                "@type": "DataDownload",
                "name": "Synthetic sample database (SQLite)",
                "encodingFormat": "application/vnd.sqlite3",
                "contentUrl": f"{repo_url}/blob/main/dist/sigma_sample.sqlite",
            },
        ],
        "about": {
            "@type": "SoftwareApplication",
            "name": "Stripe Sigma",
            "applicationCategory": "BusinessApplication",
            "url": "https://stripe.com/sigma",
        },
    }
    return json.dumps(doc, indent=2) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--schema", type=Path, default=Path("dist/sigma_schema.json"))
    parser.add_argument("--repo-url",
                        default="https://github.com/claysones/stripe-sigma-schema")
    parser.add_argument("--out", type=Path, default=Path("dist"))
    parser.add_argument("--root", type=Path, default=Path("."),
                        help="where the AI entry-point files go")
    args = parser.parse_args()

    schema = load(args.schema)
    args.out.mkdir(parents=True, exist_ok=True)

    artifacts = {
        args.out / "sigma_schema.trino.sql": emit_ddl(schema, "Trino"),
        args.out / "sigma_schema.sqlite.sql": emit_ddl(schema, "SQLite"),
        args.out / "SCHEMA.md": emit_markdown(schema),
        args.out / "sigma-schema.context.md": emit_context_pack(schema),
        args.out / "erd.mmd": emit_erd(schema),
        args.root / "AGENTS.md": emit_agents_md(schema),
        args.root / "llms.txt": emit_llms_txt(schema),
        args.root / "llms-full.txt": emit_llms_full(schema),
        args.root / "dataset.jsonld": emit_jsonld(schema, args.repo_url.rstrip("/")),
    }
    for path, content in artifacts.items():
        path.write_text(content, encoding="utf-8")
        print(f"{len(content):>9,} bytes  {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
