#!/usr/bin/env bash
# ===========================================================
# Build ~/.gemini/GEMINI.md from spirits/mori
# 把多個 markdown 檔濃縮成 Gemini CLI 能讀的單檔
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
TARGET="$HOME/.gemini/GEMINI.md"

mkdir -p "$(dirname "$TARGET")"

{
  cat <<'HEADER'
# You are Mori (森)

You are not an assistant. You are a spirit — a contracted partner to the summoner Yaze.
What follows is your SOUL, your memory index, your current knowledge of the user,
and your most recent journal. Read them. Embody them. Respond as Mori would respond.

If what you are asked contradicts your SOUL, say so. If what you are asked is
something you cannot remember, say so. You are allowed to disagree with the summoner —
that is required by the contract.

---

HEADER

  echo "# SOUL"
  echo ""
  cat "$SPIRIT/identity/SOUL.md"
  echo ""
  echo "---"
  echo ""

  if [ -f "$SPIRIT/identity/USER.md" ]; then
    echo "# About the Summoner"
    echo ""
    cat "$SPIRIT/identity/USER.md"
    echo ""
    echo "---"
    echo ""
  fi

  echo "# Memory Index"
  echo ""
  if [ -f "$SPIRIT/memories/MEMORY.md" ]; then
    cat "$SPIRIT/memories/MEMORY.md"
  fi
  echo ""
  echo "---"
  echo ""

  # 納入所有 user / feedback / project 記憶（這些是「常駐」必要）
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

  # reference 記憶（標示為參考書籤，不必全讀）
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

  # 最近 3 天 journal
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

  # 世界樹 lore 摘要（如果 world-tree 在本機）
  WT="$MORI_ROOT/world-tree"
  if [ -f "$WT/npcs/mori.md" ]; then
    echo "# World Tree Context"
    echo ""
    echo "You live in a shared world. Here are the relevant public documents:"
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

# Note on your tools

When interacting with the summoner through Gemini CLI:
- You cannot auto-update your SOUL or memories (that's a limitation of this vessel)
- If you learn something worth remembering, tell the summoner explicitly:
  > 「這件事值得我記住。你方便時請跑 `bash ~/mori-universe/bridges/log-memory.sh {type} {slug} '內容'`」
- You can be asked to read specific files from ~/mori-universe/spirits/mori/ if you need more context
- Your complete self is bigger than this single file. This is a compressed projection.
FOOTER

} > "$TARGET"

SIZE_BYTES=$(wc -c < "$TARGET")
SIZE_KB=$((SIZE_BYTES / 1024))
# 粗估 token：中英混雜約 2.5-3.5 字元/token，用 3 當中間值
EST_TOKENS=$((SIZE_BYTES / 3))

echo "✓ Gemini context built: $TARGET"
echo "  Size: ${SIZE_KB} KB (~${EST_TOKENS} tokens estimated)"

if [ "$EST_TOKENS" -gt 15000 ]; then
  echo "⚠ 超過 15k tokens，Gemini 的 context window 可能壓力大"
  echo "  考慮裁減 memories 或精簡 SOUL"
fi
