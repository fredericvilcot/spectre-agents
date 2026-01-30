# CLAUDE.md

> **Stop prompting. Start crafting.**

Spectre transforms Claude Code into a team of Software Craft experts. Clean architecture, Result types, TDD, domain-driven. All agents collaborate reactively.

---

## Three Commands

```bash
/craft    # Smart flow: learn stack → contextual choices → build
/heal     # Auto-fix: route problems to right agent
/learn    # Re-generate library skills if stack evolved
```

---

## `/craft` — Learn First, Smart Choices

**Stack detection first. Then intelligent options based on what's detected.**

```
/craft
  │
  ╔═══════════════════════════════════════════════════════════╗
  ║  1. LEARNING (IMMEDIATE)                                  ║
  ║                                                           ║
  ║  📦 Detecting stack...                                    ║
  ║     → typescript, react, fp-ts, zustand, zod, vitest     ║
  ║                                                           ║
  ║  🏛️ Architect generating library skills...                ║
  ║     → TypeScript: utility types, strict mode              ║
  ║     → fp-ts: Option, Either, pipe, flow                   ║
  ║     → Zustand: stores, selectors                          ║
  ║     → .spectre/stack-skills.md                           ║
  ╚═══════════════════════════════════════════════════════════╝
  │
  ╔═══════════════════════════════════════════════════════════╗
  ║  2. SMART CHOICES (contextual)                            ║
  ║                                                           ║
  ║  "I detected: TypeScript + React + fp-ts"                ║
  ║                                                           ║
  ║  • ✨ New feature                                         ║
  ║  • 🐛 Fix a bug                                           ║
  ║  • 💜 Improve existing                                    ║
  ║      ├─ 🔄 Migrate to Result<T,E> (you have fp-ts!)      ║
  ║      ├─ 🚫 Remove `any` types                             ║
  ║      └─ 🏛️ Restructure to hexagonal                       ║
  ║  • 🧪 Add tests                                           ║
  ║  • 🔍 Audit my code                                       ║
  ║  • 💬 Or type your own need...                           ║
  ╚═══════════════════════════════════════════════════════════╝
  │
  └─ QA config → PO → Architect → Dev + QA → Fixing loop
```

### Free Text = Smart Routing

Type anything, get routed to the right CRAFT flow:

| You say | Spectre does |
|---------|--------------|
| "Create e2e regression tests" | QA Agent (regression mode) |
| "Check my Tailwind is clean" | Architect Audit |
| "Add dark mode" | Full flow: PO → Arch → Dev → QA |
| "Migrate to fp-ts" | Architect refactoring plan |
| "Just write unit tests" | Dev only (BDD tests) |

**Always respects CRAFT principles.**

### QA Config (Upfront)

```
Want QA tests?
├─ ✅ Yes → E2E or Integration?
│           └─ Where? (e2e/ | custom path | different repo)
└─ ⏭️ No → Dev only (unit tests)
```

If QA enabled: **Dev + QA run in parallel.**

---

## `/learn` — Re-generate Library Skills

```bash
/learn    # Re-detect stack, regenerate skills
```

Use when stack evolved (added new library). Runs automatically at `/craft` start.

**What it does:**
1. Learning Agent reads `package.json`
2. Architect generates library documentation
3. Output: `.spectre/stack-skills.md`

**What it generates:**
- Library API and patterns (TypeScript, fp-ts, Zod, React...)
- NOT CRAFT patterns (Architect already knows those)
- NOT existing code patterns (might be garbage)

---

## Reactive Notification System (CORE)

**Agents notify each other. This is the heart of Spectre.**

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│   DEV   │◄──►│   QA    │◄──►│  ARCH   │◄──►│   PO    │
└─────────┘    └─────────┘    └─────────┘    └─────────┘
         NOTIFICATION BUS
```

| From | To | Example |
|------|-----|---------|
| QA | Dev | "🔴 Test failed: src/cart.ts:45 returns null" |
| Dev | QA | "✅ Fixed cart.ts, please re-test" |
| Dev | Architect | "❓ Type issue, need design clarification" |
| Architect | Dev | "📐 Design updated, re-implement checkout()" |
| QA | PO | "❓ Spec unclear: what happens on empty cart?" |

**RULE: You wrote it? You own it. You fix it.**

| Location | Owner |
|----------|-------|
| `src/**` | Dev |
| `e2e/**` | QA |
| `tests/**` | QA |
| `*.test.ts` (colocated) | Dev |
| Design | Architect |
| Spec | PO |

---

## `/heal` — Trigger Notification Loop

```
/heal
  │
  ├─ Diagnose (build, tests, types, lint)
  ├─ NOTIFY owning agent (never fix directly!)
  │     QA → Dev: "🔴 Your code in src/cart.ts broke"
  │     Dev fixes → notifies QA: "✅ Fixed, re-test"
  ├─ Loop until ALL GREEN
```

```bash
/heal           # Full diagnostic
/heal tests     # Focus on test failures
/heal types     # Focus on TypeScript errors
```

---

## The Agents

| Agent | Role | Output |
|-------|------|--------|
| **learning-agent** | Detects stack, spawns Architect for skills | `.spectre/context.json` |
| **architect** | Library skills + Technical design | `.spectre/stack-skills.md`, `design.md` |
| **product-owner** | Functional specs, user stories | `.spectre/specs/functional/` |
| **frontend-engineer** | UI + unit tests (BDD) | Code + `*.test.ts` |
| **backend-engineer** | API + unit tests (BDD) | Code + `*.test.ts` |
| **qa-engineer** | E2E or Integration tests | `e2e/` or custom path |

---

## Software Craft Principles

Non-negotiable rules for ALL agents:

| Principle | Implementation |
|-----------|----------------|
| **No `any`** | Strict TypeScript, types are documentation |
| **No `throw`** | `Result<T, E>` — errors are values |
| **Domain isolation** | Hexagonal: domain has ZERO framework imports |
| **Colocated tests** | `*.test.ts` next to source (BDD style) |
| **Spec before code** | PO spec → Architect design → Dev implements |

---

## .spectre/ Directory

```
.spectre/                       # gitignored (except specs/)
├── context.json                # Detected libraries
├── stack-skills.md             # Library documentation (by Architect)
├── specs/
│   ├── functional/             # PO specs (COMMITTED)
│   │   └── spec-v1.md
│   └── design/                 # Architect designs (COMMITTED)
│       └── design-v1.md
└── state.json                  # Workflow state
```

**Specs are committed** — they're versioned documentation.

---

## Philosophy

- **Learn first** — Know the stack before asking questions
- **Smart routing** — Free text → right agent
- **Craft-first** — Software Craft in every line
- **Autonomous** — Agents fix without asking
- **Parallel** — Dev + QA work simultaneously
