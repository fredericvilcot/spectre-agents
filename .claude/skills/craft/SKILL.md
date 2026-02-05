---
name: craft
description: "Craft something. Claude orchestrates, agents execute."
context: conversation
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion
---

# /craft — CRAFT Mode

## IMMEDIATE: Show Banner

```
╭──────────────────────────────────────────────────────────────╮
│                                                              │
│   🟣 C L E A N   C L A U D E                                 │
│                                                              │
│   ══════════════════════════════════════════════════════     │
│   CRAFT MODE                                                 │
│   ══════════════════════════════════════════════════════     │
│                                                              │
╰──────────────────────────────────────────────────────────────╯
```

---

# FLOW OVERVIEW

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   CLAUDE ORCHESTRATES — NO LEARNING-AGENT                                ║
║                                                                           ║
║   Step 1: DETECT       Claude reads package.json → context.json          ║
║   Step 2: SCOPE        If monorepo → ask user                            ║
║   Step 3: CHOOSE       "What do you want to craft?"                      ║
║   Step 4: QA CONFIG    "E2E tests?" → yes/no                             ║
║   Step 5: ROUTE        PO → Architect → Dev + QA                         ║
║   Step 6: VERIFY       Tests → fix loop → green                          ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

# STEP 1: DETECT (Claude does this directly)

**DO NOT spawn any agent. Claude does this.**

```
1. Read("package.json")
2. Glob("{lerna,nx,turbo}.json,pnpm-workspace.yaml")
3. IF monorepo: Glob("apps/*,packages/*,modules/*")
4. Grep("clean-claude: architecture-reference", "**/*.md")  ← Check for arch ref
5. Write(".clean-claude/context.json")
```

**context.json:**
```json
{
  "project": {
    "type": "monorepo | frontend | backend | fullstack",
    "monorepo": { "detected": true, "workspaces": [...] },
    "scope": null,
    "language": "typescript"
  },
  "architectureRef": {
    "path": "docs/ARCHITECTURE.md",
    "version": 2
  }
}
```

> **IF architectureRef found → Architect MUST read and follow it.**

**Show:**
```
🟢 Step 1 ─ Detect                              ✓ Complete
   Project: [TYPE] · Language: [LANG] · Monorepo: [yes/no]
```

---

# STEP 2: SCOPE (if monorepo)

**Only if `project.monorepo.detected == true`**

```
AskUserQuestion: "Which workspace?"
→ User selects
→ Update context.json with scope
→ Show: "🟢 Scope: [SELECTED]"
```

**DO NOT re-analyze. Just save scope and continue.**

---

# STEP 3: CHOOSE

```
AskUserQuestion:
  "What do you want to craft?"

  Options:
  - ✨ New feature
  - 🔄 Refactor
  - 🐛 Fix bug
  - 🧪 Add tests
```

---

# STEP 4: QA CONFIG

```
AskUserQuestion:
  "Do you want E2E tests?"

  Options:
  - Yes (Playwright E2E)
  - Yes (Integration tests)
  - No (unit tests only, Dev writes them)
```

---

# STEP 5: ROUTE TO AGENTS

## Routing Table

| Choice | Route |
|--------|-------|
| New feature | PO → Architect → Dev + QA |
| Refactor | Architect → Dev + QA |
| Fix bug (user-facing) | PO → Architect → Dev |
| Fix bug (technical) | Architect → Dev |
| Add tests | QA only |

---

## 5a. PO (if needed)

```
Task(
  subagent_type: "product-owner",
  prompt: "Write functional spec for: [USER_REQUEST]. Output: .clean-claude/specs/functional/spec-v1.md"
)
```

**PO asks user approval. Wait for approval.**

---

## 5b. ARCHITECT

```
Task(
  subagent_type: "architect",
  prompt: """
    Design implementation for: [REQUEST]

    1. Check context.json for architectureRef
       → IF exists: Read it and FOLLOW its patterns
       → Confirm: "Architecture Reference: [path] (v[N]) ✅"

    2. Read [SCOPE]/package.json for stack
    3. Write .clean-claude/stack-skills.md (library skills for devs)
    4. Write .clean-claude/specs/design/design-v1.md with Implementation Checklist
    5. Ask user approval
  """
)
```

**Architect asks user approval. Wait for approval.**

---

## 5c. DEV + QA (parallel)

**Spawn in SAME message for parallel execution:**

```
Task(
  subagent_type: "frontend-engineer",  // or backend-engineer
  prompt: """
    Implement from design: .clean-claude/specs/design/design-v1.md
    Read stack-skills: .clean-claude/stack-skills.md
    Follow Implementation Checklist EXACTLY.
    Output: FILES CREATED table.
  """
)

Task(
  subagent_type: "qa-engineer",
  prompt: """
    Write E2E tests from spec: .clean-claude/specs/functional/spec-v1.md
    Cover ALL acceptance criteria.
  """
)
```

---

# STEP 6: VERIFY

```
1. Run: npm test (or project's test command)
2. Run: npm run build (or project's build command)

IF all green → GO TO STEP 7
IF failures → ROUTE to appropriate agent
```

## Fix Loop Routing

| Error Type | Route To |
|------------|----------|
| Test failure in src/ | Dev (frontend or backend) |
| Test failure in e2e/ | QA |
| Type error | Architect (design issue) |
| Spec unclear | PO |

**Loop until all green.**

---

# STEP 7: ARCHITECTURE CAPTURE (if no reference existed)

**Only if `architectureRef` was null at start:**

```
AskUserQuestion:
  "Implementation complete. Capture as architecture reference?"

  Options:
  - Yes, capture patterns
  - No, skip
```

**If YES:**
```
Task(
  subagent_type: "architect",
  prompt: """
    Capture architecture patterns from this implementation.

    Output: [SCOPE]/ARCHITECTURE.md with frontmatter:
    ---
    clean-claude: architecture-reference
    version: 1
    ---

    Include: folder structure, naming conventions, patterns used.
  """
)
```

**This becomes the reference for future features in this scope.**

---

# REACTIVE NOTIFICATIONS

Agents notify each other:

| From | To | When |
|------|-----|------|
| QA | Dev | "🔴 Test failed: [file:line]" |
| Dev | QA | "✅ Fixed, please re-test" |
| Dev | Architect | "❓ Design unclear: [question]" |
| Architect | Dev | "📐 Design updated: [change]" |
| Any | PO | "❓ Spec unclear: [question]" |

---

# OWNERSHIP

| Location | Owner |
|----------|-------|
| src/**/*.ts | Dev |
| src/**/*.test.ts | Dev |
| e2e/** | QA |
| .clean-claude/specs/functional/ | PO |
| .clean-claude/specs/design/ | Architect |
| .clean-claude/stack-skills.md | Architect |

**You wrote it? You fix it.**

---

# PARALLEL EXECUTION

**Independent tasks = spawn in SAME message**

```
// Good: parallel
Task(frontend-engineer, "Wave 1: types/")
Task(frontend-engineer, "Wave 1: hooks/")
Task(qa-engineer, "E2E tests")

// Bad: sequential (don't do this for independent tasks)
Task(frontend-engineer, "Wave 1: types/")
// wait
Task(frontend-engineer, "Wave 1: hooks/")
```

---

# AGENT OUTPUTS

**Devs MUST output:**
```
## ✅ FILES CREATED
| File | Test | Status |
|------|------|--------|

## ❌ FILES NOT CREATED (if any)
| File | Reason |

## 📊 WAVE COMPLETION: X/Y files (Z%)
```

**This lets Claude track progress and spawn more agents if needed.**

---

# DESIGN COVERAGE — BLOCKING

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🚨 BEFORE DECLARING "COMPLETE" — VERIFY 100% COVERAGE                  ║
║                                                                           ║
║   1. Read design.md → Implementation Checklist                           ║
║   2. For EACH file in checklist:                                         ║
║      → Check file EXISTS                                                 ║
║      → Check file has TEST (*.test.ts)                                   ║
║   3. Calculate: created / total = X%                                     ║
║                                                                           ║
║   IF < 100%:                                                              ║
║      → Show: "⚠️ Implementation Incomplete: X/Y files (Z%)"             ║
║      → List missing files                                                ║
║      → Spawn dev agents for missing files                                ║
║      → Loop until 100%                                                   ║
║                                                                           ║
║   ONLY AT 100% → Proceed to VERIFY step                                  ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

**Incomplete implementation = NOT DONE. Never skip this check.**

---

# SUMMARY

```
/craft
  │
  ├─ Step 1: Claude detects project + arch ref → context.json
  │
  ├─ Step 2: Scope (if monorepo)
  │
  ├─ Step 3-4: Choose + QA Config
  │
  ├─ Step 5a: PO (if feature) → User approves spec
  │
  ├─ Step 5b: Architect reads arch ref + skills + design → User approves
  │
  ├─ Step 5c: Dev + QA implement (parallel)
  │
  ├─ Step 6: Verify → Fix loop → Green
  │
  └─ Step 7: Capture as arch ref (if none existed)
```

**No learning-agent. Claude orchestrates. Agents execute.**
