# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Spectre Agents** is a reactive multi-agent system for Claude Code, built on Software Craftsmanship principles.

> **Code is a craft. Agents perfect it together.**

## Core Philosophy

### 🛠️ CRAFT — Excellence Without Compromise

Every agent embodies:

| Principle | Meaning |
|-----------|---------|
| **Domain First** | Business logic at the center, frameworks at the periphery |
| **Type Safety** | The type system as safety net and living documentation |
| **Explicit > Implicit** | No silent exceptions, no magic, no guessing |
| **Test-Driven** | Tests are executable specifications |
| **Pedagogy** | Explain the "why" before the "how" |

### 🔄 REACTIVE — Self-Correcting Agents

```
┌────────────────────────────────────────────────────────────┐
│                    REACTIVE LOOP                           │
│                                                            │
│   QA finds error ──▶ Dev fixes ──▶ QA verifies             │
│         ▲                              │                   │
│         └──────────── retry ◀──────────┘                   │
│                                                            │
│   Agents collaborate. Errors trigger fixes. Automatically. │
└────────────────────────────────────────────────────────────┘
```

## Usage

### The Only Command You Need

```bash
/guide
```

Spectre asks questions about your need and configures the right agents automatically.

### The Flow

```
/guide
   │
   ├─→ "What's your situation?"
   │      [ Build ] [ Fix ] [ Improve ] [ Think ]
   │
   ├─→ "Where are you starting from?" (if Build)
   │      [ User need ] [ Know what to build ] [ Just code it ]
   │
   ├─→ "What part of the app?"
   │      [ UI ] [ Backend ] [ Both ]
   │
   ├─→ "Should this be tested?"
   │      [ Yes ] [ No (prototype) ]
   │
   └─→ "Describe what you want"
          → Launches the right agent chain
```

### Mapping

| Situation | Starting Point | Result |
|-----------|----------------|--------|
| Build | User need | `PO → Architect → Dev → QA` |
| Build | Know what to build | `Architect → Dev → QA` |
| Build | Just code it | `Dev ↔ QA` (loop) |
| Fix | Tests failing | `Dev ↔ QA` (loop) |
| Improve | Refactor | `Architect → QA` |
| Think | Architecture | `Architect` alone |

## Agents

| Agent | Role | Expertise |
|-------|------|-----------|
| **software-craftsman** | Architect | Clean Architecture, DDD, SOLID, TDD/BDD |
| **product-owner** | Product | User stories, acceptance criteria, prioritization |
| **frontend-dev** | Implementation | React, accessibility, state management, testing |
| **qa-engineer** | Quality | Test strategy, TDD/BDD, test pyramid |

## Craft Skills

| Skill | Description |
|-------|-------------|
| `/typescript-craft` | Strict typing, algebraic types, Result types, pure functions |
| `/react-craft` | Component design, hooks, accessibility, testing |
| `/test-craft` | TDD/BDD, test pyramid, proper test doubles |
| `/init-frontend` | Bootstrap React + Vite + TypeScript + Vitest project |

## Structure

```
spectre-agents/
├── .claude/
│   ├── agents/           # Agent definitions
│   └── skills/           # Skill definitions
├── scripts/              # Reactive system hooks
└── docs/
    └── ARCHITECTURE.md   # Full technical documentation
```

## Component Format

### Agents (`.claude/agents/*.md`)
```yaml
---
name: agent-name
description: "When to use this agent..."
model: opus | sonnet | haiku
color: purple | blue | green
---

# System Prompt
```

### Skills (`.claude/skills/<name>/SKILL.md`)
```yaml
---
name: skill-name
description: "What this skill does"
context: fork | conversation
allowed-tools: Read, Write, Edit, Bash
---

# Skill Instructions
```

---

**Full documentation**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
