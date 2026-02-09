# Mandatory Stack Skills — React + TypeScript + TanStack Query

> These skills are HARDCODED. They ship with Clean Claude and are NOT generated.
> The Architect copies this section as-is into specs/stack/stack-skills.md,
> then appends project-specific skills for additional libraries.

---

## TypeScript — Strict Mode, No Escape Hatches

### DO

```typescript
// Strict types — types are documentation
interface User {
  readonly id: string;
  readonly email: string;
  readonly name: string;
}

// Discriminated unions for states
type AsyncState<T, E = Error> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: E };

// Result type for explicit errors
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E };

const ok = <T>(value: T): Result<T, never> => ({ ok: true, value });
const err = <E>(error: E): Result<never, E> => ({ ok: false, error });

// Brand types for nominal typing
type UserId = string & { readonly __brand: 'UserId' };
type Email = string & { readonly __brand: 'Email' };
```

### DON'T

```typescript
// ❌ any — use unknown + type guards
const data: any = fetchData();

// ❌ as unknown as — double cast is a type smell
const user = data as unknown as User;

// ❌ @ts-ignore / @ts-expect-error — fix the type
// @ts-ignore
const broken = thing.method();

// ❌ throw for expected cases — use Result<T,E>
function getUser(id: string): User {
  throw new Error('Not found'); // caller doesn't know this can fail
}

// ✅ Instead:
function getUser(id: string): Result<User, NotFoundError> {
  if (!user) return err(new NotFoundError(id));
  return ok(user);
}
```

---

## React — Components Are Pure Presenters

### Component Patterns

```tsx
// ✅ Composition over configuration
<Modal>
  <Modal.Header>Title</Modal.Header>
  <Modal.Body>{content}</Modal.Body>
</Modal>

// ❌ Configuration hell
<Modal title="Title" showHeader showFooter footerButtons={['ok']} />
```

### State Colocation

```
1. Local state (useState)     → UI state, form inputs, toggles
2. Lifted state               → Shared between siblings
3. Context                    → Theme, auth, truly global
4. Server state (useQuery)    → API data — NEVER in useState
5. URL state                  → Filters, pagination, shareable
```

### Hooks Discipline

```tsx
// ✅ Derive directly — no useEffect for derived state
const fullName = `${firstName} ${lastName}`;

// ❌ BAD: useEffect for derived state
useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);

// ✅ Custom hooks extract reusable logic
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState(value);
  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(timer);
  }, [value, delay]);
  return debouncedValue;
}
```

### DO

```tsx
// Semantic HTML first
<button type="submit" onClick={handleSubmit}>Send</button>
<nav aria-label="Main navigation">{links}</nav>

// Accessible interactive elements
<dialog open={isOpen} aria-labelledby="title">
  <h2 id="title">Confirm</h2>
</dialog>

// Keyboard navigation
onKeyDown={(e) => e.key === 'Escape' && onClose()}
```

### DON'T

```tsx
// ❌ div for interactive elements
<div onClick={handleClick}>Submit</div>

// ❌ dangerouslySetInnerHTML — XSS risk
<div dangerouslySetInnerHTML={{ __html: content }} />

// ❌ direct DOM access — use useRef
document.getElementById('myDiv')

// ❌ console.log in production
console.log('debug:', data);
```

---

## TanStack Query — Server State Done Right

### Data Fetching

```tsx
// ✅ useQuery for server state
const { data: users, isLoading, error } = useQuery({
  queryKey: ['users'],
  queryFn: () => api.getUsers(),
});

// ✅ useQuery with parameters
const { data: user } = useQuery({
  queryKey: ['users', userId],
  queryFn: () => api.getUser(userId),
  enabled: !!userId,
});

// ✅ useMutation for writes
const createUser = useMutation({
  mutationFn: (input: CreateUserInput) => api.createUser(input),
  onSuccess: () => {
    queryClient.invalidateQueries({ queryKey: ['users'] });
  },
});
```

### DON'T

```tsx
// ❌ useState + useEffect + fetch — TanStack does this better
const [users, setUsers] = useState([]);
const [loading, setLoading] = useState(false);
useEffect(() => {
  setLoading(true);
  fetch('/api/users')
    .then(r => r.json())
    .then(setUsers)
    .finally(() => setLoading(false));
}, []);
// No caching, no revalidation, no error handling, no dedup

// ❌ useEffect + fetch — use useQuery
useEffect(() => {
  fetchUsers().then(setUsers);
}, []);

// ❌ Manual cache management — TanStack handles it
localStorage.setItem('users', JSON.stringify(users));
```

### Query Keys Convention

```typescript
// ✅ Hierarchical keys for smart invalidation
['users']                    // all users
['users', 'list', filters]  // filtered list
['users', userId]            // single user
['users', userId, 'posts']   // user's posts

// Invalidate all user-related queries
queryClient.invalidateQueries({ queryKey: ['users'] });
```

### QueryClient Setup

```tsx
// ✅ Proper defaults
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000,      // 5 minutes
      retry: 1,
      refetchOnWindowFocus: false,
    },
  },
});

// ✅ Test setup — no retries, no cache
const testQueryClient = new QueryClient({
  defaultOptions: {
    queries: { retry: false, gcTime: 0 },
  },
});
```

---

## Testing — BDD, User-Centric

### Query by Role (Testing Library)

```tsx
// ✅ Query like a user
screen.getByRole('button', { name: /submit/i });
screen.getByLabelText(/email/i);
screen.getByRole('heading', { level: 1 });

// ❌ Query by implementation
screen.getByTestId('submit-btn');
screen.getByClassName('email-input');
```

### Test Structure (BDD)

```tsx
describe('LoginForm', () => {
  it('should submit credentials when form is valid', async () => {
    const user = userEvent.setup();
    const onSubmit = vi.fn();

    render(<LoginForm onSubmit={onSubmit} />);

    await user.type(screen.getByLabelText(/email/i), 'john@example.com');
    await user.type(screen.getByLabelText(/password/i), 'secret123');
    await user.click(screen.getByRole('button', { name: /sign in/i }));

    expect(onSubmit).toHaveBeenCalledWith({
      email: 'john@example.com',
      password: 'secret123',
    });
  });

  it('should show error when email is invalid', async () => {
    const user = userEvent.setup();
    render(<LoginForm onSubmit={vi.fn()} />);

    await user.type(screen.getByLabelText(/email/i), 'not-an-email');
    await user.click(screen.getByRole('button', { name: /sign in/i }));

    expect(screen.getByRole('alert')).toHaveTextContent(/invalid email/i);
  });
});
```

### Testing with TanStack Query

```tsx
// ✅ Wrap in QueryClientProvider for tests
import { render } from '@/test/test-utils'; // custom render with providers

// ✅ Mock API calls, not hooks
vi.mock('@/lib/api', () => ({
  getUsers: vi.fn().mockResolvedValue([{ id: '1', name: 'John' }]),
}));
```

---

## Architecture — Hexagonal Adapted to Frontend

### Lean Hexagonal (for React + TanStack)

```
src/
├── domain/           # PURE — no React, no TanStack, no framework imports
│   ├── types.ts      # Entities, value objects, branded types
│   ├── errors.ts     # Domain errors (typed, not thrown)
│   └── rules.ts      # Business rules (pure functions)
│
├── api/              # Infrastructure — API calls + mappers
│   ├── client.ts     # HTTP client setup
│   ├── users.api.ts  # API functions (fetch, transform)
│   └── mappers/      # DTO → Domain mapping
│
├── hooks/            # Application layer — TanStack hooks ARE the use cases
│   ├── useUsers.ts   # useQuery wrapping api + domain
│   └── useCreateUser.ts
│
├── components/       # Presentation — pure React
│   ├── ui/           # Generic (Button, Modal, Input)
│   └── features/     # Feature-specific (UserList, UserForm)
│
└── pages/            # Route-level components (if using router)
```

### Key Rule: Domain Is PURE

```typescript
// ✅ domain/types.ts — ZERO imports from react, @tanstack, axios, etc.
import type { Result } from './result';

// ❌ domain/types.ts — framework leak
import { useQuery } from '@tanstack/react-query'; // FORBIDDEN in domain
```

### TanStack Hooks = Application Layer

```
Classic hexagonal:     domain → application/use-cases → infrastructure
Lean frontend:         domain → hooks (useQuery/useMutation) → api

TanStack hooks replace use-cases for simple CRUD.
Use-case files only for complex multi-step orchestration.
```
