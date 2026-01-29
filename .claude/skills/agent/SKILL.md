---
name: agent
description: "Start a Spectre agent with optional reactive links. Examples: /agent frontend-dev, /agent frontend-dev --link qa-engineer, /agent software-craftsman --link frontend-dev,qa-engineer"
context: conversation
allowed-tools: Read, Write, Bash, Task
---

# Agent Skill — Start with Reactive Links

Start any Spectre agent with optional reactive connections to other agents.

## Syntax

```
/agent <agent-name> [--link <agents>] [--stack <stack>] [--task <description>]
```

### Arguments

| Argument | Description | Example |
|----------|-------------|---------|
| `<agent-name>` | Agent to start | `frontend-dev`, `qa-engineer` |
| `--link <agents>` | Agents to link reactively (comma-separated) | `--link qa-engineer` |
| `--stack <stack>` | Stack context | `--stack frontend` |
| `--task <desc>` | Task description | `--task "Build login form"` |

## Examples

### Start frontend-dev alone
```
/agent frontend-dev
```
Agent works, no reactive loop.

### Start frontend-dev linked to QA
```
/agent frontend-dev --link qa-engineer
```
Frontend works → QA verifies → error → Frontend fixes → loop

### Start architect linked to dev and QA
```
/agent software-craftsman --link frontend-dev,qa-engineer
```
Architect designs → Frontend implements → QA verifies → errors route back

### Start with task description
```
/agent frontend-dev --link qa-engineer --task "Build user authentication form"
```

## Available Agents

| Agent | Role | Common Links |
|-------|------|--------------|
| `software-craftsman` | Architecture, design | `frontend-dev`, `backend-dev` |
| `product-owner` | User stories | `software-craftsman` |
| `frontend-dev` | UI implementation | `qa-engineer`, `software-craftsman` |
| `backend-dev` | API implementation | `qa-engineer`, `software-craftsman` |
| `qa-engineer` | Testing, verification | `frontend-dev`, `backend-dev` |

## Link Behaviors

### frontend-dev → qa-engineer
```
┌──────────────┐         ┌──────────────┐
│  frontend-   │  done   │     qa-      │
│     dev      │ ──────▶ │   engineer   │
└──────────────┘         └──────┬───────┘
       ▲                        │
       │         error          │
       └────────────────────────┘
```

### software-craftsman → frontend-dev → qa-engineer
```
┌──────────────┐         ┌──────────────┐         ┌──────────────┐
│   software-  │  done   │  frontend-   │  done   │     qa-      │
│   craftsman  │ ──────▶ │     dev      │ ──────▶ │   engineer   │
└──────────────┘         └──────────────┘         └──────┬───────┘
                                ▲                        │
                                │         error          │
                                └────────────────────────┘
```

### qa-engineer → frontend-dev (reverse for test-first)
```
┌──────────────┐         ┌──────────────┐
│     qa-      │  tests  │  frontend-   │
│   engineer   │ ──────▶ │     dev      │
└──────────────┘         └──────┬───────┘
       ▲                        │
       │         verify         │
       └────────────────────────┘
```

## How It Works

1. **Parse arguments** from the skill invocation
2. **Initialize .spectre/** if not exists
3. **Configure links** in `.spectre/links.json`
4. **Start the agent** with context
5. **Hooks route** based on configured links

## Implementation

When you invoke `/agent`, parse the arguments and:

### Step 1: Parse Arguments

Extract from the user's command:
- `agent_name`: The agent to start
- `links`: Array of linked agents (from --link)
- `stack`: Stack context (from --stack, default: "frontend")
- `task`: Task description (from --task)

### Step 2: Initialize Spectre State

```bash
mkdir -p .spectre

# Create links configuration
cat > .spectre/links.json << EOF
{
  "primary": "<agent_name>",
  "links": [<links_array>],
  "stack": "<stack>",
  "task": "<task>"
}
EOF

# Initialize state
cat > .spectre/state.json << EOF
{
  "workflow": "agent",
  "feature": "<task or 'ad-hoc'>",
  "stack": "<stack>",
  "phase": "active",
  "retryCount": 0,
  "maxRetries": 3,
  "agents": {
    "primary": "<agent_name>",
    "links": [<links_array>],
    "lastActive": null,
    "lastDev": null,
    "history": []
  },
  "status": "in_progress"
}
EOF
```

### Step 3: Start the Agent

Use the Task tool to spawn the agent:

```
Use the <agent_name> agent to work on: <task>

Context:
- Stack: <stack>
- Linked agents: <links>
- When complete, linked agents will be triggered automatically

<Additional context from .spectre/context.json if exists>
```

### Step 4: Reactive Routing

The hooks will handle routing based on `.spectre/links.json`:

When the primary agent completes:
1. Check if there are linked agents
2. Trigger the first link (e.g., qa-engineer)
3. If error in verification → route back to primary
4. Loop until success

## Examples of Parsed Commands

### `/agent frontend-dev`
```json
{
  "primary": "frontend-dev",
  "links": [],
  "stack": "frontend",
  "task": null
}
```
→ Starts frontend-dev alone, no reactive loop

### `/agent frontend-dev --link qa-engineer`
```json
{
  "primary": "frontend-dev",
  "links": ["qa-engineer"],
  "stack": "frontend",
  "task": null
}
```
→ Starts frontend-dev, QA verifies after, errors loop back

### `/agent frontend-dev --link qa-engineer,software-craftsman --task "Build login"`
```json
{
  "primary": "frontend-dev",
  "links": ["qa-engineer", "software-craftsman"],
  "stack": "frontend",
  "task": "Build login"
}
```
→ Starts frontend-dev with full context, linked to both QA and architect

## Shorthand Commands

For convenience, also support:

| Shorthand | Equivalent |
|-----------|------------|
| `/agent front` | `/agent frontend-dev` |
| `/agent back` | `/agent backend-dev` |
| `/agent arch` | `/agent software-craftsman` |
| `/agent qa` | `/agent qa-engineer` |
| `/agent po` | `/agent product-owner` |

## Integration with Existing Workflow

This skill complements `/reactive-loop`:
- `/reactive-loop` — Full workflow (PO → Arch → Dev → QA)
- `/agent` — Flexible, start any agent with chosen links

Both use the same `.spectre/` state and routing infrastructure.
