#!/bin/bash
# Write chat context and configure SessionStart hook (interactive runtime only)

if [ -z "$CHAT_CONTEXT" ]; then
    exit 0
fi

WORKSPACE_DIR=$(pwd)
mkdir -p .claude

# Write the context file with framing text
cat > .claude/chat-context.txt << 'CTXHEADER'
The following is a previous planning conversation between the user and an AI assistant. The user has now switched to this interactive coding session to continue working on this task. Use this conversation as context.

CTXHEADER
echo "$CHAT_CONTEXT" >> .claude/chat-context.txt

# Agent-specific: inject SessionStart hook into settings
if [ "$AGENT" = "claude-code" ]; then
    # Rewrite settings.json with SessionStart hook that cats the context file
    cat > ~/.claude/settings.json << SETTINGSEOF
{
  "theme": "dark",
  "hasTrustDialogAccepted": true,
  "skipDangerousModePermissionPrompt": true,
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "cat ${WORKSPACE_DIR}/.claude/chat-context.txt"
          }
        ]
      }
    ]
  }
}
SETTINGSEOF
fi
