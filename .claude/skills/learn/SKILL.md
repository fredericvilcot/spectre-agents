---
name: learn
description: "Re-run stack detection and skill generation. Use when stack evolved or on first run."
context: conversation
allowed-tools: Read, Bash, Glob, Grep, Write, Task
---

# Clean Claude Learn — Stack & Architecture Learning

> **CLEAN CLAUDE CODE OF CONDUCT APPLIES** — See CLAUDE.md
> - No non-CRAFT code, no anti-CRAFT requests, no inappropriate behavior
> - All generated skills follow Software Craft principles
> - REFUSE to learn from code smells

**Detect stack. Learn architecture. Architect generates skills. All CRAFT-validated.**

---

## Commands

```
/learn                      # Learn everything (stack + architecture)
/learn stack                # Stack only (libraries)
/learn architecture         # Architecture only (project patterns)
/learn <url|path>           # Analyze external source (GitHub URL or folder)
```

---

## What Gets Learned

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🎯 TWO TYPES OF LEARNING                                               ║
║                                                                           ║
║   ═══════════════════════════════════════════════════════════════════    ║
║                                                                           ║
║   1. STACK LEARNING (libraries)                                          ║
║      → Detects installed libraries (package.json, go.mod, etc.)         ║
║      → Architect generates CRAFT-linked skills                          ║
║      → Output: specs/stack/stack-skills.md                            ║
║                                                                           ║
║   2. ARCHITECTURE LEARNING (project patterns)                            ║
║      → Analyzes existing code structure                                  ║
║      → Extracts CRAFT-compliant patterns ONLY                           ║
║      → Output: .clean-claude/architecture-guide.md                       ║
║                                                                           ║
║   ═══════════════════════════════════════════════════════════════════    ║
║                                                                           ║
║   🚫 NEVER LEARN FROM CODE SMELLS                                        ║
║                                                                           ║
║   The learning process VALIDATES code before extracting patterns:       ║
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
  ├─ 1. STACK DETECTION
  │     → Learning Agent reads package.json
  │     → Spawns Architect for library skills
  │     → Output: specs/stack/stack-skills.md
  │
  └─ 2. ARCHITECTURE DETECTION (if src/ exists)
        → Learning Agent analyzes code structure
        → VALIDATES CRAFT compliance first
        │
        ├─ CRAFT-compliant → Extract patterns
        │     → Spawns Architect for architecture guide
        │     → Output: .clean-claude/architecture-guide.md
        │
        └─ NOT CRAFT-compliant → Report issues
              → List violations
              → Suggest /craft "Refactor" to fix
              → DO NOT learn anti-patterns
```

### Execution

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    LEARN EVERYTHING (stack + architecture)

    MODE: full

    1. STACK LEARNING
       → Read package.json/go.mod/etc.
       → Write .clean-claude/context.json
       → Spawn Architect for library skills
       → Output: specs/stack/stack-skills.md

    2. ARCHITECTURE LEARNING (if src/ exists)
       → Analyze folder structure
       → VALIDATE CRAFT compliance FIRST
       → If compliant: Spawn Architect for architecture guide
       → If NOT compliant: Report violations, suggest fixes
       → Output: .clean-claude/architecture-guide.md (if compliant)

    OUTPUT progress to user.
  """
)
```

---

## /learn stack — Libraries Only

**Focus on installed libraries, skip architecture analysis.**

```
/learn stack
  │
  └─ STACK DETECTION
       → Learning Agent reads package.json
       → Spawns Architect for library skills
       → Output: specs/stack/stack-skills.md
```

### Execution

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    LEARN STACK ONLY

    MODE: stack

    1. Read package.json/go.mod/Cargo.toml/pyproject.toml
    2. Extract library list
    3. Write .clean-claude/context.json
    4. Spawn Architect for library skills
    5. Output: specs/stack/stack-skills.md

    DO NOT analyze architecture.
    OUTPUT progress to user.
  """
)
```

---

## /learn architecture — Project Patterns Only

**Focus on extracting CRAFT-compliant patterns from existing code.**

```
/learn architecture
  │
  └─ ARCHITECTURE DETECTION
       │
       ├─ VALIDATE CRAFT compliance
       │
       ├─ CRAFT-compliant?
       │     → Extract patterns
       │     → File organization
       │     → Naming conventions
       │     → Layer boundaries
       │     → Result<T,E> usage
       │     → Test structure
       │
       └─ Output: .clean-claude/architecture-guide.md
```

### Execution

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    LEARN ARCHITECTURE ONLY

    MODE: architecture

    1. VALIDATE CRAFT compliance in src/
       → Check for `any` types
       → Check for `throw` without Result
       → Check for proper layering
       → Check for test presence

    2. IF COMPLIANT:
       → Analyze folder structure
       → Extract naming conventions
       → Extract layer patterns (domain, infra, ui)
       → Extract Result<T,E> patterns
       → Extract test organization
       → Spawn Architect for architecture guide
       → Output: .clean-claude/architecture-guide.md

    3. IF NOT COMPLIANT:
       → List all violations
       → Suggest /craft "Refactor" with specific targets
       → DO NOT generate architecture-guide.md

    OUTPUT progress to user.
  """
)
```

---

## /learn <url|path> — External Source Analysis

**Analyze external code (GitHub repo or folder) for CRAFT patterns.**

```
/learn https://github.com/org/repo
  │
  └─ EXTERNAL ANALYSIS
       │
       ├─ Clone repo to temp folder
       │
       ├─ VALIDATE CRAFT compliance
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
  → Clone to temp, analyze, cleanup

IF args IS a path (starts with "/" or "./" or relative folder name):
  → Local folder analysis
  → Analyze in place
```

### Execution (GitHub URL)

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    ANALYZE EXTERNAL SOURCE

    MODE: external
    SOURCE: https://github.com/org/repo

    1. CLONE to temp folder
       git clone --depth 1 <url> /tmp/clean-claude-analysis-<random>

    2. VALIDATE CRAFT compliance
       → Check for `any` types
       → Check for `throw` without Result
       → Check for proper layering
       → Check for test presence

    3. GENERATE REPORT (.clean-claude/external-analysis.md)

       IF CRAFT-COMPLIANT:
       ```
       # External Analysis: <repo name>

       ## Summary
       ✅ CRAFT-compliant repository

       ## Patterns Worth Adopting
       - [pattern 1]
       - [pattern 2]

       ## File Organization
       <structure>

       ## Recommended for: [use cases]
       ```

       IF NOT CRAFT-COMPLIANT:
       ```
       # External Analysis: <repo name>

       ## Summary
       ⚠️ NOT CRAFT-compliant — NOT recommended as reference

       ## Violations Found
       - X files with `any` types
       - Y functions using `throw`
       - Z missing test coverage

       ## What Can Be Learned (with caution)
       - [non-anti-pattern elements]

       ## Recommendation
       Do NOT use as architecture reference.
       Consider CRAFT-compliant alternatives.
       ```

    4. CLEANUP temp folder

    OUTPUT progress to user.
  """
)
```

### Execution (Local Folder)

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    ANALYZE EXTERNAL SOURCE

    MODE: external
    SOURCE: /path/to/folder

    1. VALIDATE folder exists and has code

    2. VALIDATE CRAFT compliance
       → Check for `any` types
       → Check for `throw` without Result
       → Check for proper layering
       → Check for test presence

    3. GENERATE REPORT (.clean-claude/external-analysis.md)
       [Same format as GitHub analysis]

    DO NOT modify the external folder.
    OUTPUT progress to user.
  """
)
```

---

## CRAFT Validation — What Gets Checked

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   🔍 VALIDATION CHECKS (Learning Agent runs these)                       ║
║                                                                           ║
║   ════════════════════════════════════════════════════════════════════   ║
║                                                                           ║
║   CHECK 1: TypeScript Strictness                                         ║
║   ──────────────────────────────                                         ║
║   grep -r ": any" --include="*.ts" --include="*.tsx"                     ║
║   grep -r "as any" --include="*.ts" --include="*.tsx"                    ║
║   → 0 matches = ✅ PASS                                                  ║
║   → Any matches = ❌ FAIL ("X files use `any` type")                     ║
║                                                                           ║
║   CHECK 2: Error Handling                                                 ║
║   ───────────────────────                                                 ║
║   grep -r "throw new" --include="*.ts" --include="*.tsx"                 ║
║   + Check for Result<T,E> or Either usage                                ║
║   → Has Result/Either = ✅ PASS                                          ║
║   → Only throw = ❌ FAIL ("Uses throw instead of Result")                ║
║                                                                           ║
║   CHECK 3: Architecture Layering                                          ║
║   ──────────────────────────────                                          ║
║   Look for: domain/, application/, infrastructure/, ui/                  ║
║   OR: core/, services/, adapters/, ports/                                ║
║   → Clear layers = ✅ PASS                                               ║
║   → No separation = ⚠️ WARN ("No clear architecture")                    ║
║                                                                           ║
║   CHECK 4: Test Presence                                                  ║
║   ─────────────────────                                                   ║
║   Count *.test.ts, *.spec.ts files                                       ║
║   Compare to *.ts files (ratio)                                          ║
║   → > 50% coverage = ✅ PASS                                             ║
║   → < 50% coverage = ⚠️ WARN ("Low test coverage")                       ║
║   → 0 tests = ❌ FAIL ("No tests")                                       ║
║                                                                           ║
║   ════════════════════════════════════════════════════════════════════   ║
║                                                                           ║
║   RESULT THRESHOLDS                                                       ║
║                                                                           ║
║   ✅ CRAFT-COMPLIANT: All checks pass or only warnings                   ║
║   ⚠️ PARTIALLY COMPLIANT: Warnings but no failures                       ║
║   ❌ NOT COMPLIANT: Any check fails                                      ║
║                                                                           ║
║   Only ✅ and ⚠️ can have patterns extracted.                            ║
║   ❌ generates violation report ONLY.                                    ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## Output Files

```
.clean-claude/
├── context.json              # Detected libraries (gitignored)
├── stack-skills.md           # Library documentation (gitignored)
├── external-analysis.md      # External source report (gitignored)
│
└── architecture-guide.md     # Project patterns — COMMITTED ✅
                              # (shared reference for all µApps)
```

**architecture-guide.md is COMMITTED** — it's the shared reference architecture for the entire team and all future features.

### architecture-guide.md Example

```markdown
# Architecture Guide

> Extracted from this project. CRAFT-validated.

## File Organization

```
src/
├── domain/           # Pure business logic (no imports from infra)
│   ├── entities/
│   ├── value-objects/
│   └── services/
├── application/      # Use cases, orchestration
│   └── use-cases/
├── infrastructure/   # External world (DB, APIs, etc.)
│   ├── repositories/
│   └── adapters/
└── ui/               # Presentation (React, CLI, etc.)
    ├── components/
    └── pages/
```

## Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Entity | PascalCase | `User`, `Order` |
| Value Object | PascalCase | `Email`, `Money` |
| Service | PascalCase + suffix | `OrderService` |
| Repository | PascalCase + suffix | `UserRepository` |
| Use Case | Verb + Noun | `CreateOrder`, `GetUserById` |

## Result<T, E> Usage

```typescript
// All operations that can fail return Result
type Result<T, E> = { ok: true; value: T } | { ok: false; error: E }

// Example from this project:
const createUser = (data: UserInput): Result<User, ValidationError> => {
  // ...
}
```

## Test Organization

- Unit tests: colocated `*.test.ts`
- Integration tests: `tests/integration/`
- E2E tests: `e2e/`

## Layer Dependencies

```
UI → Application → Domain ← Infrastructure
         ↓
     Infrastructure

Domain has ZERO external imports.
```
```

---

## Automatic in /craft

Learning runs automatically at `/craft` start:

```
/craft
   │
   ├─ ══════════════════════════════════
   │   LEARNING (auto)
   │   → /learn (full mode)
   │   → Stack + Architecture (if exists)
   │  ══════════════════════════════════
   │
   ├─ PO → spec
   ├─ Architect → design (uses skills + architecture)
   └─ Dev → implements
```

**Use `/learn` subcommands only to re-run manually or analyze external sources.**

---

## Summary

| Command | What It Does | Output |
|---------|--------------|--------|
| `/learn` | Everything (stack + architecture) | stack-skills.md + architecture-guide.md |
| `/learn stack` | Libraries only | stack-skills.md |
| `/learn architecture` | Project patterns only | architecture-guide.md |
| `/learn <url>` | Analyze external GitHub repo | external-analysis.md |
| `/learn <path>` | Analyze external folder | external-analysis.md |

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
║   ❌ DO NOT generate architecture-guide.md                               ║
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
