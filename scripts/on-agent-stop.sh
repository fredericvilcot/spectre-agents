#!/usr/bin/env bash
set -euo pipefail

# Hook: SubagentStop
# Called when any Clean Claude agent completes

CLEAN_CLAUDE_DIR=.clean-claude
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Read hook input from stdin (JSON with agent info)
INPUT=$(cat)

# Extract agent type from hook input
AGENT_TYPE=$(echo "$INPUT" | jq -r '.agent_type // .subagent_type // "unknown"')

# List of Clean Claude agents
CLEAN_CLAUDE_AGENTS="qa-engineer|frontend-engineer|backend-engineer|architect|product-owner|devops-engineer|orchestrator"

# Only process Clean Claude agents
if echo "$AGENT_TYPE" | grep -qE "^($CLEAN_CLAUDE_AGENTS)$"; then
    echo "$INPUT" | "$SCRIPT_DIR/clean-claude-router.sh" "agent-complete" "$AGENT_TYPE"
fi

exit 0
