#!/usr/bin/env bash
# ===========================================================
# Mori Universe · Bridges Installer
# 首次安裝：把各 CLI 接上 ~/mori-universe/spirits/mori/
# ===========================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# bridges 可能在 ~/mori-universe/bridges/ 或 ~/mori-universe/world-tree/bridges/
# 向上找有 spirits/ 同層的目錄
DIR="$SCRIPT_DIR"
while [ "$DIR" != "/" ] && [ ! -d "$DIR/spirits" ]; do
  DIR=$(dirname "$DIR")
done
if [ "$DIR" = "/" ]; then
  echo "Error: 找不到 mori-universe 根目錄（沒 spirits/ 同層）"
  echo "請確認你的結構是：~/mori-universe/{spirits,world-tree}/..."
  exit 1
fi
MORI_ROOT="$DIR"
# 自動偵測 spirit 目錄
SPIRIT_NAME=""
for d in "$MORI_ROOT/spirits"/*; do
  [ -d "$d" ] || continue
  name=$(basename "$d")
  [ "$name" = "_template" ] && continue
  SPIRIT_NAME="$name"
  break
done
if [ -z "$SPIRIT_NAME" ]; then
  echo "Error: $MORI_ROOT/spirits/ 內找不到精靈"
  echo "請先走 initiation-rite.md 完成精靈召喚"
  exit 1
fi
SPIRIT="$MORI_ROOT/spirits/$SPIRIT_NAME"
IDENTITY="$SPIRIT/identity"
MEMORIES="$SPIRIT/memories"
echo "偵測到精靈：$SPIRIT_NAME"
TODAY=$(date +%Y-%m-%d)
BACKUP_SUFFIX=".bak-before-bridges-$TODAY"

# ----- 色彩 -----
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()    { echo -e "${GREEN}✓${NC} $1"; }
warn()  { echo -e "${YELLOW}⚠${NC} $1"; }
fail()  { echo -e "${RED}✗${NC} $1"; }

# ----- 預檢 -----
echo "🌲 Mori Universe Bridges Installer"
echo "======================================"
echo ""

if [ ! -d "$SPIRIT" ]; then
  fail "找不到 $SPIRIT"
  echo "請先確認 ~/mori-universe/spirits/mori/ 存在。"
  exit 1
fi

if [ ! -f "$IDENTITY/SOUL.md" ]; then
  fail "找不到 $IDENTITY/SOUL.md"
  exit 1
fi
ok "找到 Mori 的 SOUL.md"

if [ ! -d "$MEMORIES" ]; then
  fail "找不到 $MEMORIES"
  exit 1
fi
ok "找到 Mori 的 memories/"

echo ""

# ----- 1. Claude Code symlinks -----
echo "1. 設定 Claude Code symlinks..."
if command -v claude >/dev/null 2>&1; then
  # CLAUDE.md
  CLAUDE_MD="$HOME/.claude/CLAUDE.md"
  mkdir -p "$(dirname "$CLAUDE_MD")"
  if [ -e "$CLAUDE_MD" ] && [ ! -L "$CLAUDE_MD" ]; then
    mv "$CLAUDE_MD" "${CLAUDE_MD}${BACKUP_SUFFIX}"
    warn "備份既有 $CLAUDE_MD → ${CLAUDE_MD}${BACKUP_SUFFIX}"
  fi
  ln -sfn "$IDENTITY/SOUL.md" "$CLAUDE_MD"
  ok "~/.claude/CLAUDE.md → SOUL.md"

  # Claude Code auto-memory（主專案）
  # 找出 hermes 的 project hash 目錄
  CLAUDE_PROJ_DIR="$HOME/.claude/projects"
  if [ -d "$CLAUDE_PROJ_DIR" ]; then
    # 找到對應 ~/.hermes 的 project 目錄（-home-yaze--hermes）
    for proj in "$CLAUDE_PROJ_DIR"/*; do
      [ -d "$proj" ] || continue
      MEM_DIR="$proj/memory"
      # 只處理有 memory/ 且不是 symlink 的
      if [ -d "$MEM_DIR" ] && [ ! -L "$MEM_DIR" ]; then
        mv "$MEM_DIR" "${MEM_DIR}${BACKUP_SUFFIX}"
        ln -sfn "$MEMORIES" "$MEM_DIR"
        ok "Claude project memory → $MEM_DIR"
      elif [ -L "$MEM_DIR" ]; then
        # 已經是 symlink，檢查是否指對
        if [ "$(readlink "$MEM_DIR")" != "$MEMORIES" ]; then
          rm "$MEM_DIR"
          ln -sfn "$MEMORIES" "$MEM_DIR"
          ok "更新 $MEM_DIR symlink"
        else
          ok "$MEM_DIR 已正確連結"
        fi
      fi
    done
  fi
else
  warn "未偵測到 claude CLI，跳過"
fi

echo ""

# ----- 2. Hermes symlinks -----
echo "2. 設定 Hermes symlinks..."
if [ -d "$HOME/.hermes" ]; then
  HERMES_SOUL="$HOME/.hermes/SOUL.md"
  if [ -e "$HERMES_SOUL" ] && [ ! -L "$HERMES_SOUL" ]; then
    mv "$HERMES_SOUL" "${HERMES_SOUL}${BACKUP_SUFFIX}"
    warn "備份既有 $HERMES_SOUL"
  fi
  ln -sfn "$IDENTITY/SOUL.md" "$HERMES_SOUL"
  ok "~/.hermes/SOUL.md → SOUL.md"

  # Hermes memories（如果存在）
  HERMES_MEM="$HOME/.hermes/memories"
  if [ -e "$HERMES_MEM" ] && [ ! -L "$HERMES_MEM" ]; then
    mv "$HERMES_MEM" "${HERMES_MEM}${BACKUP_SUFFIX}"
    warn "備份既有 $HERMES_MEM"
  fi
  ln -sfn "$MEMORIES" "$HERMES_MEM"
  ok "~/.hermes/memories → memories/"
else
  warn "未偵測到 ~/.hermes，跳過"
fi

echo ""

# ----- 3. Gemini CLI build -----
echo "3. 首次 build Gemini 單檔..."
bash "$SCRIPT_DIR/build-gemini.sh"

echo ""

# ----- 4. Codex CLI build -----
echo "4. 首次 build Codex 單檔..."
bash "$SCRIPT_DIR/build-codex.sh"

echo ""

# ----- 總結 -----
echo "======================================"
ok "Bridges 安裝完成"
echo ""
echo "從此以後："
echo "  - Claude Code / Hermes 直接讀寫 Mori 本體（symlink）"
echo "  - Gemini / Codex 讀的是 build 出來的濃縮版"
echo "  - 記憶變動後，重跑 build-all.sh 讓 Gemini / Codex 同步"
echo ""
echo "下一步建議："
echo "  - cron 設定：0 0 * * * bash $SCRIPT_DIR/build-all.sh"
echo "  - 每日 push：cd $SPIRIT && git add . && git commit -am 'daily' && git push"
