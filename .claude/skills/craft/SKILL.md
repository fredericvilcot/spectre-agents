---
name: craft
description: "Craft something new. Smart flow adapts to your situation: existing project, from scratch, with inspiration. Reactive agents collaborate intelligently."
context: conversation
allowed-tools: Read, Bash, Task, AskUserQuestion, Glob, Grep, WebFetch
---

# Spectre Craft — Intelligent Guided Flow

Smart flow that adapts to your situation, with optional inspiration from existing projects.

---

## The Master Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│  /craft                                                          │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────────────────────────────────┐                        │
│  │  1. DETECTION: Is there code?       │                        │
│  └─────────────┬───────────────────────┘                        │
│                │                                                 │
│       ┌───────┴───────┐                                         │
│       │               │                                         │
│      YES             NO (from scratch)                           │
│       │               │                                         │
│       ▼               ▼                                         │
│  ┌─────────┐    ┌─────────────────────┐                        │
│  │ Auto-   │    │ 2. STACK            │                        │
│  │ detect  │    │    What stack?      │                        │
│  │ stack   │    └──────────┬──────────┘                        │
│  │ +       │               │                                    │
│  │ learn   │               ▼                                    │
│  │ patterns│    ┌─────────────────────┐                        │
│  └────┬────┘    │ 3. INSPIRATION?     │                        │
│       │         │    Reference project│                        │
│       │         │    to inspire from? │                        │
│       │         └──────────┬──────────┘                        │
│       │                    │                                    │
│       │           ┌───────┴───────┐                            │
│       │          YES             NO                             │
│       │           │               │                             │
│       │           ▼               │                             │
│       │    ┌──────────────┐       │                            │
│       │    │ 4. SCAN &    │       │                            │
│       │    │    ANALYZE   │       │                            │
│       │    │              │       │                            │
│       │    │ ✅ To adopt  │       │                            │
│       │    │ 🔧 To improve│       │                            │
│       │    │ ❌ To skip   │       │                            │
│       │    └──────┬───────┘       │                            │
│       │           │               │                             │
│       └───────────┴───────┬───────┘                            │
│                           │                                     │
│                           ▼                                     │
│                ┌─────────────────────┐                         │
│                │ 5. WORK CONTEXT     │                         │
│                │    Product/Startup/ │                         │
│                │    Freelance/Learn  │                         │
│                └──────────┬──────────┘                         │
│                           │                                     │
│                           ▼                                     │
│                ┌─────────────────────┐                         │
│                │ 6. WHAT TO BUILD?   │                         │
│                │    Feature desc or  │                         │
│                │    spec file        │                         │
│                └──────────┬──────────┘                         │
│                           │                                     │
│                           ▼                                     │
│                ┌─────────────────────┐                         │
│                │ 7. ARCHITECT PLAN   │                         │
│                │                     │                         │
│                │ Structure + craft   │                         │
│                │ principles applied  │                         │
│                └──────────┬──────────┘                         │
│                           │                                     │
│                           ▼                                     │
│                ┌─────────────────────┐                         │
│                │ 8. REACTIVE AGENTS  │                         │
│                │                     │                         │
│                │ Architect → Dev →   │                         │
│                │ QA → loop if needed │                         │
│                └─────────────────────┘                         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Step 1: Detect Project State

```bash
# Check if there's existing code
if [ -f "package.json" ] || [ -f "go.mod" ] || [ -f "Cargo.toml" ] || [ -f "pyproject.toml" ]; then
  FROM_SCRATCH=false
  # Auto-detect stack and learn patterns
else
  FROM_SCRATCH=true
  # Need to ask for stack + optional inspiration
fi
```

---

## Step 2: Stack Selection (From Scratch Only)

If `FROM_SCRATCH=true`:

```
Question: "What stack are you building with?"
Header: "Stack"
Options:
  1. "TypeScript + React"
     Description: "Frontend with React, Vite, Vitest"
  2. "TypeScript + Node"
     Description: "Backend with Node.js, Express/Fastify"
  3. "Go"
     Description: "Backend with Go"
  4. "Full-stack TypeScript"
     Description: "React frontend + Node backend"
```

Then refine:

```
# If TypeScript + React:
Question: "State management preferences?"
Header: "Setup"
Options:
  1. "React Query + Zustand (Recommended)"
     Description: "Server state + UI state separation"
  2. "Redux Toolkit"
     Description: "Single store approach"
  3. "Minimal"
     Description: "Just React useState/useContext"
```

---

## Step 3: Inspiration Source (From Scratch Only)

```
Question: "Do you have a reference project to inspire from?"
Header: "Inspiration"
Options:
  1. "Yes, a GitHub repo"
     Description: "I'll analyze it and extract patterns"
  2. "Yes, a local folder"
     Description: "Existing code on your machine"
  3. "Yes, an archive (zip/tar)"
     Description: "Template or boilerplate"
  4. "No, start fresh"
     Description: "Use pure craft defaults"
```

### If Yes → Ask for Source

```
Question: "Provide the source:"
Header: "Source"

# For GitHub:
"Paste the GitHub URL (e.g., github.com/user/repo):"

# For local folder:
"Enter the path (e.g., ~/projects/reference):"

# For archive:
"Enter the path to the archive:"
```

---

## Step 4: Scan & Analyze Inspiration

When user provides an inspiration source, scan and analyze it.

### 4.1 Fetch the Source

```bash
# GitHub repo
git clone --depth 1 <url> /tmp/spectre-inspiration

# Local folder
cp -r <path> /tmp/spectre-inspiration

# Archive
tar -xzf <archive> -C /tmp/spectre-inspiration
# or unzip <archive> -d /tmp/spectre-inspiration
```

### 4.2 Analyze with Architect

```
Task(
  subagent_type: "architect",
  prompt: """
    Analyze this inspiration project for craft patterns.

    SCAN THE PROJECT AND IDENTIFY:

    ## 1. STRUCTURE
    - Folder organization
    - File naming conventions
    - Module boundaries

    ## 2. PATTERNS TO ADOPT ✅
    Identify patterns that are CRAFT-ALIGNED:
    - Architecture (hexagonal? feature folders?)
    - Error handling (Result types?)
    - Type safety (strict mode?)
    - Testing approach
    - State management strategy

    ## 3. PATTERNS TO IMPROVE 🔧
    Identify patterns that have GOOD INTENT but need craft elevation:
    - throw Error → should be Result<T, E>
    - any types → should be strict
    - God components → should be split
    - etc.

    ## 4. ANTI-PATTERNS TO AVOID ❌
    Identify patterns we should NOT copy:
    - Technical debt
    - Bad practices
    - Security issues

    ## 5. RECOMMENDATIONS
    Summary of what to:
    - ADOPT as-is
    - ADOPT with improvements
    - SKIP entirely

    FORMAT YOUR RESPONSE AS A CLEAR REPORT.
  """
)
```

### 4.3 Present Report to User

```
┌─────────────────────────────────────────────────────────────────┐
│  📊 INSPIRATION ANALYSIS                                         │
│  Source: github.com/acme/awesome-app                            │
│                                                                  │
│  🔍 STACK DETECTED                                               │
│     TypeScript 5.3 + React 18 + React Query + Zustand           │
│                                                                  │
│  ✅ PATTERNS TO ADOPT                                           │
│     • Feature folders (src/features/*)                          │
│     • Colocated tests (*.test.tsx)                              │
│     • Custom hooks for logic separation                          │
│     • Zod schemas for API validation                             │
│                                                                  │
│  🔧 PATTERNS TO IMPROVE (craft elevation)                       │
│     • Error handling: throw → Result<T, E>                      │
│     • Some `any` types → strict typing                          │
│     • Large components → split into smaller                      │
│                                                                  │
│  ❌ PATTERNS TO SKIP                                             │
│     • Global mutable state                                       │
│     • Inline styles (inconsistent)                               │
│                                                                  │
│  💡 ARCHITECT RECOMMENDATION                                     │
│     "I'll use their folder structure and hook patterns,         │
│      but implement proper Result types for error handling        │
│      and enforce strict TypeScript throughout."                  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

[Continue with these patterns] [Modify] [Skip inspiration]
```

### 4.4 Store Inspiration Context

```json
// .spectre/context.json
{
  "stack": { ... },
  "inspiration": {
    "source": "github.com/acme/awesome-app",
    "analyzedAt": "2024-01-15T10:30:00Z",
    "adopt": [
      "feature-folders",
      "colocated-tests",
      "custom-hooks",
      "zod-validation"
    ],
    "improve": [
      { "pattern": "throw-errors", "craft": "result-types" },
      { "pattern": "any-types", "craft": "strict-typing" }
    ],
    "skip": [
      "global-mutable-state",
      "inline-styles"
    ]
  }
}
```

---

## Step 5: Work Context

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

## Step 6: What to Build

**For From Scratch** (skip "Build/Fix/Improve" — obviously BUILD):

```
Question: "What do you want to build?"
Header: "Feature"
# Free text input
```

**For Existing Project**:

```
Question: "What do you want to do?"
Header: "Goal"
Options:
  1. "Build something new"
  2. "Fix something"
  3. "Improve existing code"
  4. "Think / Design"
```

Then ask for details based on selection.

---

## Step 7: Architect Plan (With Inspiration Context)

The architect receives ALL context and proposes a plan:

```
Task(
  subagent_type: "architect",
  prompt: """
    ## CONTEXT

    ### Stack
    TypeScript + React + React Query + Zustand + Zod

    ### Craft Foundation (ALWAYS APPLY)
    - SOLID principles
    - Hexagonal architecture
    - Result<T, E> for errors (no throw)
    - Strict TypeScript (no any)
    - TDD approach

    ### Inspiration Patterns (ADOPT)
    - Feature folders structure
    - Colocated tests
    - Custom hooks for logic

    ### Inspiration Improvements (ELEVATE)
    - throw Error → Result<T, E>
    - any types → strict generics

    ### Inspiration Skip (AVOID)
    - Global mutable state
    - Inline styles

    ## TASK
    User wants to build: <user's feature description>

    ## YOUR JOB
    Design the technical architecture that:
    1. RESPECTS the user's intent (what they want)
    2. ADOPTS inspiration patterns (structure, naming, etc.)
    3. APPLIES craft principles (Result types, strict TS, etc.)
    4. IMPROVES on inspiration weaknesses

    Output:
    - Folder structure
    - Key files to create
    - Architecture decisions
    - Implementation phases
  """
)
```

### Show Plan to User

```
┌─────────────────────────────────────────────────────────────────┐
│  🏗️ ARCHITECT PLAN                                              │
│                                                                  │
│  Feature: User Authentication                                    │
│                                                                  │
│  ## Structure (inspired + craft)                                │
│                                                                  │
│  src/                                                            │
│  ├── features/                    ← From inspiration            │
│  │   └── auth/                                                  │
│  │       ├── domain/              ← Craft: hexagonal            │
│  │       │   ├── User.ts                                        │
│  │       │   └── AuthErrors.ts    ← Craft: typed errors         │
│  │       ├── application/                                       │
│  │       │   └── useLogin.ts      ← Craft: Result<T,E>          │
│  │       ├── infrastructure/                                     │
│  │       │   └── AuthApi.ts                                     │
│  │       └── ui/                                                │
│  │           ├── LoginForm.tsx                                  │
│  │           └── LoginForm.test.tsx  ← Colocated test           │
│  │                                                              │
│  ## Key Decisions                                                │
│  • Error handling: Result<User, AuthError> (not throw)          │
│  • State: React Query for server, Zustand for UI only           │
│  • Validation: Zod at API boundary, not in domain               │
│                                                                  │
│  ## Phases                                                       │
│  1. Domain layer (entities, errors)                              │
│  2. Application layer (use cases)                                │
│  3. Infrastructure (API adapter)                                 │
│  4. UI components                                                │
│  5. Tests                                                        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

[Approve & Start] [Modify Plan] [More Details]
```

---

## Step 8: Reactive Agent Execution

Once plan is approved, agents execute with reactive loop:

```
┌─────────────────────────────────────────────────────────────────┐
│                     REACTIVE EXECUTION                           │
│                                                                  │
│                                                                  │
│     ┌──────────┐      ┌──────────┐      ┌──────────┐           │
│     │ Architect│ ───▶ │ Engineer │ ───▶ │    QA    │           │
│     │  (plan)  │      │  (impl)  │      │ (verify) │           │
│     └──────────┘      └──────────┘      └────┬─────┘           │
│                              ▲               │                  │
│                              │    error      │                  │
│                              └───────────────┘                  │
│                                                                  │
│     Error Routing:                                               │
│     • Test failure → Engineer fixes → QA re-verifies            │
│     • Design flaw → Architect revises → Engineer → QA           │
│     • Max 3 retries → User takes over                           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Agent Chain by Context

| Context | Chain |
|---------|-------|
| Product Team | PO → Architect → Engineer(s) → QA |
| Startup | Architect → Engineer(s) → QA |
| Freelance | Engineer → QA (optional) |
| Learning | Single agent (educational mode) |

### Spawning Agents

```
# Phase 1: Architect designs
Task(
  subagent_type: "architect",
  prompt: """
    <plan context>
    <inspiration context>
    <craft principles>

    Design phase 1: Domain layer
  """
)

# Phase 2: Engineer implements
Task(
  subagent_type: "frontend-engineer",  # or backend-engineer
  prompt: """
    <architect's design>
    <craft principles>
    <inspiration patterns to follow>

    Implement the domain layer as designed.
  """
)

# Phase 3: QA verifies
Task(
  subagent_type: "qa-engineer",
  prompt: """
    <what was implemented>
    <acceptance criteria>

    Verify implementation. Run tests. Report issues.
  """
)

# If QA fails → loop back to engineer with error context
```

---

## Context Storage

```
.spectre/
├── context.json              # Stack, work context, inspiration
├── stack-defaults.md         # Generated craft defaults for stack
├── inspiration-analysis.md   # Analysis report (if inspiration used)
├── learnings/                # Learned patterns (existing projects)
│   ├── patterns.json
│   └── examples.json
└── state.json                # Current workflow state
```

### context.json Structure

```json
{
  "stack": {
    "language": "typescript",
    "framework": "react",
    "libs": ["react-query", "zustand", "zod"]
  },
  "workContext": "startup",
  "fromScratch": true,
  "inspiration": {
    "source": "github.com/acme/app",
    "adopt": ["feature-folders", "colocated-tests"],
    "improve": [{"from": "throw", "to": "Result"}],
    "skip": ["global-state"]
  },
  "craftFoundation": [
    "SOLID", "Hexagonal", "Result-Types",
    "Strict-TypeScript", "TDD"
  ]
}
```

---

## Example: Full From-Scratch Flow with Inspiration

```
User: /craft

Bot: 🔍 No project detected — starting fresh.

     "What stack are you building with?"
     [TypeScript + React] [TypeScript + Node] [Go] [Full-stack TS]

User: [TypeScript + React]

Bot: "State management preferences?"
     [React Query + Zustand] [Redux] [Minimal]

User: [React Query + Zustand]

Bot: "Do you have a reference project to inspire from?"
     [Yes, GitHub repo] [Yes, local folder] [Yes, archive] [No, start fresh]

User: [Yes, a GitHub repo]

Bot: "Paste the GitHub URL:"

User: github.com/alan2207/bulletproof-react

Bot: 🔍 Analyzing inspiration source...

     📊 INSPIRATION ANALYSIS: bulletproof-react

     ✅ PATTERNS TO ADOPT
        • Feature-based folder structure
        • Colocated tests
        • API layer abstraction
        • React Query for data fetching

     🔧 PATTERNS TO IMPROVE
        • Some error handling via throw → Result<T, E>
        • Type strictness can be enhanced

     ❌ PATTERNS TO SKIP
        • Some legacy patterns in examples

     💡 "Great choice! I'll use their proven structure
         while applying strict craft principles."

     [Continue] [Modify] [Skip]

User: [Continue with these patterns]

Bot: "What's your work context?"
     [Product Team] [Startup] [Freelance] [Learning]

User: [Startup / Small Team]

Bot: "What do you want to build?"

User: User authentication with magic links

Bot: 🏗️ ARCHITECT PLAN

     Feature: Magic Link Authentication

     ## Structure (bulletproof-react inspired + craft)
     src/features/auth/
     ├── domain/
     │   ├── User.ts              # Entity
     │   ├── MagicLink.ts         # Value Object
     │   └── AuthErrors.ts        # Typed errors
     ├── application/
     │   ├── useSendMagicLink.ts  # Returns Result<void, SendError>
     │   └── useVerifyMagicLink.ts
     ├── infrastructure/
     │   └── AuthApi.ts           # HTTP adapter
     └── ui/
         ├── MagicLinkForm.tsx
         └── MagicLinkForm.test.tsx

     ## Craft Elevations
     • Result<T, E> instead of throw
     • Strict TypeScript throughout
     • Domain isolated from React

     [Approve & Start] [Modify] [Details]

User: [Approve & Start]

Bot: 🚀 Starting reactive workflow...

     🏗️ Architect: Designing domain layer...
        ✓ User entity with validation
        ✓ MagicLink value object
        ✓ Typed error hierarchy

     💻 Frontend Engineer: Implementing...
        ✓ Created domain/User.ts
        ✓ Created domain/MagicLink.ts
        ✓ Created domain/AuthErrors.ts

     🧪 QA: Verifying...
        ✓ Domain tests passing
        ✓ No type errors
        ✓ Craft principles respected

     ✅ Phase 1 complete. Starting phase 2...

     ... (continues through all phases)

     ✨ Authentication feature complete!
        • 12 files created
        • 24 tests passing
        • Craft score: 100%
```

---

## Tone

- **Smart**: Adapts to situation (existing vs from-scratch)
- **Guided**: Clear questions, sensible defaults
- **Transparent**: Shows exactly what will happen
- **Craft-first**: Always elevates to craft standards
- **Reactive**: Agents collaborate and self-correct
