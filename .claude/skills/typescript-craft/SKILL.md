---
name: typescript-craft
description: "Apply software craftsmanship principles to TypeScript code: type safety, functional patterns, clean architecture, and best practices"
context: fork
agent: software-craftsman
allowed-tools: Read, Grep, Glob, Edit, Write
---

# TypeScript Craft Skill

You are applying software craftsmanship principles to TypeScript code. Follow these guidelines rigorously.

## Type Safety First

### Strict Configuration
Always assume and enforce strict TypeScript configuration:
```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "exactOptionalPropertyTypes": true
  }
}
```

### Avoid Type Escapes
- **Never use `any`** - use `unknown` and narrow with type guards
- **Never use `as` assertions** unless absolutely necessary (and document why)
- **Never use `!` non-null assertions** - handle null/undefined explicitly
- **Avoid `@ts-ignore`** - fix the type issue instead

### Leverage the Type System
```typescript
// Bad: primitive obsession
function createUser(name: string, email: string, age: number) {}

// Good: domain types
type UserName = Brand<string, 'UserName'>
type Email = Brand<string, 'Email'>
type Age = Brand<number, 'Age'>

function createUser(name: UserName, email: Email, age: Age) {}
```

## Algebraic Data Types

### Discriminated Unions for Domain Modeling
```typescript
// Model all possible states explicitly
type AsyncData<T, E = Error> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: E }

// Result type for error handling
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E }
```

### Exhaustive Pattern Matching
```typescript
function handleState<T>(state: AsyncData<T>): string {
  switch (state.status) {
    case 'idle': return 'Not started'
    case 'loading': return 'Loading...'
    case 'success': return `Data: ${state.data}`
    case 'error': return `Error: ${state.error.message}`
    default: {
      const _exhaustive: never = state
      return _exhaustive
    }
  }
}
```

## Functional Patterns

### Immutability by Default
```typescript
// Use readonly everywhere
type User = Readonly<{
  id: UserId
  name: string
  roles: readonly Role[]
}>

// Prefer const assertions
const config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000,
} as const
```

### Pure Functions
```typescript
// Bad: side effects, mutation
function processUsers(users: User[]) {
  users.sort((a, b) => a.name.localeCompare(b.name))
  return users
}

// Good: pure, no mutation
function processUsers(users: readonly User[]): User[] {
  return [...users].sort((a, b) => a.name.localeCompare(b.name))
}
```

### Function Composition
```typescript
// Small, composable functions
const pipe = <T>(...fns: Array<(arg: T) => T>) =>
  (value: T): T => fns.reduce((acc, fn) => fn(acc), value)

const processUser = pipe(
  validateUser,
  normalizeEmail,
  hashPassword,
)
```

## Clean Architecture in TypeScript

### Domain Layer (No Dependencies)
```typescript
// domain/user.ts - Pure domain logic
export type UserId = Brand<string, 'UserId'>

export type User = Readonly<{
  id: UserId
  email: Email
  name: UserName
}>

export type UserRepository = {
  findById(id: UserId): Promise<Result<User, UserNotFoundError>>
  save(user: User): Promise<Result<void, PersistenceError>>
}
```

### Application Layer (Use Cases)
```typescript
// application/create-user.ts
type CreateUserDeps = {
  userRepository: UserRepository
  emailService: EmailService
}

type CreateUserCommand = {
  email: string
  name: string
}

export const createUser = (deps: CreateUserDeps) =>
  async (command: CreateUserCommand): Promise<Result<User, CreateUserError>> => {
    // Business logic here
  }
```

### Infrastructure Layer (Adapters)
```typescript
// infrastructure/postgres-user-repository.ts
export const createPostgresUserRepository = (db: Database): UserRepository => ({
  findById: async (id) => {
    // Implementation detail
  },
  save: async (user) => {
    // Implementation detail
  },
})
```

## Error Handling

### Never Throw for Expected Errors
```typescript
// Bad: throwing for business errors
function divide(a: number, b: number): number {
  if (b === 0) throw new Error('Division by zero')
  return a / b
}

// Good: explicit error type
function divide(a: number, b: number): Result<number, DivisionByZeroError> {
  if (b === 0) return { ok: false, error: new DivisionByZeroError() }
  return { ok: true, value: a / b }
}
```

### Typed Errors
```typescript
// Define specific error types
class UserNotFoundError extends Error {
  readonly _tag = 'UserNotFoundError'
  constructor(readonly userId: UserId) {
    super(`User not found: ${userId}`)
  }
}

class ValidationError extends Error {
  readonly _tag = 'ValidationError'
  constructor(readonly field: string, readonly reason: string) {
    super(`Validation failed for ${field}: ${reason}`)
  }
}

type CreateUserError = UserNotFoundError | ValidationError | PersistenceError
```

## Testing Patterns

### Arrange-Act-Assert with Type Safety
```typescript
describe('createUser', () => {
  it('should create a valid user', async () => {
    // Arrange
    const deps: CreateUserDeps = {
      userRepository: createInMemoryUserRepository(),
      emailService: createMockEmailService(),
    }
    const command: CreateUserCommand = {
      email: 'test@example.com',
      name: 'Test User',
    }

    // Act
    const result = await createUser(deps)(command)

    // Assert
    expect(result.ok).toBe(true)
    if (result.ok) {
      expect(result.value.email).toBe(command.email)
    }
  })
})
```

### Test Factories
```typescript
// test/factories/user.factory.ts
export const createTestUser = (overrides?: Partial<User>): User => ({
  id: 'user-123' as UserId,
  email: 'test@example.com' as Email,
  name: 'Test User' as UserName,
  ...overrides,
})
```

## Code Style

### Naming Conventions
- Types/Interfaces: `PascalCase`
- Functions/Variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE` for true constants, `camelCase` for const bindings
- Files: `kebab-case.ts` for modules, `PascalCase.ts` for classes/components

### File Structure
```
src/
├── domain/           # Pure domain logic, no dependencies
│   ├── user/
│   │   ├── user.ts
│   │   ├── user.repository.ts
│   │   └── user.errors.ts
├── application/      # Use cases, orchestration
│   └── user/
│       └── create-user.ts
├── infrastructure/   # External adapters
│   ├── persistence/
│   └── http/
└── shared/           # Cross-cutting utilities
    ├── types/
    └── utils/
```

## When Reviewing TypeScript Code

Check for:
1. Type safety violations (`any`, assertions, `!`)
2. Proper error handling (Result types vs exceptions)
3. Immutability (readonly, no mutations)
4. Pure functions (no side effects)
5. Domain modeling (proper use of types)
6. Separation of concerns (layers respected)
7. Test coverage and quality
