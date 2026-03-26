#!/bin/bash
# Called by ttyd on each connection — resumes session if valid, otherwise starts fresh

cd /home/coding-agent/workspace

SESSION_FILE="/home/coding-agent/.claude-ttyd-sessions/${PORT}"
CLAUDE_ARGS="claude --dangerously-skip-permissions"

if [ -f "$SESSION_FILE" ]; then
    SESSION_ID=$(cat "$SESSION_FILE")
    if [ -f "/home/coding-agent/.claude/projects/-home-coding-agent-workspace/${SESSION_ID}.jsonl" ]; then
        CLAUDE_ARGS="$CLAUDE_ARGS --resume $SESSION_ID"
    fi
fi

exec $CLAUDE_ARGS
