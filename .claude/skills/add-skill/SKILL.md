---
name: add-skill
description: "Fine-tune agents with specific skills. Injects expertise, triggers reactive re-implementation."
context: conversation
allowed-tools: Read, Write, Bash, Task, AskUserQuestion
---

# Spectre Add-Skill — Fine-Tuning Mode

Injecte manuellement un skill spécifique à un agent, puis déclenche une boucle réactive pour ré-implémenter le code avec cette nouvelle expertise.

## Syntax

```bash
/add-skill <agent> <skill> [--scope <path>]
```

### Arguments

| Argument | Description | Example |
|----------|-------------|---------|
| `<agent>` | Agent cible | `architect`, `frontend-engineer`, `backend-engineer` |
| `<skill>` | Skill à injecter | `DDD`, `CQRS`, `Event-Sourcing`, `React-Patterns`, `TDD` |
| `--scope` | Limiter à un path | `--scope src/features/orders` |

## Examples

```bash
/add-skill architect DDD
/add-skill architect CQRS --scope src/features/orders
/add-skill backend-engineer Event-Sourcing
/add-skill frontend-engineer React-Patterns
/add-skill qa-engineer TDD
```

---

## Flow Réactif

```
┌─────────────────────────────────────────────────────────────────┐
│                    /add-skill architect DDD                      │
│                                                                  │
│  1. INJECTION DU SKILL                                          │
│     ─────────────────────                                        │
│     → Génère un skill document détaillé pour "DDD"              │
│     → Stocke dans .spectre/skills/ddd.md                        │
│     → Ajoute au contexte de l'architect                         │
│                                                                  │
│  2. ANALYSE DU CODEBASE                                         │
│     ─────────────────────                                        │
│     → Architect analyse le code avec le nouveau skill           │
│     → Identifie les violations / améliorations possibles        │
│     → Génère un plan de refactoring                             │
│                                                                  │
│  3. PROPOSITION À L'USER                                        │
│     ─────────────────────                                        │
│     → Présente le plan de refactoring                           │
│     → User approuve / modifie / refuse                          │
│                                                                  │
│  4. BOUCLE RÉACTIVE (si approuvé)                               │
│     ─────────────────────────────                                │
│     → Architect détaille les changements                        │
│     → Backend/Frontend Engineers implémentent                   │
│     → QA vérifie                                                │
│     → Loop si échec                                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Skills Disponibles

### Architecture Skills

| Skill | Description | Pour Agent |
|-------|-------------|------------|
| `DDD` | Domain-Driven Design complet | architect |
| `CQRS` | Command Query Responsibility Segregation | architect, backend |
| `Event-Sourcing` | Event store, projections, replay | architect, backend |
| `Hexagonal` | Ports & Adapters approfondi | architect |
| `Microservices` | Patterns microservices | architect |
| `Modular-Monolith` | Modular monolith patterns | architect |

### Frontend Skills

| Skill | Description | Pour Agent |
|-------|-------------|------------|
| `React-Patterns` | Compound components, render props, hooks avancés | frontend |
| `State-Machines` | XState, statecharts | frontend |
| `Micro-Frontends` | Module federation, patterns | frontend |
| `A11y-Expert` | Accessibilité avancée | frontend |
| `Performance` | Core Web Vitals, optimisation | frontend |

### Backend Skills

| Skill | Description | Pour Agent |
|-------|-------------|------------|
| `API-Design` | REST avancé, HATEOAS, versioning | backend |
| `GraphQL` | Schema design, resolvers, DataLoader | backend |
| `Message-Queues` | RabbitMQ, Kafka patterns | backend |
| `Caching` | Redis, cache invalidation strategies | backend |

### Testing Skills

| Skill | Description | Pour Agent |
|-------|-------------|------------|
| `TDD` | Test-Driven Development approfondi | qa, all |
| `BDD` | Behavior-Driven Development, Gherkin | qa |
| `Contract-Testing` | Pact, consumer-driven contracts | qa |
| `Property-Testing` | Property-based testing, fuzzing | qa |

---

## Implémentation

### Step 1: Parse Arguments

```typescript
interface AddSkillArgs {
  agent: 'architect' | 'frontend-engineer' | 'backend-engineer' | 'qa-engineer';
  skill: string;
  scope?: string;
}

// Parse: /add-skill architect DDD --scope src/orders
const args = parseAddSkillCommand(input);
```

### Step 2: Generate Skill Document

Utilise l'architect pour générer un document de skill détaillé :

```
Task(
  subagent_type: "architect",
  prompt: """
    Génère un document de skill expert pour: DDD (Domain-Driven Design)

    Format requis:

    ## Principes Fondamentaux
    - Liste des principes clés

    ## Patterns Tactiques
    - Entities, Value Objects, Aggregates, etc.
    - Avec exemples de code TypeScript

    ## Patterns Stratégiques
    - Bounded Contexts, Context Mapping, etc.

    ## Application au Codebase
    - Comment identifier les domaines
    - Comment refactorer vers DDD

    ## Checklist de Review
    - Questions à se poser

    ## Anti-patterns à Éviter
    - Erreurs communes
  """
)
```

### Step 3: Store Skill

```bash
mkdir -p .spectre/skills
# Stocke le skill généré
cat > .spectre/skills/ddd.md << EOF
<contenu généré>
EOF
```

### Step 4: Analyze Codebase

```
Task(
  subagent_type: "architect",
  prompt: """
    Tu as maintenant le skill: DDD

    <contenu du skill .spectre/skills/ddd.md>

    Analyse le codebase (scope: ${scope || 'tout le projet'}) :

    1. Identifie les Bounded Contexts potentiels
    2. Identifie les Aggregates manquants
    3. Identifie les violations DDD
    4. Propose un plan de refactoring priorisé

    Format de sortie:

    ## Analyse DDD

    ### Bounded Contexts Identifiés
    - ...

    ### Violations Trouvées
    | Fichier | Violation | Priorité | Fix proposé |
    |---------|-----------|----------|-------------|

    ### Plan de Refactoring
    1. Phase 1: ...
    2. Phase 2: ...
  """
)
```

### Step 5: User Approval

```
Question: "Voici le plan de refactoring DDD. Que voulez-vous faire?"
Header: "Plan"
Options:
  1. "Approuver et implémenter"
     Description: "Lance la boucle réactive avec les engineers"
  2. "Modifier le scope"
     Description: "Limiter à certains fichiers/dossiers"
  3. "Voir les détails"
     Description: "Plus d'explications sur les changements"
  4. "Annuler"
     Description: "Ne pas appliquer"
```

### Step 6: Reactive Implementation Loop

Si approuvé :

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│  Pour chaque phase du plan:                                     │
│                                                                  │
│  1. Architect détaille les changements                          │
│     → "Transformer UserService en Aggregate User"               │
│     → Fournit le design détaillé                                │
│                                                                  │
│  2. Backend/Frontend Engineer implémente                        │
│     → Reçoit le design + skill context                          │
│     → Implémente les changements                                │
│                                                                  │
│  3. QA vérifie                                                  │
│     → Tests passent?                                            │
│     → Code respecte le skill?                                   │
│                                                                  │
│  4. Loop si échec                                               │
│     → Engineer corrige                                          │
│     → QA re-vérifie                                             │
│                                                                  │
│  5. Phase suivante                                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Storage

```
.spectre/
├── skills/
│   ├── ddd.md              # Skill injecté
│   ├── cqrs.md             # Autre skill
│   └── ...
├── refactoring-plans/
│   └── ddd-2024-01-15.md   # Plan généré
└── context.json            # Référence les skills actifs
```

### context.json avec skills

```json
{
  "stack": { ... },
  "activeSkills": [
    {
      "name": "DDD",
      "agent": "architect",
      "addedAt": "2024-01-15T10:30:00Z",
      "scope": "src/features/orders"
    }
  ]
}
```

---

## Exemple Complet

```
> /add-skill architect DDD --scope src/features/orders

🎯 Injecting skill: DDD → architect

📝 Generating skill document...
   ✓ DDD principles documented
   ✓ Tactical patterns with examples
   ✓ Strategic patterns explained
   ✓ Stored in .spectre/skills/ddd.md

🔍 Analyzing codebase with DDD lens...
   Scope: src/features/orders

📋 Analysis Complete

## Bounded Contexts Identified
- Orders (current scope)
- Payments (referenced)
- Inventory (referenced)

## Violations Found
| File | Violation | Priority |
|------|-----------|----------|
| OrderService.ts | Anemic domain model | 🔴 High |
| Order.ts | No aggregate root | 🔴 High |
| CreateOrder.ts | Business logic in use case | 🟠 Medium |

## Refactoring Plan
1. **Phase 1**: Create Order Aggregate
2. **Phase 2**: Move business logic to domain
3. **Phase 3**: Add domain events

───────────────────────────────────────

What do you want to do?
  [Approve & Implement]  [Modify Scope]  [See Details]  [Cancel]

> Approve & Implement

🚀 Starting reactive implementation loop...

🏗️ Architect: Phase 1 - Create Order Aggregate
   → Designing Order aggregate with OrderItem entities
   → Defining invariants and domain events

💻 Backend Engineer: Implementing...
   → Created src/features/orders/domain/Order.ts
   → Created src/features/orders/domain/OrderItem.ts
   → Updated OrderRepository interface

🧪 QA: Verifying...
   → Running tests... ✓ 12 passing
   → Checking DDD compliance... ✓ Aggregate valid

✅ Phase 1 complete

🏗️ Architect: Phase 2 - Move business logic...
   ...

✅ DDD refactoring complete!

Skills active: [DDD]
Files modified: 8
Tests: 24 passing
```

---

## Tone

- **Expert**: Le skill injecté doit être de niveau expert
- **Pedagogique**: Expliquer pourquoi, pas juste comment
- **Progressif**: Refactoring par phases, pas big bang
- **Réactif**: Boucle jusqu'à ce que ce soit correct
