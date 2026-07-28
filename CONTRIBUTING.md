# Contributing

The most valuable contribution to this project is **verification**. Everything
else is secondary.

## Why verification matters most

Stripe publishes the complete Sigma column list only inside the Dashboard schema
browser. There's no machine-readable export. So 508 of the columns here are
marked `community`: curated, plausible, and unproven.

You have something this project cannot get on its own — a real Sigma account.
Ten minutes of your time converts guesses into facts for everyone.

## Verify columns against your account

```bash
python3 tools/verify_against_sigma.py --probe-sql > probe.sql
```

That writes one `select <every column we think exists> from <table> limit 0;`
per table. Run the blocks in the [Sigma query editor](https://dashboard.stripe.com/sigma/queries).

- A block that **parses and returns 0 rows** confirms every column in it exists.
- A block that **errors** names the offending column. Remove it and re-run to
  find the rest.

Then either open a PR editing `sources/curated_*.json` directly, or export a CSV
with `table_name,column_name` and let the tool diff it:

```bash
python3 tools/verify_against_sigma.py --results export.csv
```

Attach the generated `build/verification.json` to your PR.

**Never paste real customer data, real ids, real amounts or account identifiers
into an issue or PR.** Column names only.

## Confidence rules

| Level | When to use it |
| --- | --- |
| `documented` | The column appears in an official Stripe doc page. **Must** carry `doc_sources`. |
| `conventional` | Follows a rule Stripe documents (`*_metadata`, `connected_account_*`). Set by the build, not by hand. |
| `community` | Default. Curated but unproven. |
| `verified` | You confirmed it against a live account. Say which in the PR. |

Do not promote a column to `documented` without a citation, or to `verified`
without having actually run the query. An overconfident schema is worse than an
incomplete one, because it produces SQL that looks right and is wrong.

## Other useful contributions

- **Missing tables.** Especially `connected_account_*` mirrors, which vary by
  account. Add them to `sources/supplemental_tables.json` with an `evidence` link.
- **Corrections** to descriptions, grain statements, enum values or join keys.
- **Caveats.** If a query pattern silently gave you a wrong number, that belongs
  in the table's `notes` — it's the highest-value content in the whole dataset.
- **Query recipes** for common metrics.

## Making changes

```bash
make            # rebuild everything
make validate   # integrity checks
make test       # smoke test
```

Edit `sources/`. Never edit `dist/`, `AGENTS.md`, `llms.txt`, `llms-full.txt` or
`dataset.jsonld` — the build overwrites them. Commit the regenerated artifacts
along with your source change so consumers can use the repo without a build step.

## Style

- Python 3.11+, standard library only. No dependencies, ever — this has to run
  anywhere without a package install.
- Descriptions are sentences, not fragments. Say what the column *means* and
  when it will mislead you, not just what it's called.

## License

Contributions to `tools/` are MIT. Contributions to `sources/` and documentation
are released under CC0 1.0. By submitting a PR you agree to those terms.
