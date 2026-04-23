#!/usr/bin/env bash
# ===========================================================
# 每日自動 commit + push spirits/mori
# 建議設 cron：0 23 * * * bash ~/mori-universe/bridges/auto-commit.sh
# ===========================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIR="$SCRIPT_DIR"
while [ "$DIR" != "/" ] && [ ! -d "$DIR/spirits" ]; do
  DIR=$(dirname "$DIR")
done
MORI_ROOT="$DIR"
SPIRIT_NAME=""
for d in "$MORI_ROOT/spirits"/*; do
  [ -d "$d" ] || continue
  [ "$(basename "$d")" = "_template" ] && continue
  SPIRIT_NAME="$(basename "$d")"; break
done
SPIRIT="$MORI_ROOT/spirits/$SPIRIT_NAME"

cd "$SPIRIT"

# 無變動就跳過
if git diff --quiet && git diff --cached --quiet; then
  echo "$(date): no changes, skipping"
  exit 0
fi

DATE=$(date +%Y-%m-%d)
git add .
git commit -m "auto: $DATE daily update"

if git remote | grep -q origin; then
  git push origin main 2>&1 || git push origin master 2>&1 || true
  echo "$(date): pushed"
else
  echo "$(date): committed locally (no remote set)"
fi
