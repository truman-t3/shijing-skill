# 安装提示词（发给任意 Agent 即可安装）

本文件是一段「可直接复制」的提示词。把它**整体**发给你正在用的任意 Agent（Claude Code / Codex / Cursor / OpenClaw / WorkBuddy 皆可），它会自动把 skill 装到正确位置。

---

> 请帮我安装「诗经创作」skill：
> 1. 从 https://github.com/truman-t3/shijing-skill 拉取最新文件；
> 2. 把 `AGENTS.md`（或对应你平台的入口文件：Claude Code 用 `CLAUDE.md`、WorkBuddy 用 `SKILL.md`）放到我的技能 / 指令目录；
> 3. 确认之后按它的规范创作诗经体诗歌。
> 各平台目录参考：Claude Code → 项目根 `CLAUDE.md` 或 `~/.claude/skills/shijing/`；Codex → `AGENTS.md`；WorkBuddy → `~/.workbuddy/skills/shijing/`；Cursor → `~/.cursor/skills/shijing/`。

---

## 备选：一行命令安装（任意平台）

不想手发提示词，也可以直接让本机跑脚本：

```bash
# macOS / Linux / Git Bash
curl -fsSL https://raw.githubusercontent.com/truman-t3/shijing-skill/master/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/truman-t3/shijing-skill/master/install.sh | iex
```

脚本会自动识别你装了哪个 Agent（Claude Code / Cursor / WorkBuddy）并把 skill 复制进去；
也可用 `-p` 指定平台：`bash install.sh -p claude`（可选 `claude` / `cursor` / `workbuddy` / `codex`）。

装好后，直接对 Agent 说「用诗经体写一首……」即可触发。
