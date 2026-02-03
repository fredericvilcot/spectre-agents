#!/usr/bin/env bash
set -euo pipefail

# Hook: PostToolUse (Bash)
# Checks if a test command was run and captures results

CLEAN_CLAUDE_DIR=.clean-claude
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Only process if .clean-claude exists (reactive system is active)
[[ -d "$CLEAN_CLAUDE_DIR" ]] || exit 0

# Read hook input from stdin
INPUT=$(cat)

# Extract the command that was run
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
OUTPUT=$(echo "$INPUT" | jq -r '.tool_output.stdout // empty')
STDERR=$(echo "$INPUT" | jq -r '.tool_output.stderr // empty')
EXIT_CODE=$(echo "$INPUT" | jq -r '.tool_output.exit_code // 0')

# Combine output
FULL_OUTPUT="$OUTPUT"$'\n'"$STDERR"

# Test command patterns
TEST_PATTERNS="vitest|jest|npm test|npm run test|pnpm test|yarn test|playwright|cypress|mocha|ava"

# Build command patterns
BUILD_PATTERNS="npm run build|pnpm build|yarn build|vite build|tsc|esbuild"

# Lint command patterns
LINT_PATTERNS="eslint|prettier|npm run lint|pnpm lint"

# Check if this was a test command
if echo "$COMMAND" | grep -qiE "($TEST_PATTERNS)"; then
    echo "$FULL_OUTPUT" | "$SCRIPT_DIR/clean-claude-router.sh" "test-result"
fi

# Check if this was a build command that failed
if echo "$COMMAND" | grep -qiE "($BUILD_PATTERNS)" && [[ "$EXIT_CODE" != "0" ]]; then
    echo "$FULL_OUTPUT" | "$SCRIPT_DIR/clean-claude-router.sh" "error" "build" "Build failed"
fi

# Check if this was a lint command that failed
if echo "$COMMAND" | grep -qiE "($LINT_PATTERNS)" && [[ "$EXIT_CODE" != "0" ]]; then
    echo "$FULL_OUTPUT" | "$SCRIPT_DIR/clean-claude-router.sh" "error" "lint" "Lint failed"
fi

# Track file ownership from git operations
if echo "$COMMAND" | grep -qE "^git (add|commit)" && [[ -f "$CLEAN_CLAUDE_DIR/state.json" ]]; then
    # Get the last active dev agent
    LAST_DEV=$(jq -r '.agents.lastDev // empty' "$CLEAN_CLAUDE_DIR/state.json")

    if [[ -n "$LAST_DEV" ]]; then
        # Get modified files
        MODIFIED_FILES=$(git diff --name-only HEAD~1 2>/dev/null | tr '\n' ',' | sed 's/,$//')
        if [[ -n "$MODIFIED_FILES" ]]; then
            "$SCRIPT_DIR/clean-claude-router.sh" "ownership" "$LAST_DEV" "$MODIFIED_FILES"
        fi
    fi
fi

exit 0
