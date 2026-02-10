#!/usr/bin/env bash
set -euo pipefail

# Setup Clean Claude Reactive System in a project
# Configures hooks, creates shared state, and copies scripts

PROJECT_DIR="${1:-.}"
CLEAN_CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info() { echo -e "${BLUE}→${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1" >&2; exit 1; }

echo -e "${BOLD}${CYAN}Clean Claude Reactive System Setup${NC}"
echo "Setting up intelligent multi-agent routing in: $PROJECT_DIR"
echo ""

cd "$PROJECT_DIR"

# 1. Create .clean-claude directory
info "Creating .clean-claude directory..."
mkdir -p .clean-claude

cat > .clean-claude/state.json << 'EOF'
{
    "workflow": null,
    "feature": null,
    "stack": "frontend",
    "phase": "idle",
    "retryCount": 0,
    "maxRetries": 3,
    "agents": {
        "lastActive": null,
        "lastDev": null,
        "history": []
    },
    "status": "ready"
}
EOF

touch .clean-claude/errors.jsonl
touch .clean-claude/events.jsonl
touch .clean-claude/learnings.jsonl
echo '{}' > .clean-claude/ownership.json
echo '{}' > .clean-claude/context.json

success "Created .clean-claude directory with state files"

# 2. Create scripts directory
info "Setting up router scripts..."
mkdir -p scripts/clean-claude
cp "$CLEAN_CLAUDE_DIR/scripts/clean-claude-router.sh" scripts/clean-claude/
cp "$CLEAN_CLAUDE_DIR/scripts/on-agent-stop.sh" scripts/clean-claude/
cp "$CLEAN_CLAUDE_DIR/scripts/check-test-results.sh" scripts/clean-claude/
chmod +x scripts/clean-claude/*.sh
success "Copied router scripts to scripts/clean-claude/"

# 3. Configure hooks in settings
info "Configuring Claude Code hooks..."
mkdir -p .claude

HOOKS_CONFIG=$(cat << 'EOF'
{
    "SubagentStop": [
        {
            "matcher": "qa-engineer|frontend-engineer|backend-engineer|architect|product-owner|devops-engineer",
            "hooks": [
                {
                    "type": "command",
                    "command": "./scripts/clean-claude/on-agent-stop.sh"
                }
            ]
        }
    ],
    "PostToolUse": [
        {
            "matcher": "Bash",
            "hooks": [
                {
                    "type": "command",
                    "command": "./scripts/clean-claude/check-test-results.sh"
                }
            ]
        }
    ]
}
EOF
)

if [[ -f .claude/settings.json ]]; then
    warn "Existing .claude/settings.json found"

    if command -v jq &> /dev/null; then
        # Merge hooks into existing settings
        jq --argjson hooks "$HOOKS_CONFIG" '.hooks = (.hooks // {}) * $hooks' .claude/settings.json > .claude/settings.json.tmp
        mv .claude/settings.json.tmp .claude/settings.json
        success "Merged hooks into existing settings"
    else
        warn "jq not found - please manually add hooks to .claude/settings.json"
        echo "$HOOKS_CONFIG" > .clean-claude/hooks-to-add.json
        echo "Hooks saved to .clean-claude/hooks-to-add.json"
    fi
else
    cat > .claude/settings.json << EOF
{
    "hooks": $HOOKS_CONFIG
}
EOF
    success "Created .claude/settings.json with hooks"
fi

# 4. Create docs directory for feature artifacts
info "Creating docs structure..."
mkdir -p docs/features
success "Created docs/features directory"

# 5. Update .gitignore
if [[ -f .gitignore ]]; then
    if ! grep -q ".clean-claude/state.json" .gitignore 2>/dev/null; then
        info "Adding .clean-claude runtime files to .gitignore..."
        cat >> .gitignore << 'EOF'

# Clean Claude Agents - Runtime state (regenerated)
.clean-claude/state.json
.clean-claude/events.jsonl
.clean-claude/context.json
.clean-claude/ownership.json
.clean-claude/trigger
.clean-claude/stack-skills.md
.clean-claude/external-analysis.md

# Clean Claude Agents - COMMITTED (shared reference)
# .clean-claude/architecture-guide.md  ← KEEP IN GIT
# .clean-claude/specs/                  ← KEEP IN GIT
EOF
        success "Updated .gitignore"
    fi
else
    cat > .gitignore << 'EOF'
# Clean Claude Agents - Runtime state (regenerated)
.clean-claude/state.json
.clean-claude/events.jsonl
.clean-claude/context.json
.clean-claude/ownership.json
.clean-claude/trigger
.clean-claude/stack-skills.md
.clean-claude/external-analysis.md

# Clean Claude Agents - COMMITTED (shared reference)
# .clean-claude/architecture-guide.md  ← KEEP IN GIT
# .clean-claude/specs/                  ← KEEP IN GIT
EOF
    success "Created .gitignore"
fi

echo ""
echo -e "${GREEN}${BOLD}Setup complete!${NC}"
echo ""
echo -e "${CYAN}Directory structure:${NC}"
echo "  .clean-claude/              → Shared state between agents"
echo "  scripts/clean-claude/       → Router and hook scripts"
echo "  docs/features/         → Feature documentation output"
echo ""
echo -e "${CYAN}Features:${NC}"
echo "  • Intelligent error routing (type → agent)"
echo "  • Multi-stack support (frontend, backend, fullstack)"
echo "  • File ownership tracking"
echo "  • Learning from successful fixes"
echo "  • Automatic retry with context"
echo ""
echo -e "${CYAN}Usage:${NC}"
echo "  /reactive-loop                    → Start a feature"
echo "  ./scripts/clean-claude/clean-claude-router.sh status  → Check status"
echo "  ./scripts/clean-claude/clean-claude-router.sh init <feature> [stack]"
echo ""
echo -e "${YELLOW}Stacks available:${NC} frontend, backend, fullstack"
