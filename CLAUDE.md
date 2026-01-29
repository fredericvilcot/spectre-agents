# CLAUDE.md

> **Stop prompting. Start crafting.**

## Three Commands

```bash
/craft    # Build features with the right agent team
/heal     # Auto-fix everything (tests, build, types)
/learn    # Adapt to YOUR codebase patterns
```

## `/craft`

Adapts to your work context:

```
/craft
  → Context? [ Product Team | Startup | Freelance | Learning ]
  → What do you need?
  → Agents assemble and work
```

| Context | Workflow |
|---------|----------|
| Product Team | `PO → Architect → Dev → QA` |
| Startup | `Architect → Dev → QA` |
| Freelance | `Dev → QA` |
| Learning | Single agent, educational |

## `/heal`

Auto-repair with smart routing:

```bash
/heal           # Fix all (tests, build, types, specs)
/heal tests     # Fix tests only
/heal types     # Fix TypeScript errors
/heal spec      # Sync spec ↔ code
```

## `/learn`

Learn YOUR patterns, refuse anti-patterns:

```bash
/learn              # Full project analysis
/learn <file>       # Learn from specific file
/learn --auto       # Intelligent scan (STOPS on violations)
```

## Agents

| Agent | Role |
|-------|------|
| **product-owner** | Specs, user stories |
| **architect** | Architecture, design, code review |
| **frontend-engineer** | UI, React, accessibility |
| **backend-engineer** | APIs, services, security |
| **qa-engineer** | Tests, verification |

## Philosophy

- **Domain First** — Business logic at center
- **Type Safety** — Types are documentation
- **Explicit > Implicit** — No magic, Result<T, E>
- **Test-Driven** — Tests are specs that run
- **Self-Correcting** — Agents fix their own bugs
- **Adaptive** — Learns YOUR patterns, guards against anti-patterns
