<p align="center">
  <img src="https://img.shields.io/badge/SPECTRE-AGENTS-blueviolet?style=for-the-badge&logo=ghost&logoColor=white" alt="Spectre Agents"/>
</p>

<h1 align="center">Stop prompting. Start crafting.</h1>

<p align="center">
  <em>Turn Claude Code into a team of expert developers<br/>that write production-ready code. Together.</em>
</p>

---

## The Problem

You prompt. AI dumps code. You debug it.

No architecture. No tests. No standards. Just... code.

**You became the QA for an AI.**

---

## The Solution

What if Claude Code worked like a **real dev team**?

```
You: "Build user authentication"

    Product Owner    →  Writes the spec
    Architect        →  Designs the solution
    Developer        →  Implements it
    QA Engineer      →  Tests it

    Bug found? → Dev fixes → QA re-tests → Loop until green.
```

That's Spectre.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/fredericvilcot/spectre-agents/main/install.sh | bash
```

---

## Three Commands. That's It.

```bash
/craft    # Build something
/heal     # Fix something
/learn    # Adapt to your codebase
```

---

## `/craft` — Your AI Dev Team

Say what you want. Spectre does the rest.

```
> /craft "user authentication with OAuth"

🔍 Detected: TypeScript + React + Node

👤 PO → spec.md
   ✓ User story
   ✓ 6 acceptance criteria

🏗️ Architect → design.md
   ✓ 8 files planned
   ✓ CRAFT patterns

💻 Dev + 🧪 QA (parallel)
   ✓ Implementing...
   ✗ Test failed: OAuth callback
   🔧 Dev fixing... (auto)
   ✓ 6/6 tests passing

✨ Done.
```

**All agents. Always. No shortcuts. Autonomous fixing.**

---

## `/heal` — Re-launch the Agent Loop

Something broken? Spectre relaunches agents to fix it.

```bash
/heal        # Diagnose → Route → Fix → Verify → Loop
/heal tests  # Focus on test failures
/heal types  # Focus on TypeScript errors
```

**`/heal` is NOT `npm test`.** It relaunches the full agent loop:

1. **Diagnose** — What's broken?
2. **Route** — Send to the right agent
3. **Fix** — Agent fixes autonomously
4. **Verify** — QA re-runs tests
5. **Loop** — Until all green

| Problem | Agent fixes it |
|---------|----------------|
| Test failing | Developer |
| Type error | Architect |
| Spec gap | Product Owner |

---

## `/learn` — Adapts to YOU

Spectre learns your codebase:

- Your folder structure
- Your naming conventions
- Your patterns

Then enforces them. Everywhere.

```
> /learn

📦 Detected: TypeScript + React + Vitest
📐 Patterns: Feature folders, Result types
⚠️ Found: 5x 'any' types

🏗️ Architect proposes refactoring plan...
```

---

## Why Spectre?

| Without Spectre | With Spectre |
|-----------------|--------------|
| You prompt, you debug | Agents collaborate, QA verifies |
| Generic code | Learns YOUR patterns |
| `any` everywhere | Strict TypeScript |
| `throw new Error` | `Result<T, E>` |
| No tests | Tests included |
| You are the QA | QA agent catches bugs |

---

## The Team

| Agent | Superpower |
|-------|------------|
| **Product Owner** | Turns vague ideas into clear specs |
| **Architect** | Designs clean, maintainable solutions |
| **Developer** | Implements with craft principles |
| **QA Engineer** | Catches bugs before you do |
| **Learning Agent** | Adapts everything to YOUR codebase |

---

## Craft Principles

Every agent follows:

- **No `any`** — Types are documentation
- **No `throw`** — Use `Result<T, E>`
- **No god classes** — Single responsibility
- **No code without tests** — TDD mindset
- **No implementation without spec** — Contracts first

---

<p align="center">
  <strong>Spectre learns. Spectre adapts. Spectre crafts.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge//%20craft-8A2BE2?style=for-the-badge" alt="/craft"/>
  <img src="https://img.shields.io/badge//%20heal-9400D3?style=for-the-badge" alt="/heal"/>
  <img src="https://img.shields.io/badge//%20learn-9932CC?style=for-the-badge" alt="/learn"/>
</p>

---

<p align="center">
  <sub>BSD 3-Clause License</sub>
</p>
