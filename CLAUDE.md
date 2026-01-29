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

Reactive learning — violations trigger architect for refacto plan:

```bash
/learn              # Full scan: stack + patterns + violations
/learn --only <path># Scan specific path
/learn --show       # View current learnings
```

## Under the Hood

Spectre orchestrates specialized agents internally:

| Agent | Role |
|-------|------|
| **learning-agent** | Stack detection, pattern learning, violation detection |
| **product-owner** | Specs, user stories |
| **architect** | Architecture, design, code review |
| **frontend/backend** | Implementation |
| **qa-engineer** | Tests, verification |

## Philosophy

- **Reactive** — Agents collaborate, not block
- **Domain First** — Business logic at center
- **Type Safety** — Types are documentation
- **Explicit > Implicit** — No magic, Result<T, E>
- **Test-Driven** — Tests are specs that run
- **Self-Correcting** — Agents fix their own bugs
