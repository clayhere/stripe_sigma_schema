#!/usr/bin/env python3
"""Generate deterministic, referentially-valid sample rows for the Sigma schema.

The point of the sample data is to show an agent what values actually look like —
id prefixes, minor-unit amounts, enum spellings, timestamp formats — and to give
it a sandbox it can run real SQL against before touching a live Sigma account.

Foreign keys are honoured: a charge's customer_id always exists in customers.
Output is byte-for-byte stable across runs for a given seed, so it diffs cleanly.

Usage:
    python3 tools/generate_samples.py --schema dist/sigma_schema.json --out dist/samples
"""

from __future__ import annotations

import argparse
import csv
import json
import random
import sqlite3
import string
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

# Anchor so regenerating tomorrow doesn't churn every timestamp.
EPOCH = datetime(2026, 1, 5, 9, 14, 3, tzinfo=timezone.utc)

CURRENCIES = ["usd", "usd", "usd", "eur", "gbp", "jpy"]
COUNTRIES = ["US", "US", "GB", "DE", "FR", "CA", "AU"]
CARD_BRANDS = ["Visa", "Visa", "MasterCard", "American Express", "Discover"]
FIRST = ["Ada", "Grace", "Alan", "Katherine", "Linus", "Radia", "Barbara", "Tim"]
LAST = ["Lovelace", "Hopper", "Turing", "Johnson", "Torvalds", "Perlman", "Liskov"]
COMPANIES = ["Northwind Supply", "Acme Robotics", "Blue Harbor Coffee", "Vertex Labs",
             "Copper Kettle", "Lumen Analytics", "Ironwood Gear"]
PRODUCT_NAMES = ["Starter Plan", "Growth Plan", "Enterprise Plan", "Onboarding Fee",
                 "Extra Seat", "Priority Support"]

# How many rows to emit per table. Anything unlisted gets DEFAULT_ROWS.
DEFAULT_ROWS = 4
ROW_COUNTS = {
    "customers": 8,
    "charges": 14,
    "balance_transactions": 20,
    "balance_transaction_fee_details": 20,
    "invoices": 10,
    "invoice_line_items": 14,
    "subscriptions": 8,
    "subscription_items": 9,
    "subscription_item_change_events": 12,
    "products": 6,
    "prices": 7,
    "refunds": 5,
    "disputes": 3,
    "payment_intents": 12,
    "exchange_rates_from_usd": 5,
}


# Enum values weighted toward the common case, so sample data looks like real
# traffic rather than a uniform spread across every failure mode.
ENUM_WEIGHTS = {
    "status": {"succeeded": 6, "active": 6, "paid": 6, "open": 2, "pending": 2,
               "failed": 3, "canceled": 1, "past_due": 1, "void": 1, "draft": 1},
    "outcome_type": {"authorized": 8, "issuer_declined": 2, "blocked": 1,
                     "manual_review": 1, "invalid": 1},
    "outcome_risk_level": {"normal": 8, "elevated": 2, "highest": 1},
}


def id_prefix_map(schema: dict) -> dict[str, str]:
    """Invert the conventions' prefix->table map into table->prefix."""
    out: dict[str, str] = {}
    for prefix, target in schema["conventions"]["id_prefixes"].items():
        if prefix.startswith("$"):
            continue
        table = target.split(" ")[0]
        out.setdefault(table, prefix)
    out.setdefault("connected_accounts", "acct")
    return out


class Generator:
    def __init__(self, schema: dict, seed: int) -> None:
        self.schema = schema
        self.rng = random.Random(seed)
        self.tables = {t["name"]: t for t in schema["tables"]}
        self.prefixes = id_prefix_map(schema)
        self.rows: dict[str, list[dict]] = {}
        self.pk_pool: dict[str, list[str]] = {}

    # ---- primitive value generation ---------------------------------------
    def token(self, n: int = 14) -> str:
        alphabet = string.ascii_letters + string.digits
        return "".join(self.rng.choice(alphabet) for _ in range(n))

    def make_id(self, table: str, index: int) -> str:
        prefix = self.prefixes.get(table)
        if not prefix:
            # Derive something readable for tables with no documented prefix.
            prefix = "".join(w[0] for w in table.split("_"))[:4]
        return f"{prefix}_{self.token()}"

    def timestamp(self, index: int) -> str:
        moment = EPOCH + timedelta(
            days=self.rng.randint(0, 170),
            hours=self.rng.randint(0, 23),
            minutes=self.rng.randint(0, 59),
        )
        return moment.strftime("%Y-%m-%d %H:%M:%S")

    def amount(self, table: str, column: str) -> int | float:
        # itemized_fees reports MAJOR units; everything else uses minor units.
        if table in ("itemized_fees", "connected_account_itemized_fees",
                     "itemized_fees_beta", "connected_account_itemized_fees_beta"):
            return round(self.rng.uniform(0.15, 48.0), 2)
        if "tax" in column or "fee" in column or "discount" in column:
            return self.rng.choice([0, 59, 87, 120, 190, 304, 450])
        return self.rng.choice([500, 999, 1500, 1999, 2500, 4200, 7500, 10000, 24900])

    def value(self, table: str, col: dict, index: int, fk_targets: dict[str, str]):
        name, ctype = col["name"], col.get("type", "unknown")

        if name in fk_targets:
            pool = self.pk_pool.get(fk_targets[name], [])
            if pool:
                return self.rng.choice(pool)
            return ""

        if col.get("key") == "primary" and name == "id":
            return self.make_id(table, index)

        if col.get("enum"):
            weights = ENUM_WEIGHTS.get(name)
            if weights:
                pool = [v for v in col["enum"] for _ in range(weights.get(v, 1))]
                return self.rng.choice(pool)
            return self.rng.choice(col["enum"])

        # An unresolved *_id column still deserves a Stripe-shaped value, so an
        # agent reading the samples learns the right prefix for that object.
        if name.endswith("_id") and name != "id":
            stem = name[:-3]
            for candidate in (f"{stem}s", stem, f"{stem}es"):
                if candidate in self.prefixes:
                    return f"{self.prefixes[candidate]}_{self.token()}"
            initials = "".join(w[0] for w in stem.split("_") if w)[:4] or "ref"
            return f"{initials}_{self.token()}"

        # Name-driven realism beats type-driven defaults for Stripe data.
        if name == "currency" or name.endswith("_currency"):
            return self.rng.choice(CURRENCIES)
        if name == "email":
            return f"{self.rng.choice(FIRST).lower()}.{self.rng.choice(LAST).lower()}@example.com"
        if name == "name" and table == "products":
            return self.rng.choice(PRODUCT_NAMES)
        if name in ("name", "business_name", "display_name"):
            return self.rng.choice(COMPANIES)
        if name in ("legal_entity_first_name",):
            return self.rng.choice(FIRST)
        if name in ("legal_entity_last_name",):
            return self.rng.choice(LAST)
        if name.endswith("country") or name == "country":
            return self.rng.choice(COUNTRIES)
        if name == "card_brand" or name == "brand":
            return self.rng.choice(CARD_BRANDS)
        if name in ("last4", "card_last4"):
            return f"{self.rng.randint(1000, 9999)}"
        if name == "key":
            return self.rng.choice(["order_id", "internal_ref", "cohort", "channel"])
        if name == "value":
            return self.rng.choice(["ORD-4471", "acme-2026", "enterprise", "partner"])
        if name == "buy_currency_exchange_rates":
            return json.dumps({"usd": 1.0, "eur": 0.92, "gbp": 0.79, "jpy": 151.4})
        if name == "url":
            return f"https://buy.stripe.com/test_{self.token(10)}"
        if name in ("description", "product_feature_description"):
            return self.rng.choice(["Monthly subscription", "Seat overage",
                                    "Card payment processing", "Onboarding"])
        if name == "statement_descriptor":
            return self.rng.choice(["NORTHWIND", "ACME ROBOTICS", "BLUEHARBOR"])
        if name in ("payment_method_type", "type") and table in ("charges", "payment_methods",
                                                                 "payment_method_details"):
            return self.rng.choice(["card", "card", "card", "us_bank_account", "sepa_debit"])
        if name == "card_funding":
            return self.rng.choice(["credit", "credit", "debit", "prepaid"])
        if name == "outcome_seller_message":
            return self.rng.choice(["Payment complete.", "The bank returned the decline code.",
                                    "Stripe blocked this payment as high risk."])
        if name == "outcome_network_status":
            return self.rng.choice(["approved_by_network", "approved_by_network",
                                    "declined_by_network"])
        if name.startswith("requirements_") or name.startswith("future_requirements_"):
            return self.rng.choice(["", "", "individual.verification.document"])
        if "amount" in name or name in ("fee", "net", "total", "subtotal", "tax", "balance"):
            return self.amount(table, name)
        if name == "quantity" or name.endswith("_count") or name == "times_redeemed":
            return self.rng.randint(1, 12)
        if name in ("percent_off", "percentage", "tax_rate_percentage"):
            return round(self.rng.uniform(2.5, 25.0), 2)
        if name == "risk_score" or name == "outcome_risk_score":
            return self.rng.randint(1, 92)

        if ctype == "timestamp":
            return self.timestamp(index)
        if ctype == "date":
            return (EPOCH + timedelta(days=index)).strftime("%Y-%m-%d")
        if ctype == "boolean":
            return self.rng.choice([True, False])
        if ctype == "bigint":
            return self.rng.randint(1, 5000)
        if ctype == "double":
            return round(self.rng.uniform(0.5, 500.0), 2)
        if ctype == "varchar":
            if name.endswith("_id") or name == "account":
                return f"{self.token(10)}"
            return self.rng.choice(["standard", "default", "primary", ""])
        return ""

    # ---- table generation --------------------------------------------------
    def order_tables(self) -> list[str]:
        """Topologically sort so a table's FK parents are generated first."""
        pending = {n for n, t in self.tables.items() if t["columns"]}
        ordered: list[str] = []
        while pending:
            progressed = False
            for name in sorted(pending):
                deps = {
                    fk["references"]["table"]
                    for fk in self.tables[name]["foreign_keys"]
                    if fk["references"]["table"] != name
                }
                if deps & pending:
                    continue
                ordered.append(name)
                pending.discard(name)
                progressed = True
            if not progressed:
                # Cycle (e.g. charges <-> disputes). Break it deterministically.
                ordered.extend(sorted(pending))
                break
        return ordered

    def generate(self) -> None:
        for name in self.order_tables():
            table = self.tables[name]
            fk_targets = {
                fk["columns"][0]: fk["references"]["table"]
                for fk in table["foreign_keys"]
                if len(fk["columns"]) == 1
            }
            count = ROW_COUNTS.get(name, DEFAULT_ROWS)
            rows = []
            for i in range(count):
                row = {
                    c["name"]: self.value(name, c, i, fk_targets)
                    for c in table["columns"]
                }
                rows.append(row)
            self.rows[name] = rows

            pk = table["primary_key"]
            if pk and pk[0] in (c["name"] for c in table["columns"]):
                self.pk_pool[name] = [r[pk[0]] for r in rows]

        self._enforce_consistency()

    def _enforce_consistency(self) -> None:
        """Fix up relationships that generic FK filling can't express."""
        # A refund's balance transaction should be negative; a charge's positive.
        bt = {r["id"]: r for r in self.rows.get("balance_transactions", [])}
        for row in self.rows.get("refunds", []):
            target = bt.get(row.get("balance_transaction_id"))
            if target:
                target["type"] = "refund"
                target["amount"] = -abs(int(target["amount"]))
                target["net"] = target["amount"] + abs(int(target["fee"] or 0))

        # net = amount - fee for charge-like rows.
        for row in self.rows.get("balance_transactions", []):
            if row.get("type") != "refund":
                row["net"] = int(row["amount"]) - int(row["fee"] or 0)

        # Fee details should sum to the parent's fee.
        by_txn: dict[str, list[dict]] = {}
        for row in self.rows.get("balance_transaction_fee_details", []):
            by_txn.setdefault(row.get("balance_transaction_id", ""), []).append(row)
        for txn_id, details in by_txn.items():
            parent = bt.get(txn_id)
            if not parent:
                continue
            total = abs(int(parent["fee"] or 0))
            share = total // len(details)
            for detail in details[:-1]:
                detail["amount"] = share
            details[-1]["amount"] = total - share * (len(details) - 1)
            for detail in details:
                detail["currency"] = parent["currency"]

        # A charge that failed has no captured_at, no refunds and is not paid.
        for row in self.rows.get("charges", []):
            amount = int(row.get("amount") or 0)
            if row.get("status") == "failed":
                row["captured_at"] = ""
                row["paid"] = False
                row["refunded"] = False
                row["amount_refunded"] = 0
                row["dispute_id"] = ""
                row["balance_transaction_id"] = ""
                row["outcome_type"] = "issuer_declined"
                row["failure_code"] = self.rng.choice(
                    ["card_declined", "insufficient_funds", "expired_card"]
                )
                row["failure_message"] = self.rng.choice(
                    ["Your card was declined.", "Your card has insufficient funds."]
                )
            else:
                row["paid"] = True
                row["failure_code"] = ""
                row["failure_message"] = ""
                # Refunds and disputes are the exception, not the rule.
                if self.rng.random() < 0.25:
                    refunded = min(int(row.get("amount_refunded") or 0) or amount, amount)
                else:
                    refunded = 0
                row["amount_refunded"] = refunded
                row["refunded"] = refunded == amount and amount > 0
                if self.rng.random() > 0.12:
                    row["dispute_id"] = ""

            # Card-only columns must be blank for non-card payment methods.
            if row.get("payment_method_type") != "card":
                for card_col in ("card_brand", "card_country", "card_funding", "card_last4",
                                 "card_cvc_check", "card_address_zip_check"):
                    if card_col in row:
                        row[card_col] = ""

        # Invoice arithmetic should hold.
        for row in self.rows.get("invoices", []):
            subtotal = int(row.get("subtotal") or 0)
            tax = int(row.get("tax") or 0)
            row["total"] = subtotal + tax
            row["amount_paid"] = row["total"] if row.get("status") == "paid" else 0
            row["amount_due"] = row["total"] - row["amount_paid"]
            row["amount_remaining"] = row["amount_due"]
            row["paid"] = row.get("status") == "paid"

    # ---- output ------------------------------------------------------------
    def write_csv(self, out_dir: Path) -> int:
        out_dir.mkdir(parents=True, exist_ok=True)
        for name, rows in sorted(self.rows.items()):
            if not rows:
                continue
            path = out_dir / f"{name}.csv"
            with path.open("w", newline="", encoding="utf-8") as handle:
                writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
                writer.writeheader()
                writer.writerows(rows)
        return len(self.rows)

    def write_sqlite(self, path: Path) -> None:
        path.parent.mkdir(parents=True, exist_ok=True)
        if path.exists():
            path.unlink()
        conn = sqlite3.connect(path)
        try:
            for name, rows in sorted(self.rows.items()):
                if not rows:
                    continue
                cols = list(rows[0].keys())
                quoted = ", ".join(f'"{c}"' for c in cols)
                conn.execute(f'CREATE TABLE "{name}" ({quoted})')
                placeholders = ", ".join("?" for _ in cols)
                conn.executemany(
                    f'INSERT INTO "{name}" VALUES ({placeholders})',
                    [tuple(r[c] for c in cols) for r in rows],
                )
            conn.commit()
        finally:
            conn.close()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--schema", type=Path, default=Path("dist/sigma_schema.json"))
    parser.add_argument("--out", type=Path, default=Path("dist/samples"))
    parser.add_argument("--sqlite", type=Path, default=Path("dist/sigma_sample.sqlite"))
    parser.add_argument("--seed", type=int, default=20260728)
    args = parser.parse_args()

    schema = json.loads(args.schema.read_text(encoding="utf-8"))
    generator = Generator(schema, args.seed)
    generator.generate()
    n = generator.write_csv(args.out)
    generator.write_sqlite(args.sqlite)

    total = sum(len(r) for r in generator.rows.values())
    print(f"{n} tables, {total} sample rows -> {args.out} and {args.sqlite}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
