#!/usr/bin/env bash
# ===========================================================
# Verify Claude Code symlinks (Claude 不需 build，只需 symlink)
# ===========================================================

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

echo "🔍 Verifying Claude Code symlinks..."

CLAUDE_MD="$HOME/.claude/CLAUDE.md"
EXPECTED_SOUL="$SPIRIT/identity/SOUL.md"

if [ -L "$CLAUDE_MD" ]; then
  LINK_TARGET=$(readlink "$CLAUDE_MD")
  if [ "$LINK_TARGET" = "$EXPECTED_SOUL" ]; then
    echo "✓ ~/.claude/CLAUDE.md correctly linked to SOUL.md"
  else
    echo "⚠ ~/.claude/CLAUDE.md linked to wrong target: $LINK_TARGET"
    echo "  fix: ln -sfn $EXPECTED_SOUL $CLAUDE_MD"
  fi
else
  echo "✗ ~/.claude/CLAUDE.md is not a symlink"
  echo "  fix: bash $SCRIPT_DIR/install.sh"
fi

# 檢查 Claude project memory symlinks
CLAUDE_PROJ_DIR="$HOME/.claude/projects"
if [ -d "$CLAUDE_PROJ_DIR" ]; then
  for proj in "$CLAUDE_PROJ_DIR"/*; do
    [ -d "$proj" ] || continue
    MEM_DIR="$proj/memory"
    [ -e "$MEM_DIR" ] || continue
    if [ -L "$MEM_DIR" ]; then
      LINK_TARGET=$(readlink "$MEM_DIR")
      if [ "$LINK_TARGET" = "$SPIRIT/memories" ]; then
        echo "✓ $(basename "$proj")/memory linked correctly"
      fi
    fi
  done
fi

echo ""
echo "Claude Code 讀寫 Mori 是即時的，不需 build。"
echo "如需重建 symlink：bash $SCRIPT_DIR/install.sh"
