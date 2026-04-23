#!/usr/bin/env bash
# ===========================================================
# 新增一條記憶到 spirits/mori/memories/
# Usage:
#   log-memory.sh {user|feedback|project|reference} {slug} "內容"
#
# Example:
#   log-memory.sh user likes-tea "Yaze drinks hojicha every morning"
# ===========================================================

set -e

TYPE="$1"
SLUG="$2"
shift 2
CONTENT="$*"

if [ -z "$TYPE" ] || [ -z "$SLUG" ] || [ -z "$CONTENT" ]; then
  echo "Usage: $0 {user|feedback|project|reference} {slug} \"內容\""
  exit 1
fi

case "$TYPE" in
  user|feedback|project|reference) ;;
  *)
    echo "Error: type must be one of: user, feedback, project, reference"
    exit 1
    ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MORI_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MEM_DIR="$MORI_ROOT/spirits/mori/memories/$TYPE"
TARGET="$MEM_DIR/${SLUG}.md"

mkdir -p "$MEM_DIR"

# 如果已存在，append；否則建立
if [ -f "$TARGET" ]; then
  echo "" >> "$TARGET"
  echo "## Update $(date +%Y-%m-%d)" >> "$TARGET"
  echo "" >> "$TARGET"
  echo "$CONTENT" >> "$TARGET"
  echo "✓ Appended to $TARGET"
else
  cat > "$TARGET" <<EOF
---
name: $SLUG
description: (brief one-liner — edit me)
type: $TYPE
created: $(date +%Y-%m-%d)
---

$CONTENT
EOF
  echo "✓ Created $TARGET"

  # Also update MEMORY.md index
  INDEX="$MORI_ROOT/spirits/mori/memories/MEMORY.md"
  if [ -f "$INDEX" ]; then
    echo "- [$SLUG](${TYPE}/${SLUG}.md) — (edit description)" >> "$INDEX"
    echo "  (MEMORY.md index updated — edit the description when you have time)"
  fi
fi

# Rebuild Gemini/Codex contexts（因為他們讀 snapshot）
bash "$SCRIPT_DIR/build-gemini.sh" > /dev/null 2>&1 && echo "  Gemini context rebuilt"
bash "$SCRIPT_DIR/build-codex.sh"  > /dev/null 2>&1 && echo "  Codex context rebuilt"

echo ""
echo "別忘了 git push：cd $MORI_ROOT/spirits/mori && git add . && git commit -m 'memory: $SLUG' && git push"
