# Spectre Agents

**Reactive multi-agent system for [Claude Code](https://claude.ai/code), built on Software Craftsmanship.**

> **Code is a craft. Agents perfect it together.**

---

## What Makes Spectre Different

```
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│   🛠️  CRAFT                              🔄  REACTIVE                    │
│                                                                          │
│   Clean Architecture                     Self-correcting agents          │
│   DDD, SOLID, TDD/BDD                    Automatic error → fix loop      │
│   Type safety, no shortcuts              Shared memory & learnings       │
│   Pedagogy over speed                    Agents collaborate, not just    │
│                                          execute                         │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

**Other agent libraries** give you workflows. **Spectre** gives you a **team that learns**.

---

## Quick Start

### Install

```bash
# Linux/macOS
curl -fsSL https://raw.githubusercontent.com/fvilcot/spectre-agents/main/install.sh | bash

# Windows PowerShell
irm https://raw.githubusercontent.com/fvilcot/spectre-agents/main/install.ps1 | iex
```

Restart Claude Code after installation.

### Use

```bash
/guide
```

That's it. Spectre will ask you a few questions and launch the right agents.

---

## How `/guide` Works

Express your need, Spectre configures the agents.

```
/guide
   │
   ▼
┌─────────────────────────────────────────────────────────────────┐
│  "What's your situation?"                                       │
│                                                                 │
│  [ I want to build something ]    [ Something isn't working ]   │
│  [ I want to improve code ]       [ I need to think first ]     │
└─────────────────────────────────────────────────────────────────┘
                    │
                    ▼ (if "build")
┌─────────────────────────────────────────────────────────────────┐
│  "Where are you starting from?"                                 │
│                                                                 │
│  [ A user need or idea ]     → Full workflow with PO            │
│  [ I know what to build ]    → Architect designs first          │
│  [ Just need to code it ]    → Dev implements directly          │
└─────────────────────────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────────┐
│  "What part of the app?"                                        │
│                                                                 │
│  [ User interface ]    [ Backend / API ]    [ Both ]            │
└─────────────────────────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────────┐
│  "Should this be tested before shipping?"                       │
│                                                                 │
│  [ Yes, with automated tests ]    [ No, just a prototype ]      │
└─────────────────────────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────────┐
│  "Describe what you want to build:"                             │
│                                                                 │
│  > "Password reset via email"                                   │
└─────────────────────────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────────┐
│  ## Got it! Here's the plan:                                    │
│                                                                 │
│  product-owner → software-craftsman → frontend-dev → qa         │
│                                             ↑            │      │
│                                             └── error ───┘      │
│                                                                 │
│  Agents start working...                                        │
└─────────────────────────────────────────────────────────────────┘
```

### What Happens Based on Your Answers

| Situation | Starting Point | Testing | What Spectre Does |
|-----------|----------------|---------|-------------------|
| **Build** | User need/idea | Yes | PO writes spec → Architect designs → Dev builds → QA tests |
| **Build** | Know what to build | Yes | Architect designs → Dev builds → QA tests |
| **Build** | Just code it | Yes | Dev builds → QA tests (loops if errors) |
| **Build** | Any | No | Single agent works, no verification |
| **Fix** | Tests failing | — | Dev fixes → QA re-verifies → loops until green |
| **Fix** | Build broken | — | Architect analyzes → fixes types/structure |
| **Improve** | Add tests | — | QA writes tests |
| **Improve** | Refactor | — | Architect refactors → QA verifies |
| **Think** | Architecture | — | Architect analyzes and proposes design |

### Smart Shortcuts

Skip questions by providing context:

```bash
/guide add login form       # → build + UI flow
/guide fix failing tests    # → fix + tests flow
/guide refactor auth        # → improve flow
/guide how to design auth   # → think flow
```

---

## The Reactive Loop

What makes Spectre unique: **agents that fix their own mistakes**.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         SPECTRE REACTIVE LOOP                           │
│                                                                         │
│    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐        │
│    │ Product  │ ─▶ │ Software │ ─▶ │ Frontend │ ─▶ │    QA    │        │
│    │  Owner   │    │ Craftsman│    │   Dev    │    │ Engineer │        │
│    └──────────┘    └──────────┘    └──────────┘    └────┬─────┘        │
│                                          ▲               │              │
│                                          │    error      │              │
│                                          └───────────────┘              │
│                                             fix & retry                 │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

1. **QA runs tests** → finds error
2. **Dev agent spawns** automatically with error context
3. **Dev fixes** the issue
4. **QA re-verifies** automatically
5. **Loop until success** (max 3 retries)
6. **Learning recorded** for future reference

---

## Agents

Specialized experts that `/guide` orchestrates for you.

| Agent | Role | Expertise |
|-------|------|-----------|
| **software-craftsman** | 🏗️ Architect | Clean Architecture, DDD, Hexagonal, SOLID, TDD/BDD |
| **product-owner** | 📋 Product | User stories, acceptance criteria, prioritization |
| **frontend-dev** | ⚛️ Frontend | React, accessibility, state management, testing |
| **backend-dev** | 🔧 Backend | APIs, services, data layer, integration |
| **qa-engineer** | 🧪 Quality | Test strategy, TDD/BDD, test pyramid, coverage |

---

## Craft Skills

Apply excellence to specific areas (invoked automatically by `/guide` or manually):

| Skill | What It Does |
|-------|--------------|
| `/typescript-craft` | Strict typing, algebraic types, Result types, pure functions |
| `/react-craft` | Component design, hooks patterns, accessibility, testing |
| `/test-craft` | TDD/BDD workflow, test pyramid, proper mocks |
| `/init-frontend` | Bootstrap React + Vite + TypeScript + Vitest project |

---

## Philosophy

### 🛠️ Craft Principles

| Principle | What It Means |
|-----------|---------------|
| **Domain First** | Business logic at the center, frameworks at the periphery |
| **Type Safety** | Types are documentation and safety net |
| **Explicit > Implicit** | No magic, no silent failures, no guessing |
| **Test-Driven** | Tests are specifications, not afterthoughts |
| **Pedagogy** | Explain the "why" before the "how" |

### 🔄 Reactive Principles

| Principle | What It Means |
|-----------|---------------|
| **Auto-Correction** | Errors trigger fixes without human intervention |
| **Shared Memory** | Agents communicate through shared state |
| **Learning** | Every successful fix becomes a pattern |
| **Bounded Retry** | Max 3 attempts, then ask for help |

---

## Installation

### From Source

```bash
git clone https://github.com/fvilcot/spectre-agents.git
cd spectre-agents
./install.sh  # or .\install.ps1 on Windows
```

### Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/fvilcot/spectre-agents/main/uninstall.sh | bash
```

---

## Documentation

- **[Architecture Guide](docs/ARCHITECTURE.md)** — Full technical documentation
- **[CLAUDE.md](CLAUDE.md)** — Instructions for Claude Code

---

## License

BSD 3-Clause

---

<p align="center">
  <strong>Code is a craft. Agents perfect it together.</strong>
</p>
