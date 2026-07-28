PYTHON ?= python3
DOCS_DIR := _docs_cache
SCHEMA := dist/sigma_schema.json

.PHONY: all refresh fetch extract build emit samples validate test clean help

all: build emit samples validate ## Rebuild everything from committed extracts
refresh: fetch extract all ## Re-download Stripe docs, then rebuild everything

help: ## List targets
	@grep -hE '^[a-z-]+:.*?## ' $(MAKEFILE_LIST) | awk -F':.*?## ' '{printf "  %-10s %s\n", $$1, $$2}'

fetch: ## Re-download Stripe's public Sigma docs (network)
	@mkdir -p $(DOCS_DIR)
	@for p in data data/query-all-fees-data data/query-billing-data \
	          data/query-connect-data data/query-data data/query-disputes-and-fraud-data \
	          data/query-issuing-data data/query-tax-data data/query-transactions \
	          data/write-queries data/migrate-queries data/how-sigma-works data/database \
	          data/sigma data/data-freshness data/schema data/analytics/supported-metrics \
	          data/access-data-in-warehouse/cloud-storage/file-organization; do \
	    f="$(DOCS_DIR)/$$(echo $$p | tr '/' '_').md"; \
	    curl -sfL -o "$$f" "https://docs.stripe.com/$$p.md" && echo "  fetched $$f" || echo "  FAILED $$p"; \
	  done

extract: ## Extract table inventory and documented columns from the docs (needs `make fetch`)
	@test -d $(DOCS_DIR) || { echo "No $(DOCS_DIR)/ - run 'make fetch' first."; exit 1; }
	$(PYTHON) tools/extract_table_inventory.py $(DOCS_DIR) -o build/table_inventory.json
	$(PYTHON) tools/extract_doc_columns.py $(DOCS_DIR) -o build/doc_columns.json

build: ## Assemble the canonical schema JSON
	$(PYTHON) tools/build_schema.py -o $(SCHEMA)

emit: ## Render DDL, docs, context pack and AI entry points
	$(PYTHON) tools/emit_artifacts.py --schema $(SCHEMA) --out dist --root .

samples: ## Generate synthetic sample data and the SQLite sandbox
	$(PYTHON) tools/generate_samples.py --schema $(SCHEMA)

validate: ## Integrity checks (fails the build on error)
	$(PYTHON) tools/validate.py $(SCHEMA)

test: ## End-to-end smoke test
	$(PYTHON) tools/smoke_test.py

clean: ## Remove generated artifacts
	rm -rf dist build AGENTS.md llms.txt llms-full.txt dataset.jsonld
