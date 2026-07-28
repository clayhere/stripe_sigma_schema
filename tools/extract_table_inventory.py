#!/usr/bin/env python3
"""Extract the canonical Sigma table inventory from Stripe's data-freshness page.

Stripe publishes the authoritative list of Sigma tables — with dataset grouping
and freshness SLA — as two markdown tables on the data freshness page. Parsing it
rather than hand-copying keeps the inventory reproducible and easy to refresh.

Usage:
    python3 tools/extract_table_inventory.py <docs_dir> -o build/table_inventory.json
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

FRESHNESS_DOC = "data_data-freshness.md"
SECTION = re.compile(r"^####\s+(.+?)\s*$", re.MULTILINE)
ROW = re.compile(r"^\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*(\d+)\s*\|\s*$", re.MULTILINE)

SOURCE_KIND = {
    "API-backed data": "api_backed",
    "Derived data": "derived",
}


def clean_table_name(raw: str) -> tuple[str, bool]:
    """Strip backticks and a trailing `(Preview)` marker."""
    name = raw.strip().strip("`").strip()
    preview = False
    if name.lower().endswith("(preview)"):
        name = name[: name.lower().rindex("(preview)")].strip()
        preview = True
    return name.strip("`").strip(), preview


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("docs_dir", type=Path)
    parser.add_argument("-o", "--output", type=Path, required=True)
    args = parser.parse_args()

    doc = (args.docs_dir / FRESHNESS_DOC).read_text(encoding="utf-8")

    # Split the document into `#### <heading>` sections so each freshness table
    # is attributed to the right source kind.
    sections: list[tuple[str, str]] = []
    matches = list(SECTION.finditer(doc))
    for i, match in enumerate(matches):
        end = matches[i + 1].start() if i + 1 < len(matches) else len(doc)
        sections.append((match.group(1).strip(), doc[match.end() : end]))

    tables: dict[str, dict] = {}
    for heading, body in sections:
        kind = SOURCE_KIND.get(heading)
        if not kind:
            continue
        for dataset, raw_name, hours in ROW.findall(body):
            name, preview = clean_table_name(raw_name)
            if not name or name.lower() == "table name":
                continue
            tables[name] = {
                "name": name,
                "dataset": dataset.strip().strip("`"),
                "source": kind,
                "freshness_hours": int(hours),
                "preview": preview,
            }

    result = [tables[k] for k in sorted(tables)]
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")

    by_kind: dict[str, int] = {}
    for t in result:
        by_kind[t["source"]] = by_kind.get(t["source"], 0) + 1
    print(f"{len(result)} tables ({by_kind}) -> {args.output}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
