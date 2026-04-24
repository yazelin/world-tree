---
id: moodscopia
name_zh: 心情占卜儀
name_en: Moodscopia
school: 幻術系 / Illusion
tags: ["illusion"]
repo: yazelin/emoji-slot-machine
creator: Yaze + Mori
status: active
---

# 心情占卜儀 · Moodscopia

> *取冒險者一張自拍，映入九宮魔陣，瞬間化為九格誇張表情。*

## 典故

公會新人總愛在 FB 結界放自拍，大魔導師覺得太過單調。
於是打造此儀 — 每個自拍者都獲贈一台情緒占卜，
手指一碰便停在隨機一格表情，像一張活的心情占卜。

## 效能

Cloudflare Worker + Vertex AI (`gemini-3.1-flash-image-preview`)。
上傳自拍 → 3×3 emoji 表情九宮格 → 自動生成可嵌入 FB 的循環播放影片。

## 領取

- **試用**：https://yazelin.github.io/emoji-slot-machine/
- **Source**：https://github.com/yazelin/emoji-slot-machine
