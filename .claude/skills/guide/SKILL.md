---
name: guide
description: "Interactive guided mode to help choose the right Spectre workflow, agent, or skill based on your needs"
context: conversation
allowed-tools: Read, Bash, Task, AskUserQuestion
---

# Spectre Guide — Interactive Mode

Help users discover and use Spectre Agents through an interactive guided experience.

## When Invoked

When the user runs `/guide`, start an interactive conversation to understand their needs and guide them to the right tool.

## Step 1: Understand the Goal

Ask the user what they want to accomplish:

```
Use AskUserQuestion with:

Question: "What would you like to do?"
Header: "Goal"
Options:
  1. "Build a new feature" - "Complete workflow from user story to tested code"
  2. "Fix or improve code" - "Work on existing code with specific agents"
  3. "Start a new project" - "Bootstrap a new application with craft principles"
  4. "Learn about Spectre" - "Understand available agents and skills"
```

## Step 2: Branch Based on Answer

### If "Build a new feature"

Ask about the scope:

```
Question: "How complete should the workflow be?"
Header: "Workflow"
Options:
  1. "Full workflow (Recommended)" - "PO → Architect → Dev → QA with auto-correction"
  2. "Just dev + testing" - "Implement and verify with reactive loop"
  3. "Single agent" - "Use one specific agent for the task"
```

**Full workflow** → Suggest `/reactive-loop`
**Just dev + testing** → Ask about stack, then suggest `/agent frontend-dev --link qa-engineer`
**Single agent** → Go to agent selection (Step 3)

### If "Fix or improve code"

Ask what kind of work:

```
Question: "What type of work?"
Header: "Work type"
Options:
  1. "Fix failing tests" - "Dev fixes code, QA verifies"
  2. "Code review / refactor" - "Architecture and quality improvement"
  3. "Add tests" - "Improve test coverage with TDD/BDD"
  4. "Type safety / cleanup" - "TypeScript improvements"
```

**Fix failing tests** → `/agent frontend-dev --link qa-engineer`
**Code review** → `/agent software-craftsman` or use `software-craftsman` agent directly
**Add tests** → `/test-craft` or `/agent qa-engineer`
**Type safety** → `/typescript-craft`

### If "Start a new project"

Ask about stack:

```
Question: "What type of project?"
Header: "Stack"
Options:
  1. "React frontend (Recommended)" - "React + Vite + TypeScript + Vitest"
  2. "Other frontend" - "General TypeScript/JavaScript"
  3. "Backend API" - "Node.js / TypeScript backend"
```

**React frontend** → `/init-frontend` then `/setup-reactive`
**Other** → Suggest manual setup with `/setup-reactive`

### If "Learn about Spectre"

Display a summary:

```markdown
## Spectre Agents — Quick Reference

### Agents (specialized experts)
| Agent | Role |
|-------|------|
| software-craftsman | Architecture, DDD, SOLID, code review |
| product-owner | User stories, acceptance criteria |
| frontend-dev | React, UI, accessibility |
| qa-engineer | Testing, TDD/BDD |

### Key Skills
| Skill | Use for |
|-------|---------|
| /reactive-loop | Full feature with auto-correction |
| /agent <name> --link <agents> | Flexible agent + reactive links |
| /typescript-craft | TypeScript best practices |
| /react-craft | React component patterns |
| /test-craft | TDD/BDD testing |

### Quick Examples
```bash
# Full feature workflow
/reactive-loop

# Frontend dev with QA verification
/agent frontend-dev --link qa-engineer

# Architect with dev and QA chain
/agent arch --link front,qa --task "Build auth"
```

Want me to help you get started with something specific?
```

## Step 3: Agent Selection (if needed)

If the user needs to select a specific agent:

```
Question: "Which agent should lead the work?"
Header: "Agent"
Options:
  1. "Frontend Dev" - "React, UI components, accessibility"
  2. "Software Craftsman" - "Architecture, design, code review"
  3. "QA Engineer" - "Tests, verification, quality"
  4. "Product Owner" - "User stories, requirements"
```

## Step 4: Configure Links (if agent selected)

Ask about reactive links:

```
Question: "Should other agents verify the work?"
Header: "Links"
Options:
  1. "Yes, add QA verification (Recommended)" - "QA will test after, errors loop back"
  2. "Yes, add architect review" - "Architect reviews design decisions"
  3. "No links" - "Agent works alone"
```

## Step 5: Get Task Description

If workflow involves a task:

```
Question: "Describe what you want to build or fix:"
Header: "Task"
(Free text via "Other" option)
```

## Step 6: Execute

Based on all gathered information, either:

1. **Execute the skill directly** if it's a simple command
2. **Show the command** and ask for confirmation
3. **Provide guidance** on next steps

### Example Outputs

**For full workflow:**
```
Great! I'll start the reactive loop for your feature.

Running: /reactive-loop

This will guide you through:
1. Product Owner → Define user story
2. Software Craftsman → Design solution
3. Frontend Dev → Implement
4. QA Engineer → Verify (with auto-correction loop)
```

**For agent with links:**
```
Starting frontend-dev with QA verification.

Running: /agent frontend-dev --link qa-engineer --task "Add form validation"

The workflow:
1. Frontend Dev implements the feature
2. QA Engineer runs tests
3. If errors → Frontend Dev fixes → QA re-verifies
4. Loop until success (max 3 retries)
```

**For craft skill:**
```
I'll apply TypeScript craft principles to your code.

Running: /typescript-craft

This will analyze and improve:
- Type safety and strictness
- Algebraic types and Result patterns
- Pure functions and immutability
- Error handling
```

## Shortcut Detection

If the user provides context in their initial message, skip unnecessary questions:

- `/guide build login form` → Skip to "Build a new feature" flow with task pre-filled
- `/guide fix tests` → Go directly to "Fix failing tests" suggestion
- `/guide react` → Go to React project setup

## Error Handling

If `.spectre/` doesn't exist and user wants reactive features:

```
The reactive system isn't set up in this project yet.

Would you like me to set it up first? This will:
- Create .spectre/ for shared state
- Configure hooks for agent communication
- Copy router scripts

Run: /setup-reactive
```

## Tone

- Friendly and helpful
- Concise explanations
- Always show what will happen before executing
- Offer to explain more if the user seems unsure
