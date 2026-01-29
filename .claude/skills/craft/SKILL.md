---
name: craft
description: "Craft something new. Adapts to your work context (Product Team, Startup, Freelance). Express your need, Spectre configures the agents."
context: conversation
allowed-tools: Read, Bash, Task, AskUserQuestion, Skill
---

# Spectre Craft — Adapted to Your Context

Craft features based on HOW you work, not just WHAT you want to build.

## Philosophy

Different contexts need different workflows:
- **Product Team** → Full process, specs, reviews, compliance
- **Startup** → Fast iterations, ship & learn
- **Freelance** → Efficient, focused, no overhead

---

## Step 0: Auto-Detect Stack OR Guide Stack Selection

**Before asking any questions**, check for existing project:

### Case A: Existing Project → Auto-Detect

```bash
# Check for stack indicators
if [ -f "package.json" ]; then
  STACK="node"
  grep -q "react" package.json && FRAMEWORK="react"
  grep -q "vue" package.json && FRAMEWORK="vue"
  [ -f "tsconfig.json" ] && LANGUAGE="typescript" || LANGUAGE="javascript"
elif [ -f "go.mod" ]; then
  STACK="go" && LANGUAGE="go"
elif [ -f "Cargo.toml" ]; then
  STACK="rust" && LANGUAGE="rust"
elif [ -f "pyproject.toml" ]; then
  STACK="python" && LANGUAGE="python"
elif [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
  STACK="jvm" && LANGUAGE="java"
fi
```

### Case B: Empty/New Project → Guide Stack Selection

If no stack detected, **ask the user**:

```
Question: "What stack are you building with?"
Header: "Stack"
Options:
  1. "TypeScript + React"
     Description: "Frontend with React, Vite, Vitest"
  2. "TypeScript + Node"
     Description: "Backend with Node.js, Express/Fastify"
  3. "Go"
     Description: "Backend with Go, standard library or Gin/Echo"
  4. "Rust"
     Description: "Systems or backend with Rust"
  5. "Python"
     Description: "Backend with FastAPI/Django/Flask"
  6. "Other"
     Description: "Specify your stack"
```

Then ask for more specifics:

```
# If TypeScript + React:
Question: "Any preferences?"
Header: "Setup"
Options:
  1. "Full setup (Recommended)"
     Description: "Vite + Vitest + TailwindCSS + strict TS"
  2. "Minimal"
     Description: "Just React + TypeScript"
  3. "With state management"
     Description: "Add Zustand + React Query"
```

### Store Context

```bash
mkdir -p .spectre

cat > .spectre/context.json << EOF
{
  "stack": {
    "language": "$LANGUAGE",
    "runtime": "$STACK",
    "framework": "$FRAMEWORK",
    "setup": "$SETUP"
  },
  "learning": {
    "enabled": true,
    "scope": "project"
  },
  "fromScratch": true,
  "detectedAt": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
```

### Agent Skill Injection

Based on stack, inject relevant knowledge into agents:

| Stack | Architect Knows | Engineers Know |
|-------|-----------------|----------------|
| **TS + React** | React patterns, hooks, component design | JSX, Testing Library, a11y |
| **TS + Node** | Express/Fastify patterns, middleware | API design, Zod validation |
| **Go** | Go idioms, error handling, interfaces | Standard lib, testing |
| **Rust** | Ownership, traits, Result/Option | Cargo, testing, async |
| **Python** | FastAPI/Django patterns, typing | pytest, type hints |

### Auto-Learn (if existing code)

If `learning.enabled: true` AND project has code:
- Scan codebase for patterns
- Apply craft guard (stop on violations)
- Store learnings in `.spectre/learnings/`

**This happens silently** — user only sees output if violations are found or stack needs selection.

---

## The Flow

### Step 1: What's Your Work Context?

**First time only** (remember for the session):

```
Question: "What's your work context?"
Header: "Context"
Options:
  1. "Product Team / Enterprise"
     Description: "Specs, process, reviews, multiple stakeholders"
  2. "Startup / Small Team"
     Description: "Fast iterations, agile, ship & learn"
  3. "Freelance / Solo"
     Description: "Efficient, focused, minimal overhead"
  4. "Learning / Exploring"
     Description: "Trying things out, no pressure"
```

---

### Step 2: What Do You Want to Do?

```
Question: "What do you want to do?"
Header: "Goal"
Options:
  1. "Build something new"
     Description: "New feature, component, or functionality"
  2. "Fix something"
     Description: "Bug, error, failing tests"
  3. "Improve existing code"
     Description: "Refactor, add tests, clean up"
  4. "Think / Design"
     Description: "Architecture, planning, decisions"
```

---

### Step 3: Context-Specific Questions

#### If "Build something new"

**For Product Team / Enterprise:**

```
Question: "What do you have to start with?"
Header: "Input"
Options:
  1. "A PRD or feature spec"
     Description: "Product requirements document, Jira ticket, detailed spec"
  2. "A user story or brief"
     Description: "High-level requirement, needs refinement"
  3. "Just a concept"
     Description: "Idea that needs to be specced out"
```

Then:
```
Question: "What part of the system?"
Header: "Domain"
Options:
  1. "Frontend / UI"
  2. "Backend / API"
  3. "Full-stack"
```

**For Startup / Small Team:**

```
Question: "How clear are the requirements?"
Header: "Clarity"
Options:
  1. "Crystal clear — let's build"
     Description: "I know exactly what to do"
  2. "Mostly clear — might need quick design"
     Description: "90% there, need to figure out some details"
  3. "Rough idea — need to shape it"
     Description: "Know the goal, need to define the how"
```

Then:
```
Question: "Frontend, backend, or both?"
Header: "Stack"
Options:
  1. "Frontend"
  2. "Backend"
  3. "Both"
```

**For Freelance / Solo:**

```
Question: "What are you building?"
Header: "Stack"
Options:
  1. "UI / Frontend"
  2. "API / Backend"
  3. "Full-stack"
```

Then:
```
Question: "Testing?"
Header: "Quality"
Options:
  1. "Yes, with tests (Recommended)"
     Description: "QA agent verifies your work"
  2. "No, ship it"
     Description: "Just the implementation"
```

**For Learning / Exploring:**

```
Question: "What are you exploring?"
Header: "Area"
Options:
  1. "Frontend / React"
  2. "Backend / API"
  3. "Architecture patterns"
  4. "Testing practices"
```

→ Suggest appropriate craft skill directly

---

## Mapping Tables

### Product Team / Enterprise

| Input | Domain | Agents Chain |
|-------|--------|--------------|
| PRD/Spec | Frontend | `Architect → frontend-engineer → QA` |
| PRD/Spec | Backend | `Architect → backend-engineer → QA` |
| PRD/Spec | Full-stack | `Architect → backend-engineer → frontend-engineer → QA` |
| User story/Brief | Any | `PO (refine) → Architect → Dev → QA` |
| Just a concept | Any | `PO (full spec) → Architect → Dev → QA` |

**Characteristics:**
- Always includes architect for design review
- Always includes QA for testing
- PO refines unclear requirements
- Full documentation trail

### Startup / Small Team

| Clarity | Stack | Agents Chain |
|---------|-------|--------------|
| Crystal clear | Frontend | `frontend-engineer → QA` |
| Crystal clear | Backend | `backend-engineer → QA` |
| Crystal clear | Full-stack | `backend-engineer → frontend-engineer → QA` |
| Mostly clear | Any | `Architect (quick) → Dev → QA` |
| Rough idea | Any | `Architect → Dev → QA` |

**Characteristics:**
- Skip PO — you ARE the PO
- Architect only when needed
- Always QA for quality
- Fast feedback loop

### Freelance / Solo

| Stack | Testing | Agents Chain |
|-------|---------|--------------|
| Frontend | Yes | `frontend-engineer → QA` |
| Frontend | No | `frontend-engineer` |
| Backend | Yes | `backend-engineer → QA` |
| Backend | No | `backend-engineer` |
| Full-stack | Yes | `backend-engineer → frontend-engineer → QA` |
| Full-stack | No | `backend-engineer → frontend-engineer` |

**Characteristics:**
- Direct to implementation
- Testing is optional (but recommended)
- Minimal overhead
- Maximum efficiency

### Learning / Exploring

| Area | Agent |
|------|-------|
| Frontend/React | `frontend-engineer` (educational mode) |
| Backend/API | `backend-engineer` (educational mode) |
| Architecture | `architect` (design mode) |
| Testing | `qa-engineer` (educational mode) |

**Characteristics:**
- Educational mode
- Single agent explains concepts
- No pressure
- Pedagogical approach prioritized

---

## Step 4: Get Task Description

Context-appropriate prompt:

**Product Team:**
```
"Paste the PRD/spec or describe the feature:"
```

**Startup:**
```
"What are you building? (Keep it brief)"
```

**Freelance:**
```
"What do you need?"
```

**Learning:**
```
"What do you want to learn about?"
```

---

## Step 5: Confirm and Launch

Show context-appropriate summary:

### Product Team Example

```markdown
## Workflow for: User Authentication Feature

**Context:** Product Team / Enterprise
**Input:** PRD provided
**Domain:** Full-stack

### Agents Pipeline:

┌────────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐
│   Architect    │ ──▶ │  backend-engineer   │ ──▶ │  frontend-engineer  │ ──▶ │  qa-engineer   │
│                │     │                │     │                │     │                │
│ • Tech design  │     │ • API          │     │ • UI           │     │ • Tests        │
│ • Data model   │     │ • Auth logic   │     │ • Forms        │     │ • Verification │
│ • Security     │     │ • Validation   │     │ • State        │     │ • Compliance   │
└────────────────┘     └────────────────┘     └────────────────┘     └───────┬────────┘
                                                      ▲                      │
                                                      └──── fix & retry ─────┘

**Output:** Tech spec → Implementation → Tested code
```

### Startup Example

```markdown
## Quick Build: Login Form

**Context:** Startup / Fast iteration
**Clarity:** Crystal clear
**Stack:** Frontend

### Agents:

┌────────────────┐     ┌────────────────┐
│  frontend-engineer  │ ──▶ │  qa-engineer   │
│                │     │                │
│ Build it       │     │ Test it        │
└────────────────┘     └───────┬────────┘
        ▲                      │
        └──── loop if needed ──┘

**Time to first feedback:** Fast ⚡
```

### Freelance Example

```markdown
## Task: Add Payment Form

**Context:** Freelance / Efficient
**Stack:** Frontend
**Testing:** Yes

### Agent:

frontend-engineer → qa-engineer (verify)

**Approach:** Direct implementation with quality check.
```

---

## Smart Context Detection

If user provides hints, detect context:

| Signal | Detected Context |
|--------|------------------|
| "PRD", "Jira", "spec", "requirements doc" | Product Team |
| "quick", "MVP", "ship it", "iterate" | Startup |
| "client", "project", "deadline" | Freelance |
| "learn", "try", "explore", "understand" | Learning |

---

## Remember Context

Store context for the session:

```json
// .spectre/context.json
{
  "workContext": "startup",
  "defaultStack": "frontend",
  "preferTesting": true
}
```

On subsequent `/craft` calls, skip Step 1 and use stored context.

To change: `/craft --reset` or answer "Other" to change context.

---

## Example Conversations

### Product Team: Building from PRD

```
User: /craft

Bot: "What's your work context?"
     [Product Team] [Startup] [Freelance] [Learning]

User: [Product Team / Enterprise]

Bot: "What do you want to do?"
     [Build something new] [Fix] [Improve] [Think]

User: [Build something new]

Bot: "What do you have to start with?"
     [A PRD or feature spec] [A user story] [Just a concept]

User: [A PRD or feature spec]

Bot: "What part of the system?"
     [Frontend] [Backend] [Full-stack]

User: [Full-stack]

Bot: "Paste the PRD or describe the feature:"

User: "User authentication with OAuth2, email/password, and 2FA support.
       See PRD-2024-AUTH in Confluence."

Bot:
## Enterprise Workflow: Authentication System

**Context:** Product Team
**Input:** PRD-2024-AUTH
**Scope:** Full-stack

### Pipeline:

1. **architect** — Technical design & security review
2. **backend-engineer** — API, auth logic, OAuth integration
3. **frontend-engineer** — Login UI, forms, state management
4. **qa-engineer** — Security tests, E2E, compliance

Starting architect...
```

### Startup: Quick Feature

```
User: /craft

Bot: "What's your work context?"

User: [Startup / Small Team]

Bot: "What do you want to do?"

User: [Build something new]

Bot: "How clear are the requirements?"
     [Crystal clear] [Mostly clear] [Rough idea]

User: [Crystal clear — let's build]

Bot: "Frontend, backend, or both?"

User: [Frontend]

Bot: "What are you building?"

User: "Dark mode toggle"

Bot:
## Quick Build: Dark Mode Toggle

frontend-engineer → qa-engineer

Starting frontend-engineer...
```

### Freelance: Direct Task

```
User: /craft

User: [Freelance / Solo]

Bot: "What do you want to do?"

User: [Build something new]

Bot: "What are you building?"
     [UI / Frontend] [API / Backend] [Full-stack]

User: [UI / Frontend]

Bot: "Testing?"
     [Yes, with tests] [No, ship it]

User: [Yes, with tests]

Bot: "What do you need?"

User: "Contact form with validation"

Bot:
## Task: Contact Form

frontend-engineer → qa-engineer

Starting...
```

---

## Tone by Context

| Context | Tone |
|---------|------|
| Product Team | Professional, thorough, documentation-focused |
| Startup | Energetic, fast, pragmatic |
| Freelance | Efficient, direct, no fluff |
| Learning | Patient, educational, encouraging |

---

## Agent Invocation

### How to Spawn Agents

Use the **Task tool** with the appropriate `subagent_type`:

```
Task tool:
  subagent_type: "architect"
  prompt: "Design the technical architecture for: <task>"
```

### Available Agent Types

| Agent | subagent_type | Use For |
|-------|---------------|---------|
| Product Owner | `product-owner` | User stories, specs, acceptance criteria |
| Architect | `architect` | Architecture, design, code review |
| Frontend Engineer | `frontend-engineer` | UI implementation, React, components |
| Backend Engineer | `backend-engineer` | API implementation, services, data |
| QA Engineer | `qa-engineer` | Tests, verification, quality |

### Chaining Agents

For pipelines like `Architect → Dev → QA`:

1. Spawn first agent, wait for completion
2. Pass output as context to next agent
3. Continue chain until QA passes or max retries

### Reactive Loop

When QA finds errors:
1. Parse error type (test failure, design flaw, spec gap)
2. Route to appropriate agent based on error
3. Re-run QA after fix
4. Loop until success (max 3 retries)

### Example: Startup Frontend Flow

```
# Step 1: Spawn frontend-engineer
Task(
  subagent_type: "frontend-engineer",
  prompt: "Implement: <task>\n\nContext: Startup mode, fast iteration."
)

# Step 2: On completion, spawn qa-engineer
Task(
  subagent_type: "qa-engineer",
  prompt: "Verify implementation:\n<what was built>\n\nAcceptance criteria:\n<criteria>"
)

# Step 3: If QA fails, loop back to frontend-engineer with error context
Task(
  subagent_type: "frontend-engineer",
  prompt: "Fix this error:\n<error details>\n\nOriginal task: <task>"
)
```
