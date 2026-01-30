---
name: learn
description: "Real-time CRAFT guardian. Auto-learns patterns, watches for violations, triggers Architect immediately. Always on by default."
context: conversation
allowed-tools: Read, Bash, Glob, Grep, Write, Task, AskUserQuestion
---

# Spectre Learn — Real-Time CRAFT Guardian

**Always watching. Always enforcing. Always learning.**

---

## Philosophy

Learning is **continuous**, not on-demand. The Learning Agent:

1. **Watches** code changes in real-time
2. **Detects** CRAFT violations immediately
3. **Triggers** Architect to propose fixes
4. **Prompts** user for approval

```
┌─────────────────────────────────────────────────────────────────┐
│                    REAL-TIME GUARDIAN                            │
│                                                                  │
│   Code changes (save, commit, pull)                              │
│        │                                                         │
│        ▼                                                         │
│   ┌─────────────────┐                                           │
│   │ Learning Agent  │ ← ALWAYS WATCHING                         │
│   │                 │                                           │
│   │ • Detect stack  │                                           │
│   │ • Learn patterns│                                           │
│   │ • Check CRAFT   │                                           │
│   └────────┬────────┘                                           │
│            │                                                     │
│     ┌──────┴──────┐                                             │
│     │             │                                             │
│  CLEAN        VIOLATION                                          │
│     │             │                                             │
│     ▼             ▼                                             │
│   Store      ┌──────────┐                                       │
│   patterns   │ Architect│ ← IMMEDIATE TRIGGER                   │
│              │          │                                       │
│              │ Propose  │                                       │
│              │ fix      │                                       │
│              └────┬─────┘                                       │
│                   │                                             │
│                   ▼                                             │
│              ┌──────────┐                                       │
│              │  User    │ ← PROMPT FOR APPROVAL                 │
│              │ decides  │                                       │
│              └──────────┘                                       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Commands

```bash
/learn              # Force re-scan now
/learn --off        # Disable auto-learning (not recommended)
/learn --from <x>   # One-shot learn from external source
```

| Command | Action |
|---------|--------|
| `/learn` | Force immediate re-scan of project |
| `/learn --off` | Disable real-time watching |
| `/learn --from <path>` | Learn from external (repo, file, folder, URL) |

**That's it. Simple.**

---

## Auto-Learning (Default: ON)

Learning Agent activates automatically on:

- First `/craft` or `/heal`
- Any code change detected
- Git pull/merge

```
┌─────────────────────────────────────────────────────────────────┐
│                    AUTO-LEARNING TRIGGERS                        │
│                                                                  │
│   /craft or /heal                                                │
│        │                                                         │
│        ├── .spectre/context.json exists?                        │
│        │        │                                                │
│        │   ┌────┴────┐                                          │
│        │   │         │                                          │
│        │  YES       NO                                           │
│        │   │         │                                          │
│        │   │         ▼                                          │
│        │   │    Learning Agent                                   │
│        │   │    starts watching                                  │
│        │   │         │                                          │
│        │   └────┬────┘                                          │
│        │        │                                                │
│        ▼        ▼                                                │
│   Continue with learned context                                  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Real-Time Violation Detection

When the Learning Agent detects a CRAFT violation:

### 1. Immediate Architect Trigger

```
Learning Agent detects violation
       │
       ▼
┌─────────────────────────────────────────────────────────────────┐
│                      ARCHITECT TRIGGERED                         │
│                                                                  │
│   "⚠️ CRAFT violation detected in src/api/client.ts"            │
│                                                                  │
│   Violation: `any` type on line 45                              │
│                                                                  │
│   Architect is analyzing...                                      │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 2. Architect Proposes Fix

```
Task(
  subagent_type: "architect",
  prompt: """
    REAL-TIME CRAFT VIOLATION DETECTED

    ## Violation
    - File: <file>
    - Line: <line>
    - Type: <any | throw | god-class | etc>
    - Code: <snippet>

    ## Your Mission
    1. Analyze the violation
    2. Propose a PURELY TECHNICAL fix
    3. Present to user immediately

    ## Output
    Quick fix proposal (inline, not a full document):
    - What's wrong
    - How to fix
    - Risk level
  """
)
```

### 3. User Prompt (Immediate)

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│  ⚠️ CRAFT VIOLATION DETECTED                                    │
│                                                                  │
│  File: src/api/client.ts:45                                     │
│  Issue: `any` type found                                        │
│                                                                  │
│  Architect suggests:                                             │
│  Replace `data: any` with `data: ApiResponse<T>`                │
│                                                                  │
│  [ 💜 Fix now ]  [ ⏭️ Later ]  [ 🚫 Ignore this file ]          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## CRAFT Violations Watched

**All Architect principles are monitored in real-time.**

### 🔴 Critical (Block & Fix Immediately)

| Violation | Detection | Architect Rule |
|-----------|-----------|----------------|
| `any` type | `: any` in code | "Never use `any`" |
| `throw` for expected | `throw new Error` in services/domain | "Use Result types" |
| Framework in domain | Import React/Express/DB in `domain/` | "Domain is sacred" |
| No tests for business logic | Domain file without `.test.ts` | "Untested = legacy" |
| Dependency Rule violation | Domain imports from infrastructure | "Dependencies point inward" |
| Hidden coupling | Direct instantiation (`new Service()`) | "Make dependencies explicit" |

### 🟠 Warning (Fix Soon)

| Violation | Detection | Architect Rule |
|-----------|-----------|----------------|
| God class | >300 lines or >10 methods | Single Responsibility |
| Long method | >20 lines | "Functions do one thing" |
| Long parameter list | >4 parameters | Introduce Parameter Object |
| Type assertions | `as unknown as` | Type safety |
| Missing strict mode | `"strict": false` | Type safety |
| Poor naming | Abbreviations, single letters | "Names reveal intent" |

### 🟡 Code Smells (Suggest Refactor)

| Smell | Detection | Refactoring |
|-------|-----------|-------------|
| Feature Envy | Method uses other class data heavily | Move Method |
| Data Clumps | Same params in multiple functions | Extract Parameter Object |
| Primitive Obsession | `string` for email/money/id | Extract Value Object |
| Shotgun Surgery | One change = many files | Extract Class |
| Divergent Change | Many reasons to change one file | Split by responsibility |

### SOLID Violations

| Principle | Violation Sign | Detection |
|-----------|----------------|-----------|
| **S**ingle Responsibility | Class does too much | >1 reason to change |
| **O**pen/Closed | Modifying for new features | Switch/if chains for types |
| **L**iskov Substitution | Override breaks behavior | Override changes semantics |
| **I**nterface Segregation | Fat interfaces | Interface with >5 methods |
| **D**ependency Inversion | Concrete dependencies | Import implementation, not interface |

---

## One-Shot External Learning

`/learn --from <source>` learns from external inspiration without disabling auto-learn.

```bash
/learn --from ../other-project        # Local folder
/learn --from ./legacy/old-service    # Subfolder
/learn --from https://github.com/...  # Remote repo
/learn --from pattern:hexagonal       # Named pattern
```

### Flow

```
/learn --from <source>
       │
       ▼
┌─────────────────────────────────────────────────────────────────┐
│                      ARCHITECT ANALYSIS                          │
│                                                                  │
│   Scan external source                                           │
│        │                                                         │
│        ▼                                                         │
│   Generate Learning Report                                       │
│        │                                                         │
│        ▼                                                         │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                                                           │  │
│   │  ✅ WILL LEARN (CRAFT compliant)                         │  │
│   │  - Feature folders                                        │  │
│   │  - Result<T, E> types                                     │  │
│   │                                                           │  │
│   │  ❌ WON'T LEARN (CRAFT violations)                       │  │
│   │  - `any` types (5 occurrences)                           │  │
│   │  - `throw` in services                                    │  │
│   │                                                           │  │
│   │  [ 💜 Apply learnings ]  [ ❌ Cancel ]                   │  │
│   │                                                           │  │
│   └──────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Storage

```
.spectre/
├── context.json              # Stack + learned patterns
├── violations.json           # Current violations (if any)
└── state.json                # Workflow state (learning: on/off)
```

---

## Implementation

### On First Run

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    INITIALIZE REAL-TIME GUARDIAN

    1. Detect stack (package.json, tsconfig, etc.)
    2. Scan codebase for patterns
    3. Check for existing CRAFT violations
    4. Write .spectre/context.json
    5. If violations → trigger Architect immediately

    CRAFT RULES (NON-NEGOTIABLE):
    - No `any`
    - No `throw` for expected errors (use Result<T, E>)
    - Domain isolated from frameworks
    - Colocated tests
    - Single responsibility

    Stay watching for changes.
  """
)
```

### On Code Change

```
# File changed: src/api/client.ts

Learning Agent:
  1. Read changed file
  2. Check against CRAFT rules
  3. If violation:
     → Trigger Architect
     → Architect proposes fix
     → User prompted immediately
  4. If clean:
     → Update patterns if new pattern detected
```

### On Violation Fix

```
User approves fix
       │
       ▼
Dev implements fix
       │
       ▼
QA runs regression tests
       │
       ▼
Learning Agent confirms fix
       │
       ▼
Remove from violations.json
```

---

## Summary

| Aspect | Behavior |
|--------|----------|
| **Default** | Auto-learning ON |
| **Watching** | Real-time, always |
| **On violation** | Architect triggered immediately |
| **User prompt** | Immediate, inline |
| **External learning** | One-shot, doesn't disable auto |
| **CRAFT rules** | Non-negotiable, always enforced |
