#!/usr/bin/env python3
"""Assemble the canonical Sigma schema from its sources.

Inputs (all under sources/, plus extractor output under build/):
  build/table_inventory.json   table list scraped from Stripe's data-freshness page
  build/doc_columns.json       columns seen in official Stripe SQL examples
  sources/supplemental_tables.json  tables Stripe demos but doesn't list
  sources/conventions.json     structural rules (metadata tables, Connect mirrors, ...)
  sources/curated_*.json       hand-written descriptions, keys and columns

Output:
  dist/sigma_schema.json       the single machine-readable artifact everything else derives from

Every column carries a `confidence`:
  documented  - appears in a published Stripe SQL example or column table
  conventional- synthesized from a rule Stripe documents (metadata/Connect mirrors)
  community   - curated here from experience; plausible but unproven
  verified    - confirmed against a live Sigma account by verify_against_sigma.py
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

CONFIDENCE_RANK = {"community": 0, "conventional": 1, "documented": 2, "verified": 3}

# Column names the doc extractor can emit that are query artifacts, not real columns.
DOC_COLUMN_BLOCKLIST = {"current_date", "data_load_time"}

# Known extractor false positives: a bare column in a multi-table doc query that
# actually belongs to the *other* table in the join. Listed explicitly so the
# correction is auditable rather than hidden in extractor heuristics.
DOC_COLUMN_FALSE_POSITIVES = {
    # `group by display_name` refers to billing_meters.display_name, not the summary table.
    "billing_meter_event_summaries": {"display_name"},
    # `key`/`value` are filtered on the joined *_payload table.
    "billing_meter_invalid_events": {"key", "value"},
}


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def strip_comments(obj: dict) -> dict:
    return {k: v for k, v in obj.items() if not k.startswith("$")}


def singularize(table: str) -> str:
    """subscriptions -> subscription, prices -> price, charges -> charge."""
    if table.endswith("ies"):
        return table[:-3] + "y"
    if table.endswith("ses") or table.endswith("xes") or table.endswith("zes"):
        return table[:-2]
    if table.endswith("s") and not table.endswith("ss"):
        return table[:-1]
    return table


def metadata_parent(table: str, known: set[str] | None = None) -> str:
    """Resolve the object table a *_metadata table hangs off.

    Usually a plain suffix strip, but Stripe sometimes singularizes the stem
    (terminal_hardware_order_metadata -> terminal_hardware_orders).
    """
    stem = table[: -len("_metadata")]
    if known is None or stem in known:
        return stem
    for candidate in (f"{stem}s", f"{stem}es"):
        if candidate in known:
            return candidate
    return stem


def build_metadata_table(name: str, conventions: dict, known: set[str]) -> dict:
    parent = metadata_parent(name, known)
    fk_column = f"{singularize(parent)}_id"
    spec = conventions["metadata_tables"]

    columns = []
    for col in spec["columns"]:
        col = dict(col)
        col["name"] = col["name"].replace("<parent>", singularize(parent))
        col["confidence"] = "conventional"
        columns.append(col)

    return {
        "description": f"Metadata key/value pairs set on {parent}. {spec['grain']}",
        "grain": spec["grain"],
        "primary_key": [],
        "columns": columns,
        "columns_complete": True,
        "foreign_keys": [
            {
                "columns": [fk_column],
                "references": {"table": parent, "columns": ["id"]},
                "confidence": "conventional",
            }
        ],
        "notes": [
            "Values are always strings, even when they hold numbers or booleans.",
            f"Pivot to columns with: select {fk_column}, map_agg(key, value) as md "
            f"from {name} group by 1",
        ],
        "derived_from_convention": "metadata_tables",
    }


def apply_connect_mirror(table: dict, conventions: dict) -> dict:
    """Add the `account` column that every connected_account_* table carries."""
    spec = conventions["connect_mirror_tables"]
    existing = {c["name"] for c in table.get("columns", [])}
    for extra in spec["extra_columns"]:
        if extra["name"] in existing:
            continue
        col = {k: v for k, v in extra.items() if k != "references"}
        col["confidence"] = "conventional"
        table.setdefault("columns", []).insert(0, col)
        table.setdefault("foreign_keys", []).append(
            {
                "columns": [extra["name"]],
                "references": {
                    "table": extra["references"]["table"],
                    "columns": [extra["references"]["column"]],
                },
                "confidence": "conventional",
            }
        )
    table["derived_from_convention"] = "connect_mirror_tables"
    return table


def merge_doc_columns(table: dict, doc_cols: dict[str, list[str]], all_tables: set[str]) -> None:
    """Promote curated columns to `documented`, and append documented columns we missed."""
    by_name = {c["name"]: c for c in table.get("columns", [])}
    bogus = DOC_COLUMN_FALSE_POSITIVES.get(table["name"], set())
    for col_name, sources in sorted(doc_cols.items()):
        if col_name in DOC_COLUMN_BLOCKLIST or col_name in all_tables or col_name in bogus:
            continue
        if col_name in by_name:
            col = by_name[col_name]
            if CONFIDENCE_RANK.get(col.get("confidence", "community"), 0) < CONFIDENCE_RANK["documented"]:
                col["confidence"] = "documented"
            col.setdefault("doc_sources", sources)
        else:
            table.setdefault("columns", []).append(
                {
                    "name": col_name,
                    "type": "unknown",
                    "description": "Referenced in an official Stripe SQL example; type and full semantics not published.",
                    "confidence": "documented",
                    "doc_sources": sources,
                }
            )


def apply_verified_overlay(tables: list[dict], verified: dict) -> dict:
    """Replace curated column lists with ground truth from a live Sigma account.

    Verified data wins outright: the column list, order and types come from
    information_schema. Curated descriptions, enums and key roles are carried
    over for columns that actually exist, and dropped for ones that don't.
    """
    by_name = {t["name"]: t for t in tables}
    stats = {"tables_verified": 0, "columns_verified": 0,
             "columns_dropped": 0, "columns_gained": 0, "tables_added": 0}

    for table_name, live_columns in verified["tables"].items():
        table = by_name.get(table_name)
        if table is None:
            table = {
                "name": table_name,
                "dataset": "unclassified",
                "source": "api_backed",
                "freshness_hours": None,
                "preview": False,
                "listed_in_stripe_freshness_table": False,
                "description": "",
                "grain": "",
                "primary_key": [],
                "foreign_keys": [],
                "notes": [],
            }
            tables.append(table)
            by_name[table_name] = table
            stats["tables_added"] += 1

        curated = {c["name"]: c for c in table.get("columns", [])}
        previously_known = set(curated)
        rebuilt = []
        for live in live_columns:
            col = dict(curated.pop(live["name"], {}))
            col.update({
                "name": live["name"],
                "type": live["type"],
                "confidence": "verified",
            })
            if live.get("raw_type"):
                col["raw_type"] = live["raw_type"]
            if live.get("nullable") is not None:
                col["nullable"] = live["nullable"]
            # Stripe's own wording beats ours when the warehouse exposes it.
            if live.get("comment"):
                col["description"] = live["comment"]
            col.setdefault("description", "")
            rebuilt.append(col)

        stats["columns_verified"] += len(rebuilt)
        stats["columns_gained"] += sum(
            1 for c in live_columns if c["name"] not in previously_known
        )
        # Whatever is left in `curated` was never reported by the account.
        stats["columns_dropped"] += len(curated)
        stats["tables_verified"] += 1

        table["columns"] = rebuilt
        table["columns_complete"] = True
        table["verified_against_account"] = True

        # Drop keys and joins that referenced columns which don't exist.
        live_names = {c["name"] for c in rebuilt}
        table["primary_key"] = [c for c in table["primary_key"] if c in live_names]
        table["foreign_keys"] = [
            fk for fk in table["foreign_keys"]
            if all(c in live_names for c in fk["columns"])
        ]

    # A table we listed but the account never reported may still exist for
    # other accounts (product not enabled), so flag rather than delete.
    for table in tables:
        if table["name"] not in verified["tables"]:
            table["verified_against_account"] = False

    return stats


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path("."))
    parser.add_argument("-o", "--output", type=Path, default=Path("dist/sigma_schema.json"))
    parser.add_argument("--schema-version", default="1.0.0")
    args = parser.parse_args()

    root = args.root
    inventory = load(root / "build/table_inventory.json")
    doc_columns = load(root / "build/doc_columns.json")
    conventions = load(root / "sources/conventions.json")
    supplemental = [t for t in load(root / "sources/supplemental_tables.json") if t.get("name") != "$meta"]

    curated: dict[str, dict] = {}
    for path in sorted((root / "sources").glob("curated_*.json")):
        curated.update(strip_comments(load(path)))

    # ---- assemble the table list -------------------------------------------
    entries: dict[str, dict] = {}
    for item in inventory:
        entries[item["name"]] = dict(item)
    for item in supplemental:
        item = dict(item)
        item.setdefault("preview", False)
        item["listed_in_stripe_freshness_table"] = False
        entries.setdefault(item["name"], item)
    for name in entries:
        entries[name].setdefault("listed_in_stripe_freshness_table", True)

    all_names = set(entries)
    tables: list[dict] = []

    for name in sorted(entries):
        base = entries[name]
        table: dict = {
            "name": name,
            "dataset": base["dataset"],
            "source": base["source"],
            "freshness_hours": base.get("freshness_hours"),
            "preview": base.get("preview", False),
            "listed_in_stripe_freshness_table": base["listed_in_stripe_freshness_table"],
        }
        if base.get("evidence"):
            table["evidence"] = base["evidence"]

        if name.endswith("_metadata") and metadata_parent(name, all_names) in all_names:
            table.update(build_metadata_table(name, conventions, all_names))
        elif name in curated:
            table.update(strip_comments(curated[name]))
        else:
            table.setdefault("description", "")
            table.setdefault("primary_key", [])
            table.setdefault("columns", [])

        if base.get("mirror_of") or curated.get(name, {}).get("mirror_of"):
            table["mirror_of"] = base.get("mirror_of") or curated[name]["mirror_of"]
        if name.startswith("connected_account_"):
            table = apply_connect_mirror(table, conventions)

        table.setdefault("columns", [])
        table.setdefault("primary_key", [])
        table.setdefault("foreign_keys", [])
        table.setdefault("columns_complete", False)

        for col in table["columns"]:
            col.setdefault("confidence", "community")
            col.setdefault("type", "unknown")

        if name in doc_columns:
            merge_doc_columns(table, doc_columns[name], all_names)

        # Mark primary/foreign key roles consistently.
        pk = set(table["primary_key"])
        fk_cols = {c for fk in table["foreign_keys"] for c in fk["columns"]}
        for col in table["columns"]:
            if col["name"] in pk:
                col["key"] = "primary"
            elif col.get("key") != "primary" and col["name"] in fk_cols:
                col["key"] = "foreign"

        table["columns"].sort(key=lambda c: (c["name"] != "id", c["name"]))
        tables.append(table)

    # ---- inherit from `same_columns_as` / `mirror_of` -----------------------
    # Done after the main pass so the base table is fully assembled first.
    by_name = {t["name"]: t for t in tables}
    for table in tables:
        alias = table.pop("same_columns_as", None) or table.get("mirror_of")
        source = by_name.get(alias) if alias else None
        if not source:
            continue

        if not table["columns"] or table.get("derived_from_convention") == "connect_mirror_tables":
            inherited = {c["name"]: c for c in json.loads(json.dumps(source["columns"]))}
            merged = []
            for col in table["columns"]:
                # A doc-only stub has no type; prefer the base table's typed version
                # while keeping the stub's `documented` confidence and citations.
                base_col = inherited.pop(col["name"], None)
                if base_col and col.get("type") == "unknown":
                    base_col = dict(base_col)
                    base_col["confidence"] = col["confidence"]
                    if "doc_sources" in col:
                        base_col["doc_sources"] = col["doc_sources"]
                    merged.append(base_col)
                else:
                    merged.append(col)
            # Keep columns already on the mirror (e.g. `account`) in front.
            table["columns"] = merged + list(inherited.values())
            table["foreign_keys"] = table["foreign_keys"] + [
                fk
                for fk in json.loads(json.dumps(source["foreign_keys"]))
                if fk not in table["foreign_keys"]
            ]
            table["columns_inherited_from"] = alias

        if not table.get("description"):
            table["description"] = (
                f"Connect platform view of {alias} for connected accounts. "
                f"{source.get('description', '')}".strip()
            )
        table.setdefault("primary_key", source["primary_key"])
        table.setdefault("grain", source.get("grain", ""))

    # ---- ground truth from a live account (highest priority) ---------------
    verified_path = root / "sources/verified_schema.json"
    verification_stats = None
    if verified_path.exists():
        verification_stats = apply_verified_overlay(tables, load(verified_path))
        tables.sort(key=lambda t: t["name"])
        print(f"  verified overlay: {verification_stats}")

    # ---- stats --------------------------------------------------------------
    conf_counts: dict[str, int] = {}
    for table in tables:
        for col in table["columns"]:
            conf_counts[col["confidence"]] = conf_counts.get(col["confidence"], 0) + 1

    schema = {
        "schema_version": args.schema_version,
        "generated_by": "tools/build_schema.py",
        "product": "Stripe Sigma",
        "warning": "Column lists are complete only where columns_complete is true. Stripe publishes the full column list only inside the Dashboard schema browser; run tools/verify_against_sigma.py against a real account to confirm and extend this file.",
        "confidence_levels": {
            "documented": "Appears in an official Stripe SQL example or published column table.",
            "conventional": "Synthesized from a structural rule Stripe documents (metadata tables, Connect mirrors).",
            "community": "Curated from experience. Plausible, but not proven against a live account.",
            "verified": "Confirmed to exist by querying a real Sigma account.",
        },
        "conventions": conventions,
        "verification": {
            "verified_against_live_account": verification_stats is not None,
            "details": verification_stats,
            "how_to_verify": "See verification/README.md",
        },
        "stats": {
            "tables": len(tables),
            "columns": sum(len(t["columns"]) for t in tables),
            "columns_by_confidence": dict(sorted(conf_counts.items())),
            "tables_with_complete_columns": sum(1 for t in tables if t["columns_complete"]),
        },
        "tables": tables,
    }

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(schema, indent=2) + "\n", encoding="utf-8")
    print(f"{len(tables)} tables, {schema['stats']['columns']} columns -> {args.output}")
    print(f"  by confidence: {schema['stats']['columns_by_confidence']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
