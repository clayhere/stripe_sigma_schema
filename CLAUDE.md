# CLAUDE.md

This project's agent instructions live in **[AGENTS.md](AGENTS.md)** — read that file.

It contains the full Stripe Sigma schema context pack: every table, column, join
key, enum, dialect rule and query pitfall needed to write correct Sigma SQL.

## Working on this repo

- `dist/`, `AGENTS.md`, `llms.txt`, `llms-full.txt` and `dataset.jsonld` are **generated**.
  Never edit them directly — edit `sources/` and run `make`.
- `sources/curated_*.json` is the hand-maintained source of truth for descriptions,
  keys and columns.
- Run `make validate` before committing; it catches broken foreign keys, duplicate
  columns and primary keys that don't exist.
- When adding a column, set its `confidence` honestly. `community` is the default
  for anything not proven against a live Sigma account or cited in Stripe's docs.
  Never upgrade a column to `documented` without a `doc_sources` citation.
