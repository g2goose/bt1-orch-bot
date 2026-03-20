#!/bin/bash
# Start Claude Code in tmux, serve via ttyd (interactive runtime only)

tmux -u new-session -d -s claude 'claude --dangerously-skip-permissions'
exec ttyd --writable -p "${PORT:-7681}" tmux attach -t claude
