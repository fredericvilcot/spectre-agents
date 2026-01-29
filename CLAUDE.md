# CLAUDE.md

> **Stop prompting. Start crafting.**

## Two Commands

```bash
/craft    # Create something new
/heal     # Fix what's broken
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

Auto-repair everything:

```bash
/heal           # Fix all (tests, build, types, specs)
/heal tests     # Fix tests only
/heal types     # Fix TypeScript errors
/heal spec      # Sync spec ↔ code
```

## Agents

| Agent | Role |
|-------|------|
| **product-owner** | Specs, user stories |
| **software-craftsman** | Architecture, design |
| **frontend-dev** | UI, React, accessibility |
| **backend-dev** | APIs, services |
| **qa-engineer** | Tests, verification |

## Craft Skills

```bash
/typescript-craft    # Types, Result patterns
/react-craft         # Components, hooks
/test-craft          # TDD/BDD
/init-frontend       # Bootstrap project
```

## Philosophy

- **Domain First** — Business logic at center
- **Type Safety** — Types are documentation
- **Explicit > Implicit** — No magic
- **Test-Driven** — Tests are specs

---

[Full documentation](docs/ARCHITECTURE.md)
