#!/usr/bin/env python3
"""MCP server exposing the Stripe Sigma schema as agent-callable tools.

Lets an agent look up exactly the table it needs instead of loading the whole
reference into context. Speaks MCP over stdio with no third-party dependencies.

Register with Claude Code:
    claude mcp add stripe-sigma-schema -- python3 /path/to/tools/mcp_server.py

Or in an MCP client config:
    {"mcpServers": {"stripe-sigma-schema": {
        "command": "python3", "args": ["/path/to/tools/mcp_server.py"]}}}

Tools:
    search_tables    find tables by name, dataset or description
    describe_table   full column list, keys, enums and caveats for one table
    find_column      locate which tables expose a given column
    join_path        how to join two tables
    get_conventions  dialect rules, naming divergence, id prefixes, gotchas
"""

from __future__ import annotations

import json
import sys
from pathlib import Path
from typing import Any

SCHEMA_PATH = Path(__file__).resolve().parent.parent / "dist" / "sigma_schema.json"
PROTOCOL_VERSION = "2024-11-05"

_schema: dict | None = None


def schema() -> dict:
    global _schema
    if _schema is None:
        if not SCHEMA_PATH.exists():
            raise SystemExit(
                f"schema not found at {SCHEMA_PATH}; run `make build` first"
            )
        _schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    return _schema


def tables_by_name() -> dict[str, dict]:
    return {t["name"]: t for t in schema()["tables"]}


# ------------------------------------------------------------------ tool impls
def search_tables(query: str = "", dataset: str = "", limit: int = 25) -> str:
    query = query.lower().strip()
    hits = []
    for table in schema()["tables"]:
        if dataset and table["dataset"] != dataset:
            continue
        haystack = f"{table['name']} {table.get('description', '')}".lower()
        if query and query not in haystack:
            continue
        hits.append(table)

    # Prefer name matches over description matches.
    hits.sort(key=lambda t: (query not in t["name"].lower(), t["name"]))
    if not hits:
        return f"No tables matched query={query!r} dataset={dataset!r}."

    lines = [f"{len(hits)} match(es), showing up to {limit}:", ""]
    for table in hits[:limit]:
        fresh = table["freshness_hours"]
        lines.append(
            f"- {table['name']} [{table['dataset']}"
            f"{f', {fresh}h fresh' if fresh is not None else ''}"
            f", {len(table['columns'])} cols]"
        )
        if table.get("description"):
            lines.append(f"    {table['description'][:180]}")
    return "\n".join(lines)


def describe_table(name: str) -> str:
    table = tables_by_name().get(name)
    if not table:
        close = [n for n in tables_by_name() if name.lower() in n.lower()][:8]
        hint = f" Did you mean: {', '.join(close)}?" if close else ""
        return f"No table named {name!r}.{hint}"

    out = [f"# {table['name']}", ""]
    if table.get("description"):
        out += [table["description"], ""]
    if table.get("grain"):
        out.append(f"Grain: {table['grain']}")
    fresh = table["freshness_hours"]
    out.append(f"Dataset: {table['dataset']} | Source: {table['source']}"
               f" | Freshness: {f'{fresh}h' if fresh is not None else 'unpublished'}")
    if table["primary_key"]:
        out.append(f"Primary key: {', '.join(table['primary_key'])}")
    out.append(
        "Column list is COMPLETE." if table["columns_complete"]
        else "Column list is PARTIAL - other columns may exist that are not listed here."
    )
    out.append("")

    if table["columns"]:
        out.append("## Columns")
        out.append("")
        for col in table["columns"]:
            bits = [f"- {col['name']} ({col['type']}, {col['confidence']})"]
            if col.get("key"):
                bits.append(f"[{col['key']} key]")
            out.append(" ".join(bits))
            if col.get("description"):
                out.append(f"    {col['description']}")
            if col.get("enum"):
                out.append(f"    Values: {', '.join(col['enum'])}")
        out.append("")

    if table["foreign_keys"]:
        out.append("## Joins")
        out.append("")
        for fk in table["foreign_keys"]:
            ref = fk["references"]
            out.append(
                f"- {table['name']}.{', '.join(fk['columns'])}"
                f" -> {ref['table']}.{', '.join(ref['columns'])}"
            )
        out.append("")

    if table.get("notes"):
        out.append("## Caveats")
        out.append("")
        out += [f"- {n}" for n in table["notes"]]
    return "\n".join(out)


def find_column(name: str) -> str:
    name = name.lower().strip()
    exact, partial = [], []
    for table in schema()["tables"]:
        for col in table["columns"]:
            if col["name"].lower() == name:
                exact.append((table, col))
            elif name in col["name"].lower():
                partial.append((table, col))

    if not exact and not partial:
        return f"No column matching {name!r}."

    out = []
    if exact:
        out.append(f"## Exact matches for {name!r}")
        for table, col in exact:
            out.append(
                f"- {table['name']}.{col['name']} ({col['type']}, {col['confidence']})"
                f" - {col.get('description', '')[:140]}"
            )
    if partial:
        out.append("")
        out.append(f"## Partial matches ({len(partial)}, showing 20)")
        for table, col in partial[:20]:
            out.append(f"- {table['name']}.{col['name']} ({col['type']}, {col['confidence']})")
    return "\n".join(out)


def join_path(from_table: str, to_table: str) -> str:
    tables = tables_by_name()
    if from_table not in tables:
        return f"No table named {from_table!r}."
    if to_table not in tables:
        return f"No table named {to_table!r}."

    # Breadth-first over the undirected FK graph; these paths are short.
    edges: dict[str, list[tuple[str, str]]] = {}
    for table in schema()["tables"]:
        for fk in table["foreign_keys"]:
            target = fk["references"]["table"]
            clause = (
                f"{table['name']}.{fk['columns'][0]}"
                f" = {target}.{fk['references']['columns'][0]}"
            )
            edges.setdefault(table["name"], []).append((target, clause))
            edges.setdefault(target, []).append((table["name"], clause))

    queue: list[tuple[str, list[str]]] = [(from_table, [])]
    seen = {from_table}
    while queue:
        node, path = queue.pop(0)
        if node == to_table:
            if not path:
                return f"{from_table} and {to_table} are the same table."
            return (
                f"Join path {from_table} -> {to_table} ({len(path)} hop(s)):\n\n"
                + "\n".join(f"  {i+1}. {c}" for i, c in enumerate(path))
            )
        for neighbour, clause in edges.get(node, []):
            if neighbour in seen:
                continue
            seen.add(neighbour)
            queue.append((neighbour, path + [clause]))

    return (
        f"No foreign-key path between {from_table} and {to_table} in this schema. "
        "They may still be joinable on a polymorphic column such as "
        "balance_transactions.source_id or tax_transactions.source_id - check both "
        "tables' caveats with describe_table."
    )


def get_conventions(topic: str = "") -> str:
    conv = schema()["conventions"]
    topic = topic.lower().strip()
    if topic:
        for key, value in conv.items():
            if topic in key.lower():
                return json.dumps({key: value}, indent=2)
        return f"No convention topic matching {topic!r}. Available: {', '.join(conv)}"
    return json.dumps(conv, indent=2)


TOOLS: dict[str, dict[str, Any]] = {
    "search_tables": {
        "fn": search_tables,
        "description": "Search Stripe Sigma tables by keyword and/or dataset. Use this first to locate the right table.",
        "schema": {
            "type": "object",
            "properties": {
                "query": {"type": "string", "description": "Keyword to match against table name and description."},
                "dataset": {"type": "string", "description": "Restrict to one dataset, e.g. billing, payments, tax, issuing, treasury."},
                "limit": {"type": "integer", "description": "Max results (default 25)."},
            },
        },
    },
    "describe_table": {
        "fn": describe_table,
        "description": "Full detail for one Sigma table: columns, types, enums, keys, joins and query caveats.",
        "schema": {
            "type": "object",
            "properties": {"name": {"type": "string", "description": "Exact table name, e.g. balance_transactions."}},
            "required": ["name"],
        },
    },
    "find_column": {
        "fn": find_column,
        "description": "Find which Sigma tables expose a given column name.",
        "schema": {
            "type": "object",
            "properties": {"name": {"type": "string", "description": "Column name or fragment, e.g. customer_id."}},
            "required": ["name"],
        },
    },
    "join_path": {
        "fn": join_path,
        "description": "Find the foreign-key join path between two Sigma tables, with ON clauses.",
        "schema": {
            "type": "object",
            "properties": {
                "from_table": {"type": "string"},
                "to_table": {"type": "string"},
            },
            "required": ["from_table", "to_table"],
        },
    },
    "get_conventions": {
        "fn": get_conventions,
        "description": "Sigma dialect rules, API-vs-Sigma naming divergence, id prefixes, amount units and metadata/Connect table conventions.",
        "schema": {
            "type": "object",
            "properties": {"topic": {"type": "string", "description": "Optional: dialect, metadata_tables, connect_mirror_tables, id_prefixes, api_to_sigma_divergence, amount_units, special_values."}},
        },
    },
}


# ------------------------------------------------------------------- transport
def respond(request_id: Any, result: Any = None, error: dict | None = None) -> None:
    message: dict[str, Any] = {"jsonrpc": "2.0", "id": request_id}
    if error:
        message["error"] = error
    else:
        message["result"] = result
    sys.stdout.write(json.dumps(message) + "\n")
    sys.stdout.flush()


def handle(message: dict) -> None:
    method = message.get("method")
    request_id = message.get("id")
    params = message.get("params") or {}

    if method == "initialize":
        respond(request_id, {
            "protocolVersion": PROTOCOL_VERSION,
            "capabilities": {"tools": {}},
            "serverInfo": {"name": "stripe-sigma-schema", "version": schema()["schema_version"]},
        })
    elif method == "notifications/initialized":
        pass  # notification: no response
    elif method == "tools/list":
        respond(request_id, {
            "tools": [
                {"name": name, "description": spec["description"], "inputSchema": spec["schema"]}
                for name, spec in TOOLS.items()
            ]
        })
    elif method == "tools/call":
        name = params.get("name")
        spec = TOOLS.get(name)
        if not spec:
            respond(request_id, error={"code": -32602, "message": f"unknown tool {name!r}"})
            return
        try:
            text = spec["fn"](**(params.get("arguments") or {}))
            respond(request_id, {"content": [{"type": "text", "text": text}]})
        except TypeError as exc:
            respond(request_id, error={"code": -32602, "message": f"bad arguments: {exc}"})
        except Exception as exc:  # surface as tool error, don't kill the server
            respond(request_id, {
                "content": [{"type": "text", "text": f"error: {exc}"}],
                "isError": True,
            })
    elif request_id is not None:
        respond(request_id, error={"code": -32601, "message": f"unknown method {method!r}"})


def main() -> int:
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            message = json.loads(line)
        except json.JSONDecodeError:
            continue
        handle(message)
    return 0


if __name__ == "__main__":
    sys.exit(main())
