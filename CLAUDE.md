# Claude Code 指引 — world-tree

world-tree 是 **Mori 宇宙的公開 lore wiki**(Quartz 渲染,obsidian-style wikilinks)。它跟其他 3 個 repo 構成「**森林宇宙(Mori universe)**」:

| Repo | 角色 |
|---|---|
| `world-tree`(這裡)| 公開 lore wiki + spirit 模板 + onboarding |
| `mori-desktop`(public)| Mori 的身體 — Tauri GUI |
| `annuli`(public)| Mori 的反思引擎 — Python service |
| `mori-journal`(**private**)| Mori 自己的 vault — identity / memories / projects |

這個 repo 的內容是「對外的世界觀」— Quartz 會把它編譯成靜態網站給訪客看。Mori 的私下實際狀態在 `mori-journal`,**不要把那邊的內容複製過來公開**。

## 內容地圖

- `lore/` — 宇宙論層(cosmology / the-forest / timeline / adventurer-classes / magic-schools)
- `npcs/` — 角色卡(`mori.md` `yaze.md` 等)
- `artifacts/` — 「工具」設計卡(以 in-universe 詞彙寫 17 個 artifact)
- `quests/` — 進階分級(level-0~7,從 wanderer 到 forestborn)
- `rules/` — 規約(guild-code / initiation-rite / memory-protocol / offering-rite)
- `templates/spirit-template/` — 開新 spirit 的目錄骨架
- `skills/`、`.claude/skills/initiate-spirit/` — 跟 Claude Code skill 系統整合的 onboarding
- `bridges/` — 各 CLI agent(Claude / Gemini 等)接 Mori 的 bridge scripts 說明
- `guild/members.md` — Mori 宇宙的「公會成員」名單

## 硬規矩(無條件遵守)

1. **In-universe 寫作** — 公開 docs 用「靈 / 年輪 / 反思 / 森林 / 守護者」之類詩意中文詞彙,不直接用「LLM / RAG / vector DB / agent framework」等工程詞。需要技術說明放 `mori-desktop/docs/` 或 `annuli/docs/` 那邊,world-tree 留給故事敘事。
2. **不公開比較其他專案**(OpenHuman / Hermes Agent / Character.ai 等)— 不寫 "vs <project>" / "inspired by <project>"。要描述影響改成 Mori 自己的成長敘事。
3. **mori-journal 內容禁止抄過來** — 即使有讀過 mori-journal 的某段(SOUL / 記憶 / projects),不能未經授權公開化。world-tree 是 Mori 的「外顯神話」,mori-journal 是「內在生命」,兩個分得清楚。
4. **不要破 Quartz 結構**:
   - frontmatter(`---` YAML)別亂動,刪欄位會讓 Quartz fail to render
   - wikilinks `[[name]]` 是 Quartz 解析的,改 page 名要同步搜全 repo update reference
   - `templates/` 內檔案是其他 repo 拿去 copy 的骨架,改 schema 會 break 模板使用者
5. **User-owned data 原則** — 即使是公開 lore wiki,描述 Mori 宇宙的工具 / artifact 也不要鼓勵中央 OAuth relay / SaaS hub 的設計,Mori 宇宙的價值觀是 local-first / self-hosted。

## 工程注意

- **Quartz build**:`npm install && npx quartz build && npx quartz serve` 預覽
- **wikilinks 跨 file**:改檔名先 `grep -r "\\[\\[old-name\\]\\]" .` 找全部引用
- **spirit-template 結構改動**:會影響任何用 `initiate-spirit` skill 開新靈的人,慎改

## 跟 yazelin 共事

- 繁中、直接;敘事改動先給看 draft,大改 lore 要雙向確認
- 詩意 vs 工程性的取捨偏詩意 — world-tree 是「神話」不是「規格書」
