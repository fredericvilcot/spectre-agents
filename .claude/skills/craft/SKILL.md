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

# RULES — READ BEFORE ANYTHING

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🚫 FORBIDDEN IN /craft:                                                ║
║                                                                           ║
║   ❌ Bash for file exploration (use Read, Glob, Grep ONLY)              ║
║   ❌ Explore agent (NEVER spawn Explore — Claude explores directly)      ║
║   ❌ Skipping steps or reordering the flow                              ║
║   ❌ Analyzing code before asking the user what they want               ║
║   ❌ Making assumptions about the feature without asking                ║
║                                                                           ║
║   ✅ ONLY USE: Read, Glob, Grep, Write, Task, AskUserQuestion           ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

# FLOW OVERVIEW

```
Step 1: DETECT       Claude: Read + Glob → context.json
Step 2: SCOPE        If monorepo → ask user
Step 3: CHOOSE       "What do you want to craft?" + describe it
Step 4: QA CONFIG    "E2E tests?" → yes/no
Step 5: ROUTE        PO → Architect → Dev + QA
Step 6: VERIFY       Tests → fix loop → green
Step 7: CAPTURE      Architecture reference (if none existed)
```

---

# STEP 1: DETECT (Claude does this directly)

**DO NOT spawn any agent. DO NOT use Bash. Claude does this with Read/Glob/Grep only.**

```
1. Read("package.json")
2. Glob("{lerna,nx,turbo}.json,pnpm-workspace.yaml")
3. IF monorepo: Glob("apps/*,packages/*,modules/*")
4. Grep("clean-claude: architecture-reference", "**/*.md")
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
  "architectureRef": null
}
```

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
→ GO TO STEP 3 IMMEDIATELY
```

**DO NOT re-analyze. DO NOT read scope's package.json. Just save scope and continue.**

---

# STEP 3: CHOOSE + DESCRIBE

**Two questions in this step:**

**Question 1: What type?**
```
AskUserQuestion:
  "What do you want to craft?"
  Options:
  - New feature
  - Refactor
  - Fix bug
  - Add tests
```

**Question 2: Describe it + spec?**
```
AskUserQuestion:
  "Describe what you want. Do you have an existing spec or reference?"
  Options:
  - I have a spec (give me the path)
  - I have a legacy app to migrate (give me the path)
  - I'll describe it now
  - Let the PO write the spec from scratch
```

**IF user provides a spec path → READ IT. Pass it to PO as input.**
**IF user provides a legacy app → READ IT. Pass it to PO as context.**

**DO NOT start exploring code on your own. Ask the user first.**

---

# STEP 4: QA CONFIG

```
AskUserQuestion:
  "Do you want QA tests?"
  Options:
  - E2E tests (Playwright)
  - Integration tests
  - Unit + Integration (Dev writes them)
  - No QA (unit tests only)
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
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   PO RULES — CRITICAL                                                    ║
║                                                                           ║
║   1. ENGLISH ONLY — All specs in English                                 ║
║   2. NO TECH — Zero technical details (no API endpoints, no code,        ║
║      no enums, no DB schemas, no framework names)                        ║
║   3. FUNCTIONAL ONLY — User stories, behaviors, business rules           ║
║   4. Endpoints/API = ARCHITECT'S JOB, never PO's                        ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

**IF user provided an existing spec:**
```
Task(
  subagent_type: "product-owner",
  prompt: """
    ENRICH this existing spec: [SPEC_PATH]
    Read it, then ENRICH with missing functional requirements.

    IF there is legacy code at [LEGACY_PATH]:
      → Read it to find ALL features
      → Add EVERY missing feature to the spec

    RULES:
    - Write in ENGLISH
    - PURELY FUNCTIONAL — no API endpoints, no code, no tech details
    - User stories with Given/When/Then acceptance criteria
    - Output: .clean-claude/specs/functional/spec-v[N].md
    - Ask user approval before finalizing
  """
)
```

**IF no existing spec:**
```
Task(
  subagent_type: "product-owner",
  prompt: """
    Write functional spec for: [USER_DESCRIPTION]

    RULES:
    - Write in ENGLISH
    - PURELY FUNCTIONAL — no API endpoints, no code, no tech details
    - User stories with Given/When/Then acceptance criteria
    - Output: .clean-claude/specs/functional/spec-v1.md
    - Ask user approval before finalizing
  """
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

    Spec: .clean-claude/specs/functional/spec-v[N].md

    1. Check context.json for architectureRef
       → IF exists: Read it and FOLLOW its patterns
       → Confirm: "Architecture Reference: [path] (v[N]) ✅"

    2. Read [SCOPE]/package.json for stack
    3. Write .clean-claude/stack-skills.md (library skills for devs)
    4. Write .clean-claude/specs/design/design-v1.md with:
       - Architecture decisions
       - File structure
       - API endpoints / routes (if applicable)
       - Implementation Checklist (MANDATORY — every file to create/modify)
       - Execution Plan (waves for parallelization)
    5. Ask user approval
  """
)
```

**Architect asks user approval. Wait for approval.**

> Note: API endpoints, routes, tech specs = Architect's job, NOT PO's.

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
  subagent_type: "qa-engineer",  // only if QA enabled
  prompt: """
    Write tests from spec: .clean-claude/specs/functional/spec-v[N].md
    Cover ALL acceptance criteria.
  """
)
```

---

# STEP 6: VERIFY

```
1. Check DESIGN COVERAGE (100% of Implementation Checklist)
2. Run: npm test (or project's test command)
3. Run: npm run build (or project's build command)

IF all green → GO TO STEP 7
IF failures → ROUTE to appropriate agent
```

## Design Coverage Check

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
║      → Spawn dev agents for missing files                                ║
║      → Loop until 100%                                                   ║
║                                                                           ║
║   ONLY AT 100% → Proceed to test verification                            ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
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

**If YES → Architect captures patterns into ARCHITECTURE.md**

---

# REACTIVE NOTIFICATIONS

| From | To | When |
|------|-----|------|
| QA | Dev | "🔴 Test failed: [file:line]" |
| Dev | QA | "✅ Fixed, please re-test" |
| Dev | Architect | "❓ Design unclear: [question]" |
| Architect | Dev | "📐 Design updated: [change]" |
| Any | PO | "❓ Spec unclear: [question]" |

**You wrote it? You fix it.**

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

---

# PARALLEL EXECUTION

**Independent tasks = spawn in SAME message**

```
// Good: parallel (independent files)
Task(frontend-engineer, "Wave 1: types/")
Task(frontend-engineer, "Wave 1: hooks/")
Task(qa-engineer, "E2E tests")

// Bad: sequential for independent work
Task(frontend-engineer, "Wave 1: types/")
// wait...
Task(frontend-engineer, "Wave 1: hooks/")
```

---

# SUMMARY

```
/craft
  │
  ├─ Step 1: Claude detects project (Read/Glob only) → context.json
  │
  ├─ Step 2: Scope (if monorepo) → save and continue
  │
  ├─ Step 3: Choose + Describe (spec? legacy? from scratch?)
  │
  ├─ Step 4: QA Config
  │
  ├─ Step 5a: PO enriches/writes spec (ENGLISH, no tech) → User approves
  │
  ├─ Step 5b: Architect: skills + design + endpoints → User approves
  │
  ├─ Step 5c: Dev + QA implement (parallel)
  │
  ├─ Step 6: Coverage 100% + Tests green + Build OK → Fix loop
  │
  └─ Step 7: Capture as arch ref (if none existed)
```

**No learning-agent. No Explore agent. Claude orchestrates. Agents execute.**
