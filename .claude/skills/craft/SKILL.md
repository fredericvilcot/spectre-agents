---
name: craft
description: "Craft something new. Smart flow adapts to your situation: existing project, from scratch, with inspiration. Reactive agents collaborate intelligently."
context: conversation
allowed-tools: Read, Bash, Task, AskUserQuestion, Glob, Grep, WebFetch
---

# Spectre Craft — Smart Reactive Flow

Intelligent flow that adapts to your situation AND your input.

---

## The Smart Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│  /craft                                                          │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────────────────────────────────┐                        │
│  │  1. PROJECT DETECTION               │                        │
│  │     Existing code? Stack?           │                        │
│  └─────────────┬───────────────────────┘                        │
│                │                                                 │
│                ▼                                                 │
│  ┌─────────────────────────────────────┐                        │
│  │  2. WORK CONTEXT                    │                        │
│  │     Product / Startup / Freelance   │                        │
│  └─────────────┬───────────────────────┘                        │
│                │                                                 │
│                ▼                                                 │
│  ┌─────────────────────────────────────┐                        │
│  │  3. WHAT TO BUILD?                  │                        │
│  │     User describes feature/idea     │                        │
│  └─────────────┬───────────────────────┘                        │
│                │                                                 │
│                ▼                                                 │
│  ┌─────────────────────────────────────┐                        │
│  │  4. INPUT ANALYSIS ← NEW!           │                        │
│  │     Detect input type & route       │                        │
│  └─────────────┬───────────────────────┘                        │
│                │                                                 │
│       ┌────────┼────────┬──────────┐                            │
│       │        │        │          │                            │
│       ▼        ▼        ▼          ▼                            │
│    ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                          │
│    │ Idea│  │Func │  │Tech │  │Bug/ │                          │
│    │ raw │  │Spec │  │Spec │  │Fix  │                          │
│    └──┬──┘  └──┬──┘  └──┬──┘  └──┬──┘                          │
│       │        │        │        │                              │
│       ▼        ▼        ▼        ▼                              │
│    ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                          │
│    │ PO  │  │Archi│  │ Dev │  │ Dev │                          │
│    │first│  │first│  │first│  │only │                          │
│    └─────┘  └─────┘  └─────┘  └─────┘                          │
│                                                                  │
│                ▼                                                 │
│  ┌─────────────────────────────────────┐                        │
│  │  5. REACTIVE PARALLEL EXECUTION     │                        │
│  │     Agents work & collaborate       │                        │
│  └─────────────────────────────────────┘                        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Step 1: Project Detection

```bash
# Check for existing project
if [ -f "package.json" ] || [ -f "go.mod" ] || [ -f "Cargo.toml" ]; then
  FROM_SCRATCH=false
  # → Auto-detect stack, trigger /learn
else
  FROM_SCRATCH=true
  # → Ask for stack
fi
```

### If From Scratch → Ask Stack

```
Question: "What stack?"
Header: "Stack"
Options:
  1. "TypeScript + React" - Frontend with Vite
  2. "TypeScript + Node" - Backend API
  3. "Full-stack TypeScript" - React + Node
  4. "Go" - Backend with Go
```

---

## Step 2: Work Context

```
Question: "What's your work context?"
Header: "Context"
Options:
  1. "Product Team" - Full process: PO → Architect → Dev → QA
  2. "Startup" - Fast: Architect → Dev → QA
  3. "Freelance" - Efficient: Dev → QA
  4. "Learning" - Educational: Single agent explains
```

---

## Step 3: What to Build

```
Question: "What do you want to build?"
Header: "Feature"
# Free text input - user describes their idea/feature/spec
```

---

## Step 4: Input Analysis (THE SMART PART)

Analyze what the user provided to determine routing:

### Input Types

| Type | Indicators | Example | Route |
|------|------------|---------|-------|
| **Raw Idea** | Vague, no acceptance criteria, informal | "a sexy counter" | PO first |
| **Functional Spec** | User stories, acceptance criteria, behavior described | "Counter that increments, persists in localStorage, has dark mode" | Architect first |
| **Technical Spec** | Architecture details, file structure, implementation notes | "Create Counter.tsx with useState, useEffect for localStorage sync" | Dev first |
| **Bug/Fix** | References existing code, describes problem | "Fix the counter reset bug in Counter.tsx" | Dev only |

### Detection Logic

```
ANALYZE the user's input:

IF input is vague/informal (just an idea, no specifics):
  → INPUT_TYPE = "raw_idea"
  → NEEDS_PO = true
  → "User has an idea but no spec. PO will formalize it."

ELSE IF input has functional requirements (what, not how):
  → INPUT_TYPE = "functional_spec"
  → NEEDS_PO = false
  → "User has functional spec. Architect can design."

ELSE IF input has technical details (how, structure, files):
  → INPUT_TYPE = "technical_spec"
  → NEEDS_PO = false
  → NEEDS_ARCHITECT = false
  → "User has technical spec. Dev can implement."

ELSE IF input references existing code/bug:
  → INPUT_TYPE = "fix"
  → NEEDS_PO = false
  → NEEDS_ARCHITECT = false
  → "Bug fix. Dev handles, QA verifies."
```

### Inform the User

```
Based on your input, here's the plan:

📝 Input type: Raw idea
🎯 Flow: PO → Architect → Dev ⇄ QA

The Product Owner will first create a proper spec from your idea,
then the Architect will design the technical solution.

[Start] [I have more details to add]
```

---

## Step 5: Smart Routing by Input Type

### Route A: Raw Idea → PO First

```
┌─────────────────────────────────────────────────────────────────┐
│  USER INPUT: "a sexy counter"                                    │
│                                                                  │
│       ┌──────────┐                                              │
│       │    PO    │ ← Creates functional spec                    │
│       │  (spec)  │                                              │
│       └────┬─────┘                                              │
│            │ user story + acceptance criteria                   │
│            ▼                                                     │
│       ┌──────────┐                                              │
│       │ Architect│ ← Creates technical design                   │
│       │ (design) │                                              │
│       └────┬─────┘                                              │
│            │ architecture + file structure                      │
│            ▼                                                     │
│       ┌─────────────────────────┐                               │
│       │      PARALLEL           │                               │
│       │  ┌──────┐  ┌──────┐    │                               │
│       │  │ Dev  │  │  QA  │    │                               │
│       │  │impl  │⇄│tests │    │                               │
│       │  └──────┘  └──────┘    │                               │
│       └─────────────────────────┘                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**PO Output:**
```markdown
## User Story
As a user, I want a visually appealing counter
so that I can track a value with delight.

## Acceptance Criteria
- [ ] Counter displays current value (starts at 0)
- [ ] Increment button (+1) with satisfying animation
- [ ] Decrement button (-1) with animation
- [ ] Reset button
- [ ] Value persists across page refresh
- [ ] Dark/light mode toggle
- [ ] Micro-interactions on hover/click
- [ ] Accessible (keyboard nav, screen reader)

## Edge Cases
- Negative values allowed? → Ask user or default to yes
- Max value? → No limit unless specified
```

### Route B: Functional Spec → Architect First

```
┌─────────────────────────────────────────────────────────────────┐
│  USER INPUT: "Counter with +/-, localStorage, dark mode"        │
│                                                                  │
│       ┌──────────┐                                              │
│       │ Architect│ ← Designs from functional spec               │
│       │ (design) │                                              │
│       └────┬─────┘                                              │
│            │                                                     │
│            ▼                                                     │
│       ┌─────────────────────────┐                               │
│       │      PARALLEL           │                               │
│       │  ┌──────┐  ┌──────┐    │                               │
│       │  │ Dev  │  │  QA  │    │                               │
│       │  │impl  │⇄│tests │    │                               │
│       │  └──────┘  └──────┘    │                               │
│       └─────────────────────────┘                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Route C: Technical Spec → Dev First

```
┌─────────────────────────────────────────────────────────────────┐
│  USER INPUT: "Create Counter.tsx with useState, Tailwind..."    │
│                                                                  │
│       ┌─────────────────────────┐                               │
│       │      PARALLEL           │                               │
│       │  ┌──────┐  ┌──────┐    │                               │
│       │  │ Dev  │  │  QA  │    │                               │
│       │  │impl  │⇄│tests │    │                               │
│       │  └──────┘  └──────┘    │                               │
│       └─────────────────────────┘                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Route D: Bug Fix → Dev Only

```
┌─────────────────────────────────────────────────────────────────┐
│  USER INPUT: "Fix the counter not persisting on refresh"        │
│                                                                  │
│       ┌──────┐      ┌──────┐                                    │
│       │ Dev  │ ───▶ │  QA  │                                    │
│       │ fix  │      │verify│                                    │
│       └──────┘      └──────┘                                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Parallel Execution: Dev ⇄ QA

The magic: **Dev and QA work in parallel**, not sequentially.

```
┌─────────────────────────────────────────────────────────────────┐
│                   PARALLEL REACTIVE LOOP                         │
│                                                                  │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                                                          │  │
│   │    Dev implements          QA writes tests              │  │
│   │         │                        │                       │  │
│   │         │   ← shares context →   │                       │  │
│   │         │                        │                       │  │
│   │         ▼                        ▼                       │  │
│   │    Code ready              Tests ready                   │  │
│   │         │                        │                       │  │
│   │         └────────┬───────────────┘                       │  │
│   │                  │                                       │  │
│   │                  ▼                                       │  │
│   │            QA runs tests                                 │  │
│   │                  │                                       │  │
│   │         ┌───────┴───────┐                               │  │
│   │         │               │                               │  │
│   │        PASS            FAIL                              │  │
│   │         │               │                               │  │
│   │         ▼               ▼                               │  │
│   │       Done         Dev fixes                            │  │
│   │                        │                                │  │
│   │                        └──────▶ QA re-runs              │  │
│   │                                                          │  │
│   └──────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### How Parallel Works

1. **Architect** outputs design with:
   - File structure
   - Component specs
   - Acceptance criteria (for QA)

2. **Dev starts** implementing from the design

3. **QA starts** writing tests from acceptance criteria
   - Doesn't wait for Dev to finish
   - Writes test shells based on expected behavior

4. **When Dev completes a component**, QA runs its tests

5. **If tests fail**, Dev gets immediate feedback and fixes

6. **Loop continues** until all tests pass

---

## Agent Prompts

### PO Prompt (Raw Idea → Spec)

```
Task(
  subagent_type: "product-owner",
  prompt: """
    USER'S IDEA: <raw idea>
    STACK: <detected or chosen stack>

    ## Your Job

    Transform this raw idea into a proper functional specification.

    ## Output Format

    ### User Story
    As a [user type], I want [feature]
    so that [benefit].

    ### Acceptance Criteria
    - [ ] Criterion 1 (specific, testable)
    - [ ] Criterion 2
    - [ ] ...

    ### Edge Cases
    - What happens if...?
    - What about...?

    ### Out of Scope (for this iteration)
    - Things to explicitly NOT do now

    ### Questions for User (if any)
    - Clarifications needed before proceeding

    ## Rules
    - Be specific and testable
    - Think about edge cases
    - Consider accessibility
    - Keep scope reasonable for first iteration
  """
)
```

### Architect Prompt (Spec → Design)

```
Task(
  subagent_type: "architect",
  prompt: """
    ## CONTEXT

    FUNCTIONAL SPEC:
    <PO's output or user's functional spec>

    STACK: <stack>
    CRAFT PRINCIPLES: Result<T,E>, strict TypeScript, hexagonal

    ## Your Job

    Design the technical architecture.

    ## Output Format

    ### Architecture Decision
    Brief explanation of approach.

    ### File Structure
    ```
    src/
    ├── features/
    │   └── <feature>/
    │       ├── domain/       # Entities, value objects
    │       ├── application/  # Use cases, hooks
    │       ├── infrastructure/ # API, storage
    │       └── ui/           # Components
    ```

    ### Key Files to Create
    1. File path - purpose
    2. ...

    ### For Dev
    Implementation notes, patterns to use.

    ### For QA (Acceptance Test Specs)
    Test scenarios derived from acceptance criteria:
    - Test: "should increment counter"
    - Test: "should persist value to localStorage"
    - ...

    ### Implementation Phases
    1. Phase 1: ...
    2. Phase 2: ...
  """
)
```

### Parallel Dev + QA Spawn

```
# Launch BOTH in parallel
Task(
  subagent_type: "frontend-engineer",
  run_in_background: true,
  prompt: """
    ARCHITECT DESIGN: <design>

    Implement the feature following the design.
    Write to .spectre/dev-progress.md as you complete each file.
  """
)

Task(
  subagent_type: "qa-engineer",
  run_in_background: true,
  prompt: """
    ACCEPTANCE CRITERIA: <from PO or architect>
    TEST SPECS: <from architect>

    Write tests for this feature.
    - Unit tests for domain logic
    - Integration tests for use cases
    - Component tests for UI

    Watch .spectre/dev-progress.md for completed files.
    Run tests as files become available.
    Write failures to .spectre/test-failures.md
  """
)

# Orchestrator monitors both and routes failures
```

---

## Context-Aware Routing Matrix

| Context | Input Type | Pipeline |
|---------|------------|----------|
| **Product Team** | Raw idea | PO → Architect → Dev // QA |
| **Product Team** | Func spec | Architect → Dev // QA |
| **Product Team** | Tech spec | Dev // QA |
| **Startup** | Raw idea | PO (light) → Architect → Dev // QA |
| **Startup** | Func spec | Architect → Dev // QA |
| **Startup** | Tech spec | Dev // QA |
| **Freelance** | Any | Dev → QA |
| **Learning** | Any | Single agent (explains as it goes) |

---

## Example: Full Flow

```
User: /craft

🔍 No existing project detected.

"What stack?"
[ TypeScript + React ]

"What's your work context?"
[ Startup ]

"What do you want to build?"

User: a sexy counter

📝 Analyzing your input...

   Input type: Raw idea (informal, no specifics)
   Recommended flow: PO → Architect → Dev ⇄ QA

   The Product Owner will create a proper spec first.

[ Start ] [ Add more details ]

User: [ Start ]

👤 Product Owner creating spec...

   ## User Story
   As a user, I want a visually appealing counter
   so that I can track values with delight.

   ## Acceptance Criteria
   - [ ] Display current value (default: 0)
   - [ ] Increment (+1) with micro-animation
   - [ ] Decrement (-1) with micro-animation
   - [ ] Reset to 0
   - [ ] Persist in localStorage
   - [ ] Dark/light theme toggle
   - [ ] Keyboard accessible (arrows, enter)
   - [ ] Smooth transitions

   ## Edge Cases
   - Allow negative values
   - No max limit

[ Approve spec ] [ Modify ]

User: [ Approve spec ]

🏗️ Architect designing...

   ## Architecture

   src/features/counter/
   ├── domain/
   │   └── Counter.ts         # Value + operations
   ├── application/
   │   └── useCounter.ts      # Hook with localStorage
   ├── infrastructure/
   │   └── CounterStorage.ts  # localStorage adapter
   └── ui/
       ├── Counter.tsx        # Main component
       ├── Counter.test.tsx   # Tests
       └── CounterButton.tsx  # Animated button

   ## For QA - Test Scenarios
   - renders with initial value 0
   - increments on + click
   - decrements on - click
   - resets to 0
   - persists to localStorage
   - loads from localStorage on mount
   - supports keyboard navigation

[ Approve design ] [ Modify ]

User: [ Approve design ]

🚀 Starting parallel execution...

   ┌─────────────────────────────────────────┐
   │  💻 Dev implementing...                  │
   │  🧪 QA writing tests...                  │
   └─────────────────────────────────────────┘

   Dev: ✓ Created Counter.ts (domain)
   QA:  ✓ Writing domain tests...

   Dev: ✓ Created useCounter.ts
   QA:  ✓ Writing hook tests...

   Dev: ✓ Created Counter.tsx
   QA:  🧪 Running tests...

   QA:  ❌ FAIL: "should persist to localStorage"
        Expected localStorage.setItem to be called

   Dev: 🔧 Fixing... added localStorage sync

   QA:  🧪 Re-running...
   QA:  ✓ All tests passing (12/12)

✨ Feature complete!

   Files: 6 created
   Tests: 12 passing
   Coverage: 94%
```

---

## State Storage

```json
// .spectre/state.json
{
  "workflow": "craft",
  "inputType": "raw_idea",
  "context": "startup",
  "phase": "parallel_execution",
  "agents": {
    "po": { "status": "complete", "output": "spec.md" },
    "architect": { "status": "complete", "output": "design.md" },
    "dev": { "status": "in_progress", "files": ["Counter.ts", "useCounter.ts"] },
    "qa": { "status": "in_progress", "tests": 12, "passing": 10, "failing": 2 }
  }
}
```

---

## Tone

- **Smart**: Detects input type, routes intelligently
- **Parallel**: Dev and QA work together, not sequentially
- **Reactive**: Failures route instantly to the right agent
- **Transparent**: User sees what's happening at each step
- **Adaptive**: Different flows for different contexts
