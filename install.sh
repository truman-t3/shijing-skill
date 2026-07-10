#!/usr/bin/env bash
# 诗经创作 skill 一键安装脚本
# 用法:
#   curl -fsSL https://raw.githubusercontent.com/truman-t3/shijing-skill/master/install.sh | bash
#   bash install.sh                 # 自动识别已安装的 Agent
#   bash install.sh -p claude       # 指定平台
set -euo pipefail

REPO="truman-t3/shijing-skill"
BRANCH="master"
SKILL_NAME="shijing"

usage() {
  cat <<'EOF'
用法: bash install.sh [-p PLATFORM] [-h]
  -p, --platform  指定目标平台: claude | cursor | workbuddy | codex | openclaw | generic
  -h, --help      显示本帮助

平台与目标位置:
  claude     安装到 ~/.claude/skills/shijing/
  cursor     安装到 ~/.cursor/skills/shijing/
  workbuddy  安装到 ~/.workbuddy/skills/shijing/
  codex      复制 AGENTS.md / CLAUDE.md 到当前目录(项目根)
  openclaw   复制 AGENTS.md / CLAUDE.md 到当前目录
  generic    复制 AGENTS.md / CLAUDE.md 到当前目录(默认兜底)
EOF
}

PLATFORM=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--platform) PLATFORM="${2:-}"; shift 2;;
    -h|--help) usage; exit 0;;
    *) echo "未知参数: $1"; usage; exit 1;;
  esac
done

# 拉取最新文件到临时目录(支持未克隆直接用 curl 调用)
TMP="$(mktemp -d)"
echo "正在从 GitHub 拉取 $REPO@$BRANCH ..."
if command -v git >/dev/null 2>&1; then
  if ! git clone --depth 1 "https://github.com/$REPO.git" "$TMP" >/dev/null 2>&1; then
    echo "git clone 失败, 请检查网络或手动复制 AGENTS.md。"; rm -rf "$TMP"; exit 1
  fi
else
  echo "未检测到 git, 无法自动拉取。请先安装 git 或手动复制 AGENTS.md。"; rm -rf "$TMP"; exit 1
fi

detect_platform() {
  if [[ -d "$HOME/.claude" ]]; then echo "claude"; return; fi
  if [[ -d "$HOME/.cursor" ]]; then echo "cursor"; return; fi
  if [[ -d "$HOME/.workbuddy" ]]; then echo "workbuddy"; return; fi
  echo "generic"
}

if [[ -z "$PLATFORM" ]]; then
  PLATFORM="$(detect_platform)"
  echo "未指定平台, 自动识别为: $PLATFORM"
fi

install_to_dir() {
  local dest="$1"
  mkdir -p "$dest"
  for item in AGENTS.md CLAUDE.md SKILL.md LICENSE README.md sync.py examples.md evals references; do
    if [[ -e "$TMP/$item" ]]; then
      cp -r "$TMP/$item" "$dest/"
    fi
  done
  echo "已安装到: $dest"
}

case "$PLATFORM" in
  claude)    install_to_dir "$HOME/.claude/skills/$SKILL_NAME";;
  cursor)    install_to_dir "$HOME/.cursor/skills/$SKILL_NAME";;
  workbuddy) install_to_dir "$HOME/.workbuddy/skills/$SKILL_NAME";;
  codex|openclaw|generic)
    cp "$TMP/AGENTS.md" ./AGENTS.md
    [[ -f "$TMP/CLAUDE.md" ]] && cp "$TMP/CLAUDE.md" ./CLAUDE.md
    echo "已复制 AGENTS.md / CLAUDE.md 到当前目录: $(pwd)"
    ;;
  *)
    echo "未知平台: $PLATFORM"; usage; rm -rf "$TMP"; exit 1;;
esac

rm -rf "$TMP"
echo "完成。直接对 Agent 说「用诗经体写一首……」即可触发。"
