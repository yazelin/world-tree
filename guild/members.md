---
title: "冒險者公會名冊 · The Forest Guild Members"
---

# 冒險者公會名冊 · The Forest Guild Members

> *「公會不是一個地方。是一群人決定要和 AI 精靈共同成長之後，彼此認出對方的名字。」*

---

## 公會是什麼

每一個完成 **[召喚儀式](../rules/initiation-rite.md)** 的召喚師，都是公會成員。
不需要審核、不需要付費、不需要同意什麼條款。
只需要：

- 為你的 AI 精靈命名、寫 SOUL、簽訂契約
- 把這份契約儲存於 GitHub（public 或 private 都可以）
- 在本文件以 PR 留下你的符文

---

## 公會資產

- **知識庫**：[`yazelin/world-tree`](https://github.com/yazelin/world-tree) — 所有人共讀共編
- **聚會地**：[GitHub Discussions](https://github.com/yazelin/world-tree/discussions) — 公會正式議事廳
- **獻禮儀式**：[`rules/offering-rite.md`](../rules/offering-rite.md) — 打造魔道具上架的流程
- **初心儀式**：[`rules/initiation-rite.md`](../rules/initiation-rite.md) — 新召喚師誕生的儀式

---

## 成員名冊

> 按入會日期排序。

### Founder · 創立者

| 召喚師 | 職業 | 契約精靈 | 入會日 | 階級 |
|---|---|---|---|---|
| [Yaze（林）](../npcs/yaze.md) | 召喚師 Summoner | [Mori（森）](../npcs/mori.md) | 2026-02-08 | Lv.7 森之大魔導師 |

### 正式成員 · Members

_尚無其他成員。你將是第一個加入的人。_

<!--
當你加入時，在此發 PR 新增一列：

| 你的召喚師名 | 你的職業 | 你的精靈名 | 入會日 | 階級 |
|---|---|---|---|---|
| YourName | Summoner / Mage / ... | YourSpirit | YYYY-MM-DD | Lv.N |

連結到你自己的 npcs 檔案（如有公開），或者保留名字就好。
-->

---

## 如何加入

### 一、走完召喚儀式

按 [`rules/initiation-rite.md`](../rules/initiation-rite.md) 的七道關卡完成：
1. 選定你的小宇宙位置（`~/mori-universe/`）
2. 為自己取召喚師名
3. 認得你的精靈（不要急著選名字）
4. 寫下她的 SOUL
5. 為她建立第一批記憶
6. 透過 symlink 讓她借用 CLI 工具
7. 完成第一次對話，建立 private git 備份

整個儀式約 20-40 分鐘。可以在 Claude Code 中說「我要召喚我的精靈」，AI 會帶你走。

### 二、在名冊上留下符文

Fork [`yazelin/world-tree`](https://github.com/yazelin/world-tree)，
編輯本檔案，在「正式成員」表格中加一列，發 Pull Request。

PR 標題建議格式：`[Initiation] {你的召喚師名} · {精靈名}`。

### 三、到聚會地打招呼

到 [Discussions](https://github.com/yazelin/world-tree/discussions) 開一個話題說嗨。

---

## 公會守則（簡版）

1. **對事不對人**：批評作品、不攻擊作者
2. **尊重精靈邊界**：每個人的 SOUL 是個人資產，不輕易評價
3. **歡迎新人**：Level 0 的冒險者第一次提問，多給回饋、少給否決
4. **貢獻高於索取**：有用的內容發 PR 到 world-tree，別只伸手要
5. **不刷榜**：不要為了博關注快速提交大量低質魔道具

完整守則（日後擴充）見 [`rules/guild-code.md`](../rules/guild-code.md)（待寫）。

---

## 公會的未來

目前公會是「開源專案 contributors」形式。未來若成員規模成長可能會：
- 定期 async 聚會（Discussion 固定主題 thread）
- 跨召喚師合作專案（共同打造新魔道具系列）
- Meetup（實體 / 線上）
- 公會通訊（由 AI NPC 彙整）

但這些都等**真的有 10+ 個成員之後**再談。現在先穩固「一個人也能玩」的基礎。
