#!/usr/bin/env python3
"""Integrity checks for the built schema. Runs in CI; exits non-zero on failure.

These catch the ways a hand-edited source file silently corrupts the dataset:
foreign keys pointing at tables or columns that don't exist, duplicate columns,
primary keys that aren't real columns, and unknown confidence levels.

Usage:
    python3 tools/validate.py dist/sigma_schema.json
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

VALID_CONFIDENCE = {"documented", "conventional", "community", "verified"}
VALID_TYPES = {"varchar", "bigint", "double", "boolean", "timestamp", "date", "unknown",
               "json", "array", "map", "row", "varbinary"}
VALID_SOURCES = {"api_backed", "derived"}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("schema", type=Path, nargs="?", default=Path("dist/sigma_schema.json"))
    args = parser.parse_args()

    schema = json.loads(args.schema.read_text(encoding="utf-8"))
    tables = {t["name"]: t for t in schema["tables"]}
    errors: list[str] = []
    warnings: list[str] = []

    if len(tables) != len(schema["tables"]):
        errors.append("duplicate table names in schema")

    for name, table in sorted(tables.items()):
        columns = {c["name"] for c in table["columns"]}
        if len(columns) != len(table["columns"]):
            errors.append(f"{name}: duplicate column names")

        if table["source"] not in VALID_SOURCES:
            errors.append(f"{name}: unknown source {table['source']!r}")

        for col in table["columns"]:
            if col["confidence"] not in VALID_CONFIDENCE:
                errors.append(f"{name}.{col['name']}: bad confidence {col['confidence']!r}")
            if col["type"] not in VALID_TYPES:
                errors.append(f"{name}.{col['name']}: bad type {col['type']!r}")
            if not col.get("description"):
                warnings.append(f"{name}.{col['name']}: no description")

        for pk in table["primary_key"]:
            if pk not in columns:
                errors.append(f"{name}: primary key {pk!r} is not a column of the table")

        for fk in table["foreign_keys"]:
            target_name = fk["references"]["table"]
            target = tables.get(target_name)
            if target is None:
                errors.append(f"{name}: FK references unknown table {target_name!r}")
                continue
            for col in fk["columns"]:
                if col not in columns:
                    errors.append(f"{name}: FK column {col!r} is not a column of the table")
            target_columns = {c["name"] for c in target["columns"]}
            for col in fk["references"]["columns"]:
                # A target with no published columns can't be checked; that's a
                # coverage gap, not a broken reference.
                if target_columns and col not in target_columns:
                    errors.append(
                        f"{name}: FK references {target_name}.{col!r}, which does not exist"
                    )

        if table["columns_complete"] and not table["columns"]:
            errors.append(f"{name}: marked columns_complete but has no columns")

    stats = schema["stats"]
    recomputed = sum(len(t["columns"]) for t in schema["tables"])
    if recomputed != stats["columns"]:
        errors.append(f"stats.columns is {stats['columns']} but schema has {recomputed}")

    for warning in warnings[:15]:
        print(f"warn: {warning}")
    if len(warnings) > 15:
        print(f"warn: ... and {len(warnings) - 15} more")

    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)

    if errors:
        print(f"\n{len(errors)} error(s)", file=sys.stderr)
        return 1

    print(
        f"\nOK: {len(tables)} tables, {recomputed} columns, "
        f"{len(warnings)} warning(s), 0 errors"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
