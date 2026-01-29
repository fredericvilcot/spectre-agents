---
name: learn
description: "Auto-learns project patterns by default. Adapts agents to YOUR conventions. Craft guard stops on violations. Can be scoped or disabled."
context: conversation
allowed-tools: Read, Bash, Glob, Grep, Write, Task, AskUserQuestion
---

# Spectre Learn — Adaptive Intelligence

**Active by default.** Spectre automatically learns your project's patterns and adapts all agents to match YOUR conventions.

## Default Behavior

When you run `/craft` or `/heal`, Spectre automatically:

1. **Detects your stack** (package.json, go.mod, Cargo.toml, etc.)
2. **Learns your patterns** (architecture, naming, error handling, tests)
3. **Applies craft guard** (stops on violations)
4. **Adapts agents** to your conventions

You don't need to run `/learn` manually — it happens automatically.

---

## Stack Auto-Detection

On first invocation, Spectre detects your stack:

```
┌─────────────────────────────────────────────────────────────┐
│  FILE DETECTED          →  STACK                            │
├─────────────────────────────────────────────────────────────┤
│  package.json           →  Node.js / TypeScript / React     │
│  go.mod                 →  Go                               │
│  Cargo.toml             →  Rust                             │
│  pyproject.toml         →  Python                           │
│  pom.xml                →  Java / Maven                     │
│  build.gradle           →  Java / Kotlin / Gradle           │
│  mix.exs                →  Elixir                           │
│  Gemfile                →  Ruby                             │
│  composer.json          →  PHP                              │
│  *.csproj               →  C# / .NET                        │
└─────────────────────────────────────────────────────────────┘
```

Stored in `.spectre/context.json`:

```json
{
  "stack": {
    "language": "typescript",
    "runtime": "node",
    "framework": "react",
    "testing": "vitest",
    "styling": "tailwind"
  },
  "detectedAt": "2024-01-15T10:30:00Z"
}
```

Agents automatically adapt to this context.

---

## Manual Commands

### Configure Learning Scope

```bash
/learn                    # Re-learn entire project (refresh)
/learn --only <path>      # Learn ONLY from this file/folder
/learn --off              # Disable auto-learning completely
/learn --on               # Re-enable auto-learning (default)
```

### View & Reset

```bash
/learn --show             # Show current learnings
/learn --reset            # Reset all learnings
/learn --violations       # Show detected violations
```

---

## Scope Control

### Default: Entire Project

```bash
# Auto-learning is ON for the whole project
# Nothing to do, it just works
```

### Scoped: Specific Path Only

```bash
/learn --only src/features/auth/

# Now Spectre ONLY learns from src/features/auth/
# Ignores patterns from other parts of the codebase
# Useful for: monorepos, legacy code you don't want to learn from
```

### Disabled: No Learning

```bash
/learn --off

# Auto-learning is completely disabled
# Agents use default craft principles only
# Useful for: new projects, when you want pure craft defaults
```

### Re-enable

```bash
/learn --on

# Back to default: learn from entire project
```

---

## Craft Guard — Always Active

**Spectre will NEVER learn anti-patterns.**

Whether auto or manual, scoped or full — the craft guard is always on.

```
> /craft "Add user service"

🔍 Auto-learning project patterns...

🛑 CRAFT VIOLATIONS DETECTED

   src/services/UserService.ts:45
   → throw new Error('User not found')
   → Violates: Explicit Error Handling

📋 Report: .spectre/violations-report.md

❌ Pattern NOT learned. Fix violation first.

   [ 🔧 Fix it ]  [ ⏭️ Skip file ]  [ 🛑 Stop ]
```

### What Gets Checked

| Principle | Compliant ✅ | Violation ❌ |
|-----------|-------------|-------------|
| **Type Safety** | Strict types, generics | `any`, type assertions |
| **Error Handling** | Result types, explicit | Thrown exceptions |
| **Architecture** | Layers, DI, ports/adapters | God classes, tight coupling |
| **SOLID** | Single responsibility, DIP | God objects, concrete deps |
| **Immutability** | Const, readonly, pure | Mutations everywhere |

### Violation Report

Generated at `.spectre/violations-report.md`:

```markdown
## Action Plan

| Priority | File | Issue | Fix |
|----------|------|-------|-----|
| 🔴 P0 | PaymentService.ts | God class | Split into focused services |
| 🟠 P1 | UserService.ts:45 | throw Error | Use Result<T, E> |
```

---

## What Gets Learned

### Patterns Detected

| Category | Examples |
|----------|----------|
| **Architecture** | Hexagonal, feature-folders, layers |
| **Error Handling** | Result types, error classes, Go-style |
| **Naming** | Files: kebab-case, Functions: camelCase |
| **Imports** | Absolute paths, barrel exports |
| **Testing** | Co-located, factories, mocking style |
| **API Style** | REST conventions, response format |

### Language-Specific Adaptations

Craft principles are universal. Implementation adapts to your stack:

| Principle | TypeScript | Go | Rust |
|-----------|------------|-----|------|
| Explicit Errors | `Result<T, E>` | `error` return | `Result<T, E>` |
| Type Safety | Strict mode | Strong types | Ownership |
| Immutability | `readonly`, `const` | Value semantics | By default |
| DI | Constructor injection | Interface params | Traits |

---

## Storage

```
.spectre/
├── context.json          # Stack + settings
├── learnings/
│   ├── patterns.json     # Learned patterns
│   └── examples.json     # Reference files
├── violations-report.md  # Current violations
└── state.json            # Workflow state
```

---

## Integration with /craft and /heal

Auto-learning runs transparently:

```
/craft "Build login form"
    │
    ├─→ Check .spectre/context.json
    │       │
    │       └─→ Missing? → Auto-detect stack
    │
    ├─→ Check learning scope (--only, --off)
    │       │
    │       └─→ Active? → Scan for patterns + guard
    │
    ├─→ Violations found?
    │       │
    │       ├─→ YES → Stop, report, ask user
    │       │
    │       └─→ NO → Continue with learned context
    │
    └─→ Agents work with adapted conventions
```

---

## Summary

| Setting | Command | Behavior |
|---------|---------|----------|
| **Default** | (nothing) | Learn entire project, guard on |
| **Scoped** | `/learn --only <path>` | Learn only from path |
| **Disabled** | `/learn --off` | No learning, pure craft defaults |
| **Re-enabled** | `/learn --on` | Back to full project |
| **Refresh** | `/learn` | Re-scan and update learnings |
| **View** | `/learn --show` | Display current learnings |
| **Reset** | `/learn --reset` | Clear all learnings |
