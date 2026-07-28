#!/usr/bin/env python3
"""Extract table/column references that Stripe's own documentation demonstrates.

This is the provenance backbone of the dataset. Every column it emits appeared in
a SQL example or schema table published on docs.stripe.com, which lets us mark
those columns `documented` instead of guessing at them.

Usage:
    python3 tools/extract_doc_columns.py <docs_dir> -o build/doc_columns.json
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

SQL_BLOCK = re.compile(r"```sql\n(.*?)```", re.DOTALL | re.IGNORECASE)
LINE_COMMENT = re.compile(r"--[^\n]*")
BLOCK_COMMENT = re.compile(r"/\*.*?\*/", re.DOTALL)
STRING_LITERAL = re.compile(r"'(?:[^']|'')*'")
ALIAS_DEF = re.compile(r"\bas\s+([a-z_][a-z0-9_]*)\b", re.IGNORECASE)

# `from foo`, `join foo bar`, `join foo as bar`
TABLE_REF = re.compile(
    r"\b(?:from|join)\s+([a-z_][a-z0-9_]*)\b(?!\s*\()"
    r"(?:\s+(?:as\s+)?([a-z_][a-z0-9_]*)\b)?",
    re.IGNORECASE,
)
# CTE names: `with foo as (` and `, foo as (`
CTE_DEF = re.compile(r"(?:\bwith\b|,)\s*([a-z_][a-z0-9_]*)\s+as\s*\(", re.IGNORECASE)
QUALIFIED_COL = re.compile(r"\b([a-z_][a-z0-9_]*)\.([a-z_][a-z0-9_]*)\b", re.IGNORECASE)

# Words that follow `as` but are keywords, not aliases.
SQL_KEYWORDS = {
    "select", "from", "where", "join", "inner", "left", "right", "full", "outer",
    "cross", "on", "group", "order", "by", "having", "limit", "union", "all",
    "and", "or", "not", "in", "as", "with", "case", "when", "then", "else", "end",
    "unnest", "lateral", "using", "distinct", "asc", "desc", "over", "partition",
    "interval", "day", "month", "year", "hour", "minute", "second", "week",
    "time", "zone", "at", "if", "distinct",
    "is", "null", "nulls", "true", "false", "between", "like", "cast", "rows",
    "unbounded", "preceding", "following", "current", "row", "ignore", "timestamp",
    "date", "varchar", "double", "bigint", "boolean", "map", "array", "json",
}


def strip_comments(sql: str) -> str:
    return LINE_COMMENT.sub(" ", BLOCK_COMMENT.sub(" ", sql))


def parse_block(sql: str) -> dict[str, set[str]]:
    """Map real table name -> set of columns referenced against it in this query."""
    sql = STRING_LITERAL.sub(" '' ", strip_comments(sql))
    ctes = {m.group(1).lower() for m in CTE_DEF.finditer(sql)}
    aliases = {m.group(1).lower() for m in ALIAS_DEF.finditer(sql)}

    alias_to_table: dict[str, str] = {}
    tables: set[str] = set()
    # An alias bound to a CTE in one scope and a real table in another (common in
    # long queries that reuse `p`, `c`, ...) cannot be resolved by this flat parse.
    # Track those and drop them rather than mis-attributing their columns.
    ambiguous: set[str] = set()

    for match in TABLE_REF.finditer(sql):
        table, alias = match.group(1).lower(), match.group(2)
        alias = alias.lower() if alias else None
        if table in SQL_KEYWORDS:
            continue
        if table in ctes:
            # Referencing a CTE: any alias it introduces shadows a real table alias.
            if alias and alias not in SQL_KEYWORDS:
                ambiguous.add(alias)
            continue
        tables.add(table)
        alias_to_table[table] = table
        if alias and alias not in SQL_KEYWORDS and alias not in ctes:
            if alias in alias_to_table and alias_to_table[alias] != table:
                ambiguous.add(alias)
            alias_to_table[alias] = table

    for alias in ambiguous:
        alias_to_table.pop(alias, None)

    found: dict[str, set[str]] = defaultdict(set)
    for match in QUALIFIED_COL.finditer(sql):
        qualifier, column = match.group(1).lower(), match.group(2).lower()
        table = alias_to_table.get(qualifier)
        if table:
            found[table].add(column)

    # A single-table query can use bare column names unambiguously.
    if len(tables) == 1:
        (only_table,) = tables
        select_scope = re.search(
            r"\bselect\b(.*?)\bfrom\b", sql, re.DOTALL | re.IGNORECASE
        )
        where_scope = re.search(
            r"\bwhere\b(.*?)(?:\border\b|\bgroup\b|\blimit\b|$)", sql, re.DOTALL | re.IGNORECASE
        )
        for scope in (select_scope, where_scope):
            if not scope:
                continue
            for word in re.findall(r"\b([a-z_][a-z0-9_]*)\b", scope.group(1), re.IGNORECASE):
                word = word.lower()
                if word in SQL_KEYWORDS or word in ctes or word in tables or word in aliases:
                    continue
                if len(word) < 3:
                    continue
                # Skip function calls and known non-columns.
                if re.search(rf"\b{re.escape(word)}\s*\(", scope.group(1), re.IGNORECASE):
                    continue
                found[only_table].add(word)

    return found


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("docs_dir", type=Path)
    parser.add_argument("-o", "--output", type=Path, required=True)
    args = parser.parse_args()

    corpus: dict[str, dict[str, set[str]]] = defaultdict(lambda: defaultdict(set))
    for path in sorted(args.docs_dir.glob("*.md")):
        text = path.read_text(encoding="utf-8")
        for block in SQL_BLOCK.findall(text):
            for table, columns in parse_block(block).items():
                for column in columns:
                    corpus[table][column].add(path.name)

    result = {
        table: {col: sorted(srcs) for col, srcs in sorted(cols.items())}
        for table, cols in sorted(corpus.items())
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")

    total = sum(len(c) for c in result.values())
    print(f"{len(result)} tables, {total} documented columns -> {args.output}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
