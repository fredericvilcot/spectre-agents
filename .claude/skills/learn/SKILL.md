---
name: learn
description: "Re-run stack detection and skill generation. Use when stack evolved or on first run."
context: conversation
allowed-tools: Read, Bash, Glob, Grep, Write, Task, AskUserQuestion
---

# Clean Claude Learn — Stack & Architecture Learning

> **CLEAN CLAUDE CODE OF CONDUCT APPLIES** — See CLAUDE.md
> - Mandatory stack: TypeScript + React + TanStack Query
> - All generated skills follow Software Craft principles
> - REFUSE to learn from code smells

**Claude orchestrates. Architect generates skills. No separate learning agent.**

---

## Commands

```
/learn                      # Learn everything (stack + architecture)
/learn stack                # Stack only (libraries)
/learn architecture         # Architecture only (project patterns)
/learn <url|path>           # Analyze external source (GitHub URL or folder)
```

---

## ORCHESTRATION MODEL

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🧠 CLAUDE ORCHESTRATES — NO LEARNING AGENT                             ║
║                                                                           ║
║   Claude does the detection (Read, Glob, Grep).                          ║
║   Claude spawns Architect for skills generation.                         ║
║   Claude spawns Architect for architecture capture.                      ║
║                                                                           ║
║   WHY: Detection is fast (< 5 sec, no agent needed).                    ║
║   Skills generation needs Architect's expertise.                        ║
║   Architecture capture needs Architect's judgement.                     ║
║                                                                           ║
║   STACK: TypeScript + React + TanStack Query (mandatory)                ║
║   + additional libraries detected from package.json                     ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## What Gets Learned

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🎯 TWO TYPES OF LEARNING                                               ║
║                                                                           ║
║   1. STACK LEARNING (libraries)                                          ║
║      → Claude detects installed libraries (package.json)                 ║
║      → Claude spawns Architect for CRAFT-linked skills                   ║
║      → Output: specs/stack/stack-skills.md (COMMITTED)                   ║
║                                                                           ║
║   2. ARCHITECTURE LEARNING (project patterns)                            ║
║      → Claude analyzes existing code structure (Glob/Grep)               ║
║      → Claude validates CRAFT compliance                                ║
║      → Claude spawns Architect for architecture guide                    ║
║      → Output: ARCHITECTURE.md with frontmatter flag (COMMITTED)         ║
║                                                                           ║
║   ═══════════════════════════════════════════════════════════════════    ║
║                                                                           ║
║   🚫 NEVER LEARN FROM CODE SMELLS                                        ║
║                                                                           ║
║   Claude VALIDATES code before spawning Architect:                      ║
║   • Checks for `any` types → REJECT                                     ║
║   • Checks for `throw` without Result → REJECT                          ║
║   • Checks for spaghetti architecture → REJECT                          ║
║   • Checks for missing tests → WARN                                     ║
║                                                                           ║
║   If code is NOT CRAFT-compliant → Report issues, DON'T learn patterns  ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## /learn (no args) — Learn Everything

**Default behavior: stack + architecture (if code exists)**

```
/learn
  │
  ├─ 1. STACK DETECTION (Claude — Read/Glob)
  │     → Read package.json (root + workspaces)
  │     → Extract library list beyond mandatory stack
  │     → Spawn Architect for library skills
  │     → Output: specs/stack/stack-skills.md
  │
  └─ 2. ARCHITECTURE DETECTION (Claude — Glob/Grep)
        → Analyze code structure
        → VALIDATE CRAFT compliance
        │
        ├─ CRAFT-compliant → Spawn Architect for architecture guide
        │     → Output: ARCHITECTURE.md
        │
        └─ NOT CRAFT-compliant → Report issues
              → List violations
              → Suggest /craft "Refactor" to fix
              → DO NOT learn anti-patterns
```

### Step 1: Stack Detection (Claude does this directly)

```
1. Read package.json (root)
   → IF monorepo: also read apps/*/package.json, packages/*/package.json

2. Extract ALL dependencies + devDependencies
   → Mandatory (skip in skills — hardcoded in templates/):
     react, react-dom, @tanstack/react-query, typescript

   → Additional libs to learn (project-specific):
     react-router-dom, zustand, zod, tailwindcss, @tanstack/react-table,
     msw, playwright, i18next, date-fns, etc.

3. Write to .clean-claude/context.json:
   {
     "project": {
       "type": "frontend | monorepo",
       "language": "typescript",
       "stackGuard": "pass",
       "additionalLibs": ["react-router-dom", "zustand", ...]
     }
   }

4. IF additional libs found → Spawn Architect for skills:
```

```
Task(
  subagent_type: "architect",
  prompt: """
    🔔 STACK SKILLS GENERATION

    ## YOUR TASK
    Generate CRAFT-linked skills for the project's additional libraries.

    ## MANDATORY STACK (ALREADY HANDLED — DO NOT REGENERATE)
    React, TypeScript, TanStack Query skills are HARDCODED in
    .claude/templates/mandatory-stack-skills.md
    → Read it, COPY as-is into the FIRST section of stack-skills.md

    ## ADDITIONAL LIBRARIES TO DOCUMENT
    [LIST from context.json additionalLibs]

    ## FOR EACH ADDITIONAL LIBRARY
    Generate CRAFT-linked skills following the format in your agent file:
    - CRAFT Principles Table
    - Mandatory Patterns
    - Best Practices (Official + Community)
    - Anti-Patterns to AVOID
    - Code Examples (✅ vs ❌)

    ## OUTPUT
    Write specs/stack/stack-skills.md:
    1. FIRST section = mandatory-stack-skills.md (copied as-is)
    2. THEN one section per additional library

    (CRAFT rules and tool restrictions are enforced by hooks)
  """
)
```

### Step 2: Architecture Detection (Claude does this directly)

```
1. Check if src/ exists (Glob)
   → No src/ → Skip architecture learning

2. VALIDATE CRAFT compliance (Claude — Grep):

   CHECK 1: TypeScript Strictness
   Grep(":\s*any\b|as\s+any\b", glob="*.ts,*.tsx")
   → 0 matches = ✅ | matches = ❌ "X files use any"

   CHECK 2: Error Handling
   Grep("throw\s+new\b", glob="*.ts,*.tsx")
   + Grep("Result<|Either<", glob="*.ts,*.tsx")
   → Has Result/Either = ✅ | Only throw = ❌

   CHECK 3: Architecture Layering
   Glob("src/domain/**") or Glob("src/core/**")
   → Clear layers = ✅ | No separation = ⚠️

   CHECK 4: Test Presence
   Glob("**/*.test.ts") count vs Glob("src/**/*.ts") count
   → > 50% = ✅ | < 50% = ⚠️ | 0 = ❌

3. IF COMPLIANT (✅ or ⚠️ only):
   → Spawn Architect for architecture capture
   → Output: ARCHITECTURE.md

4. IF NOT COMPLIANT (any ❌):
   → Show violations to user
   → Suggest /craft "Refactor" to fix
   → DO NOT spawn Architect for architecture guide
```

```
Task(
  subagent_type: "architect",
  prompt: """
    🔔 ARCHITECTURE CAPTURE

    ## YOUR TASK
    Analyze the implemented code and document the architecture patterns.

    ## WHAT TO ANALYZE (use Read/Glob/Grep — NEVER Bash)
    - Folder structure conventions
    - Naming patterns (entities, hooks, components, services)
    - Layer boundaries (domain → application → infrastructure → UI)
    - Error handling patterns (Result<T,E> usage)
    - Test organization (colocated, integration, e2e)
    - Key architectural decisions

    ## OUTPUT
    Write {SCOPE}/ARCHITECTURE.md with frontmatter:

    ---
    clean-claude: architecture-reference
    version: 1
    created: [today]
    updated: [today]
    approved-by: user
    ---

    Sections:
    - Architecture pattern (hexagonal variant chosen)
    - Folder structure convention
    - Naming conventions table
    - Error handling patterns (Result<T,E> examples from actual code)
    - Testing patterns
    - Layer dependencies diagram
    - Key decisions (ADR style)

    This becomes the REFERENCE for ALL future features.

    (CRAFT rules and tool restrictions are enforced by hooks)
  """
)
```

---

## /learn stack — Libraries Only

**Focus on installed libraries, skip architecture analysis.**

```
/learn stack
  │
  └─ Claude: Read package.json → extract libs → spawn Architect for skills
     → Output: specs/stack/stack-skills.md
```

**Claude executes Step 1 only (see above). No architecture analysis.**

---

## /learn architecture — Project Patterns Only

**Focus on extracting CRAFT-compliant patterns from existing code.**

```
/learn architecture
  │
  └─ Claude: Glob/Grep for CRAFT validation → spawn Architect if compliant
     → Output: ARCHITECTURE.md
```

**Claude executes Step 2 only (see above). No stack detection.**

---

## /learn <url|path> — External Source Analysis

**Analyze external code (GitHub repo or folder) for CRAFT patterns.**

```
/learn https://github.com/org/repo
  │
  └─ EXTERNAL ANALYSIS
       │
       ├─ Clone repo to temp folder (Bash: git clone --depth 1)
       │
       ├─ Claude validates CRAFT compliance (Grep)
       │     │
       │     ├─ CRAFT-compliant → Extract patterns
       │     │     → Generate analysis report
       │     │     → List patterns worth adopting
       │     │
       │     └─ NOT CRAFT-compliant → Report issues
       │           → "This repo has X violations"
       │           → "Not recommended as reference"
       │
       └─ Output: .clean-claude/external-analysis.md
```

### URL Detection

```
IF args STARTS WITH "http" OR "https" OR "github.com":
  → External GitHub repo
  → Bash: git clone --depth 1 <url> /tmp/clean-claude-analysis
  → Analyze with Glob/Grep in temp folder
  → Cleanup: Bash: rm -rf /tmp/clean-claude-analysis

IF args IS a path (starts with "/" or "./" or relative folder name):
  → Local folder analysis
  → Analyze in place with Glob/Grep
  → DO NOT modify the external folder
```

### Execution (External)

```
1. Clone/access the source

2. Claude validates CRAFT compliance (same checks as /learn architecture):
   → Grep for `any`, `throw`, check layers, check tests

3. Write .clean-claude/external-analysis.md:

   IF CRAFT-COMPLIANT:
   ---
   # External Analysis: <repo name>
   ## Summary: ✅ CRAFT-compliant
   ## Patterns Worth Adopting
   ## File Organization
   ## Recommended for: [use cases]
   ---

   IF NOT CRAFT-COMPLIANT:
   ---
   # External Analysis: <repo name>
   ## Summary: ⚠️ NOT CRAFT-compliant
   ## Violations Found (X `any`, Y `throw`, Z missing tests)
   ## What Can Be Learned (with caution)
   ## Recommendation: Do NOT use as architecture reference.
   ---

4. Cleanup temp folder if cloned
```

---

## Output Files

```
specs/                                    # COMMITTED ✅
├── stack/
│   └── stack-skills.md                   # Library skills (mandatory + project-specific)
└── ...

{SCOPE}/ARCHITECTURE.md                   # COMMITTED ✅ (architecture reference)

.clean-claude/                             # GITIGNORED
├── context.json                           # Detection cache
└── external-analysis.md                   # External repo report (temporary)
```

---

## Automatic in /craft

Learning runs automatically at `/craft` Step 5b (Architect generates skills WITH the design):

```
/craft
   │
   ├─ Step 1: Detect (Claude: package.json → context.json)
   │          NO skills generated yet — too early
   │
   ├─ Step 5b: Architect
   │   │
   │   ├─ Reads .claude/templates/mandatory-stack-skills.md (hardcoded)
   │   ├─ Generates skills for ADDITIONAL libs only
   │   ├─ Writes specs/stack/stack-skills.md
   │   └─ Writes specs/design/design-v1.md
   │
   └─ /learn is for MANUAL re-runs or external analysis
```

**Use `/learn` only to re-run manually or analyze external sources.**

---

## Enterprise Scale (Monorepo / Modular Monolith)

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🏢 ENTERPRISE: /learn in Monorepo Context                              ║
║                                                                           ║
║   /learn scans the SCOPED workspace (from context.json):                ║
║                                                                           ║
║   Monorepo:                                                               ║
║   ├── apps/dashboard/package.json  ← scoped /learn reads THIS           ║
║   ├── apps/admin/package.json                                            ║
║   ├── packages/ui/package.json     ← shared lib, also detectable        ║
║   └── packages/domain/package.json ← shared domain                      ║
║                                                                           ║
║   /learn (no scope) → reads ROOT package.json + all workspaces          ║
║   /learn (with scope) → reads SCOPED package.json only                  ║
║                                                                           ║
║   Architecture reference is PER-PROJECT (not per-workspace):             ║
║   → One ARCHITECTURE.md at root or at scope level                       ║
║   → ALL apps follow the SAME patterns                                   ║
║   → Consistency across 40+ developers                                   ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## CRAFT Validation Checks

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🔍 VALIDATION CHECKS (Claude runs these with Grep/Glob)               ║
║                                                                           ║
║   CHECK 1: TypeScript Strictness                                         ║
║   Grep(": any\\b|as any\\b", glob="*.ts,*.tsx")                          ║
║   → 0 matches = ✅ PASS                                                  ║
║   → Any matches = ❌ FAIL ("X files use `any` type")                     ║
║                                                                           ║
║   CHECK 2: Error Handling                                                 ║
║   Grep("throw new\\b", glob="*.ts,*.tsx")                                ║
║   + Grep("Result<|Either<", glob="*.ts,*.tsx")                           ║
║   → Has Result/Either = ✅ PASS                                          ║
║   → Only throw = ❌ FAIL ("Uses throw instead of Result")                ║
║                                                                           ║
║   CHECK 3: Architecture Layering                                          ║
║   Glob("src/domain/**") or Glob("src/core/**")                           ║
║   → Clear layers = ✅ PASS                                               ║
║   → No separation = ⚠️ WARN ("No clear architecture")                    ║
║                                                                           ║
║   CHECK 4: Test Presence                                                  ║
║   Glob("**/*.test.ts") count vs Glob("src/**/*.ts") count                ║
║   → > 50% ratio = ✅ PASS                                                ║
║   → < 50% ratio = ⚠️ WARN ("Low test coverage")                         ║
║   → 0 tests = ❌ FAIL ("No tests")                                       ║
║                                                                           ║
║   RESULT THRESHOLDS                                                       ║
║   ✅ CRAFT-COMPLIANT: All checks pass or only warnings                   ║
║   ⚠️ PARTIALLY COMPLIANT: Warnings but no failures                       ║
║   ❌ NOT COMPLIANT: Any check fails                                      ║
║                                                                           ║
║   Only ✅ and ⚠️ → patterns extracted. ❌ → violation report ONLY.       ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## Summary

| Command | Claude Does | Spawns | Output |
|---------|-------------|--------|--------|
| `/learn` | Read pkg, Grep validation | Architect (skills + arch) | stack-skills.md + ARCHITECTURE.md |
| `/learn stack` | Read pkg | Architect (skills) | stack-skills.md |
| `/learn architecture` | Grep validation | Architect (arch capture) | ARCHITECTURE.md |
| `/learn <url>` | Clone + Grep validation | — | external-analysis.md |
| `/learn <path>` | Grep validation | — | external-analysis.md |

---

## CRITICAL: No Code Smell Learning

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🚫 THE LEARNING PROCESS REFUSES TO LEARN ANTI-PATTERNS                 ║
║                                                                           ║
║   If code is NOT CRAFT-compliant:                                        ║
║   ❌ DO NOT extract "patterns" from it                                   ║
║   ❌ DO NOT use it as reference for future code                          ║
║   ❌ DO NOT generate ARCHITECTURE.md                                     ║
║                                                                           ║
║   Instead:                                                                ║
║   ✅ Report all violations found                                         ║
║   ✅ Suggest /craft "Refactor" to fix                                    ║
║   ✅ Offer to help migrate to CRAFT                                      ║
║                                                                           ║
║   CRAFT PRINCIPLES > EXISTING CODE                                        ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```
