#!/usr/bin/env python3
"""Turn a structural export + a description map into sources/verified_schema.json.

This is the sibling of tools/ingest_verification.py for cases where
information_schema access isn't available. Instead of a CSV export, the input
is two JSON files: one listing every table's columns with type and key role,
and one mapping "table.column" to its description text.

Inputs:
  <structural>    [{table, columns: [{name, type, key}]}] for every table/column.
  <descriptions>  {"table.column": "description text"} for columns with a
                  known description.

Output:
  sources/verified_schema.json  - same shape tools/ingest_verification.py produces;
                                   build_schema.py treats it as authoritative and marks
                                   every listed column `verified`.

Usage:
    python3 tools/build_verified_schema.py
    make build emit samples validate
"""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

TYPE_PATTERNS = [
    (r"^(varchar|char)\b", "varchar"),
    (r"^(bigint|integer|int|smallint|tinyint)\b", "bigint"),
    (r"^(double|real|decimal|numeric)\b", "double"),
    (r"^boolean\b", "boolean"),
    (r"^timestamp\b", "timestamp"),
    (r"^date\b", "date"),
]

KEY_NORMALIZE = {"primary key": "primary", "foreign key": "foreign"}

# Extraction artifacts confirmed and corrected by hand: a parenthesized decimal
# precision concatenated onto the column name, and a stray leading underscore
# on an otherwise-universal primary key column name.
NAME_FIXUPS = {
    ("itemized_fees", "amountDecimal(38,18)"): ("amount", "Decimal(38,18)"),
    ("itemized_fees", "taxDecimal(38,18)"): ("tax", "Decimal(38,18)"),
    ("connected_account_itemized_fees", "amountDecimal(38,18)"): ("amount", "Decimal(38,18)"),
    ("connected_account_itemized_fees", "taxDecimal(38,18)"): ("tax", "Decimal(38,18)"),
    ("disputes_reporting_v1_itemized", "_id"): ("id", None),
}

# Matches description sentences that enumerate a fixed set of literal values,
# e.g. "Can be foo, bar, or baz." / "Possible values are X, Y, and Z."
ENUM_TRIGGER = re.compile(
    r"(?:can be|possible values are|possible values:|one of:?|either)\s+(.+?)\.(?:\s|$)",
    re.IGNORECASE,
)
ENUM_DROP_TOKENS = {"null", "none", "n/a", "unset"}


def simplify_type(raw: str | None) -> str:
    value = (raw or "").strip().lower()
    for pattern, simple in TYPE_PATTERNS:
        if re.match(pattern, value):
            return simple
    # Primary/foreign key columns carry no type label of their own (only a key
    # role), but Stripe object ids are always varchar.
    return "varchar"


def _clean_enum_token(tok: str) -> str | None:
    tok = tok.strip(" \t`'\"")
    tok = re.sub(r"\([^)]*\)", "", tok).strip()  # drop parentheticals
    tok = tok.rstrip(".")
    if not tok or tok.lower() in ENUM_DROP_TOKENS:
        return None
    return tok


def extract_enum(description: str | None) -> list[str] | None:
    """Pull a literal value list out of a description sentence, conservatively.

    Only fires on a short, clean comma/or-separated list right after a
    trigger phrase. Returns None (rather than a guess) for anything that
    looks like ordinary prose, so a missed enum is far more likely than a
    wrong one.
    """
    if not description:
        return None
    match = ENUM_TRIGGER.search(description)
    if not match:
        return None
    tail = re.sub(r"\s*,?\s+(?:or|and)\s+", ", ", match.group(1))
    parts = [_clean_enum_token(p) for p in tail.split(",")]
    parts = [p for p in parts if p]
    if len(parts) < 2:
        return None
    for p in parts:
        if len(p) > 30:
            return None
        words = p.split()
        if len(words) > 3:
            return None
        # Allow Title Case brand names and snake_case identifiers; reject
        # anything that still looks like a leftover prose fragment.
        if len(words) > 1 and not all(w[0].isupper() or "_" in w for w in words):
            return None
    seen: list[str] = []
    for p in parts:
        if p not in seen:
            seen.append(p)
    return seen


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--structural", type=Path, required=True,
                         help="[{table, columns: [{name, type, key}]}] export")
    parser.add_argument("--descriptions", type=Path, required=True,
                         help='{"table.column": "description"} map')
    parser.add_argument("-o", "--output", type=Path, default=Path("sources/verified_schema.json"))
    args = parser.parse_args()

    structural = json.loads(args.structural.read_text(encoding="utf-8"))
    descriptions = json.loads(args.descriptions.read_text(encoding="utf-8"))

    tables: dict[str, list[dict]] = {}
    described = 0
    enumerated = 0
    total = 0

    for t in structural:
        table_name = t["table"]
        cols = []
        for i, c in enumerate(t["columns"]):
            name = c["name"]
            raw_type = c.get("type")

            fixed = NAME_FIXUPS.get((table_name, name))
            if fixed:
                name, raw_type = fixed

            comment = descriptions.get(f"{table_name}.{name}")
            total += 1
            if comment is not None:
                described += 1

            col = {
                "name": name,
                "type": simplify_type(raw_type),
                "raw_type": raw_type,
                "nullable": None,
                "comment": comment if comment else None,
                "key": KEY_NORMALIZE.get(c.get("key")),
                "ordinal": i,
            }
            enum = extract_enum(comment)
            if enum:
                col["enum"] = enum
                enumerated += 1
            cols.append(col)
        tables[table_name] = cols

    payload = {"tables": tables}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    print(f"{len(tables)} tables, {total} columns -> {args.output}")
    print(f"  columns with a verified description: {described}")
    print(f"  columns with an extracted enum: {enumerated}")
    print("\nNext: make build emit samples validate")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
