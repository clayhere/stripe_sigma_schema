#!/usr/bin/env python3
"""Turn an information_schema export from a real Sigma account into ground truth.

Reads the CSV produced by verification/02_full_schema.sql and writes
sources/verified_schema.json, which build_schema.py then treats as authoritative:
verified tables get their column list replaced wholesale, every column marked
`verified`, with exact Trino types. Curated descriptions, enums, notes and
foreign keys are preserved for columns that survive.

Also prints a diff so we can see exactly what was wrong before.

Usage:
    python3 tools/ingest_verification.py verification/sigma_columns.csv
    python3 tools/ingest_verification.py verification/sigma_columns.csv --emit-enum-sql
"""

from __future__ import annotations

import argparse
import csv
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

# Trino type -> the simplified type this schema uses. The exact type is kept
# alongside as raw_type so nothing is lost.
TYPE_PATTERNS = [
    (r"^(varchar|char)\b", "varchar"),
    (r"^(bigint|integer|int|smallint|tinyint)\b", "bigint"),
    (r"^(double|real|decimal|numeric)\b", "double"),
    (r"^boolean\b", "boolean"),
    (r"^timestamp\b", "timestamp"),
    (r"^date\b", "date"),
    (r"^time\b", "varchar"),
    (r"^json\b", "json"),
    (r"^array\b", "array"),
    (r"^map\b", "map"),
    (r"^row\b", "row"),
    (r"^(varbinary|binary)\b", "varbinary"),
    (r"^interval\b", "varchar"),
    (r"^uuid\b", "varchar"),
]

# Header aliases, so an export that renamed columns still works.
FIELD_ALIASES = {
    "table_name": {"table_name", "table", "tablename", "table_nam"},
    "column_name": {"column_name", "column", "columnname", "col_name"},
    "data_type": {"data_type", "type", "type_name", "datatype", "column_type"},
    "ordinal_position": {"ordinal_position", "ordinal", "position", "ordinal_pos"},
    "is_nullable": {"is_nullable", "nullable"},
    "comment": {"comment", "description", "remarks"},
    "table_schema": {"table_schema", "schema", "table_schem"},
}


def simplify_type(raw: str) -> str:
    value = (raw or "").strip().lower()
    for pattern, simple in TYPE_PATTERNS:
        if re.match(pattern, value):
            return simple
    return "unknown"


def resolve_headers(fieldnames: list[str]) -> dict[str, str]:
    """Map our canonical field names onto whatever the CSV actually used."""
    lowered = {f.strip().lower(): f for f in fieldnames if f}
    resolved: dict[str, str] = {}
    for canonical, aliases in FIELD_ALIASES.items():
        for alias in aliases:
            if alias in lowered:
                resolved[canonical] = lowered[alias]
                break
    missing = {"table_name", "column_name"} - set(resolved)
    if missing:
        raise SystemExit(
            f"CSV is missing required column(s): {', '.join(sorted(missing))}.\n"
            f"Found headers: {', '.join(fieldnames)}"
        )
    return resolved


def load_export(path: Path) -> dict[str, list[dict]]:
    with path.open(newline="", encoding="utf-8-sig") as handle:
        reader = csv.DictReader(handle)
        headers = resolve_headers(reader.fieldnames or [])
        rows_by_table: dict[str, list[dict]] = defaultdict(list)
        for row in reader:
            table = (row.get(headers["table_name"]) or "").strip()
            column = (row.get(headers["column_name"]) or "").strip()
            if not table or not column:
                continue
            # Skip the metadata schema itself if it slipped into the export.
            schema_field = headers.get("table_schema")
            if schema_field and (row.get(schema_field) or "").strip() == "information_schema":
                continue

            raw_type = (row.get(headers.get("data_type", ""), "") or "").strip()
            ordinal = (row.get(headers.get("ordinal_position", ""), "") or "").strip()
            nullable = (row.get(headers.get("is_nullable", ""), "") or "").strip().upper()
            comment = (row.get(headers.get("comment", ""), "") or "").strip()

            rows_by_table[table].append({
                "name": column,
                "type": simplify_type(raw_type),
                "raw_type": raw_type or None,
                "nullable": None if not nullable else nullable in ("YES", "TRUE", "1"),
                "comment": comment or None,
                "ordinal": int(ordinal) if ordinal.isdigit() else None,
            })

    for table, columns in rows_by_table.items():
        columns.sort(key=lambda c: (c["ordinal"] is None, c["ordinal"], c["name"]))
    return dict(rows_by_table)


def diff_against_current(verified: dict[str, list[dict]], schema_path: Path) -> dict:
    if not schema_path.exists():
        return {}
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    current = {t["name"]: {c["name"] for c in t["columns"]} for t in schema["tables"]}

    report = {
        "tables_verified": len(verified),
        "tables_new": sorted(set(verified) - set(current)),
        "tables_not_on_account": sorted(set(current) - set(verified)),
        "columns_added": {},
        "columns_removed": {},
        "totals": {"added": 0, "removed": 0, "confirmed": 0},
    }
    for table, columns in verified.items():
        live = {c["name"] for c in columns}
        known = current.get(table, set())
        added = sorted(live - known)
        removed = sorted(known - live)
        report["totals"]["confirmed"] += len(live & known)
        report["totals"]["added"] += len(added)
        report["totals"]["removed"] += len(removed)
        if added:
            report["columns_added"][table] = added
        if removed:
            report["columns_removed"][table] = removed
    return report


def emit_enum_sql(verified: dict[str, list[dict]], out: Path) -> None:
    """Generate probes for the low-cardinality string columns that act as enums."""
    candidates = ("status", "type", "reason", "brand", "state", "level", "outcome",
                  "category", "behavior", "method", "interval", "mode", "funding",
                  "check", "result", "action")
    lines = [
        "-- STEP 3 - ENUM VALUES",
        "-- Generated by tools/ingest_verification.py from your verified schema.",
        "-- Confirms the exact spelling and casing of every enum-like value.",
        "-- Run it, export the CSV, and send it back.",
        "",
    ]
    blocks = []
    for table, columns in sorted(verified.items()):
        for col in columns:
            if col["type"] != "varchar":
                continue
            name = col["name"].lower()
            if not any(token in name for token in candidates):
                continue
            blocks.append(
                f"select '{table}' as table_name, '{col['name']}' as column_name,\n"
                f"       cast({col['name']} as varchar) as value, count(*) as row_count\n"
                f"from {table}\n"
                f"where {col['name']} is not null\n"
                f"group by 1, 2, 3\n"
                f"having count(*) > 0"
            )
    if not blocks:
        lines.append("-- No enum-like columns found.")
    else:
        lines.append(f"-- {len(blocks)} column(s) probed.")
        lines.append("-- If the union is too large, run it in chunks.")
        lines.append("")
        lines.append("\nunion all\n".join(blocks))
        lines.append("order by 1, 2, 4 desc;")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("csv", type=Path, help="CSV exported from verification/02_full_schema.sql")
    parser.add_argument("-o", "--output", type=Path,
                        default=Path("sources/verified_schema.json"))
    parser.add_argument("--schema", type=Path, default=Path("dist/sigma_schema.json"))
    parser.add_argument("--emit-enum-sql", action="store_true",
                        help="also write verification/03_enums.sql")
    parser.add_argument("--account-label", default="",
                        help="optional note recording whose account this came from")
    args = parser.parse_args()

    verified = load_export(args.csv)
    if not verified:
        raise SystemExit("No usable rows found in that CSV.")

    report = diff_against_current(verified, args.schema)

    payload = {
        "$comment": (
            "Ground truth captured from a live Stripe Sigma account via "
            "information_schema. build_schema.py treats these column lists as "
            "authoritative and marks them `verified`. Regenerate with "
            "tools/ingest_verification.py."
        ),
        "source_file": args.csv.name,
        "account_label": args.account_label or None,
        "tables": verified,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")

    total_columns = sum(len(c) for c in verified.values())
    print(f"verified {len(verified)} tables, {total_columns} columns -> {args.output}")

    if report:
        totals = report["totals"]
        print(f"\n  confirmed already correct : {totals['confirmed']}")
        print(f"  columns we were MISSING   : {totals['added']}")
        print(f"  columns that DON'T EXIST  : {totals['removed']}")
        if report["tables_new"]:
            print(f"\n  tables we didn't know about ({len(report['tables_new'])}): "
                  f"{', '.join(report['tables_new'][:12])}")
        if report["tables_not_on_account"]:
            print(f"  tables not on this account ({len(report['tables_not_on_account'])}): "
                  f"{', '.join(report['tables_not_on_account'][:12])}")
        if report["columns_removed"]:
            print("\n  worst hallucinations:")
            worst = sorted(report["columns_removed"].items(),
                           key=lambda kv: -len(kv[1]))[:10]
            for table, cols in worst:
                print(f"    {table}: {', '.join(cols[:8])}"
                      f"{' ...' if len(cols) > 8 else ''}")

        report_path = Path("build/verification_diff.json")
        report_path.parent.mkdir(parents=True, exist_ok=True)
        report_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        print(f"\n  full diff -> {report_path}")

    if args.emit_enum_sql:
        enum_path = Path("verification/03_enums.sql")
        emit_enum_sql(verified, enum_path)
        print(f"  enum probe -> {enum_path}")

    print("\nNext: make build emit samples validate")
    return 0


if __name__ == "__main__":
    sys.exit(main())
