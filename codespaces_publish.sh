#!/bin/bash
set -e

CONFIG_FILE="_config.yml"
BACKUP_FILE="_config.yml.bak"

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ 请先设置 GITHUB_TOKEN 环境变量"
  exit 1
fi

REPO_HTTPS="https://${GITHUB_TOKEN}@github.com/CodeFarmer2024/CodeFarmer2024.github.io.git"

# 备份 _config.yml
cp "$CONFIG_FILE" "$BACKUP_FILE"
echo "🔧 已备份 $CONFIG_FILE -> $BACKUP_FILE"

# 严格替换 deploy 下的 repo，保持缩进
# 匹配前面 2 个空格 + "repo:"
# 用 sed 直接替换
sed -i.bak -E "s|(^[[:space:]]{2}repo:).*|\1 ${REPO_HTTPS}|" "$CONFIG_FILE"
echo "✏️ 已修改 deploy 下的 repo 为 HTTPS 地址"

# 执行 Hexo 部署
echo "🚀 开始执行 hexo clean && hexo g && hexo d..."
npx hexo clean
npx hexo g
npx hexo d

# 还原 _config.yml
mv "$BACKUP_FILE" "$CONFIG_FILE"
echo "✅ 部署完成，已还原 $CONFIG_FILE"
