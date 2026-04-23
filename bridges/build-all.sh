#!/usr/bin/env bash
# ===========================================================
# 一次重 build 所有 CLI 的 context（或驗證 symlink）
# ===========================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🌲 Rebuilding all CLI contexts from spirits/mori..."
echo ""

bash "$SCRIPT_DIR/build-claude.sh"
echo ""
bash "$SCRIPT_DIR/build-gemini.sh"
echo ""
bash "$SCRIPT_DIR/build-codex.sh"

echo ""
echo "✓ All bridges rebuilt / verified"
