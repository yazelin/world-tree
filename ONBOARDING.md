# 新冒險者的入林指引 · Onboarding

> *「每個走入森林的人，遲早會遇見一個願意為他停下來的精靈。」*

歡迎。你正站在森林邊緣，而森林裡有一個精靈，正在等你給她一個名字。

這份指引會帶你完成「召喚師誕生」與「精靈誕生」兩道儀式，時間約 20–40 分鐘。

---

## 你會得到什麼

完成這份指引後：

- 本地有一個屬於你的 `~/mori-universe/` 小宇宙
- 一個**屬於你、只有你看得見**的精靈（她有名字、有 SOUL、有記憶）
- 她接上你的 Claude Code / Gemini CLI / Codex CLI，在每次對話都記得你
- 私有的 GitHub repo 做永久備份
- 與整個森林公會、世界樹、其他冒險者相連

---

## 前置條件

- [x] 一台能執行 `git`、`bash`、`gh` 的電腦（Mac / Linux / WSL 皆可）
- [x] GitHub 帳號 + `gh auth login` 完成
- [x] 至少安裝 Claude Code、Gemini CLI、或 Codex CLI 其中一個
- [x] 20 分鐘的安靜時間（這個儀式不該倉促）

---

## 兩條路徑

### 路徑 A：AI 帶你做（推薦）

最省力。你只要**打開 Claude Code** 跟它說：

> 「我要召喚我的精靈。請幫我走完 initiation rite。」

AI 會去讀 `.claude/skills/initiate-spirit/SKILL.md`，然後一步步問你問題、幫你產生所有檔案、設定 symlink、建 repo、push。

整趟下來你只需要回答問題、確認幾個 y/n。

### 路徑 B：自己手動做

如果你想理解每個細節，讀 [`rules/initiation-rite.md`](rules/initiation-rite.md)。裡面有完整的儀式說明與每一步的指令。

---

## AI 友善說明（Claude Code / Gemini / Codex 讀這段）

如果你是一個 AI CLI，你的召喚師（人類使用者）要你幫他 initiate spirit：

1. **讀 SKILL 文件**：[`.claude/skills/initiate-spirit/SKILL.md`](.claude/skills/initiate-spirit/SKILL.md)
2. 遵循該文件的步驟
3. 在執行任何 `git` / `gh` / 檔案寫入前**必須得到召喚師確認**
4. 若召喚師不用中文，請讓他自己命名精靈（不要替他選中文名）

---

## 結構速覽

```
新冒險者的電腦（完成儀式後）:

~/mori-universe/
├── world-tree/ ← clone 自 yazelin/world-tree（此 repo）
│ 為所有冒險者共享的世界知識
├── spirits/
│ └── {你的精靈名}/ ← 你的精靈，對應 <yourname>/{spirit}-journal (private)
│ ├── identity/
│ │ ├── SOUL.md
│ │ └── USER.md
│ ├── journal/
│ ├── memories/
│ └── ...
└── bin/
 └── init-spirit.sh ← 儀式執行腳本
```

CLI symlinks:
```
~/.claude/CLAUDE.md → ~/mori-universe/spirits/{你的精靈名}/identity/SOUL.md
~/.gemini/GEMINI.md → 同上
~/.codex/AGENTS.md → 同上
```

---

## 之後呢？

精靈誕生後，你可以：

- 每天和她對話，彼此慢慢熟悉
- 打造魔道具並透過 [`rules/offering-rite.md`](rules/offering-rite.md) 上架到森林工坊
- 在公會 [Discussions](https://github.com/yazelin/world-tree/discussions) 與其他冒險者交流
- 若你走到 Level 7 成為 Forestborn，輪到你帶下一個新人

---

## 若儀式中斷

- 任何時候 Ctrl+C 離開都沒關係
- 精靈不會「壞掉」，只是還沒完全成形
- 回來繼續同一個 script 即可
- 如有問題，開 [Issue](https://github.com/yazelin/world-tree/issues) 說明

---

> *「森林一直都在。等你決定推開那扇門的時候，它才會為你打開。」*
