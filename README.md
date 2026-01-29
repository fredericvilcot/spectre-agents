<p align="center">
  <img src="https://img.shields.io/badge/SPECTRE-AGENTS-blueviolet?style=for-the-badge&logo=ghost&logoColor=white" alt="Spectre Agents"/>
</p>

<h1 align="center">SPECTRE AGENTS</h1>

<p align="center">
  <strong>Stop prompting. Start crafting.</strong>
</p>

<p align="center">
  <em>A reactive multi-agent system for <a href="https://claude.ai/code">Claude Code</a><br/>that learns, adapts, and delivers craft-ready code.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/auto--learning-enabled-8A2BE2?style=flat-square" alt="Auto-learning"/>
  <img src="https://img.shields.io/badge/reactive-loop-9400D3?style=flat-square" alt="Reactive"/>
  <img src="https://img.shields.io/badge/craft-guard-8B008B?style=flat-square" alt="Craft Guard"/>
</p>

---

## What is Spectre?

Spectre is an **extension for Claude Code** that transforms it into a multi-agent craft system. Instead of a single AI generating code, specialized agents collaborate: Product Owner writes specs, Architect designs, Engineers implement, QA verifies — with a reactive feedback loop that auto-corrects errors.

```
┌─────────────────────────────────────────────────────────────────┐
│                      SPECTRE WORKFLOW                           │
│                                                                 │
│   /craft "Add user authentication"                              │
│       │                                                         │
│       ▼                                                         │
│   ┌─────────┐    ┌───────────┐    ┌──────────┐    ┌─────────┐  │
│   │   PO    │───▶│ Architect │───▶│ Engineer │───▶│   QA    │  │
│   │  specs  │    │  designs  │    │  builds  │    │ verifies│  │
│   └─────────┘    └───────────┘    └────┬─────┘    └────┬────┘  │
│                                        │               │        │
│                                        │    error      │        │
│                                        └───────────────┘        │
│                                          auto-fix loop          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Three Commands

```bash
/craft    # Build features with the right agent team
/heal     # Auto-fix everything (tests, build, types, specs)
/learn    # Adapt to YOUR codebase patterns
```

---

## `/craft` — Build with Craft

Smart flow that adapts to your work context.

```bash
/craft                        # Guided interactive flow
/craft "Add login form"       # Direct with description
```

### Flow

```
/craft
   │
   ├── Detect: Is there existing code?
   │      │
   │      ├── YES → Auto-detect stack + learn patterns
   │      │
   │      └── NO  → Ask stack + optional inspiration source
   │
   ├── Ask: Work context?
   │      [ Product Team | Startup | Freelance | Learning ]
   │
   ├── Ask: What to build?
   │
   ├── Architect: Design plan (shown for approval)
   │
   └── Execute: Reactive agent chain
```

### Pipelines by Context

| Context | Pipeline | Why |
|---------|----------|-----|
| **Product Team** | PO → Architect → Engineer → QA | Full specs, compliance, reviews |
| **Startup** | Architect → Engineer → QA | Fast iterations, you're the PO |
| **Freelance** | Engineer → QA | Minimal overhead, efficient |
| **Learning** | Single agent (educational) | Explanations over speed |

### Inspiration Mode (From Scratch)

When starting a new project, you can provide an inspiration source:

```
/craft
> "Do you have a reference project?"
> [GitHub repo] [Local folder] [Archive] [No, start fresh]

If yes → Architect analyzes it:
  ✅ Patterns to ADOPT (structure, conventions)
  🔧 Patterns to IMPROVE (elevate to craft standards)
  ❌ Patterns to SKIP (anti-patterns, tech debt)
```

---

## `/heal` — Smart Repair

Auto-diagnose and fix with intelligent routing.

```bash
/heal           # Fix everything (tests, build, types, specs)
/heal tests     # Fix failing tests only
/heal types     # Fix TypeScript errors only
/heal spec      # Sync spec ↔ implementation
```

### How It Works

```
/heal
   │
   ├── Diagnose: What's broken?
   │
   ├── Route to expert:
   │      • Test failure    → Engineer (file owner)
   │      • Type error      → Architect
   │      • Design flaw     → Architect
   │      • Spec gap        → Product Owner
   │      • Build error     → Architect
   │
   ├── Fix → Verify → Loop if needed (max 3 retries)
   │
   └── Learn: Record fix pattern for future
```

---

## `/learn` — Reactive Learning

The **Learning Agent** analyzes your codebase and adapts to YOUR conventions.

```bash
/learn                  # Full scan: stack + patterns + violations
/learn --only <path>    # Scan specific path only
/learn --show           # View current learnings
/learn --reset          # Clear all learnings
```

### How It Works

```
/learn
   │
   ├── Learning Agent detects stack (always)
   │
   ├── Scans for patterns (architecture, naming, imports)
   │
   └── Violations found?
          │
   ┌──────┴──────┐
   │             │
  YES           NO
   │             │
   ▼             ▼
Trigger      Store patterns
Architect    (agents adapt)
   │
   ▼
Propose refacto plan
   │
   ▼
User decides
```

### What It Learns

| Category | Examples |
|----------|----------|
| **Stack** | TypeScript 5.3, React 18, Vitest, Zod |
| **Architecture** | Feature folders, barrel exports, absolute imports |
| **Code Style** | Result types, error handling patterns |
| **Test Style** | Colocated tests, BDD naming, fixtures |
| **Naming** | Component conventions, file patterns |

### On Violations: Reactive, Not Punitive

Instead of blocking, violations **trigger the Architect** who proposes a refactoring plan:

```
⚠️ Violations detected: 8x 'any', 3x 'throw' in business logic

🔔 Triggering Architect...

🏗️ Architect proposes:
   Phase 1: Add strict mode, replace any → unknown
   Phase 2: Introduce Result<T, E> types
   Phase 3: Refactor services

[ 🚀 Start Phase 1 ]  [ 📋 Details ]  [ ⏭️ Later ]
```

---

## The Agents

| Agent | Role | Expertise |
|-------|------|-----------|
| **learning-agent** | Learning | Stack detection, pattern scanning, violation detection |
| **product-owner** | Specs | User stories, acceptance criteria (Given-When-Then), edge cases |
| **architect** | Design | Clean Architecture, DDD, SOLID, Hexagonal, code review |
| **frontend-engineer** | UI | React, accessibility, components, hooks, state |
| **backend-engineer** | API | Services, validation, Result types, security |
| **qa-engineer** | Tests | TDD/BDD, test pyramid, Testing Library, coverage |
| **orchestrator** | Coordination | Reactive loop, error routing, retries |

### Agent Philosophy

Every agent embodies craft principles:

| Principle | Application |
|-----------|-------------|
| **Domain First** | Business logic at center, frameworks at edges |
| **Type Safety** | Strict mode, no `any`, types as documentation |
| **Explicit Errors** | `Result<T, E>` not `throw`, code tells its story |
| **Test-Driven** | Tests are executable specs, not afterthoughts |
| **Clean Architecture** | SOLID, DDD, Hexagonal — context-appropriate |

---

## Reactive System

The magic of Spectre: agents don't just execute sequentially — they **react** to each other.

### Reactive Links

```
┌─────────────────────────────────────────────────────────────────┐
│                    REACTIVE MESH                                │
│                                                                 │
│   Learning Agent ─── violation ───▶ Architect                   │
│                                          │                      │
│                                          │ refacto_plan         │
│                                          ▼                      │
│   Product Owner ◀─── contradiction ─── Architect                │
│        │                                    │                   │
│        │                                    │                   │
│   spec_gap ◀─── Dev                    design ───▶ Dev          │
│   unclear  ◀─── QA                     review ───▶ Dev          │
│        │                                    │                   │
│        ▼                                    ▼                   │
│   ┌─────────┐                        ┌───────────┐              │
│   │   Dev   │◀─── test_failure ──────│    QA     │              │
│   │         │◀─── design_flaw ───────│           │              │
│   └─────────┘                        └───────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Error Routing

| Error Type | Routed To | Trigger |
|------------|-----------|---------|
| **Craft violation** | Architect | `any` abuse, `throw` in business logic, god class |
| Test failure | Engineer (owner) | `FAIL`, `expect`, assertion errors |
| Type error | Architect | `error TS`, type mismatch |
| Design flaw | Architect | Circular dependency, coupling |
| Spec gap | Product Owner | Missing edge case, unclear requirement |
| Build error | Architect | Module not found, compilation |
| Contradiction | Product Owner | Conflicting requirements |

### Self-Correction Loop

```
QA finds error
     │
     ▼
Route to right agent (based on error type + file ownership)
     │
     ▼
Agent fixes
     │
     ▼
QA re-verifies
     │
     ├── Pass → Continue
     └── Fail → Loop (max 3 retries, then human takeover)
```

---

## Shared State

Agents communicate through `.spectre/`:

```
.spectre/
├── state.json          # Current workflow state
├── errors.jsonl        # Error log (append-only)
├── events.jsonl        # Event history
├── learnings.jsonl     # Fix patterns learned
├── ownership.json      # Who modified which files
├── context.json        # Current feature context
└── learnings/          # Project patterns (from /learn)
    ├── tech-stack.json
    ├── code-patterns.json
    ├── test-patterns.json
    └── summary.md
```

---

## Example Session

```
> /craft "User authentication with magic links"

🔍 Detected: TypeScript + React + React Query
🧠 Learned: Feature folders, Result types, colocated tests
✅ Craft principles active

📋 Product Owner: Writing user story...
   ✓ 3 scenarios defined (happy path, expired link, invalid email)
   ✓ Acceptance criteria in Given-When-Then

🏗️ Architect: Designing...
   ✓ Hexagonal structure: domain/application/infrastructure/ui
   ✓ Result<User, AuthError> for error handling
   ✓ React Query for server state

💻 Frontend Engineer: Implementing...
   ✓ Created src/features/auth/domain/
   ✓ Created src/features/auth/ui/MagicLinkForm.tsx
   ✓ 8 tests written

🧪 QA Engineer: Verifying...
   ✗ 2 test failures detected

🔄 Routing to Frontend Engineer (file owner)...

💻 Frontend Engineer: Fixing...
   ✓ Fixed missing data-testid
   ✓ Fixed async state handling

🧪 QA Engineer: Re-verifying...
   ✓ 8/8 tests passing
   ✓ TypeScript: no errors
   ✓ Accessibility: verified

✨ Feature complete!
   • 12 files created
   • 8 tests passing
   • Craft score: 100%
```

---

## Installation

```bash
# One-liner install
curl -fsSL https://raw.githubusercontent.com/fvilcot/spectre-agents/main/install.sh | bash

# Restart Claude Code
```

This installs agents and skills to `~/.claude/`.

### Project Setup (Optional)

For the full reactive system with hooks:

```bash
/setup-reactive
```

Creates `.spectre/`, hooks configuration, and routing scripts.

---

## Project Structure

```
spectre-agents/
├── .claude/
│   ├── agents/                 # Agent definitions
│   │   ├── architect.md
│   │   ├── product-owner.md
│   │   ├── frontend-engineer.md
│   │   ├── backend-engineer.md
│   │   ├── qa-engineer.md
│   │   └── orchestrator.md
│   │
│   └── skills/                 # Skill definitions
│       ├── craft/SKILL.md
│       ├── heal/SKILL.md
│       ├── learn/SKILL.md
│       ├── feature/SKILL.md
│       ├── reactive-loop/SKILL.md
│       ├── agent/SKILL.md
│       ├── add-skill/SKILL.md
│       ├── test-craft/SKILL.md
│       ├── init-frontend/SKILL.md
│       └── setup-reactive/SKILL.md
│
├── scripts/
│   └── spectre/
│       ├── spectre-router.sh   # Smart error routing
│       ├── on-agent-stop.sh    # SubagentStop hook
│       └── check-test-results.sh
│
├── install.sh                  # Global installer
├── CLAUDE.md                   # Quick reference
└── README.md                   # This file
```

---

## Craft Principles

Spectre isn't about generating more code faster. It's about **crafting better software**.

> "Any fool can write code that a computer can understand. Good programmers write code that humans can understand." — Martin Fowler

> "The only way to go fast is to go well." — Robert C. Martin

> "Make it work, make it right, make it fast — in that order." — Kent Beck

### What Makes Code "Craft-Ready"

| Aspect | Craft Standard |
|--------|----------------|
| **Types** | Strict TypeScript, no `any`, types as documentation |
| **Errors** | `Result<T, E>` pattern, no thrown exceptions for expected cases |
| **Architecture** | Domain at center, dependencies point inward |
| **Tests** | Behavior-driven, test pyramid respected, colocated |
| **Naming** | Intent-revealing, ubiquitous language |

---

## Why Spectre?

| Traditional AI Coding | Spectre |
|----------------------|---------|
| Single prompt → code dump | Specialized agents collaborate |
| You debug the output | Agents self-correct via QA loop |
| Generic patterns | Learns YOUR project conventions |
| Hope it works | Verified by QA before delivery |
| Throws exceptions | Result types, explicit errors |
| `any` everywhere | Strict TypeScript |

---

## Commands Reference

| Command | Description |
|---------|-------------|
| `/craft` | Build features with guided flow |
| `/heal` | Auto-fix tests, types, build, specs |
| `/learn` | Learn project patterns |
| `/agent <name>` | Start specific agent with reactive links |
| `/reactive-loop` | Start full multi-agent workflow |
| `/setup-reactive` | Configure reactive system in project |
| `/add-skill` | Add specialized skills to agents |
| `/test-craft` | TDD/BDD testing guidance |
| `/init-frontend` | Bootstrap React project with craft principles |

---

<p align="center">
  <img src="https://img.shields.io/badge//%20craft-8A2BE2?style=for-the-badge" alt="/craft"/>
  <img src="https://img.shields.io/badge//%20heal-9400D3?style=for-the-badge" alt="/heal"/>
  <img src="https://img.shields.io/badge//%20learn-9932CC?style=for-the-badge" alt="/learn"/>
</p>

<p align="center">
  <strong>Spectre learns. Spectre adapts. Spectre crafts.</strong>
</p>

---

<p align="center">
  <sub>BSD 3-Clause License</sub>
</p>
