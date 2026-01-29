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

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/fredericvilcot/spectre-agents/main/install.sh | bash
```

Then restart Claude Code. Done.

---

## Three Commands

```bash
/craft    # Build features with the right agent team
/heal     # Auto-fix everything (tests, build, types)
/learn    # Adapt to YOUR codebase patterns
```

---

## What is Spectre?

Spectre transforms Claude Code into a **multi-agent craft system**. Instead of one AI generating code, specialized agents collaborate through **contracts**:

```
┌─────────────────────────────────────────────────────────────────┐
│                   SPECTRE: CONTRACT-DRIVEN                       │
│                                                                  │
│   /craft "a sexy counter"                                        │
│       │                                                          │
│       ▼                                                          │
│   ┌─────────┐                                                    │
│   │   PO    │ → .spectre/spec.md (FUNCTIONAL CONTRACT)           │
│   └────┬────┘                                                    │
│        │                                                          │
│        ▼                                                          │
│   ┌─────────┐                                                    │
│   │Architect│ → .spectre/design.md (TECHNICAL CONTRACT)          │
│   └────┬────┘                                                    │
│        │                                                          │
│        ▼                                                          │
│   ┌───────────────────────────┐                                  │
│   │   Dev ⇄ QA                │                                  │
│   │   Implement design.md     │                                  │
│   │   TO THE LETTER           │                                  │
│   └───────────────────────────┘                                  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## `/craft` — Smart Build

**Rule: All agents work from contracts (MD files).**

### RULE: No Spec = No Code

**Nothing gets implemented without both contracts:**

| Contract | Created By | Contains |
|----------|------------|----------|
| `.spectre/spec.md` | PO | User story, acceptance criteria, edge cases |
| `.spectre/design.md` | Architect | File structure, code patterns, test specs |

Dev and QA implement `design.md` **exactly**. No improvisation. No shortcuts.

### Smart Routing

| Your Input | PO Action | Pipeline |
|------------|-----------|----------|
| "a sexy counter" | Creates spec.md | PO → Architect → Dev ⇄ QA |
| "Counter with +/-, localStorage" | Creates spec.md | PO → Architect → Dev ⇄ QA |
| Jira ticket PROJ-123 | Fetches + creates spec.md | PO → Architect → Dev ⇄ QA |
| `docs/spec.md` file | Validates | Architect → Dev ⇄ QA |
| "Fix the counter bug" | — | Dev → QA |

### Parallel Execution

Dev and QA work **together**, not sequentially:

```
┌─────────────────────────────────────────────────────────────────┐
│                   DEV ⇄ QA PARALLEL                             │
│                                                                 │
│    Dev implements          QA writes tests                      │
│         │                        │                              │
│         │   ← shares context →   │                              │
│         ▼                        ▼                              │
│    Code ready              Tests ready                          │
│         │                        │                              │
│         └────────┬───────────────┘                              │
│                  ▼                                              │
│            QA runs tests                                        │
│                  │                                              │
│         ┌───────┴───────┐                                       │
│        PASS            FAIL → Dev fixes → QA re-runs            │
│         │                                                       │
│       Done                                                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Work Contexts

| Context | Pipeline | When |
|---------|----------|------|
| **Product Team** | PO → Architect → Dev ⇄ QA | Full specs, compliance |
| **Startup** | Architect → Dev ⇄ QA | Fast, you're the PO |
| **Freelance** | Dev ⇄ QA | Minimal overhead |
| **Learning** | Single agent | Educational mode |

---

## `/heal` — Smart Repair

Routes problems to the right expert:

```bash
/heal           # Fix all (tests, build, types)
/heal tests     # Fix failing tests only
/heal types     # Fix TypeScript errors
```

| Problem | Routed To |
|---------|-----------|
| Test failure | Dev (file owner) |
| Type error | Architect |
| Design flaw | Architect |
| Spec gap | Product Owner |

---

## `/learn` — Reactive Learning

Analyzes your codebase, adapts to YOUR conventions:

```bash
/learn              # Full scan
/learn --only src/  # Scan specific path
/learn --show       # View learnings
```

**On violations** (any abuse, throw in business logic):

```
⚠️ Violations: 8x 'any', 3x 'throw'

🔔 Triggering Architect...

🏗️ Refactoring plan:
   Phase 1: Add strict mode
   Phase 2: Introduce Result<T, E>

[ Start Phase 1 ] [ Details ] [ Later ]
```

Reactive, not punitive.

---

## The Agents

| Agent | Role |
|-------|------|
| **learning-agent** | Stack detection, pattern learning, violations |
| **product-owner** | User stories, acceptance criteria |
| **architect** | Design, clean architecture, code review |
| **frontend-engineer** | React, components, accessibility |
| **backend-engineer** | APIs, services, security |
| **qa-engineer** | Tests, verification |

---

## Reactive System

Agents **react** to each other:

```
┌─────────────────────────────────────────────────────────────────┐
│                    REACTIVE MESH                                │
│                                                                 │
│   Learning Agent ─── violation ───▶ Architect                   │
│                                          │                      │
│   Product Owner ◀─── contradiction ───   │                      │
│        │                                 │                      │
│   spec_gap ◀─── Dev              design ─┘                      │
│   unclear  ◀─── QA               review ───▶ Dev                │
│        │                                    │                   │
│        ▼                                    ▼                   │
│   ┌─────────┐                        ┌───────────┐              │
│   │   Dev   │◀─── test_failure ──────│    QA     │              │
│   └─────────┘                        └───────────┘              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Craft Principles

Every agent embodies:

| Principle | How |
|-----------|-----|
| **Domain First** | Business logic at center |
| **Type Safety** | Strict mode, no `any` |
| **Explicit Errors** | `Result<T, E>` not `throw` |
| **Test-Driven** | Tests are specs |

---

## Example Session

```
> /craft "a sexy counter"

📝 Input: Raw idea → PO will create spec first

👤 Product Owner:
   ✓ User story written
   ✓ 8 acceptance criteria
   ✓ Edge cases identified

🏗️ Architect:
   ✓ Feature folder structure
   ✓ Result types for errors
   ✓ Test scenarios for QA

🚀 Parallel execution starting...

   💻 Dev: Creating Counter.ts...
   🧪 QA: Writing tests...

   💻 Dev: ✓ useCounter.ts
   🧪 QA: ✓ Running tests...

   🧪 QA: ❌ FAIL: localStorage not synced
   💻 Dev: 🔧 Fixing...

   🧪 QA: ✓ 12/12 tests passing

✨ Feature complete!
```

---

## Project Structure

```
~/.claude/
├── agents/           # Installed agents
│   ├── architect.md
│   ├── product-owner.md
│   ├── frontend-engineer.md
│   └── ...
└── skills/           # Installed skills
    ├── craft/
    ├── heal/
    └── learn/
```

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
