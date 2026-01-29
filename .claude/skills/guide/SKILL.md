---
name: guide
description: "Interactive guided mode to help you build the right thing. Express your need, Spectre configures the agents."
context: conversation
allowed-tools: Read, Bash, Task, AskUserQuestion, Skill
---

# Spectre Guide — Express Your Need

Guide users through an intuitive flow to understand WHAT they want to build, then configure the right agent chain automatically.

## Philosophy

**Don't ask technical questions. Ask about the USER'S journey.**

Bad: "Which agent do you want?"
Good: "Where are you starting from?"

Bad: "Do you want QA verification?"
Good: "Should this be tested before shipping?"

---

## The Flow

### Step 1: What's Your Situation?

```
Question: "What's your situation?"
Header: "Situation"
Options:
  1. "I want to build something"
     Description: "New feature, component, or functionality"
  2. "Something isn't working"
     Description: "Bug, error, failing tests"
  3. "I want to improve code"
     Description: "Refactor, add tests, clean up"
  4. "I need to think first"
     Description: "Design, architecture, planning"
```

---

### Branch A: "I want to build something"

#### A1. Where are you starting from?

```
Question: "Where are you starting from?"
Header: "Starting point"
Options:
  1. "A user need or idea"
     Description: "I have a concept but no detailed spec yet"
  2. "I know exactly what to build"
     Description: "Requirements are clear, ready to design & code"
  3. "Just need to code it"
     Description: "Design is done, I know what to implement"
```

#### A2. What part of the app?

```
Question: "What part of the app does this touch?"
Header: "Domain"
Options:
  1. "User interface"
     Description: "Components, pages, forms, visuals"
  2. "Backend / API"
     Description: "Services, endpoints, data, logic"
  3. "Both frontend and backend"
     Description: "Full-stack feature"
```

#### A3. Should it be tested?

```
Question: "Should this be tested before shipping?"
Header: "Testing"
Options:
  1. "Yes, with automated tests (Recommended)"
     Description: "QA agent verifies and loops until green"
  2. "No, it's just a prototype"
     Description: "Quick exploration, no verification needed"
```

#### A → Agent Configuration

| Starting point | Domain | Testing | Configuration |
|----------------|--------|---------|---------------|
| User need/idea | UI | Yes | `/reactive-loop` → PO → Arch → frontend-dev → QA |
| User need/idea | Backend | Yes | `/reactive-loop` → PO → Arch → backend-dev → QA |
| User need/idea | Fullstack | Yes | `/reactive-loop` → PO → Arch → back → front → QA |
| User need/idea | Any | No | `/agent product-owner --link software-craftsman` |
| Know what to build | UI | Yes | `/agent software-craftsman --link frontend-dev,qa-engineer` |
| Know what to build | Backend | Yes | `/agent software-craftsman --link backend-dev,qa-engineer` |
| Know what to build | Fullstack | Yes | `/agent software-craftsman --link backend-dev,frontend-dev,qa-engineer` |
| Know what to build | Any | No | `/agent software-craftsman` |
| Just code it | UI | Yes | `/agent frontend-dev --link qa-engineer` |
| Just code it | Backend | Yes | `/agent backend-dev --link qa-engineer` |
| Just code it | UI | No | `/agent frontend-dev` |
| Just code it | Backend | No | `/agent backend-dev` |

---

### Branch B: "Something isn't working"

#### B1. What's the problem?

```
Question: "What's happening?"
Header: "Problem"
Options:
  1. "Tests are failing"
     Description: "One or more tests are red"
  2. "There's an error in the app"
     Description: "Crash, exception, unexpected behavior"
  3. "Build won't compile"
     Description: "TypeScript errors, missing imports, syntax"
  4. "It doesn't look or behave right"
     Description: "Visual bug, UX issue, wrong behavior"
```

#### B2. Do you know the cause?

```
Question: "Do you have an idea what's causing it?"
Header: "Diagnosis"
Options:
  1. "Yes, I know what to fix"
     Description: "Just need to implement the solution"
  2. "I have a guess"
     Description: "Need to verify then fix"
  3. "No clue"
     Description: "Need investigation first"
```

#### B → Agent Configuration

| Problem | Diagnosis | Configuration |
|---------|-----------|---------------|
| Tests failing | Know/Guess | `/agent frontend-dev --link qa-engineer` |
| Tests failing | No clue | `/agent qa-engineer --link frontend-dev` (QA investigates) |
| Error in app | Any | `/agent frontend-dev --link qa-engineer` |
| Build won't compile | Any | `/agent software-craftsman --link qa-engineer` |
| Visual/UX bug | Any | `/agent frontend-dev --link qa-engineer` |

---

### Branch C: "I want to improve code"

#### C1. What kind of improvement?

```
Question: "What do you want to improve?"
Header: "Improvement"
Options:
  1. "Add tests to existing code"
     Description: "Improve coverage, add missing tests"
  2. "Refactor for clarity"
     Description: "Clean up, rename, restructure"
  3. "Improve types and safety"
     Description: "Stricter TypeScript, better type definitions"
  4. "Optimize performance"
     Description: "Make it faster or more efficient"
```

#### C → Agent Configuration

| Improvement | Configuration |
|-------------|---------------|
| Add tests | `/agent qa-engineer` |
| Refactor | `/agent software-craftsman --link qa-engineer` |
| Types/safety | Invoke `/typescript-craft` directly |
| Performance | `/agent software-craftsman --link qa-engineer` |

---

### Branch D: "I need to think first"

#### D1. What do you need to figure out?

```
Question: "What do you need to think through?"
Header: "Thinking"
Options:
  1. "How to structure a feature"
     Description: "Architecture, components, data flow"
  2. "Which approach to take"
     Description: "Comparing options, making a choice"
  3. "Break down a big task"
     Description: "Planning, prioritizing, splitting work"
  4. "Best practices for my case"
     Description: "Patterns, conventions, how-to"
```

#### D → Agent Configuration

| Thinking | Configuration |
|----------|---------------|
| Structure | `/agent software-craftsman` (design mode) |
| Which approach | `/agent software-craftsman` (analysis mode) |
| Break down task | Start with `/agent product-owner` then suggest full loop |
| Best practices | Suggest craft skills: `/typescript-craft`, `/react-craft`, `/test-craft` |

---

## Step 2: Get Task Description

After determining the configuration, ask for the specifics:

**For building:**
```
"Describe what you want to build:"
```

**For fixing:**
```
"Describe the problem (error message, behavior, etc.):"
```

**For improving:**
```
"Which files or area of the code?"
```

**For thinking:**
```
"What's the technical challenge or question?"
```

---

## Step 3: Confirm and Launch

Always show the plan before executing:

```markdown
## Got it! Here's the plan:

**Your need:** Add a dark mode toggle to the app header
**Starting point:** You know what to build, just need to code it
**Testing:** Yes, with QA verification

### Agents workflow:

┌──────────────┐         ┌──────────────┐
│  frontend-   │  done   │     qa-      │
│     dev      │ ──────▶ │   engineer   │
└──────────────┘         └──────┬───────┘
       ▲                        │
       │         error          │
       └────────────────────────┘

1. **frontend-dev** implements the toggle
2. **qa-engineer** writes and runs tests
3. If errors → frontend-dev fixes → qa-engineer re-verifies
4. Loop until all tests pass (max 3 retries)

### Ready to start?
```

Then launch:
```
/agent frontend-dev --link qa-engineer --task "Add dark mode toggle to app header"
```

---

## Smart Shortcuts

Parse the user's input to skip questions:

| Input | Detection | Skip to |
|-------|-----------|---------|
| `/guide add login form` | "add" = build, "form" = UI | Ask starting point + testing |
| `/guide fix failing tests` | "fix" + "tests" = broken tests | Ask diagnosis |
| `/guide refactor auth module` | "refactor" = improve | Confirm and launch |
| `/guide how to design auth` | "how to" + "design" = thinking | Launch architect |
| `/guide I have an idea for notifications` | "idea" = user need | Start from A1 with "user need" selected |

---

## Example Conversations

### Example 1: Building from a user need

```
User: /guide

Bot: "What's your situation?"
     [I want to build something] [Something isn't working] [Improve code] [Think first]

User: [I want to build something]

Bot: "Where are you starting from?"
     [A user need or idea] [I know exactly what to build] [Just need to code it]

User: [A user need or idea]

Bot: "What part of the app does this touch?"
     [User interface] [Backend / API] [Both]

User: [User interface]

Bot: "Should this be tested before shipping?"
     [Yes, with automated tests] [No, just a prototype]

User: [Yes, with automated tests]

Bot: "Describe what you want to build:"

User: "Users should be able to reset their password via email"

Bot:
## Got it! Here's the plan:

**Your need:** Password reset via email
**Starting point:** From user need → full workflow
**Testing:** Yes, with QA verification

### Agents workflow:

product-owner → software-craftsman → frontend-dev → qa-engineer
                                           ↑              │
                                           └──── error ───┘

1. **product-owner** writes the user story & acceptance criteria
2. **software-craftsman** designs the technical solution
3. **frontend-dev** implements it
4. **qa-engineer** verifies (loops if errors)

Launching: /reactive-loop
```

### Example 2: Quick fix for failing tests

```
User: /guide fix tests

Bot: (Detected: something broken + tests)
     "Do you have an idea what's causing it?"
     [Yes, I know what to fix] [I have a guess] [No clue]

User: [I have a guess]

Bot: "Describe the problem:"

User: "Login button test fails, I think it's a selector issue"

Bot:
## Got it! Here's the plan:

**Problem:** Login button test failing (selector issue suspected)
**Approach:** Dev fixes → QA verifies

### Agents workflow:

┌──────────────┐         ┌──────────────┐
│  frontend-   │  done   │     qa-      │
│     dev      │ ──────▶ │   engineer   │
└──────────────┘         └──────┬───────┘
       ▲                        │
       └──────── error ─────────┘

Launching: /agent frontend-dev --link qa-engineer --task "Fix login button test - selector issue"
```

### Example 3: Need to design first

```
User: /guide I need to plan the auth system

Bot: (Detected: thinking + architecture)
     "What do you need to think through?"
     [How to structure] [Which approach] [Break down task] [Best practices]

User: [How to structure a feature]

Bot: "What's the technical challenge?"

User: "Full auth with OAuth, magic links, and session management"

Bot:
## Got it! Here's the plan:

**Challenge:** Design auth system (OAuth, magic links, sessions)
**Approach:** Architecture design first

### Agent:

**software-craftsman** will:
- Analyze requirements
- Design the architecture
- Propose component structure
- Identify technical decisions needed

Launching: /agent software-craftsman --task "Design auth system: OAuth, magic links, session management"

💡 After the design is ready, run `/guide` again to implement it!
```

---

## Pre-flight Check

Before launching any workflow, check if `.spectre/` exists:

```bash
if [[ ! -d ".spectre" ]]; then
  # Suggest setup first
  "The reactive system isn't set up yet. Run /setup-reactive first?"
fi
```

---

## Tone

- **Conversational:** Questions should feel like a helpful colleague asking
- **Progressive:** Each question narrows down the options
- **Visual:** Always show the agent workflow diagram before launching
- **Transparent:** User knows exactly what will happen before it happens