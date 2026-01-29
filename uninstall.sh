#!/usr/bin/env bash
set -euo pipefail

# Spectre Agents Uninstaller

CLAUDE_DIR="$HOME/.claude"

RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'

info() { echo -e "→ $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }

echo -e "${BOLD}Spectre Agents Uninstaller${NC}"
echo ""

# Remove agents
if [[ -f "$CLAUDE_DIR/agents/software-craftsman.md" ]]; then
    rm "$CLAUDE_DIR/agents/software-craftsman.md"
    success "Removed agent: software-craftsman"
fi

# Remove skills
if [[ -d "$CLAUDE_DIR/skills/typescript-craft" ]]; then
    rm -rf "$CLAUDE_DIR/skills/typescript-craft"
    success "Removed skill: typescript-craft"
fi

echo ""
success "Uninstallation complete!"
echo "Restart Claude Code to apply changes."
