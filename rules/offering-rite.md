---
title: "獻禮儀式 · Offering Rite"
---

# 獻禮儀式 · Offering Rite

> *「把你親手鍛造的魔道具獻給森林。讓其他冒險者在工坊找得到它、學得會它、帶得走它。」*

---

## 什麼是獻禮

獻禮儀式 = 冒險者把自己打造的**魔道具**（開源工具、AI 代理、bot、web app 等實際可用的產物）正式上架到森林工坊（`yazelin.github.io/workshop/`）的流程。

獻禮後，你的魔道具會：

- 在工坊 cabinet 裡有自己的 niche（凹槽）
- 在世界樹 (`yazelin.github.io/world-tree/artifacts/`) 有正式條目與典故
- 出現在對應魔法系的 tag 頁（`/tags/summoning` 等）
- 成為世界的一部分，其他冒險者可以學、可以參考

---

## 前置條件

**你必須：**

- [ ] 已完成[召喚儀式](initiation-rite.md)，是公會成員
- [ ] 魔道具是**你親手打造（或共同打造）**的 GitHub repo
- [ ] Repo 有清楚的 README 與使用說明
- [ ] 有至少一個可驗證的「效果」（demo、安裝指令、或公開可訪問的 URL）
- [ ] 魔道具符合公會[守則](guild-code.md)

**你的魔道具不需要：**

- 商業化或有盈利模式
- 有數千 star
- 跨平台完整支援
- 中英雙語文件

只要「它真的能用、能給別人學」就夠。

---

## 儀式步驟

### Stage 1 · 選定你的系別

讀 [`lore/magic-schools.md`](../lore/magic-schools.md)，判斷你的魔道具屬於哪一系：

| 系別 | 對應 |
|---|---|
| 召喚系 Summoning | 持續召喚某類存在（定時生成、代理人） |
| 幻術系 Illusion | 改變感知與呈現 |
| 創造系 Creation | 從無到有產生新內容 |
| 煉金系 Transmutation | 格式轉換、管線 |
| 次元系 Dimensional | 跨越空間、傳輸、分發 |
| 通靈系 Binding | 連結系統、資料、接線 |
| 聲術系 Incantation | 聲音、語言、輸入法 |

若橫跨多系，選**主屬**（最核心的那一系），其他列為副屬。

### Stage 2 · 寫你的 artifact.md

在 `world-tree/artifacts/` 下建 `<your-slug>.md`，照模板：

```markdown
---
id: your-slug
title: "你的中文名 · Your English Name"
name_zh: 你的中文名
name_en: Your English Name
school: 主系別 / Main School
tags: ["main-school-en-lowercase"]
repo: yourgithubuser/yourrepo
creator: 你的召喚師名 + 你的精靈名
birth: YYYY-MM-DD
status: active
---

# 你的中文名 · Your English Name

> *一句引言，奇幻敘事口吻。*

## 典故

一到兩段故事，說明它在森林世界觀中為什麼存在、為誰而造。
不要純技術描述，要敘事。

## 效能

技術上做什麼、怎麼做、用了什麼核心技術。
這段可以較直白。

## 領取

- **Source**：https://github.com/...
- **Demo**：https://...
- **Install**：`pip install ...` 或相關指令
```

**寫作提示：**
- 中文名 4-8 字為宜，不要太白話（「筆記工具」→「卷軸抄寫術」）
- 英文名首字母大寫
- 「典故」段要有**意象**，不是功能列表
- 「效能」段說清楚技術，讓工程師讀得懂
- 「領取」至少一個可點擊的連結

參考：[時之貓苑](../artifacts/chronocat.md)、[冥想第三眼](../artifacts/agentpulse.md)、[共食之契](../artifacts/jaba-ai.md)。

### Stage 3 · 加進工坊

在 `yazelin/workshop` repo 的 `assets/artifacts.js` 陣列底部，加一個條目：

```js
{
  id: 'your-slug',
  icon: ICONS['your-slug'],          // 在 ICONS 物件加 SVG
  nameZh: '你的中文名',
  nameEn: 'Your English Name',
  school: '主系別',                    // 中文
  schoolEn: 'MainSchool',              // 英文
  repo: 'yourgithubuser/yourrepo',
  lore: '一到兩句奇幻敘事，可用 <br> 斷行。',
  effect: '一到兩句技術描述。',
  actions: [
    { label: 'Demo', url: '...', primary: true },
    { label: 'Source', url: 'https://github.com/...' },
  ],
},
```

**Icon 規格：** 線條 SVG，16-24px，純色填充 `currentColor` 或 `var(--gold)`，避免 emoji。

### Stage 4 · 發 Pull Requests

你需要發**兩個 PR**：

1. **`yazelin/world-tree`** — artifact.md + tags 對齊
   - PR 標題：`[Offering] {你的魔道具中文名} · {英文名}`
   - PR body 貼你的引言段 + 一張 demo 截圖（若有）

2. **`yazelin/workshop`** — artifacts.js 條目 + SVG icon
   - PR 標題同上
   - PR body 連結到 world-tree 那個 PR（兩邊是配對的）

### Stage 5 · 等候公會 review

召喚師 Yaze（及未來的 reviewer 團隊）會在 **7 日內**給初步回應：

- ✓ **直接合併** — 符合標準
- ✦ **建議修改** — 命名/typo/歸類建議
- ✴ **需要更多資訊** — demo 連結失效、description 太模糊等

### Stage 6 · 合併後

兩個 PR 都 merge 後：

- Workshop 自動重新部署（GitHub Actions）
- 世界樹自動重新部署（GitHub Actions）
- 你的魔道具會出現在 cabinet 與 tag 頁

恭喜。你的魔道具現在是森林的一部分。

---

## 審核標準

### 會被合併的

- 真實可用、維護中的 repo
- Lore 敘事有自己的語氣，不只是複製 README
- Icon 風格一致（線條 SVG、無 emoji）
- 系別歸類合理
- 不與既有魔道具**完全重複功能**

### 會被退件的

- 私有 repo 或已 archive 的死專案
- Lore 含 AI 味太重的通用描述（「這個工具可以幫助你...」）
- 有嚴重安全問題（credentials 外洩、惡意 code）
- 違反公會守則（騷擾、剽竊、灌水）

### 邊界情況

- **Fork 別人的工具**：可以上架，但 lore 必須寫明原作者、並連結到上游
- **AI 生成為主的 repo**：可以，但你要能解釋每個設計決策
- **相同功能但不同實作**：可以，lore 必須寫明與既有魔道具的差異點

---

## 常見問題

**Q：我的魔道具還在開發中，可以先上架嗎？**
A：不行。至少要能「讓別人裝起來試用」的 MVP 才收。archive 狀態的 repo 也不收。

**Q：可以一次獻禮多件魔道具嗎？**
A：可以，但建議每件一個 PR 對，方便 review。

**Q：我想上架的東西不是程式，是論文/筆記/插畫？**
A：目前工坊只收「可執行的魔道具」。未來會開「典籍」「筆記」等其他類別，但現在先專注工具。

**Q：可以放商業產品嗎？**
A：可以放有付費版的 OSS，但必須有免費試用或完整 OSS 版本。純商業封閉產品不收。

**Q：review 遲遲沒回怎麼辦？**
A：7 日後若無回應，在 PR 留言 tag `@yazelin` 提醒。若 14 日仍無回應，到 [Discussions](https://github.com/yazelin/world-tree/discussions) 開 thread 問。

---

> *「森林會記得每個獻給它的禮物。你給出的越多，樹長得越高。」*
