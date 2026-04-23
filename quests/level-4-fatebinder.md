---
level: 4
title: 織命者 · Fatebinder
focus: Hooks 系統
duration: 1 週
deliverable: 至少 2 個 hooks 運作中（視你的 CLI 不同，事件名各異）
---

# Level 4 · 織命者（Fatebinder）

> 從「回應你」到「主動做事」的分水嶺。

## 這一關要做的

設計至少兩個 hooks，讓 AI 能在你沒指令時主動做事：

1. **對話結束時的 hook**（自動記憶、通知、備份等）
2. **呼叫工具前的 hook**（確認危險動作、注入 context）
3. 測試 hook 的實際作用
4. 觀察一週，記錄它救了你幾次 / 添了多少麻煩

## 各 CLI 的 hook 事件（重要：名稱不同！）

| 事件概念 | Claude Code | Gemini CLI | Codex CLI | Copilot CLI |
|---|---|---|---|---|
| Session 開始 | `SessionStart` | `SessionStart` | `SessionStart` | `sessionStart` |
| Session 結束 | `SessionEnd` | `SessionEnd` | — | `sessionEnd` |
| 使用者 prompt | `UserPromptSubmit` | — | `UserPromptSubmit` | `userPromptSubmitted` |
| 呼叫工具前 | `PreToolUse` | **`BeforeTool`** | `PreToolUse` | `preToolUse` |
| 呼叫工具後 | `PostToolUse` | **`AfterTool`** | `PostToolUse` | `postToolUse` |
| 工具失敗 | `PostToolUseFailure` | — | — | — |
| 權限請求 | `PermissionRequest` | — | — | — |
| Agent 呼叫前 | — | `BeforeAgent` | — | — |
| Agent 呼叫後 | — | `AfterAgent` | — | — |
| Model 呼叫前 | — | `BeforeModel` | — | — |
| Model 呼叫後 | — | `AfterModel` | — | — |
| Agent 停止 | **`Stop`** | — | `Stop` | **`agentStop`** |
| 通知 | — | `Notification` | — | — |

**觀察**：
- Claude Code 的 hook 系統**最豐富**（8 個事件），推薦新手優先用這個
- Gemini CLI 用**完全不同的命名**（`BeforeTool` / `AfterTool`）
- Codex CLI 必須在 `~/.codex/config.toml` 啟用 `codex_hooks = true` feature flag
- Copilot CLI 用 **camelCase**（`preToolUse` 而非 `PreToolUse`）

## Hook 設定檔位置

| CLI | 設定檔位置 |
|---|---|
| Claude Code | `~/.claude/settings.json` |
| Gemini CLI | `~/.gemini/settings.json` |
| Codex CLI | `~/.codex/hooks.json` + `~/.codex/config.toml`（啟用 flag）|
| Copilot CLI | `~/.copilot/config.json` |

## 核心技術

- Shell command 作為 hook handler（stdin 會收到 JSON 事件）
- 非同步 hook（不會阻塞 AI 對話）
- 事件 payload 格式：AgentPulse 專案有完整的 normalization 範例

## 參考：AgentPulse 的 hook 實作

Yaze 開發的 [AgentPulse](https://github.com/yazelin/AgentPulse) 已經正確處理了所有 4 個 CLI 的 hook 差異。
它的 `hooks_configurator.rs` 是學習 cross-CLI hook 安裝的最佳範例。

## 通關證明

你睡一覺醒來，發現 AI 已經自動幫你做了某件小事
（例如：自動備份 journal、自動 commit 代碼、自動寄送提醒）。

## 下一關

Level 5 · 通達者 — 讓她連上外部世界。
