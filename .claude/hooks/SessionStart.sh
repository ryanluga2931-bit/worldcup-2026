#!/bin/bash
# Nạp ngữ cảnh khi bắt đầu session mới

echo "🏆 World Cup 2026 — Claude Code Session"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 Single file: index.html"
echo "🌐 Live: https://ryanluga2931-bit.github.io/worldcup-2026/"
echo "📦 Repo: https://github.com/ryanluga2931-bit/worldcup-2026"
echo ""

# Kiểm tra git status
CHANGES=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
if [ "$CHANGES" -gt "0" ]; then
  echo "⚠️  Có $CHANGES file chưa commit:"
  git diff --name-only 2>/dev/null
  echo ""
fi

# Kiểm tra last commit
echo "📝 Commit gần nhất:"
git log -1 --pretty=format:"  %h %s (%ar)" 2>/dev/null
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
