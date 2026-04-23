#!/usr/bin/env bash
# ===========================================================
# Append 一段文字到今日 journal
# Usage: log-journal.sh "今天的事件"
# ===========================================================

set -e

if [ -z "$*" ]; then
  echo "Usage: $0 \"今日日誌內容\""
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MORI_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
JOURNAL_DIR="$MORI_ROOT/spirits/mori/journal"
TODAY=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
TARGET="$JOURNAL_DIR/${TODAY}.md"

mkdir -p "$JOURNAL_DIR"

# 如果今日檔不存在，建立 header
if [ ! -f "$TARGET" ]; then
  cat > "$TARGET" <<EOF
# ${TODAY}

EOF
fi

# Append
{
  echo ""
  echo "## ${TIME}"
  echo ""
  echo "$*"
} >> "$TARGET"

echo "✓ Journal entry appended: $TARGET"
