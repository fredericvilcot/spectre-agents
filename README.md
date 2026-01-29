<p align="center">
  <img src="https://img.shields.io/badge/SPECTRE-AGENTS-blueviolet?style=for-the-badge&logo=ghost&logoColor=white" alt="Spectre Agents"/>
</p>

<h1 align="center">👻 SPECTRE AGENTS</h1>

<p align="center">
  <strong>🚀 Stop prompting. Start crafting.</strong>
</p>

<p align="center">
  <em>The first reactive multi-agent system for <a href="https://claude.ai/code">Claude Code</a><br/>that doesn't just write code — it engineers software.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Architecture-Clean_|_Hexagonal_|_DDD-blueviolet?style=flat-square" alt="Architecture"/>
  <img src="https://img.shields.io/badge/Testing-TDD_|_BDD_|_100%25-success?style=flat-square" alt="Testing"/>
  <img src="https://img.shields.io/badge/Types-Strict_TypeScript-blue?style=flat-square" alt="Types"/>
  <img src="https://img.shields.io/badge/Agents-6_Specialists-orange?style=flat-square" alt="Agents"/>
</p>

<p align="center">
  <a href="#-the-problem">Problem</a> •
  <a href="#-the-solution">Solution</a> •
  <a href="#%EF%B8%8F-philosophy">Philosophy</a> •
  <a href="#-install">Install</a> •
  <a href="#-craft--the-command">Commands</a> •
  <a href="#-the-team">Team</a>
</p>

---

<h2 align="center">🎭 THE PROBLEM</h2>

<p align="center">
  <strong>AI coding tools are fast. But fast garbage is still garbage.</strong>
</p>

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                 │
│   😤 THE TYPICAL AI CODING EXPERIENCE:                                          │
│                                                                                 │
│      You: "Build me a login form"                                               │
│                                                                                 │
│      AI: *dumps 200 lines of spaghetti*                                         │
│                                                                                 │
│      You: "It doesn't work"                                                     │
│                                                                                 │
│      AI: *dumps 200 MORE lines*                                                 │
│                                                                                 │
│      You: "Now there are 2 bugs"                                                │
│                                                                                 │
│      AI: *adds 3 more*                                                          │
│                                                                                 │
│      You: *mass deletes everything*                                             │
│      You: *writes it yourself*                                                  │
│      You: *questions life choices*                                              │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

<br/>

<table>
<tr>
<td width="50%">

### ❌ What AI tools give you

- Code that "works" (until it doesn't)
- No tests ("you can add them later")
- No architecture (everything in one file)
- No error handling (just `try/catch` everything)
- Types? `any` everywhere
- "It compiled, ship it!"

</td>
<td width="50%">

### ✅ What you actually need

- Code that **works AND is maintainable**
- Tests that **prove it works**
- Architecture that **scales**
- Errors that **are handled explicitly**
- Types that **document your domain**
- Code you're **proud to commit**

</td>
</tr>
</table>

---

<h2 align="center">💡 THE SOLUTION</h2>

<p align="center">
  <strong>What if AI wrote code like a senior engineering team?</strong>
</p>

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                 │
│   👻 THE SPECTRE EXPERIENCE:                                                    │
│                                                                                 │
│      You: "Build me a login form"                                               │
│                                                                                 │
│      👤 Product Owner: "Let me define the user story and acceptance criteria"   │
│                                                                                 │
│      🏗️ Architect: "I'll design the auth flow with proper security patterns"    │
│                                                                                 │
│      💻 Developer: "Implementing with type-safe forms and explicit errors"      │
│                                                                                 │
│      🧪 QA: "Running tests... FAIL: Missing error state for invalid email"      │
│                                                                                 │
│      💻 Developer: "Fixed. Added Result<User, ValidationError>"                 │
│                                                                                 │
│      🧪 QA: "All tests passing. 100% coverage. Ready to ship."                  │
│                                                                                 │
│      You: *commits with confidence*                                             │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

<br/>

<p align="center">
  <strong>Spectre is a team of 6 AI specialists that collaborate, review each other's work,<br/>catch their own bugs, and deliver production-ready code.</strong>
</p>

<br/>

| Capability | Other AI | Spectre |
|:-----------|:---------|:--------|
| **Architecture** | None. Everything in one file. | 🏗️ Hexagonal, DDD, Clean Architecture |
| **Testing** | "I'll add tests later" | 🧪 TDD/BDD — tests are mandatory |
| **Error Handling** | `try { } catch { }` | 📦 `Result<T, E>` — explicit, typed errors |
| **Types** | `any`, `unknown`, pray | 🔒 Strict TypeScript, algebraic types |
| **Self-Correction** | You debug everything | 🔄 Agents fix their own mistakes |
| **Learning** | Same generic patterns | 🧠 Learns YOUR codebase conventions |
| **Quality Gate** | None | 🛡️ Refuses to generate anti-patterns |

---

<h2 align="center">🏛️ PHILOSOPHY</h2>

<p align="center">
  <img src="https://img.shields.io/badge/Software-Craftsmanship-blueviolet?style=for-the-badge" alt="Craft"/>
</p>

<p align="center">
  <strong>Code is a craft. Not a race to production.</strong>
</p>

<br/>

<table>
<tr>
<td align="center" width="33%">
<h3>🎯 Domain First</h3>
<p>Business logic at the center.<br/>Frameworks at the edges.<br/>Your domain model is sacred.</p>
</td>
<td align="center" width="33%">
<h3>🔒 Type Safety</h3>
<p>Types are documentation that compiles.<br/>No <code>any</code>. No shortcuts.<br/>The compiler is your friend.</p>
</td>
<td align="center" width="33%">
<h3>👁️ Explicit > Implicit</h3>
<p>No magic. No surprises.<br/><code>Result&lt;T, E&gt;</code> over exceptions.<br/>Make the code tell its story.</p>
</td>
</tr>
<tr>
<td align="center">
<h3>🧪 Test-Driven</h3>
<p>Tests are specs that run.<br/>Write the test first.<br/>Let it drive the design.</p>
</td>
<td align="center">
<h3>🔄 Self-Correcting</h3>
<p>Agents catch their mistakes.<br/>QA fails → Dev fixes → QA verifies.<br/>Humans intervene only when needed.</p>
</td>
<td align="center">
<h3>🧠 Adaptive</h3>
<p>Learns YOUR patterns.<br/>Adapts to YOUR architecture.<br/>Refuses to learn anti-patterns.</p>
</td>
</tr>
</table>

<br/>

<p align="center">
  <em>"Spectre doesn't just follow best practices.<br/>It learns YOUR best practices — and guards them."</em>
</p>

---

<h2 align="center">📦 INSTALL</h2>

```bash
curl -fsSL https://raw.githubusercontent.com/fvilcot/spectre-agents/main/install.sh | bash
```

<p align="center">
  <strong>Restart Claude Code. That's it.</strong> ✅
</p>

<p align="center">
  <sub>Works with any project. TypeScript, React, Node, or whatever you're building.</sub>
</p>

---

<h2 align="center">⚡ THREE COMMANDS. INFINITE POWER.</h2>

<p align="center">
  <img src="https://img.shields.io/badge/🔨_/craft-Build-success?style=for-the-badge&labelColor=1a1a1a" alt="/craft"/>
  <img src="https://img.shields.io/badge/💊_/heal-Fix-blue?style=for-the-badge&labelColor=1a1a1a" alt="/heal"/>
  <img src="https://img.shields.io/badge/🧠_/learn-Adapt-blueviolet?style=for-the-badge&labelColor=1a1a1a" alt="/learn"/>
</p>

---

## 🔨 `/craft` — Build Features Like a Pro Team

<p align="center">
  <strong>One command. Six specialists. Production-ready code.</strong>
</p>

```
> /craft

What's your work context?

  🏢 [ Product Team ]  → Full workflow: specs, design, implementation, QA
  🚀 [ Startup ]       → Fast track: design, build, test
  💼 [ Freelance ]     → Direct: build and test
  📚 [ Learning ]      → Educational: one agent explains step by step
```

### How it works

<table>
<tr>
<td width="50%">

**You say:**
```
"User authentication with OAuth and magic links"
```

</td>
<td width="50%">

**Spectre does:**
```
👤 PO: Writes user story + acceptance criteria
         ↓
🏗️ Architect: Designs auth flow + security
         ↓
💻 Dev: Implements with type-safe code
         ↓
🧪 QA: Tests everything
         ↓ (fail?)
💻 Dev: Fixes ← 🧪 QA: Re-tests
         ↓ (pass!)
✅ Done: Production-ready code
```

</td>
</tr>
</table>

### Context-Aware Workflows

| Your Context | What Happens | Why |
|:-------------|:-------------|:----|
| 🏢 **Product Team** | `PO → Architect → Dev → QA` | Full specs, compliance, documentation |
| 🚀 **Startup** | `Architect → Dev → QA` | Fast but architected |
| 💼 **Freelance** | `Dev → QA` | Direct, efficient, tested |
| 📚 **Learning** | Single agent explains | No pressure, educational |

<br/>

<details>
<summary><strong>📖 Example: Building a Payment Form</strong></summary>

```
> /craft

[Context: Startup]
[Goal: Build something new]
[Stack: Frontend]

"Payment form with credit card validation"

───────────────────────────────────────────────────

🏗️ software-craftsman is designing...

  ✓ Component: PaymentForm (controlled, accessible)
  ✓ Validation: Zod schema with card number, expiry, CVV
  ✓ Error handling: Result<PaymentData, ValidationError[]>
  ✓ State: useReducer for form state machine
  ✓ Accessibility: ARIA labels, error announcements

───────────────────────────────────────────────────

💻 frontend-dev is implementing...

  ✓ Created: src/features/payment/PaymentForm.tsx
  ✓ Created: src/features/payment/payment.schema.ts
  ✓ Created: src/features/payment/usePaymentForm.ts
  ✓ Types: Strict, no `any`
  ✓ Errors: Explicit Result types

───────────────────────────────────────────────────

🧪 qa-engineer is testing...

  ✓ Unit tests: 12 passing
  ✓ Integration: Form submission flow
  ✓ Edge cases: Invalid card, expired date, network error
  ✓ Accessibility: axe-core passing
  ✓ Coverage: 100%

───────────────────────────────────────────────────

✅ Feature complete!

  Files created:
  - src/features/payment/PaymentForm.tsx
  - src/features/payment/PaymentForm.test.tsx
  - src/features/payment/payment.schema.ts
  - src/features/payment/usePaymentForm.ts

  Ready to commit.
```

</details>

---

## 💊 `/heal` — Auto-Fix Everything

<p align="center">
  <strong>Something broke? Don't debug. Just heal.</strong>
</p>

```bash
/heal           # 🔧 Fix everything (tests, build, types, lint)
/heal tests     # 🧪 Fix failing tests only
/heal types     # 📝 Fix TypeScript errors only
/heal build     # 🔨 Fix build errors only
/heal spec      # 📋 Sync spec ↔ implementation
```

### Smart Routing

Spectre doesn't just throw code at problems. It **routes each issue to the right expert**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           INTELLIGENT ERROR ROUTING                          │
│                                                                              │
│   Error Type              Routed To           Why                            │
│   ──────────────────────────────────────────────────────────────────────    │
│   Test failure        →   💻 Dev who wrote it   Ownership matters            │
│   Type error          →   🏗️ Architect          Might be design issue        │
│   Design flaw         →   🏗️ Architect          Needs architectural fix      │
│   Build error         →   🏗️ Architect          Structural problem           │
│   Spec gap            →   👤 Product Owner      Missing requirement          │
│   Unclear criteria    →   👤 Product Owner      Needs clarification          │
│   Contradiction       →   👤 Product Owner      Must arbitrate               │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

<br/>

<details>
<summary><strong>📖 Example: Healing a Broken Build</strong></summary>

```
> /heal

🔍 Diagnosing...

  ❌ Tests: 3 failing
  ❌ Types: 2 errors
  ✅ Build: OK
  ✅ Lint: OK

───────────────────────────────────────────────────

🏗️ software-craftsman fixing type errors...

  Error: Type 'string' is not assignable to 'UserId'
  File:  src/features/auth/AuthService.ts:45

  Analysis: Missing branded type conversion
  Fix: Added UserId.parse() at API boundary

  ✓ Type errors fixed

───────────────────────────────────────────────────

💻 frontend-dev fixing test failures...

  FAIL: LoginForm should show error on invalid credentials
  File: src/features/auth/LoginForm.test.tsx

  Analysis: Error state not rendered (missing aria-live)
  Fix: Added error announcement region

  ✓ Tests fixed

───────────────────────────────────────────────────

🧪 qa-engineer verifying...

  ✓ All tests passing
  ✓ Types clean
  ✓ Build successful

───────────────────────────────────────────────────

✅ Healed! All systems healthy.

  Fixes applied:
  - src/features/auth/AuthService.ts (type safety)
  - src/features/auth/LoginForm.tsx (accessibility)
```

</details>

---

## 🧠 `/learn` — Adapt to YOUR Project

<p align="center">
  <strong>Spectre learns YOUR patterns. Not generic best practices.</strong>
</p>

```bash
/learn                       # 📖 Analyze entire project
/learn <file>                # 📄 Learn from specific file
/learn <folder>              # 📁 Learn from specific folder
/learn --example <file>      # 🌟 "THIS is my gold standard"
/learn --auto                # 🤖 Intelligent scan
/learn --violations          # 📋 Show violation report
```

### What It Learns

| Category | Examples |
|:---------|:---------|
| **Architecture** | Hexagonal, feature-folders, barrel exports |
| **Error Handling** | Result types, custom error classes |
| **Testing** | Vitest, co-located tests, MSW for mocking |
| **Naming** | Files: kebab-case, Components: PascalCase |
| **Imports** | Absolute with `@/`, barrel files |

### 🛡️ Craft Guard — Quality Gate

<p align="center">
  <strong>Spectre will NEVER learn anti-patterns. The guard is always on.</strong>
</p>

```
> /learn src/services/

🔍 Analyzing src/services/...

🛑 STOPPING — CRAFT VIOLATIONS DETECTED

┌─────────────────────────────────────────────────────────────────────────┐
│  VIOLATION 1                                                             │
│                                                                          │
│  File:     src/services/PaymentService.ts                                │
│  Issue:    God class (847 lines, 23 methods)                             │
│  Violates: Single Responsibility Principle                               │
│  Fix:      Split into PaymentProcessor, PaymentValidator, PaymentNotifier│
│  Priority: 🔴 Critical                                                   │
├──────────────────────────────────────────────────────────────────────────┤
│  VIOLATION 2                                                             │
│                                                                          │
│  File:     src/services/UserService.ts:45                                │
│  Issue:    throw new Error('User not found')                             │
│  Violates: Explicit Error Handling                                       │
│  Fix:      Return Result<User, NotFoundError>                            │
│  Priority: 🟠 Warning                                                    │
├──────────────────────────────────────────────────────────────────────────┤
│  VIOLATION 3                                                             │
│                                                                          │
│  File:     src/utils/helpers.ts:12                                       │
│  Issue:    function parse(data: any)                                     │
│  Violates: Type Safety                                                   │
│  Fix:      Define interface or use unknown with type guard               │
│  Priority: 🟠 Warning                                                    │
└─────────────────────────────────────────────────────────────────────────┘

📋 Report generated: .spectre/violations-report.md

❌ NO PATTERNS LEARNED — Fix violations first.

  [ 🔧 Fix with /heal ]  [ ⏭️ Ignore file ]  [ 🛑 Stop ]
```

<br/>

<p align="center">
  <em>The violation report is your action plan.<br/>Fix the issues, re-run /learn, and Spectre will adapt to your improved codebase.</em>
</p>

---

<h2 align="center">👥 THE TEAM</h2>

<p align="center">
  <strong>Six specialists. One mission. Production-ready code.</strong>
</p>

<br/>

<table>
<tr>
<td align="center" width="20%">
<h3>👤</h3>
<strong>Product Owner</strong>
<br/><br/>
<sub>
User stories<br/>
Acceptance criteria<br/>
Edge cases<br/>
Prioritization
</sub>
</td>
<td align="center" width="20%">
<h3>🏗️</h3>
<strong>Software Craftsman</strong>
<br/><br/>
<sub>
Clean Architecture<br/>
DDD / Hexagonal<br/>
SOLID principles<br/>
Code review
</sub>
</td>
<td align="center" width="20%">
<h3>💻</h3>
<strong>Frontend Dev</strong>
<br/><br/>
<sub>
React / Vue<br/>
Accessibility<br/>
State management<br/>
Component design
</sub>
</td>
<td align="center" width="20%">
<h3>⚙️</h3>
<strong>Backend Dev</strong>
<br/><br/>
<sub>
APIs / Services<br/>
Data access<br/>
Security<br/>
Performance
</sub>
</td>
<td align="center" width="20%">
<h3>🧪</h3>
<strong>QA Engineer</strong>
<br/><br/>
<sub>
TDD / BDD<br/>
Test pyramid<br/>
Coverage<br/>
Verification
</sub>
</td>
</tr>
</table>

<br/>

### 🔗 Reactive Links — They Talk to Each Other

<p align="center">
  <strong>Agents don't just work in sequence. They REACT.</strong>
</p>

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          REACTIVE AGENT NETWORK                              │
│                                                                              │
│                              ┌─────────────┐                                 │
│                              │   Product   │                                 │
│              clarify ────────│    Owner    │◀──────── contradiction          │
│              spec gap ───────│     👤      │◀──────── edge case              │
│                              └──────┬──────┘                                 │
│                                     │ spec                                   │
│                                     ▼                                        │
│                              ┌─────────────┐                                 │
│              blocked ────────│  Software   │◀──────── design flaw            │
│              by design ──────│  Craftsman  │                                 │
│                              │     🏗️      │─────────▶ code review           │
│                              └──────┬──────┘                                 │
│                                     │ design                                 │
│                          ┌──────────┴──────────┐                             │
│                          ▼                     ▼                             │
│                   ┌─────────────┐       ┌─────────────┐                      │
│                   │  Frontend   │       │   Backend   │                      │
│                   │    Dev      │       │    Dev      │                      │
│                   │     💻      │       │     ⚙️      │                      │
│                   └──────┬──────┘       └──────┬──────┘                      │
│                          │                     │                             │
│                          └──────────┬──────────┘                             │
│                                     │ code                                   │
│                                     ▼                                        │
│                              ┌─────────────┐                                 │
│           test failure ◀─────│     QA      │                                 │
│           re-verify ─────────│  Engineer   │                                 │
│                              │     🧪      │                                 │
│                              └─────────────┘                                 │
│                                                                              │
│   ────────────────────────────────────────────────────────────────────────   │
│                                                                              │
│   🧪 QA finds bug         → 💻 Dev fixes      → 🧪 QA re-verifies            │
│   🧪 QA finds design flaw → 🏗️ Architect fixes → 💻 Dev updates → 🧪 QA       │
│   🧪 QA finds spec gap    → 👤 PO clarifies   → 💻 Dev updates → 🧪 QA       │
│   💻 Dev blocked          → 🏗️ Architect helps → 💻 Dev continues            │
│   💻 Dev finds edge case  → 👤 PO decides     → 💻 Dev implements            │
│   🏗️ Arch finds conflict  → 👤 PO arbitrates  → 🏗️ Arch redesigns            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

<br/>

<p align="center">
  <strong>Every problem goes to the right expert. Automatically.</strong>
</p>

---

<h2 align="center">🎯 WHY SPECTRE WINS</h2>

<table>
<tr>
<td width="50%" valign="top">

### 🏆 For Senior Developers

- **Finally**, AI that understands architecture
- **Finally**, AI that writes tests first
- **Finally**, AI that handles errors properly
- **Finally**, AI you can trust to commit

</td>
<td width="50%" valign="top">

### 🚀 For Teams

- **Consistent** code quality across the team
- **Enforced** patterns and conventions
- **Automated** code review feedback
- **Documented** decisions and rationale

</td>
</tr>
<tr>
<td valign="top">

### 💡 For Learners

- **See** how experts structure code
- **Understand** why patterns matter
- **Learn** TDD/BDD by example
- **Level up** your craft

</td>
<td valign="top">

### ⚡ For Startups

- **Ship fast** without cutting corners
- **Scale** your codebase from day one
- **Onboard** new devs with consistent patterns
- **Sleep** knowing the code is solid

</td>
</tr>
</table>

---

<h2 align="center">📊 THE NUMBERS</h2>

<p align="center">
  <img src="https://img.shields.io/badge/Test_Coverage-100%25-success?style=for-the-badge" alt="Coverage"/>
  <img src="https://img.shields.io/badge/Type_Safety-Strict-blue?style=for-the-badge" alt="Types"/>
  <img src="https://img.shields.io/badge/any_Usage-0%25-blueviolet?style=for-the-badge" alt="No Any"/>
</p>

| Metric | Without Spectre | With Spectre |
|:-------|:----------------|:-------------|
| Time debugging AI output | 60% of your time | 5% of your time |
| Test coverage | "We'll add tests later" | 100% from the start |
| Type safety | `any` everywhere | Strict, branded types |
| Architecture | Spaghetti | Clean, layered, scalable |
| Error handling | `try/catch` | `Result<T, E>` |
| Code review cycles | 3-5 rounds | 1 round (pre-reviewed) |

---

## 📄 LICENSE

BSD 3-Clause — Use it, fork it, make it yours.

---

<p align="center">
  <img src="https://img.shields.io/badge/🔨_/craft-Build_Features-success?style=for-the-badge&labelColor=1a1a1a" alt="/craft"/>
  <img src="https://img.shields.io/badge/💊_/heal-Fix_Everything-blue?style=for-the-badge&labelColor=1a1a1a" alt="/heal"/>
  <img src="https://img.shields.io/badge/🧠_/learn-Adapt_&_Guard-blueviolet?style=for-the-badge&labelColor=1a1a1a" alt="/learn"/>
</p>

<br/>

<p align="center">
  <strong>Stop prompting. Start crafting.</strong>
</p>

<p align="center">
  <em>That's the Spectre way.</em> 👻
</p>

<br/>

<p align="center">
  <sub>Made with craft by developers who were tired of AI-generated garbage.</sub>
</p>
