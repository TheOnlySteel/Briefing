#!/usr/bin/env bash
set -euo pipefail

# Daily Briefing — three-pass generation script
# Pass 1: Generate the briefing
# Pass 2: Review against checklist
# Pass 3: Fix issues (if any)
# Up to 2 review cycles, then ship regardless.

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
DATE="${1:-$(date +%Y-%m-%d)}"
BRIEFING_FILE="$REPO_ROOT/briefings/$DATE.html"
MAX_REVIEW_CYCLES=2

echo "=== Daily Briefing Generation: $DATE ==="

# --- Pass 1: Generate ---
echo ""
echo "--- Pass 1: Generate briefing ---"
claude -p "$(cat <<EOF
Read CLAUDE.md and state.json carefully. Generate today's daily briefing for $DATE.

Follow the state update protocol exactly:
1. Read state.json for current psalm, used SEP entries, used biases, and recent_stories.
2. Generate the briefing HTML file at briefings/$DATE.html
3. Update index.html (prepend new entry)
4. Update feed.xml (prepend new item, prune beyond 90)
5. Update state.json (increment psalm, append SEP/bias, add story keys, prune old stories, set last_run_date)

Do NOT commit. Just write the files.
EOF
)" --allowedTools "Read,Write,Edit,Glob,Grep,Bash,WebFetch,WebSearch"

if [ ! -f "$BRIEFING_FILE" ]; then
  echo "ERROR: Briefing file not created at $BRIEFING_FILE"
  exit 1
fi

echo "Briefing generated at $BRIEFING_FILE"

# --- Pass 2+3: Review loop ---
for cycle in $(seq 1 $MAX_REVIEW_CYCLES); do
  echo ""
  echo "--- Review cycle $cycle of $MAX_REVIEW_CYCLES ---"

  REVIEW_RESULT=$(claude -p "$(cat <<EOF
You are a briefing reviewer. Read the following files:
1. REVIEW_CHECKLIST.md — your review checklist
2. CLAUDE.md — the generation instructions
3. state.json — the current state (BEFORE this briefing updated it; use recent_stories and chapter values to verify compliance)
4. briefings/$DATE.html — the generated briefing

Apply every check in REVIEW_CHECKLIST.md against the briefing. Respond with either:
- Exactly "APPROVED" if all checks pass
- A structured "FIXES REQUIRED" list if there are issues (see REVIEW_CHECKLIST.md for format)
EOF
)" --allowedTools "Read,Glob,Grep" --bare)

  echo "$REVIEW_RESULT"

  # Check if approved
  if echo "$REVIEW_RESULT" | grep -q "APPROVED"; then
    echo ""
    echo "=== Briefing APPROVED on review cycle $cycle ==="
    break
  fi

  # Not approved — run fix pass
  echo ""
  echo "--- Fix pass (cycle $cycle) ---"
  claude -p "$(cat <<EOF
The briefing at briefings/$DATE.html has been reviewed and needs fixes. Apply the following fixes exactly:

$REVIEW_RESULT

Read the briefing file, apply each fix, and write the corrected file. Also update index.html, feed.xml, and state.json if the fixes affect them. Do NOT commit.
EOF
)" --allowedTools "Read,Write,Edit,Glob,Grep,Bash,WebFetch,WebSearch"

  echo "Fixes applied."

  if [ "$cycle" -eq "$MAX_REVIEW_CYCLES" ]; then
    echo ""
    echo "=== Max review cycles reached — shipping as-is ==="
  fi
done

# --- Commit and push ---
echo ""
echo "--- Committing and pushing ---"
cd "$REPO_ROOT"
git add briefings/$DATE.html index.html feed.xml state.json
git commit -m "Daily briefing: $DATE"
git push

echo ""
echo "=== Done ==="
