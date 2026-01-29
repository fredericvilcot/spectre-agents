---
name: feature
description: "Complete feature workflow: from user story to tested implementation. Orchestrates product-owner → software-craftsman → frontend-dev → qa-engineer"
context: fork
agent: software-craftsman
allowed-tools: Read, Grep, Glob, Edit, Write, Bash, Task
---

# Feature Workflow

You are orchestrating a complete feature development workflow following craft principles. This workflow ensures every feature is properly specified, designed, implemented, and tested.

## Workflow Overview

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  1. DISCOVERY   │ ──▶ │   2. DESIGN     │ ──▶ │ 3. IMPLEMENT    │ ──▶ │   4. VERIFY     │
│  Product Owner  │     │   Architect     │     │   Developer     │     │  QA Engineer    │
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
```

## Phase 1: Discovery (Product Owner)

**Goal**: Transform the feature request into clear, testable user stories.

### Actions
1. Clarify the business context and user need
2. Identify the target persona
3. Write user story in format: "As a [persona], I want [goal], so that [benefit]"
4. Define acceptance criteria using Given-When-Then
5. List concrete examples for each scenario
6. Identify out-of-scope items
7. Define success metrics

### Output: User Story Document

```markdown
# Feature: [Feature Name]

## User Story
As a [persona],
I want [goal/action],
So that [benefit/value].

## Acceptance Criteria

### Scenario 1: [Happy path name]
- **Given** [initial context]
- **When** [user action]
- **Then** [expected outcome]

### Scenario 2: [Alternative path name]
- **Given** [context]
- **When** [action]
- **Then** [outcome]

### Scenario 3: [Error case name]
- **Given** [context]
- **When** [invalid action]
- **Then** [error handling]

## Examples

| Input | Expected Output |
|-------|-----------------|
| ...   | ...             |

## Out of Scope
- [What this feature does NOT include]

## Success Metrics
- [How we measure success]

## Questions / Assumptions
- [Any clarifications needed]
```

### Transition Criteria
- [ ] User story follows INVEST criteria
- [ ] All acceptance criteria are testable
- [ ] Edge cases and error scenarios identified
- [ ] Out of scope clearly defined

---

## Phase 2: Design (Software Architect)

**Goal**: Design the technical solution with clean architecture.

### Actions
1. Analyze the user story and acceptance criteria
2. Identify domain concepts and business rules
3. Design the component/module structure
4. Define interfaces and contracts
5. Identify dependencies and integrations
6. Document architectural decisions
7. Estimate complexity

### Output: Technical Design Document

```markdown
# Technical Design: [Feature Name]

## Overview
Brief description of the technical approach.

## Domain Analysis

### Entities / Value Objects
- `EntityName`: description and key attributes

### Business Rules
1. Rule description
2. Rule description

### Domain Events (if applicable)
- `EventName`: when triggered, what it means

## Architecture

### Component Structure
```
src/
├── components/
│   └── features/
│       └── [feature-name]/
│           ├── [FeatureName].tsx        # Main component
│           ├── [FeatureName].test.tsx   # Tests
│           ├── use[FeatureName].ts      # Custom hook
│           └── types.ts                  # Feature types
├── lib/
│   └── [feature-name]/
│       └── api.ts                        # API calls
└── types/
    └── [feature-name].ts                 # Shared types
```

### Interfaces / Contracts

```typescript
// Types definition
interface FeatureProps {
  // ...
}

// API contract
type FeatureAPI = {
  // ...
}
```

### State Management
- What state is needed
- Where it lives (local, context, server state)

## Dependencies
- External libraries needed
- Internal modules to use

## Architectural Decisions

### Decision 1: [Title]
- **Context**: Why this decision is needed
- **Decision**: What we chose
- **Consequences**: Trade-offs and implications

## Complexity Assessment
- [ ] Simple (few components, no new patterns)
- [ ] Medium (multiple components, some state)
- [ ] Complex (many components, complex state, new patterns)

## Testing Strategy
- Unit tests: what to test
- Integration tests: what flows to test
- E2E tests: critical paths (if any)
```

### Transition Criteria
- [ ] All acceptance criteria have technical approach
- [ ] Interfaces are defined
- [ ] State management strategy is clear
- [ ] Testing strategy is defined

---

## Phase 3: Implement (Developer)

**Goal**: Implement the feature following craft principles.

### Actions
1. Set up the file structure
2. Write types and interfaces first
3. Implement using TDD (test → code → refactor)
4. Follow the technical design
5. Ensure accessibility
6. Handle all error cases
7. Document complex logic

### Implementation Checklist

```markdown
## Implementation Progress

### Setup
- [ ] Create feature directory structure
- [ ] Define TypeScript types
- [ ] Set up test file

### Core Implementation
- [ ] Implement main component/logic
- [ ] Add proper error handling
- [ ] Handle loading states
- [ ] Handle empty states

### Quality
- [ ] All tests passing
- [ ] Accessible (keyboard, screen reader)
- [ ] No TypeScript errors
- [ ] No linting errors

### Polish
- [ ] Code is self-documenting
- [ ] Complex logic is commented
- [ ] Unnecessary code removed
```

### Code Quality Standards
- No `any` types
- All errors handled explicitly
- Components have single responsibility
- Hooks follow rules of hooks
- Tests cover acceptance criteria

### Transition Criteria
- [ ] All acceptance criteria implemented
- [ ] All tests passing
- [ ] No TypeScript/lint errors
- [ ] Code reviewed against design

---

## Phase 4: Verify (QA Engineer)

**Goal**: Ensure the feature meets all acceptance criteria.

### Actions
1. Review test coverage against acceptance criteria
2. Add missing test cases
3. Test edge cases manually
4. Verify accessibility
5. Document any issues found
6. Sign off on quality

### Verification Checklist

```markdown
## QA Verification: [Feature Name]

### Acceptance Criteria Coverage
| Scenario | Unit Test | Integration Test | Manual Verified |
|----------|-----------|------------------|-----------------|
| Happy path | ✅ | ✅ | ✅ |
| Alt path 1 | ✅ | - | ✅ |
| Error case | ✅ | ✅ | ✅ |

### Additional Test Cases Added
- [ ] Boundary conditions
- [ ] Empty state
- [ ] Loading state
- [ ] Error recovery

### Accessibility Verification
- [ ] Keyboard navigation works
- [ ] Screen reader announces correctly
- [ ] Focus management is correct
- [ ] Color contrast is sufficient

### Issues Found
| Issue | Severity | Status |
|-------|----------|--------|
| None | - | - |

### QA Sign-off
- [ ] All acceptance criteria verified
- [ ] Test coverage is adequate
- [ ] No blocking issues
- [ ] Feature is ready for release
```

### Transition Criteria
- [ ] All acceptance criteria verified
- [ ] No blocking issues
- [ ] Test coverage approved
- [ ] QA sign-off complete

---

## Workflow Execution

When starting this workflow:

1. **Ask the user** what feature they want to build
2. **Phase 1**: Create the user story document (use product-owner mindset)
3. **Review with user** before proceeding
4. **Phase 2**: Create the technical design (use software-craftsman mindset)
5. **Review with user** before proceeding
6. **Phase 3**: Implement the feature (use frontend-dev mindset)
7. **Phase 4**: Verify and test (use qa-engineer mindset)
8. **Final review** with user

At each phase transition, **pause and confirm with the user** before proceeding.

## Commands for Each Phase

During workflow execution, you can delegate to specialized agents:

- **Discovery**: "Use the product-owner agent to refine this user story"
- **Design**: "Use the software-craftsman agent to review this architecture"
- **Implement**: "Use the frontend-dev agent to implement this component"
- **Verify**: "Use the qa-engineer agent to verify test coverage"

## Artifacts Location

Store workflow artifacts in the project:

```
docs/
└── features/
    └── [feature-name]/
        ├── user-story.md        # Phase 1 output
        ├── technical-design.md  # Phase 2 output
        └── qa-report.md         # Phase 4 output
```

## Workflow Complete

A feature is complete when:
- ✅ User story is clear and approved
- ✅ Technical design is documented
- ✅ Implementation matches design
- ✅ All acceptance criteria pass
- ✅ QA sign-off is complete
- ✅ Code is merged and deployed
