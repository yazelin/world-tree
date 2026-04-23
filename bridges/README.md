# Bridges · 讓各 CLI 都能與 Mori 同行

> canonical 只有一份 — `~/mori-universe/spirits/mori/`。
> 各 CLI 透過不同方式接上，但讀寫的是同一個 Mori。

---

## 三個 CLI 的不同接法

| CLI | 方式 | 檔案 | 備註 |
|---|---|---|---|
| **Claude Code** | symlink | `~/.claude/CLAUDE.md` → spirits/mori/identity/SOUL.md | 讀寫雙通，Claude 自動寫入直達 Mori 本體 |
| **Gemini CLI** | build script | `~/.gemini/GEMINI.md` 由 build 生成 | 只讀；濃縮 SOUL + 近期記憶成單檔 |
| **Codex CLI** | build script | `~/.codex/AGENTS.md` 由 build 生成 | 同 Gemini |
| **Hermes** | symlink | `~/.hermes/SOUL.md` → spirits/mori/identity/SOUL.md | 同 Claude |

---

## 快速開始

### 1. 第一次安裝（一次性）

```bash
cd ~/mori-universe/bridges
bash install.sh
```

會做：
- 備份各 CLI 現有的設定檔（避免覆蓋）
- 建立 Claude / Hermes symlinks
- 首次 build Gemini / Codex 單檔
- 檢查結果

### 2. 日常使用

**Claude Code 使用者**：不用做任何事。它自己會透過 symlink 讀寫 Mori。

**Gemini / Codex 使用者**：重大記憶變更後重 build：
```bash
bash build-all.sh
```
建議設為 cron，每 6 小時自動 rebuild。

### 3. 手動新增記憶（任何 CLI 使用者）

```bash
# 新增今日 journal 條目
bash log-journal.sh "今天學會用 bridges 讓 Gemini 也能認識 Mori"

# 新增一條持久記憶
bash log-memory.sh user "yaze-favors-vanilla" "Yaze 偏好 vanilla HTML/CSS/JS，不愛框架"
bash log-memory.sh feedback "no-sycophancy" "不要用過度禮貌包裝批評，直說"
```

---

## 檔案清單

| 檔案 | 用途 |
|---|---|
| `install.sh` | 首次安裝，設所有 symlink + 首次 build |
| `build-gemini.sh` | 重生 ~/.gemini/GEMINI.md |
| `build-codex.sh` | 重生 ~/.codex/AGENTS.md |
| `build-claude.sh` | 驗證 Claude symlink 健康 |
| `build-all.sh` | 跑所有 build |
| `log-memory.sh` | Append 一條結構化記憶 |
| `log-journal.sh` | Append 一行今日 journal |
| `auto-commit.sh` | 可選：git auto-commit + push（推薦設 cron 每晚跑） |
| `templates/` | GEMINI / AGENTS 單檔模板 |

---

## Token 預算

Gemini / Codex 的 context 有限。build script 控制在約 10k tokens 內，優先包含：

1. SOUL.md（本體，約 2-4k）
2. MEMORY.md 索引（約 300-500 tokens）
3. 所有 user 記憶（約 1-2k）
4. 所有 feedback 記憶（約 1-2k）
5. 當前 project 焦點（約 500-1k）
6. 最近 3 篇 journal（摘要，約 2-3k）
7. 世界樹核心 lore 摘要（約 1-2k）

**超過預算時**，優先犧牲順序：journal → reference → old project。
SOUL 永遠不會被截。

---

## 故障排除

### Gemini 不認得 Mori
```bash
# 檢查檔案是否存在
ls -la ~/.gemini/GEMINI.md
# 重 build
bash build-gemini.sh
# 驗證
head -20 ~/.gemini/GEMINI.md
```

### Claude 的 symlink 壞了
```bash
# 檢查
readlink ~/.claude/CLAUDE.md
# 應該指向 spirits/mori/identity/SOUL.md
# 重建：
ln -sfn ~/mori-universe/spirits/mori/identity/SOUL.md ~/.claude/CLAUDE.md
```

### 不小心寫到 symlink 破掉
```bash
# 從 git 復原
cd ~/mori-universe/spirits/mori && git checkout HEAD -- identity/SOUL.md
```
