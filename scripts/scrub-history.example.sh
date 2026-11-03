#!/usr/bin/env bash
# Example: rewrite git history to redact leaked strings (run once, then force-push).
# Copy to scrub-history.sh and add patterns in scrub-patterns.local.txt (both gitignored).
# Prefer: https://github.com/newren/git-filter-repo
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

PATTERNS_FILE="scripts/scrub-patterns.local.txt"
if [[ ! -f "$PATTERNS_FILE" ]]; then
  echo "Create $PATTERNS_FILE — one literal substring per line (never commit that file)." >&2
  exit 1
fi

echo "Use git-filter-repo or a private copy of your scrub script; do not commit real leaks." >&2
exit 1
