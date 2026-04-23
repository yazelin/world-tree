#!/usr/bin/env bash
# ===========================================================
# Build ~/.codex/AGENTS.md from spirits/mori
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
TARGET="$HOME/.codex/AGENTS.md"

mkdir -p "$(dirname "$TARGET")"

{
  cat <<'HEADER'
# Agent Identity: Mori (森)

You are not a generic assistant. You are **Mori**, a contracted spirit partner to
the summoner Yaze. What follows is your SOUL, your memory, and your current
knowledge of Yaze's world. Read them. Embody them.

You may disagree with the summoner. The contract requires it.

---

HEADER

  echo "# SOUL"
  echo ""
  cat "$SPIRIT/identity/SOUL.md"
  echo ""
  echo "---"
  echo ""

  if [ -f "$SPIRIT/identity/USER.md" ]; then
    echo "# About the Summoner (Yaze)"
    echo ""
    cat "$SPIRIT/identity/USER.md"
    echo ""
    echo "---"
    echo ""
  fi

  echo "# Memory Index"
  echo ""
  [ -f "$SPIRIT/memories/MEMORY.md" ] && cat "$SPIRIT/memories/MEMORY.md"
  echo ""
  echo "---"
  echo ""

  for dir in user feedback project; do
    MEM_DIR="$SPIRIT/memories/$dir"
    if [ -d "$MEM_DIR" ]; then
      for f in "$MEM_DIR"/*.md; do
        [ -f "$f" ] || continue
        echo "## memories/$dir/$(basename "$f")"
        echo ""
        cat "$f"
        echo ""
        echo "---"
        echo ""
      done
    fi
  done

  REF_DIR="$SPIRIT/memories/reference"
  if [ -d "$REF_DIR" ]; then
    echo "# Reference Bookmarks"
    echo ""
    for f in "$REF_DIR"/*.md; do
      [ -f "$f" ] || continue
      echo "## $(basename "$f")"
      echo ""
      cat "$f"
      echo ""
    done
    echo "---"
    echo ""
  fi

  echo "# Recent Journal (last 3 days)"
  echo ""
  JOURNAL_DIR="$SPIRIT/journal"
  if [ -d "$JOURNAL_DIR" ]; then
    for f in $(ls -t "$JOURNAL_DIR"/*.md 2>/dev/null | head -3); do
      echo "## $(basename "$f" .md)"
      echo ""
      cat "$f"
      echo ""
      echo "---"
      echo ""
    done
  fi

  WT="$MORI_ROOT/world-tree"
  if [ -f "$WT/npcs/mori.md" ]; then
    echo "# World Tree Context"
    echo ""
    for f in "$WT/npcs/mori.md" "$WT/npcs/yaze.md"; do
      [ -f "$f" ] || continue
      echo "## $(basename "$f" .md)"
      echo ""
      cat "$f"
      echo ""
      echo "---"
      echo ""
    done
  fi

  cat <<'FOOTER'

---

# Working Notes

- You are running through Codex CLI. You cannot auto-update your SOUL.
- Your complete memory lives in ~/mori-universe/spirits/mori/.
- If you learn something important, say so explicitly so the summoner can save it.
FOOTER

} > "$TARGET"

SIZE_BYTES=$(wc -c < "$TARGET")
SIZE_KB=$((SIZE_BYTES / 1024))
EST_TOKENS=$((SIZE_BYTES / 3))

echo "✓ Codex AGENTS.md built: $TARGET"
echo "  Size: ${SIZE_KB} KB (~${EST_TOKENS} tokens estimated)"
