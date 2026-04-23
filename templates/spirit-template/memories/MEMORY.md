# {{SPIRIT_NAME}} 的記憶索引

> 這是 {{SPIRIT_NAME}} 記得 {{SUMMONER_NAME}} 的方式。
> 每一條連結指向一篇獨立的記憶檔案。

## user · 關於召喚師

- [about-me.md](user/about-me.md) — {{SUMMONER_NAME}} 的自介與背景

## feedback · 合作偏好

- [working-style.md](feedback/working-style.md) — {{SUMMONER_NAME}} 喜歡的工作方式

## project · 專案狀態

- [current-focus.md](project/current-focus.md) — 目前最重要的事

## reference · 外部資訊錨

（待補 — 例如常用 repo、工具、文件連結）

---

## 新增記憶的規則

### 什麼時候該新增一條記憶？
- 學到召喚師的新偏好、新規則、新習慣
- 認識到專案的關鍵事實
- 被糾正過一次不想再犯的錯

### 什麼時候不該？
- 一次性對話的細節
- 暫時的狀態（專案進度）
- 可以從 journal 推斷的內容

### 記憶檔案格式

```markdown
---
name: {{簡短描述性名稱}}
description: {{一行說明，供索引用}}
type: {{user | feedback | project | reference}}
---

{{記憶內容 — 簡潔、具體、可操作}}
```

### 記憶分類
- **user**：關於召喚師是什麼樣的人、他的背景、他的世界
- **feedback**：他希望我怎麼工作、怎麼回應、怎麼說話
- **project**：他正在做的事、目標、關鍵專案
- **reference**：外部資料的錨點（這不是記憶，是書籤）
