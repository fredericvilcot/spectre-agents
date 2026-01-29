<p align="center">
  <img src="https://img.shields.io/badge/SPECTRE-AGENTS-blueviolet?style=for-the-badge&logo=ghost&logoColor=white" alt="Spectre Agents"/>
</p>

<h1 align="center">👻 SPECTRE AGENTS</h1>

<p align="center">
  <strong>Stop prompting. Start crafting.</strong>
</p>

<p align="center">
  <em>A reactive multi-agent system for <a href="https://claude.ai/code">Claude Code</a><br/>that engineers software, not just code.</em>
</p>

<p align="center">
  <a href="#the-idea">The Idea</a> ·
  <a href="#install">Install</a> ·
  <a href="#craft">Craft</a> ·
  <a href="#heal">Heal</a> ·
  <a href="#learn">Learn</a> ·
  <a href="#the-team">The Team</a>
</p>

---

## The Idea

You've used AI coding tools. You know the drill:

*"Build me a login form"* → 200 lines of spaghetti → *"It doesn't work"* → 200 more lines → *"Now there are 2 bugs"* → You delete everything and write it yourself.

**What if AI worked like a real engineering team instead?**

With Spectre, when you ask for a login form:
- The **Architect** designs the auth flow with proper security patterns
- The **Developer** implements it with type-safe code and explicit error handling
- The **QA Engineer** tests it, finds edge cases, catches bugs
- When tests fail, the Developer fixes them automatically
- You get production-ready code. Tested. Architected. Clean.

That's the difference between *prompting* and *crafting*.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/fvilcot/spectre-agents/main/install.sh | bash
```

Restart Claude Code. You're ready.

---

## Craft

> `/craft` — Build features with the right team for your context.

```
> /craft

What's your work context?

  🏢 Product Team   →  Full workflow with specs and reviews
  🚀 Startup        →  Fast iterations, still architected
  💼 Freelance      →  Direct and efficient
  📚 Learning       →  One agent explains step by step
```

Describe what you need. Spectre assembles the team:

```
> "User authentication with OAuth and magic links"

Assembling: Architect → Frontend Dev → QA Engineer

🏗️ Architect designing auth flow...
   ✓ OAuth2 + PKCE for security
   ✓ Magic link with short-lived tokens
   ✓ Session management strategy

💻 Frontend Dev implementing...
   ✓ Type-safe auth context
   ✓ Protected route wrapper
   ✓ Login/callback components

🧪 QA Engineer testing...
   ✓ 12 tests passing
   ✓ Edge cases covered
   ✓ Security scenarios verified

✅ Ready to ship.
```

The workflow adapts to your context. Product teams get full specs and reviews. Startups get fast iterations. Freelancers get straight to the point. Learners get explanations.

---

## Heal

> `/heal` — Auto-fix everything. Tests, types, build, specs.

```bash
/heal           # Diagnose and fix whatever is broken
/heal tests     # Fix failing tests
/heal types     # Fix TypeScript errors
/heal spec      # Sync spec with implementation
```

Spectre doesn't just throw code at problems. It routes each issue to the right expert:

```
> /heal

🔍 Diagnosing...
   ❌ 3 tests failing
   ❌ 2 type errors

🏗️ Architect fixing type errors...
   → Missing branded type at API boundary
   ✓ Fixed

💻 Frontend Dev fixing tests...
   → Error state not announced to screen readers
   ✓ Fixed

🧪 QA verifying...
   ✓ All passing

✅ Healed.
```

Test failures go to the dev who wrote the code. Type errors go to the Architect. Spec gaps go to the Product Owner. The right expert, every time.

---

## Learn

> `/learn` — Adapt to YOUR codebase. Refuse anti-patterns.

```bash
/learn                  # Analyze entire project
/learn src/features/    # Learn from specific folder
/learn --example <file> # "This is my gold standard"
/learn --auto           # Intelligent scan
```

Spectre learns your patterns: your architecture, your naming conventions, your error handling style, your test structure. Then it applies them consistently.

**But it won't learn garbage.**

```
> /learn src/services/

🔍 Analyzing...

🛑 CRAFT VIOLATIONS DETECTED

   src/services/PaymentService.ts
   → God class: 847 lines, 23 methods
   → Violates: Single Responsibility
   → Fix: Split into focused services

   src/services/UserService.ts:45
   → throw new Error('User not found')
   → Violates: Explicit Error Handling
   → Fix: Return Result<User, NotFoundError>

📋 Report: .spectre/violations-report.md

❌ Nothing learned. Fix violations first.
```

The guard is always on. Every mode. No exceptions. We don't generate skills from code that violates craft principles.

---

## The Team

Six specialists. Each with deep expertise. Working together.

**👤 Product Owner** — Transforms vague ideas into clear specs. User stories with acceptance criteria. Edge cases you forgot to think about.

**🏗️ Architect** — Designs systems that scale. Clean Architecture. Domain-Driven Design. SOLID principles. Code review with teeth.

**💻 Frontend Dev** — Builds interfaces users love. Accessible. Performant. Type-safe. Components that compose well.

**⚙️ Backend Dev** — APIs that are secure and fast. Explicit error handling. Proper validation. No `any`, no shortcuts.

**🧪 QA Engineer** — Tests that prove it works. TDD/BDD. Meaningful coverage. Catches bugs before you do.

**🎭 Orchestrator** — Coordinates the team. Routes problems to the right expert. Manages retries. Keeps the loop flowing.

---

## Reactive Links

Agents don't just work in sequence. They react to each other.

When QA finds a test failure → Dev fixes it → QA re-verifies.
When QA finds a design flaw → Architect redesigns → Dev updates → QA re-verifies.
When Dev is blocked by design → Architect adjusts → Dev continues.
When Architect finds a spec contradiction → Product Owner arbitrates.

Every problem goes to the expert who can solve it. Automatically.

```
                    ┌─────────────┐
         clarify ───│   Product   │─── contradiction
         spec gap ──│    Owner    │◀── edge case
                    └──────┬──────┘
                           │
                           ▼
         blocked ──────┌─────────────┐────── design flaw
         by design ────│  Architect  │─────▶ code review
                       └──────┬──────┘
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
             ┌───────────┐       ┌───────────┐
             │  Frontend │       │  Backend  │
             │    Dev    │       │    Dev    │
             └─────┬─────┘       └─────┬─────┘
                   └─────────┬─────────┘
                             ▼
                      ┌───────────┐
        test failure ◀│    QA     │
        re-verify ────│ Engineer  │
                      └───────────┘
```

---

## Philosophy

**Domain First** — Business logic lives at the center. Frameworks live at the edges. Your domain model is sacred.

**Type Safety** — Types are documentation that compiles. No `any`. No escape hatches. The compiler is your ally.

**Explicit Over Implicit** — No magic. No surprises. `Result<T, E>` over thrown exceptions. Make the code tell its story.

**Test-Driven** — Tests are specifications that run. Write the test first. Let it drive the design.

**Self-Correcting** — Agents catch their own mistakes. QA fails, Dev fixes, QA verifies. Humans step in only when needed.

**Adaptive** — Learns your patterns. Guards your standards. Refuses to learn anti-patterns.

---

## License

BSD 3-Clause

---

<p align="center">
  <code>/craft</code> · <code>/heal</code> · <code>/learn</code>
</p>

<p align="center">
  <strong>That's the Spectre way.</strong> 👻
</p>
