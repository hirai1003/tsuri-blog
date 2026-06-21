#!/bin/bash
# 釣りブログ週次自動デプロイ用スクリプト
# 予約公開のため --buildFuture は付けない（日付ゲートを効かせる）
set -e

export PATH="$HOME/bin:$PATH"
cd /Users/hiraiyuuma/Desktop/tsuri-blog

echo "=== デプロイ開始: $(date '+%Y-%m-%d %H:%M') ==="

# ビルド（未来日付の記事は日付が来るまで非公開のまま）
hugo --minify

# Cloudflare Pages へデプロイ
~/bin/node ~/lib/node_modules/npm/bin/npx-cli.js wrangler pages deploy public \
  --project-name=tsuri-blog --branch=main --commit-dirty=true

# 反映確認
sleep 3
echo "=== 公開中の記事 ==="
ls public/posts/
echo "=== トップページ応答コード ==="
curl -s -o /dev/null -w "%{http_code}\n" https://yuuma-fishing.com/
echo "=== デプロイ完了 ==="
