---
name: craft
description: "Craft something. Smart professional flow: spec first, then adapt. ALL agents ALWAYS run."
context: conversation
allowed-tools: Read, Bash, Task, AskUserQuestion, Glob, Grep, WebFetch, Write
---

# Spectre Craft — Professional Flow

**Spec first. Always ask. All agents run.**

---

## The Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│   /craft                                                         │
│       │                                                          │
│       ▼                                                          │
│   ┌─────────────────────────────────────┐                       │
│   │  Q1: "Do you have a spec?"          │ ← FIRST QUESTION      │
│   └─────────────────┬───────────────────┘                       │
│                     │                                            │
│            ┌────────┴────────┐                                  │
│            │                 │                                  │
│           YES               NO                                   │
│            │                 │                                  │
│            ▼                 ▼                                  │
│   ┌────────────────┐  ┌────────────────┐                       │
│   │ Q2: "Where?"   │  │ Q2: "What do   │                       │
│   │ (file/Jira/URL)│  │ you want?"     │                       │
│   └───────┬────────┘  └───────┬────────┘                       │
│           │                   │                                  │
│           │                   ▼                                  │
│           │          ┌────────────────┐                         │
│           │          │ PROJECT EXISTS?│                         │
│           │          └───────┬────────┘                         │
│           │                  │                                   │
│           │         ┌────────┴────────┐                         │
│           │         │                 │                         │
│           │        YES               NO                          │
│           │         │                 │                         │
│           │         ▼                 ▼                         │
│           │   Auto-detect      ┌────────────┐                   │
│           │   stack            │ Q3: Stack? │                   │
│           │         │          └─────┬──────┘                   │
│           │         │                │                          │
│           └─────────┴────────────────┘                          │
│                          │                                       │
│                          ▼                                       │
│   ════════════════════════════════════════════════════════════  │
│   │           MANDATORY CHAIN (ALL AGENTS)                  │   │
│   ════════════════════════════════════════════════════════════  │
│                          │                                       │
│                          ▼                                       │
│                   ┌──────────┐                                  │
│                   │    PO    │ → .spectre/spec.md               │
│                   └────┬─────┘   (validates or creates)         │
│                        │                                         │
│                        ▼                                         │
│                   ┌──────────┐                                  │
│                   │ Architect│ → .spectre/design.md             │
│                   └────┬─────┘   (CRAFT tech spec)              │
│                        │                                         │
│                        ▼                                         │
│                   ┌──────────────────┐                          │
│                   │   Dev ⇄ QA       │                          │
│                   │   (parallel)     │                          │
│                   └──────────────────┘                          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Step 1: Do You Have a Spec?

**ALWAYS ask this first.**

```
AskUserQuestion(
  questions: [{
    question: "Do you have a spec or requirements document?",
    header: "Spec",
    options: [
      { label: "Yes, I have a spec", description: "File, Jira ticket, URL, or document" },
      { label: "No, just an idea", description: "I'll describe what I want" }
    ]
  }]
)
```

---

## Step 2a: If YES → Where Is the Spec?

```
AskUserQuestion(
  questions: [{
    question: "Where is your spec?",
    header: "Source",
    options: [
      { label: "Local file", description: "Path to .md, .yml, or .json file" },
      { label: "Jira / Linear / GitHub", description: "Ticket URL or ID" },
      { label: "Paste it", description: "I'll paste the content" }
    ]
  }]
)
```

Then:
- **Local file** → Ask for path, read file
- **Jira/Linear/GitHub** → Ask for URL/ID, fetch content
- **Paste** → Ask user to paste

---

## Step 2b: If NO → What Do You Want?

```
AskUserQuestion(
  questions: [{
    question: "What do you want to build?",
    header: "Goal",
    options: [
      { label: "New feature", description: "Build something new" },
      { label: "Fix a bug", description: "Something is broken" },
      { label: "Refactor", description: "Improve existing code" },
      { label: "Other", description: "Something else" }
    ]
  }]
)
```

Then ask for details (free text).

---

## Step 3: Stack (Only If No Project)

**Auto-detect first. Ask only if empty.**

```bash
# Check for project
if [ -f "package.json" ]; then
  # Read and detect: React? Node? Both?
  STACK=$(detect_from_package_json)
elif [ -f "go.mod" ]; then
  STACK="go"
elif [ -f "Cargo.toml" ]; then
  STACK="rust"
else
  # No project → must ask
  ASK_STACK=true
fi
```

If `ASK_STACK`:
```
AskUserQuestion(
  questions: [{
    question: "What stack are you using?",
    header: "Stack",
    options: [
      { label: "TypeScript + React", description: "Frontend application" },
      { label: "TypeScript + Node", description: "Backend API" },
      { label: "Full-stack TypeScript", description: "Frontend + Backend" },
      { label: "Go", description: "Backend service" }
    ]
  }]
)
```

---

## Step 4: PO — ALWAYS RUNS

### If User Provided Spec

```
Task(
  subagent_type: "product-owner",
  prompt: """
    USER PROVIDED SPEC:
    <spec content>

    ## Your Job
    1. VALIDATE the spec has:
       - Clear objective
       - Acceptance criteria (testable)
       - Edge cases
    2. If complete → approve and copy to .spectre/spec.md
    3. If incomplete → complete missing parts, then save

    ## Output
    Write validated/completed spec to .spectre/spec.md

    Format:
    ```markdown
    # Spec: [Title]

    ## Objective
    [What we're building and why]

    ## Acceptance Criteria
    - [ ] [Criterion 1]
    - [ ] [Criterion 2]

    ## Edge Cases
    - [Case 1]
    - [Case 2]

    ## Out of Scope
    - [What we're NOT doing]
    ```
  """
)
```

### If User Gave Idea

```
Task(
  subagent_type: "product-owner",
  prompt: """
    USER WANTS: <user's description>
    TYPE: <feature/fix/refactor>
    STACK: <stack>

    ## Your Job
    Create a clear, professional spec.

    ## Output: .spectre/spec.md

    Format:
    ```markdown
    # Spec: [Title]

    ## Objective
    [What we're building and why]

    ## Acceptance Criteria
    - [ ] [Criterion 1 - specific, testable]
    - [ ] [Criterion 2]
    - [ ] [Criterion 3]

    ## Edge Cases
    - [Case 1]
    - [Case 2]

    ## Out of Scope
    - [What we're NOT doing]
    ```

    Be concise. Professional. Actionable.
  """
)
```

---

## Step 5: Architect — ALWAYS RUNS

```
Task(
  subagent_type: "architect",
  prompt: """
    SPEC: Read .spectre/spec.md
    STACK: <stack>

    ## Your Job
    Design the CRAFT technical solution.

    ## CRAFT Rules (Mandatory)
    - Strict TypeScript (no any)
    - Result<T, E> for errors (no throw)
    - Domain at center (hexagonal)
    - Tests colocated

    ## Output: .spectre/design.md

    Format:
    ```markdown
    # Design: [Title]

    ## Approach
    [Brief technical approach]

    ## File Structure
    ```
    src/
    └── features/
        └── <feature>/
            ├── domain/
            │   └── [files]
            ├── application/
            │   └── [files]
            ├── infrastructure/
            │   └── [files]
            └── ui/
                └── [files]
    ```

    ## Implementation

    ### [File path]
    - Purpose: ...
    - Exports: ...
    - Pattern: Result<T, E>

    ## Tests
    - [ ] "[test 1]"
    - [ ] "[test 2]"

    ## CRAFT Checklist
    - [ ] No any
    - [ ] Result<T, E> for errors
    - [ ] Domain isolated
    - [ ] Tests colocated
    ```

    Dev and QA implement this EXACTLY.
  """
)
```

---

## Step 6: Dev + QA — ALWAYS RUN IN PARALLEL

```
Task(
  subagent_type: "frontend-engineer",  # or backend
  prompt: """
    SPEC: .spectre/spec.md
    DESIGN: .spectre/design.md

    Implement EXACTLY what design.md specifies.
    CRAFT: strict TS, Result<T,E>, domain isolated.
  """
)

Task(
  subagent_type: "qa-engineer",
  prompt: """
    SPEC: .spectre/spec.md
    DESIGN: .spectre/design.md

    Write tests from design.md.
    Run as Dev completes.
    Report failures to .spectre/failures.md.
  """
)
```

---

## Example: With Spec

```
> /craft

"Do you have a spec?"
> Yes, I have a spec

"Where is your spec?"
> Local file

"File path?"
> docs/user-auth-spec.md

═══════════════════════════════════════════════════════════════

👤 PO: Validating spec...
   ✓ Objective clear
   ✓ 5 acceptance criteria
   ⚠️ Missing edge cases → adding
   ✓ .spectre/spec.md ready

🏗️ Architect: Designing...
   ✓ Hexagonal architecture
   ✓ 8 files planned
   ✓ Result<T, E> patterns
   ✓ .spectre/design.md ready

💻 Dev + 🧪 QA: Building...
   ✓ Domain layer
   ✓ Application layer
   ✓ UI components
   ✓ 6/6 tests passing

✨ Done.
```

---

## Example: Without Spec

```
> /craft

"Do you have a spec?"
> No, just an idea

"What do you want to build?"
> New feature

"Describe it:"
> User authentication with email/password and OAuth

🔍 Detected: TypeScript + React + Node (monorepo)

═══════════════════════════════════════════════════════════════

👤 PO: Creating spec...
   ✓ Objective defined
   ✓ 7 acceptance criteria
   ✓ Edge cases covered
   ✓ .spectre/spec.md ready

🏗️ Architect: Designing...
   ✓ Auth module structure
   ✓ 12 files planned
   ✓ Security patterns
   ✓ .spectre/design.md ready

💻 Dev + 🧪 QA: Building...
   ✓ Implementing...
   ✗ Test failed: OAuth callback
   🔧 Fixing...
   ✓ 8/8 tests passing

✨ Done.
```

---

## Summary

| Step | Question | When |
|------|----------|------|
| 1 | "Do you have a spec?" | **ALWAYS** |
| 2a | "Where is it?" | If has spec |
| 2b | "What do you want?" | If no spec |
| 3 | "What stack?" | Only if no project |

| Agent | Runs | Output |
|-------|------|--------|
| PO | **ALWAYS** | `.spectre/spec.md` |
| Architect | **ALWAYS** | `.spectre/design.md` |
| Dev + QA | **ALWAYS** | Implementation |

**Professional. Smart. Complete.**
