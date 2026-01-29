# Spectre Agents

> **Stop prompting. Start crafting.**

A reactive multi-agent system for [Claude Code](https://claude.ai/code) that adapts to how you work.

---

## Two Commands. That's It.

```bash
/craft    # Create something new
/heal     # Fix what's broken
```

No configuration. No learning curve. Just results.

---

## `/craft` — Tell Us What You Need

```
> /craft

What's your work context?

  [ Product Team ]  → Full specs, reviews, compliance
  [ Startup ]       → Ship fast, iterate faster
  [ Freelance ]     → Get it done, no overhead
  [ Learning ]      → Explore, no pressure
```

Then describe what you want. Spectre assembles the right team:

```
> "User authentication with OAuth and magic links"

Got it! Here's the plan:

  product-owner → software-craftsman → frontend-dev → qa-engineer
                                             ↑              │
                                             └── fix loop ──┘

Starting...
```

**Your context changes everything:**

| You | What Happens |
|-----|--------------|
| **Product Team** | Full workflow: PO writes spec → Architect designs → Dev builds → QA tests |
| **Startup** | Fast track: Architect → Dev → QA (you're the PO) |
| **Freelance** | Direct: Dev → QA (or just Dev if prototyping) |
| **Learning** | Educational: Single agent explains as it goes |

---

## `/heal` — Fix Everything Automatically

Something broke? Don't debug. Just heal.

```bash
/heal           # Fix everything (tests, build, types, specs)
/heal tests     # Fix failing tests
/heal types     # Fix TypeScript errors
/heal spec      # Sync spec with implementation
```

```
> /heal

🔍 Diagnosing...

  ❌ 3 tests failing
  ❌ 2 type errors

🔧 Healing...

  → software-craftsman fixed type errors
  → frontend-dev fixed tests
  → qa-engineer verified

✅ All systems healthy.
```

**Even specs get healed:**

```
> /heal spec

🔍 Comparing spec vs code...

  ❌ Missing in code: "Remember me" checkbox
  ⚠️ Mismatch: spec says 5 retries, code has 3

🔧 Healing...

  → product-owner updated spec
  → frontend-dev added feature

✅ Spec and code in sync.
```

---

## Why Spectre?

```
┌────────────────────────────────────────────────────────────────┐
│                                                                │
│   Other tools:        You prompt → Agent works → You check     │
│                                                                │
│   Spectre:            You describe → Agents collaborate →      │
│                       Agents verify → Agents fix → Done        │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

**Agents that fix their own mistakes:**

```
  Dev builds  →  QA tests  →  Error?  →  Dev fixes  →  QA retests
                                ↑                           │
                                └───────── loop ────────────┘
```

No more back-and-forth. The loop runs until it's right.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/fvilcot/spectre-agents/main/install.sh | bash
```

Restart Claude Code. Done.

---

## The Team

Specialized agents that know their craft:

| Agent | Expertise |
|-------|-----------|
| **product-owner** | Specs, user stories, acceptance criteria |
| **software-craftsman** | Architecture, DDD, SOLID, clean code |
| **frontend-dev** | React, accessibility, state, components |
| **backend-dev** | APIs, services, data, integrations |
| **qa-engineer** | Tests, TDD/BDD, coverage, verification |

You don't manage them. `/craft` and `/heal` do.

---

## Craft Skills

Apply craft principles to specific areas:

```bash
/typescript-craft    # Strict types, Result patterns, pure functions
/react-craft         # Component design, hooks, accessibility
/test-craft          # TDD/BDD, test pyramid, proper mocks
/init-frontend       # Bootstrap React + Vite + TypeScript + Vitest
```

---

## Philosophy

**Code is a craft.** Not a race.

| Principle | Meaning |
|-----------|---------|
| **Domain First** | Business logic at center, frameworks at edges |
| **Type Safety** | Types are documentation that compiles |
| **Explicit > Implicit** | No magic, no surprises |
| **Test-Driven** | Tests are specs that run |

---

## Documentation

- [Architecture Guide](docs/ARCHITECTURE.md) — How it works under the hood
- [CLAUDE.md](CLAUDE.md) — Instructions for Claude Code

---

## License

BSD 3-Clause

---

<p align="center">
  <strong>/craft</strong> to create. <strong>/heal</strong> to fix.<br/>
  That's the Spectre way.
</p>
