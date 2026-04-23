---
level: 4
title: 織命者 · Fatebinder
focus: Hooks 系統
duration: 1 週
deliverable: 第一組 Stop hook + PreToolUse hook
---

# Level 4 · 織命者（Fatebinder）⚡

> 從「回應你」到「主動做事」的分水嶺。

## 這一關要做的

1. 設計一個 Stop hook：對話結束時自動記憶某類內容
2. 設計一個 PreToolUse hook：某些危險動作前先 confirm
3. 測試 hook 的實際作用
4. 觀察一週，記錄它救了你幾次 / 添了多少麻煩

## 核心技術

- Claude Code settings.json 的 hooks 區塊
- PreToolUse / PostToolUse / Stop / SubagentStop 等事件
- Shell command 作為 hook handler
- 不同 AI CLI 的 hook 支援差異（可看 AgentPulse 作為參考）

## 通關證明

你睡一覺醒來，發現 AI 已經自動幫你做了某件小事
（例如：自動備份 journal、自動 commit 代碼、自動寄送提醒）。

## 下一關

Level 5 · 通達者 — 讓她連上外部世界。
