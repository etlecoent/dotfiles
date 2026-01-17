#!/bin/bash
input=$(cat)

VERSION=$(echo "$input" | jq -r '.version')
MODEL=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
TOKEN_CURRENT=$(echo "$input" | jq -r '.token_usage.current')
TOKEN_BUDGET=$(echo "$input" | jq -r '.token_usage.budget')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')

# Create progress bar
if [ "$USAGE" != "null" ]; then
    # Calculate current context from current_usage fields
    current_tokens=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    percent_used=$((current_tokens * 100 / CONTEXT_SIZE))
else
    percent_used=0
fi
bar_length=10
filled=$((percent_used * bar_length / 100))
empty=$((bar_length - filled))
bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

CONTEXT="$bar ${percent_used}%"

# Show git branch if in a git repo
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        GIT_BRANCH=" | 🌿 $branch"
    fi
fi

echo "📦 $VERSION | 🤖 $MODEL | 🧠 $CONTEXT | 📁 ${CURRENT_DIR##*/}$GIT_BRANCH"