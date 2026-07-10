# shijing · 诗经创作 Skill（跨 Agent 通用）

> 版本：v2 · 跨 Agent 通用 —— 适用于 **WorkBuddy / Claude Code / Codex / OpenClaw** 及任何能读取 Markdown 指令的 Agent。

教 AI 写《诗经》体诗歌的 Skill。《诗经》是中国先秦四言诗的传统文体——以**赋比兴**为笔法,以**重章叠句**为节奏,以草木鸟兽起兴,朴野天然,一唱三叹。本 Skill 从《诗经》风雅颂与名篇(关雎、蒹葭、桃夭、鹿鸣、采薇等)提炼而成,支持多类题材:

- **国风**:爱情、思念、劳作、婚嫁、离别、乡土
- **雅**:宴饮、赠答、颂友、感时、家国
- **颂**:祭祀、祝寿、颂德、庆典

只要意图是"朴野天然、一唱三叹的古风四言诗",即使不提"诗经"二字也会触发。

## 快速安装

本技能是纯 Markdown 指令包,无需编译,**复制即装**。三种方式任选其一:

### 方式一:发一段提示词,让 Agent 自己装(最省事)

把下面这段直接发给你正在用的 Agent(Claude Code / Codex / Cursor / OpenClaw / WorkBuddy 等皆可):

```
请帮我安装「诗经创作」skill:从 https://github.com/truman-t3/shijing-skill 拉取最新文件,
把 AGENTS.md(或对应你平台的入口文件:Claude Code 用 CLAUDE.md、WorkBuddy 用 SKILL.md)
放到我的技能/指令目录,并确认之后按它的规范创作诗经体诗歌。
```

Agent 会自动把它放进正确位置(Claude Code → 项目根 `CLAUDE.md`;Codex → `AGENTS.md`;WorkBuddy → `~/.workbuddy/skills/shijing/`;Cursor → `~/.cursor/skills/shijing/`)。

### 方式二:git clone 复制即装

```bash
git clone https://github.com/truman-t3/shijing-skill.git
# Claude Code / Cursor(全局)
cp -r shijing-skill ~/.claude/skills/shijing      # 或 ~/.cursor/skills/shijing
# WorkBuddy(全局)
cp -r shijing-skill ~/.workbuddy/skills/shijing
# 仅当前项目:把 AGENTS.md / CLAUDE.md 放到项目根目录即可
```

### 方式三:一行 curl 取入口文件

```bash
# Claude Code
curl -fsSL https://raw.githubusercontent.com/truman-t3/shijing-skill/master/CLAUDE.md -o CLAUDE.md
# Codex / 通用 Agent
curl -fsSL https://raw.githubusercontent.com/truman-t3/shijing-skill/master/AGENTS.md -o AGENTS.md
# WorkBuddy(需含 frontmatter 的 SKILL.md)
curl -fsSL https://raw.githubusercontent.com/truman-t3/shijing-skill/master/SKILL.md -o ~/.workbuddy/skills/shijing/SKILL.md
```

> Windows(PowerShell)用 `irm` 等价命令:
> ```powershell
> irm https://raw.githubusercontent.com/truman-t3/shijing-skill/master/CLAUDE.md -OutFile CLAUDE.md
> ```

装好后直接对 Agent 说「用诗经体写一首……」即可触发。

## 跨 Agent 安装

本技能是**平台无关的**:核心指令在 `AGENTS.md`(与 WorkBuddy 的 `SKILL.md` 内容完全等价,仅去掉了平台专属 frontmatter)。各 Agent 只需把对应入口文件放进它能读取的位置:

| Agent | 入口文件 | 放置位置 |
|-------|----------|----------|
| **WorkBuddy** | `SKILL.md` | `~/.workbuddy/skills/shijing/` 或 `<项目>/.workbuddy/skills/shijing/` |
| **Claude Code** | `CLAUDE.md` | 项目根目录(Claude Code 自动读取);或 `~/.claude/CLAUDE.md` 全局生效 |
| **Codex** | `AGENTS.md` | 项目根目录(Codex 自动读取 `AGENTS.md`) |
| **OpenClaw / 其他** | `AGENTS.md` | 作为系统提示词,或放入 Agent 可读取的指令目录 |

> 通用做法:把整个 `shijing/` 目录复制进项目根目录,大部分 Agent 会自动识别 `AGENTS.md` / `CLAUDE.md`。`references/`、`evals/`、`examples.md` 为按需加载的素材,建议一并保留。

## 使用

对 AI 直接说:

```
用诗经体写一首思念远人的诗
帮我写首四言诗祝贺朋友新婚
以松柏为意象写一首赞美坚贞品格的诗
用诗经体吐槽熬夜写代码(要古雅但对象是现代的)
```

## 架构:三层渐进披露

核心设计是把"语料"逐级蒸馏成"教材",按需加载:

| 层 | 位置 | 内容 | 加载时机 |
|----|------|------|----------|
| 一 | `SKILL.md` | 四段骨架、赋比兴武器库、套语句式库 | 触发即加载,无参考也能独立成诗 |
| 二 | `references/*.md` | 四份精讲笔记:逐篇精读、四言格律、赋比兴意象库、仿作范例 | 按"缺什么读什么"索引,按需读 1–2 份 |
| 三 | `references/originals/` | 五篇原典全文(含元信息与学习要点) | 沉浸语感、取法章法时才读 |

第一层保证下限(合格),第二层追求上限(媲美名篇),第三层是可溯源的原料。

## 五篇底本

| 篇目 | 类别 | 贡献的招数 |
|------|------|------------|
| 《关雎》 | 国风·周南 | 比兴开篇、君子淑女之咏、动作复沓、愿望递进收束 |
| 《蒹葭》 | 国风·秦风 | 重章叠句极则、换字递进、物候流转、留白收束 |
| 《桃夭》 | 国风·周南 | 贺婚祝颂、以物起兴兼比、一物三态喻三世、短章三叠 |
| 《鹿鸣》 | 小雅 | 宴饮赠答、呦呦起兴、器乐铺陈、雍容雅体 |
| 《采薇》 | 小雅 | 行役思归、物候代时序、今昔对照、哀乐相生 |

## 文件结构

```
shijing/
├── AGENTS.md                  # 跨 Agent 通用指令(规范源,与 SKILL.md 等价)
├── CLAUDE.md                  # Claude Code 入口(完整指令)
├── SKILL.md                   # WorkBuddy 入口(含 YAML frontmatter)
├── README.md                  # 本文件(给人看的;AI 只读 AGENTS.md / SKILL.md)
├── evals/evals.json           # 测试用例(思念/贺婚/咏物/现代戏仿)
└── references/
    ├── 逐篇精读.md             # 五篇结构映射 + 每篇"最值得偷师的三招"
    ├── 四言格律.md             # 句式节奏、押韵、叠字、语气助词、节奏自查
    ├── 赋比兴意象库.md         # 意象分类、叠字词库、连绵词、情感—意象速配
    ├── 仿作范例.md             # 完整范文 + 逐段拆解 + 仿作三律 + 翻车点
    └── originals/              # 第三层:五篇原典(带元信息头)
        ├── 关雎.md
        ├── 蒹葭.md
        ├── 桃夭.md
        ├── 鹿鸣.md
        └── 采薇.md
```

## 扩展

- **加厚某一环**:觉得意象不够、格律不够细,直接加厚对应的精讲文件。
- **新增底本**:向 `references/originals/` 添加新篇目(附元信息头:篇目、类别、年代、对象、风格标签、名句、学习要点),在精讲笔记中提炼其独有招数,并更新 `SKILL.md` 的查阅索引表。
- **验证**: `evals/evals.json` 预置了四条测试用例,可用 skill-creator 的评测流程跑带/不带 Skill 的对照实验。

## 规范源与同步

- **`AGENTS.md` 是唯一规范源(canonical)**。WorkBuddy 的 `SKILL.md` 与 Claude Code 的 `CLAUDE.md` 都是由它生成的**适配器**,内容完全等价,只是分别套了平台专属的 YAML frontmatter / 入口说明。
- 修改指令时,**只改 `AGENTS.md`**,然后运行仓库内的 `sync.py` 重新生成另外两个文件,避免三份内容漂移:
  ```bash
  python sync.py
  ```
- `sync.py` 会从 `AGENTS.md` 抽取正文(自 `# 诗经创作` 标题起),自动补回 `SKILL.md` 的 frontmatter 与 `CLAUDE.md` 的入口说明。

## 许可

本仓库采用 [MIT License](LICENSE)。《诗经》原典原文属公有领域;原创示范、解析与技能结构归本仓库作者所有,可自由用于任何 Agent 或项目,请保留出处。
