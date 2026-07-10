#!/usr/bin/env python3
"""从 AGENTS.md（规范源）重新生成 SKILL.md（WorkBuddy）与 CLAUDE.md（Claude Code）。

设计要点：
- AGENTS.md 是唯一规范源（canonical），不携带任何平台专属 frontmatter。
- SKILL.md / CLAUDE.md 只是适配器，内容完全等价，由本脚本生成。
- 修改指令时只改 AGENTS.md，再运行 `python sync.py` 即可同步另外两个文件，
  避免三份内容漂移。

用法（在仓库根目录执行）：
    python sync.py
"""
import os
import re

REPO = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(REPO, "AGENTS.md"), encoding="utf-8") as f:
    agents = f.read()

# 规范正文：从 "# 诗经创作" 这一标题开始（跳过文件顶部的跨 Agent 说明块）
marker = "# 诗经创作\n"
idx = agents.index(marker)
body = agents[idx:]

# 复用 SKILL.md 既有的 YAML frontmatter
with open(os.path.join(REPO, "SKILL.md"), encoding="utf-8") as f:
    skill = f.read()
m = re.match(r"^---\n.*?\n---\n", skill, re.DOTALL)
frontmatter = m.group(0) if m else "---\nname: shijing\n---\n"

claude_header = (
    "# 诗经创作（Claude Code 入口）\n\n"
    "> Claude Code 会读取本文件（CLAUDE.md）。完整指令与 AGENTS.md 等价；"
    "若你的环境不自动加载 AGENTS.md，可直接阅读本文件（已含完整内容）。\n\n"
)

with open(os.path.join(REPO, "SKILL.md"), "w", encoding="utf-8") as f:
    f.write(frontmatter + body)
with open(os.path.join(REPO, "CLAUDE.md"), "w", encoding="utf-8") as f:
    f.write(claude_header + body)

print("已根据 AGENTS.md 同步生成 SKILL.md 与 CLAUDE.md")
