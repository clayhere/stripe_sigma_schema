#!/usr/bin/env python3
"""End-to-end smoke test: does every artifact exist, parse, and agree with the others?

Guards the promises the README makes, so a broken build fails in CI rather than
in someone's agent session.

Usage:
    python3 tools/smoke_test.py
"""

from __future__ import annotations

import json
import sqlite3
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FAILURES: list[str] = []


def check(condition: bool, label: str) -> None:
    if condition:
        print(f"  ok   {label}")
    else:
        print(f"  FAIL {label}")
        FAILURES.append(label)


def main() -> int:
    print("artifacts exist")
    required = [
        "dist/sigma_schema.json", "dist/SCHEMA.md", "dist/sigma-schema.context.md",
        "dist/sigma_schema.trino.sql", "dist/sigma_schema.sqlite.sql", "dist/erd.mmd",
        "dist/sigma_sample.sqlite", "AGENTS.md", "llms.txt", "llms-full.txt",
        "dataset.jsonld", "README.md", "LICENSE", "LICENSE-DATA", "NOTICE",
        "index.html", "robots.txt", "sitemap.xml",
    ]
    for rel in required:
        check((ROOT / rel).exists(), rel)

    print("\nschema integrity")
    schema = json.loads((ROOT / "dist/sigma_schema.json").read_text(encoding="utf-8"))
    tables = {t["name"]: t for t in schema["tables"]}
    check(len(tables) > 150, f"{len(tables)} tables present")
    check(schema["stats"]["columns"] == sum(len(t["columns"]) for t in schema["tables"]),
          "stats.columns matches actual column count")
    for name in ("charges", "balance_transactions", "invoices", "subscriptions", "customers"):
        check(name in tables, f"core table {name} present")
    check(all(c["confidence"] in {"documented", "conventional", "community", "verified"}
              for t in schema["tables"] for c in t["columns"]),
          "all confidence values are valid")

    print("\ndataset.jsonld is valid JSON-LD")
    jsonld = json.loads((ROOT / "dataset.jsonld").read_text(encoding="utf-8"))
    check(jsonld.get("@type") == "Dataset", "@type is Dataset")
    check(bool(jsonld.get("license")), "license declared")

    print("\ncontext pack is prompt-sized")
    pack = (ROOT / "AGENTS.md").read_text(encoding="utf-8")
    approx_tokens = len(pack) // 4
    check(approx_tokens < 15000, f"AGENTS.md ~{approx_tokens:,} tokens (< 15k)")
    check("balance_transactions" in pack, "context pack names core tables")
    check("data_load_time" in pack, "context pack documents data_load_time")

    print("\nsample database is queryable and referentially valid")
    conn = sqlite3.connect(ROOT / "dist/sigma_sample.sqlite")
    try:
        count = conn.execute(
            "select count(*) from sqlite_master where type='table'"
        ).fetchone()[0]
        check(count > 100, f"{count} sample tables")

        joined = conn.execute(
            "select count(*) from charges ch join customers cu on cu.id = ch.customer_id"
        ).fetchone()[0]
        check(joined > 0, f"charges joins customers ({joined} rows)")

        orphans = conn.execute(
            "select count(*) from charges where customer_id not in (select id from customers)"
        ).fetchone()[0]
        check(orphans == 0, "no orphaned charges.customer_id")

        bad_refunds = conn.execute(
            "select count(*) from charges where cast(amount_refunded as integer) "
            "> cast(amount as integer)"
        ).fetchone()[0]
        check(bad_refunds == 0, "no charge refunded beyond its amount")
    finally:
        conn.close()

    print("\nMCP server responds")
    requests = "\n".join([
        json.dumps({"jsonrpc": "2.0", "id": 1, "method": "initialize", "params": {}}),
        json.dumps({"jsonrpc": "2.0", "id": 2, "method": "tools/list", "params": {}}),
        json.dumps({"jsonrpc": "2.0", "id": 3, "method": "tools/call", "params": {
            "name": "join_path",
            "arguments": {"from_table": "disputes", "to_table": "customers"}}}),
    ])
    proc = subprocess.run(
        [sys.executable, str(ROOT / "tools/mcp_server.py")],
        input=requests, capture_output=True, text=True, timeout=60,
    )
    replies = [json.loads(line) for line in proc.stdout.splitlines() if line.strip()]
    check(len(replies) == 3, f"got {len(replies)} MCP replies")
    if len(replies) == 3:
        check(replies[0]["result"]["serverInfo"]["name"] == "stripe-sigma-schema",
              "server identifies itself")
        check(len(replies[1]["result"]["tools"]) == 5, "5 tools advertised")
        check("charges.customer_id = customers.id" in replies[2]["result"]["content"][0]["text"],
              "join_path resolves disputes -> customers")

    print()
    if FAILURES:
        print(f"{len(FAILURES)} check(s) failed:", file=sys.stderr)
        for failure in FAILURES:
            print(f"  - {failure}", file=sys.stderr)
        return 1
    print("all checks passed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
