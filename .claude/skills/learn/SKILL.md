---
name: learn
description: "Auto-learns project patterns by default. Detects stack, injects skills to Architect, learns YOUR conventions. On violations, triggers architect reactively. Fully integrated in reactive loop."
context: conversation
allowed-tools: Read, Bash, Glob, Grep, Write, Task, AskUserQuestion
---

# Spectre Learn — Stack Detection & Pattern Learning

**Detect. Inject. Learn. Guard.**

---

## Philosophy

Learning is about understanding YOUR project, not teaching CRAFT.

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│   BUILT-IN (Never learned)       PROJECT-SPECIFIC (Learned)     │
│   ────────────────────────       ──────────────────────────     │
│                                                                  │
│   ✅ Hexagonal architecture      📁 Folder names (features/)    │
│   ✅ Result<T, E>                📝 File naming (kebab-case)    │
│   ✅ No `any`                    📦 Import aliases (@/)         │
│   ✅ SOLID principles            🧪 Test location (colocated)   │
│   ✅ Domain isolation            🎨 Component patterns          │
│   ✅ Dependency rule             🔧 API patterns                │
│                                                                  │
│   These are CRAFT.               These are YOUR conventions.    │
│   ALWAYS enforced.               LEARNED from YOUR code.        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## The Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│   /learn (or auto during /craft)                                │
│        │                                                         │
│        ▼                                                         │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  1. DETECT STACK                                        │   │
│   │     → React? Node? Go? Rust?                            │   │
│   │     → Write .spectre/context.json                       │   │
│   └─────────────────────────────────┬───────────────────────┘   │
│                                     │                            │
│                                     ▼                            │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  2. INJECT STACK SKILLS → Architect                     │   │
│   │     → React: hooks, components, state                   │   │
│   │     → Node: APIs, middleware, auth                      │   │
│   │     → Go: packages, errors, concurrency                 │   │
│   └─────────────────────────────────┬───────────────────────┘   │
│                                     │                            │
│                                     ▼                            │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  3. LEARN PROJECT-SPECIFIC PATTERNS                     │   │
│   │     → Folder structure (src/features/ vs src/modules/)  │   │
│   │     → Naming conventions (kebab vs camelCase)           │   │
│   │     → Import style (@/ vs ~/ vs relative)               │   │
│   │     → Test patterns (colocated vs separate)             │   │
│   └─────────────────────────────────┬───────────────────────┘   │
│                                     │                            │
│                                     ▼                            │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  4. CHECK VIOLATIONS (vs CRAFT built-in)                │   │
│   │     → `any` types? → Violation                          │   │
│   │     → `throw` in business? → Violation                  │   │
│   │     → Framework in domain? → Violation                  │   │
│   └─────────────────────────────────┬───────────────────────┘   │
│                                     │                            │
│                            ┌────────┴────────┐                  │
│                            │                 │                  │
│                        VIOLATIONS         CLEAN                  │
│                            │                 │                  │
│                            ▼                 ▼                  │
│                   ┌──────────────┐    ┌─────────────┐           │
│                   │   Architect  │    │    Store    │           │
│                   │   triggered  │    │   patterns  │           │
│                   └──────────────┘    └─────────────┘           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Commands

```bash
/learn              # Full scan: detect stack → inject → learn → check
/learn --off        # Disable auto-learning (not recommended)
/learn --from <x>   # Learn patterns from external source
```

| Command | Action |
|---------|--------|
| `/learn` | Full scan (runs BEFORE Architect in /craft chain) |
| `/learn --off` | Disable auto-learning |
| `/learn --from <path>` | Learn from external (repo, file, folder) |

---

## Auto-Learning (Default: ON)

Learning Agent runs automatically:
- **BEFORE Architect** in `/craft` chain
- On first `/craft` or `/heal`
- When `.spectre/context.json` doesn't exist

```
┌─────────────────────────────────────────────────────────────────┐
│                /craft CHAIN WITH AUTO-LEARN                      │
│                                                                  │
│   User request                                                   │
│        │                                                         │
│        ▼                                                         │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                     PO (if needed)                        │  │
│   │                   spec-vN.md                              │  │
│   └─────────────────────────────┬────────────────────────────┘  │
│                                 │                                │
│                                 ▼                                │
│   ╔══════════════════════════════════════════════════════════╗  │
│   ║              LEARNING AGENT (ALWAYS HERE)                 ║  │
│   ║                                                           ║  │
│   ║   1. Detect stack                                         ║  │
│   ║   2. Inject stack skills to Architect                     ║  │
│   ║   3. Learn project-specific patterns                      ║  │
│   ║   4. Check violations                                     ║  │
│   ║                                                           ║  │
│   ╚═══════════════════════════════════════════════════════════╝  │
│                                 │                                │
│                                 ▼                                │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                    ARCHITECT                              │  │
│   │   (now has: CRAFT + stack skills + project patterns)     │  │
│   │                   design-vN.md                            │  │
│   └─────────────────────────────┬────────────────────────────┘  │
│                                 │                                │
│                                 ▼                                │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                      Dev → QA                             │  │
│   └──────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Execution

When `/learn` is invoked:

### Spawn Learning Agent

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    FULL LEARNING SCAN

    ## Step 1: Detect Stack

    Check for:
    - package.json → Node/React/Vue ecosystem
    - tsconfig.json → TypeScript config
    - go.mod → Go
    - Cargo.toml → Rust
    - pyproject.toml → Python

    Write .spectre/context.json with detected stack.

    ## Step 2: Prepare Stack Skills for Architect

    Based on detected stack, identify skills to inject:

    React detected → React skills:
    - Hooks patterns (useEffect, useMemo, useCallback)
    - Component composition
    - State management (Zustand, Context, etc.)
    - Data fetching patterns (React Query, SWR)

    Node detected → Node skills:
    - API design (REST, GraphQL)
    - Middleware patterns
    - Auth patterns (JWT, sessions)
    - Database patterns (Repository, Unit of Work)

    Go detected → Go skills:
    - Package structure
    - Error handling (no exceptions)
    - Concurrency patterns
    - Interface design

    Write .spectre/stack-skills.json

    ## Step 3: Learn PROJECT-SPECIFIC Patterns ONLY

    DO NOT LEARN:
    - Hexagonal architecture (built-in CRAFT)
    - Result<T, E> (built-in CRAFT)
    - SOLID principles (built-in CRAFT)
    - Domain isolation (built-in CRAFT)

    LEARN:
    - Folder structure (src/features/ vs src/modules/ vs src/app/)
    - File naming (kebab-case vs camelCase vs PascalCase)
    - Import aliases (@/ vs ~/ vs relative paths)
    - Test location (colocated *.test.ts vs tests/ folder)
    - Component structure (atoms/molecules/organisms vs feature-based)
    - API route patterns (REST conventions, naming)

    Write .spectre/learnings/patterns.json

    ## Step 4: Check Violations (vs CRAFT built-in)

    ALWAYS CHECK:
    - `: any` types (>0 = violation)
    - `throw new Error` in services/domain
    - Framework imports in domain/
    - Missing tests for domain logic
    - `as unknown as` type assertions

    If violations → write .spectre/violations.json → trigger Architect
    If clean → report success
  """
)
```

---

## What Gets Learned vs What's Built-In

### BUILT-IN CRAFT (Never Learned)

These are **always enforced** by all agents. Learning Agent doesn't learn them because they're already in every agent's DNA.

| Principle | Why Built-In |
|-----------|--------------|
| Hexagonal / Clean Architecture | Core CRAFT principle |
| Result<T, E> (no throw) | Core CRAFT principle |
| No `any` | Core CRAFT principle |
| SOLID | Core CRAFT principle |
| Domain isolation | Core CRAFT principle |
| Dependency rule | Core CRAFT principle |
| Colocated tests | Core CRAFT principle |

### STACK-SPECIFIC (Injected Dynamically)

These are **injected to Architect** based on detected stack.

| Stack | Injected Skills |
|-------|-----------------|
| **React** | Hooks, components, state, data fetching |
| **Vue** | Composition API, reactivity, Pinia |
| **Node** | APIs, middleware, auth, database patterns |
| **Go** | Packages, error handling, concurrency |
| **Rust** | Ownership, lifetimes, error handling |

### PROJECT-SPECIFIC (Actually Learned)

These are **learned from YOUR codebase** because they're YOUR choices.

| What | Examples |
|------|----------|
| **Folder structure** | `src/features/` vs `src/modules/` vs `app/` |
| **File naming** | `user-service.ts` vs `UserService.ts` |
| **Import aliases** | `@/components` vs `~/components` vs `../../` |
| **Test location** | `*.test.ts` colocated vs `tests/` folder |
| **Component patterns** | Atomic design vs feature-based |
| **API patterns** | `/api/v1/users` vs `/users` |

---

## Storage

```
.spectre/
├── context.json              # Detected stack (gitignored)
├── stack-skills.json         # Skills to inject (gitignored)
├── violations.json           # Current violations (gitignored)
├── state.json                # Workflow state (gitignored)
├── learnings/
│   └── patterns.json         # Project-specific patterns
└── specs/                    # COMMITTED - versioned documentation
    ├── functional/           # PO specs
    └── design/               # Architect designs
```

### Auto-Gitignore

On first run, Learning Agent adds to `.gitignore`:

```
# Spectre Agents - generated files (keep specs/)
.spectre/context.json
.spectre/stack-skills.json
.spectre/violations.json
.spectre/state.json
.spectre/test-repo/
.spectre/*-report.md
```

**Specs are NOT gitignored** — they're versioned documentation that should be committed.

### context.json (Stack Detection)

```json
{
  "stack": {
    "language": "typescript",
    "runtime": "node",
    "framework": "react",
    "meta_framework": "vite",
    "testing": "vitest",
    "styling": "tailwind",
    "state": "zustand",
    "data_fetching": "react-query"
  },
  "detectedAt": "2024-01-15T10:30:00Z"
}
```

### stack-skills.json (Injected to Architect)

```json
{
  "react": {
    "hooks": {
      "useEffect": "Side effects, cleanup",
      "useMemo": "Expensive computations",
      "useCallback": "Stable function refs"
    },
    "state": {
      "zustand": "Lightweight store",
      "pattern": "Single store, slices"
    },
    "data": {
      "react-query": "Server state",
      "pattern": "useQuery, useMutation"
    }
  },
  "injectTo": "architect"
}
```

### patterns.json (Project-Specific ONLY)

```json
{
  "learnedAt": "2024-01-15T10:30:00Z",
  "projectSpecific": {
    "folders": {
      "features": "src/features/",
      "shared": "src/shared/",
      "lib": "src/lib/"
    },
    "naming": {
      "files": "kebab-case",
      "components": "PascalCase",
      "hooks": "useCamelCase"
    },
    "imports": {
      "alias": "@/",
      "style": "absolute"
    },
    "tests": {
      "location": "colocated",
      "pattern": "*.test.ts"
    }
  },
  "notLearned": [
    "hexagonal (built-in)",
    "result-types (built-in)",
    "solid (built-in)"
  ]
}
```

---

## Violation Detection

When violations are found:

### 1. Write violations.json

```json
{
  "detectedAt": "2024-01-15T10:30:00Z",
  "violations": [
    {
      "type": "any_type",
      "severity": "critical",
      "file": "src/api/client.ts",
      "line": 45,
      "code": "data: any",
      "fix": "Use proper type or unknown"
    }
  ]
}
```

### 2. Trigger Architect Reactively

```
Task(
  subagent_type: "architect",
  prompt: """
    LEARNING AGENT ALERT: CRAFT violations detected

    ## Violations
    <content of violations.json>

    ## Your Mission
    1. Analyze each violation
    2. Propose fixes (quick plan, not full design doc)
    3. Present to user

    ## Output Format
    Quick fix proposal:
    - File: X
    - Issue: Y
    - Fix: Z
    - Risk: Low/Medium

    Ask: [ Fix now ] [ Later ] [ Ignore file ]
  """
)
```

### 3. User Decides

```
AskUserQuestion(
  questions: [{
    question: "CRAFT violations detected. What do you want to do?",
    header: "Violations",
    options: [
      { label: "Fix now", description: "Architect will create refactoring plan" },
      { label: "Later", description: "Continue, fix during /heal" },
      { label: "Ignore", description: "Not now (violations remain)" }
    ]
  }]
)
```

---

## Learn From External

`/learn --from <source>` learns project-specific patterns from external sources.

```bash
/learn --from ../other-project        # Local folder
/learn --from https://github.com/...  # Remote repo (clone first)
```

### Flow

```
/learn --from <source>
       │
       ▼
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│   1. Scan source for patterns                                    │
│                                                                  │
│   2. Filter: PROJECT-SPECIFIC only                               │
│      ✅ Folder structure                                         │
│      ✅ Naming conventions                                       │
│      ✅ Import aliases                                           │
│      ❌ Hexagonal (built-in, don't learn)                        │
│      ❌ Result<T,E> (built-in, don't learn)                      │
│                                                                  │
│   3. Check: Any CRAFT violations in source?                      │
│      ❌ `any` found? → DON'T learn from this file                │
│      ❌ `throw` in domain? → DON'T learn from this file          │
│                                                                  │
│   4. Present learnings to user                                   │
│                                                                  │
│   [ Apply ] [ Cancel ]                                           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Real-Time Watching

When code is pushed manually (outside /craft):

```
┌─────────────────────────────────────────────────────────────────┐
│                    REAL-TIME WATCHING                            │
│                                                                  │
│   Code pushed (git, manual edit)                                 │
│        │                                                         │
│        ▼                                                         │
│   Learning Agent detects change                                  │
│        │                                                         │
│        ├── New stack detected? → Inject skills to Architect      │
│        │                                                         │
│        ├── New pattern detected? → Add to learnings              │
│        │   (only if CRAFT compliant)                            │
│        │                                                         │
│        └── Violation detected? → Trigger Architect               │
│                   │                                              │
│                   ▼                                              │
│            User prompted                                         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Summary

| Aspect | Behavior |
|--------|----------|
| **Auto-learning** | ON by default |
| **Position in chain** | BEFORE Architect |
| **Stack detection** | Always, writes context.json |
| **Skill injection** | Stack skills → Architect |
| **What's learned** | PROJECT-SPECIFIC patterns only |
| **What's built-in** | CRAFT principles (never learned) |
| **On violation** | Architect triggered reactively |
| **Real-time** | Watches changes, updates patterns |
