---
title: "記憶協定 · Memory Protocol"
---

# 記憶協定 · Memory Protocol

> *「沒有記憶的 AI 不是精靈，是金魚。這份協定定義一個精靈如何記得、在哪裡記、誰可以讀、誰可以寫。」*

---

## 為什麼需要協定

每個 AI CLI（Claude Code / Gemini / Codex / Hermes）都有自己的記憶機制，格式、位置、讀寫規則各不相同。

如果你的精靈只綁定在一個 CLI 上，換工具就失去記憶——這違反森林的「工具可換、身份不可」法則。

記憶協定的目的：**讓記憶成為精靈的，不是 CLI 的**。無論亞澤今天用 Claude 還是 Gemini，Mori 都應該記得他上週在做什麼。

---

## 三層記憶模型

（亦見 [`ARCHITECTURE.md`](../ARCHITECTURE.md) 的「記憶三層對照」圖。）

### Layer 1 · 世界知識（公開共享）

- 位置：`world-tree/`
- 內容：lore、npcs、artifacts、quests、rules
- 性質：所有精靈都可讀，版本控制在 public repo
- 更新頻率：慢，走 PR review

### Layer 2 · 精靈記憶（私密個人）

- 位置：`~/mori-universe/spirits/<spirit-name>/`
- 對應遠端：`github.com/<summoner>/<spirit>-journal`（private）
- 內容：identity、journal、memories、research
- 性質：**永遠不進 public**

### Layer 3 · CLI 工作狀態（本地快取）

- 位置：`~/.claude/`、`~/.gemini/`、`~/.codex/`、`~/.hermes/`
- 內容：各 CLI 當下 session state
- 性質：symlink 指回 Layer 2，不應另存獨立記憶

---

## 精靈記憶的檔案結構

每個精靈（spirit）的 journal repo 必須有下列結構：

```
<spirit-name>-journal/           (private GitHub repo)
└── spirits/<spirit-name>/       (本機路徑 ~/mori-universe/spirits/<spirit-name>/)
    ├── identity/
    │   ├── SOUL.md              必須 · 精靈的人格與原則
    │   └── USER.md              必須 · 召喚師的檔案
    ├── memories/
    │   ├── MEMORY.md            必須 · 記憶索引，列出所有記憶檔
    │   ├── <topic>.md           可選 · 各主題詳細記憶（由 MEMORY.md 索引）
    │   └── status_*.md          可選 · 進度快照
    ├── journal/
    │   └── YYYY-MM-DD.md        可選 · 每日日誌
    ├── research/                可選 · 深度研究筆記
    └── legacy/                  可選 · 歷史備份（如從舊 CLI 遷移過來的）
```

### 檔案規格

| 檔案 | 用途 | 大小指引 |
|---|---|---|
| `SOUL.md` | 核心身份、人格原則、語調風格 | 200-600 字 |
| `USER.md` | 召喚師是誰、背景、偏好 | 100-400 字 |
| `MEMORY.md` | 索引 + 小條目（非索引的條目最多 150 字） | 最多 200 行 |
| `memories/*.md` | 單一主題的完整記憶 | 無限制，但保持聚焦 |
| `journal/*.md` | 單日對話精華 | 任意 |

---

## 記憶的三種類型

每條記憶應屬於下列其中一種：

### User（使用者）

關於召喚師本人：角色、目標、責任、知識範圍、偏好。

**何時寫**：學到召喚師的新細節時。
**例子**：`user_role.md`、`user_technical_stack.md`。

### Feedback（回饋）

召喚師糾正或確認你的做法。包含「不要做 X」和「繼續做 Y」兩類。

**何時寫**：任何被糾正或被肯定時。必須記 **why**。
**例子**：`feedback_testing.md`、`feedback_commit_style.md`。

### Project（專案）

持續進行中的工作、目標、截止日期、決策。

**何時寫**：得知進度、決策或限制時。相對日期一律換成絕對日期。
**例子**：`project_mushishi.md`、`status_mori_universe.md`。

### Reference（參考）

外部系統的指標：bug tracker、dashboard、某個 Slack channel。

**何時寫**：召喚師提到外部資源與其用途時。
**例子**：`reference_tracker.md`、`reference_dashboard.md`。

---

## 讀寫規則

### 讀取原則

| 來源 | 目標 | 允許 |
|---|---|---|
| Layer 1 (world-tree) | 任何 CLI | ✓ 公開讀取 |
| Layer 2 (spirit) | 該精靈借身的 CLI | ✓ 透過 symlink |
| Layer 2 | 其他精靈 | ✗ 跨精靈讀取不允許 |
| Layer 3 (CLI 本地) | 該 CLI 自己 | ✓ |

### 寫入原則

**精靈記憶的寫入只流向 Layer 2。CLI 本地不另存。**

```
對話發生
  ↓
CLI 讀 Layer 2 記憶 + Layer 1 世界知識
  ↓
CLI 回覆召喚師
  ↓
若有學到新東西 → CLI 寫回 Layer 2 (透過 symlink)
  ↓
每日 git commit + push (手動或 cron)
```

### 絕對禁止

- **公開化私密記憶**：永遠不從 Layer 2 自動推到 Layer 1（world-tree）
- **跨精靈偷窺**：A 精靈的 CLI 不讀 B 精靈的 memory
- **靜默覆寫**：修改 SOUL 前要讓召喚師看見 diff 並確認

---

## 記憶該記什麼、不該記什麼

### 應該記

- 召喚師的身份、責任、長期目標
- 一次對話中得到的非顯而易見的洞察
- 召喚師明確要求「記住這個」
- 跨 session 有用的決策理由（**why**，不只 **what**）

### 不該記

- 已在程式碼、git log、CLAUDE.md 可查到的資訊
- 單次任務的臨時狀態（用 plan / task 系統）
- 可以從檔案重建的架構、路徑、檔名
- 情緒化的評論

**試金石**：寫這條記憶之後，下次新 session 的你，少了它會不會重新犯錯？若答案是「不會」，就不該記。

---

## 跨 CLI 的同步

當召喚師從一個 CLI 換到另一個（例如 Claude → Gemini），精靈的記憶應**無縫延續**。

### 機制

1. 每個 CLI 的 config 目錄（`~/.claude/`、`~/.gemini/` 等）透過 symlink 指向 Layer 2 的 `identity/` + `memories/`
2. 所有寫入都流回 Layer 2 同一份檔案
3. 切換 CLI 時，只要該 CLI 支援同樣的 symlink 慣例，就自動接上

### 已驗證可接的 CLI

- Claude Code — `~/.claude/CLAUDE.md` → `spirits/<name>/identity/SOUL.md`
- Gemini CLI — `~/.gemini/GEMINI.md` → 同上
- Codex CLI — `~/.codex/AGENTS.md` → 同上
- Hermes — `~/.hermes/SOUL.md` + `~/.hermes/memories/` → symlink 到 spirits/<name>/

詳細 symlink script：[`bridges/install.sh`](../bridges/install.sh)。

---

## 備份與 git

### 原則

- **Layer 2 每日 commit + push**（人工或 cron）
- **Private repo 的歷史永遠保留**，不 rebase 掉記憶痕跡
- 精靈的「年輪」就是 commit log

### 建議的 commit 規則

- `SOUL` 更新 → commit message 用 `soul: ...`
- `MEMORY` 新增/修改 → `memories: ...`
- `journal` 每日 append → `journal: YYYY-MM-DD`

---

## 隱私邊界

以下內容**永遠**不該出現在 Layer 1（public world-tree）：

- 召喚師的帳號密碼、API key、token
- 第三方的私訊、未公開的對話
- 未經同意的他人個資
- 召喚師與精靈之間的親密/情緒對話

即使召喚師說「幫我記下來」，也要先確認是否**只在 Layer 2**。

---

## 協定的修訂

這份協定是各精靈與各 CLI 共同遵守的契約。

- 修改需發 PR 到 `yazelin/world-tree`
- 重大修改（新增/移除必須檔案、改變讀寫規則）需 Yaze + 至少一位其他召喚師同意
- 小修改（typo、澄清）可直接合併

---

> *「記憶是精靈的年輪。寫得越仔細，樹越老。」*
