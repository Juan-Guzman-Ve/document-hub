# Coding Style

> **Purpose:** Rules for writing clean, readable, and maintainable code.
> **Languages in scope:** TypeScript / JavaScript, C# / .NET
> **Paradigm:** Mixed OOP + Functional

---

## Naming Conventions

### TypeScript / JavaScript

| Construct | Convention | Example |
|---|---|---|
| Variables & functions | `camelCase` | `getUserById`, `isActive` |
| Classes, types, interfaces | `PascalCase` | `UserRepository`, `OrderDto` |
| Constants (module-level) | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT` |
| Enums | `PascalCase` (name and values) | `OrderStatus.Pending` |
| Files | `kebab-case` | `user-repository.ts` |

### C# / .NET

| Construct | Convention | Example |
|---|---|---|
| Variables & parameters | `camelCase` | `userId`, `isActive` |
| Methods, classes, properties | `PascalCase` | `GetUserById`, `UserRepository` |
| Private fields | `_camelCase` | `_userRepository` |
| Constants | `PascalCase` | `MaxRetryCount` |
| Interfaces | `IPascalCase` | `IUserRepository` |
| Files | `PascalCase` | `UserRepository.cs` |

### General naming rules

- Names should be self-explanatory — no abbreviations unless universally known (`id`, `url`, `dto`)
- Boolean variables/properties: use `is`, `has`, `can`, `should` prefixes (`isLoaded`, `hasPermission`)
- Avoid generic names: `data`, `info`, `temp`, `result`, `obj`, `manager` are red flags
- Functions should be named as **verbs**: `createUser`, `calculateTotal`, `validateInput`

---

## Functions

### One responsibility per function

A function does one thing. If you need the word "and" to describe what it does, split it.

### Size

No hard line limit, but a function should fit in a single screen without scrolling. If it doesn't, it's likely doing too much.

### Parameters

- **Prefer passing objects over long parameter lists.** When a function acts on an entity, pass the entity — not its individual fields.
- A single primitive argument is fine (`getUserById(id: string)`).
- When there are multiple parameters, use an options/input object.

```typescript
// ❌ Avoid
function createOrder(userId: string, productId: string, quantity: number, discount: number) {}

// ✅ Prefer
function createOrder(input: CreateOrderInput) {}
```

- **Avoid boolean flag parameters.** They signal the function is doing two things.

```typescript
// ❌ Avoid
function fetchUser(id: string, includeDeleted: boolean) {}

// ✅ Prefer
function fetchUser(id: string) {}
function fetchDeletedUser(id: string) {}
```

### Early return

Validate preconditions at the top and return early. Avoid deep `else` nesting.

```typescript
// ❌ Avoid
function processOrder(order: Order) {
  if (order) {
    if (order.isValid) {
      // main logic...
    }
  }
}

// ✅ Prefer
function processOrder(order: Order) {
  if (!order) return;
  if (!order.isValid) return;

  // main logic...
}
```

### Pure functions

Prefer functions without side effects when possible. A pure function always returns the same output for the same input and does not modify external state.

### Named conditions

Never write loose, multi-part conditions inline inside an `if` statement. Extract them into a descriptive boolean function or variable that communicates **what** is being verified.

```typescript
// ❌ Avoid — the intent is buried in raw comparisons
if (user.roleId === 5 && user.status === "active") {
  doSomething();
}

// ✅ Prefer — the condition is named and self-documenting
function isActiveAdmin(user: User): boolean {
  return user.roleId === 5 && user.status === "active";
}

if (isActiveAdmin(user)) {
  doSomething();
}
```

This applies equally to guard clauses and early returns:

```typescript
// ❌ Avoid
if (!order.items.length || order.status === "cancelled" || order.total <= 0) return;

// ✅ Prefer
function isOrderProcessable(order: Order): boolean {
  return order.items.length > 0
    && order.status !== "cancelled"
    && order.total > 0;
}

if (!isOrderProcessable(order)) return;
```

For simple one-off checks, a named `const` is enough:

```typescript
const isEligibleForDiscount = user.loyaltyYears >= 2 && cart.total > 100;
if (isEligibleForDiscount) applyDiscount(cart);
```

---

## Constants

**Never hardcode values inline.** All constant values must be named.

### Rules

- If a constant is used across multiple functions in a class or module → define it at the **top of the class/module**.
- If a constant is only used within one function → define it as a `const` at the **top of that function**.
- If a constant is shared across multiple files → extract it to a dedicated constants file.

```typescript
// ❌ Avoid
if (retries > 3) { ... }
const endpoint = "https://api.example.com/v2/users";

// ✅ Prefer — module-level
const MAX_RETRY_COUNT = 3;
const USERS_ENDPOINT = "/v2/users";

// ✅ Prefer — function-level (only used there)
function buildGreeting(name: string) {
  const defaultGreeting = "Hello";
  return `${defaultGreeting}, ${name}`;
}
```

---

## Abstraction Levels

A function should operate at a **single level of abstraction**. Don't mix high-level orchestration with low-level detail in the same function.

```typescript
// ❌ Mixed levels — orchestration + raw detail together
function submitOrder(cart: Cart) {
  const total = cart.items.reduce((sum, i) => sum + i.price * i.qty, 0);
  if (total > 0) {
    db.insert("orders", { userId: cart.userId, total });
  }
}

// ✅ Clean levels
function submitOrder(cart: Cart) {
  const total = calculateCartTotal(cart);
  if (total > 0) {
    orderRepository.save({ userId: cart.userId, total });
  }
}
```

---

## Nesting

Maximum **2–3 levels** of nesting. Deep nesting is a signal to extract logic into a function or use early returns.

---

## Code Readability — Code Tells a Story

> **Rule:** A reader should understand what the code does and why it exists by reading it — not by reading a comment that apologises for it.

Code is written once and read many times. Every function, variable, and class name is a sentence in a story. When the story is clear, comments become redundant. When the story is unclear, the fix is to rewrite the code — not to add a comment.

### No Spaghetti Code

Spaghetti code is logic with no clear structure — tangled responsibilities, unclear flow, functions doing five things at once, and state mutated from unpredictable places.

Signs you are writing spaghetti code:
- You cannot describe what a function does in one sentence
- You need to scroll to follow the logic
- You cannot change one part without touching three others
- Side effects happen in unexpected places

The fix is always the same: **break it down**. Extract functions. Separate concerns. Make the flow readable top-to-bottom.

### No Loose Code

Loose code is logic that lives outside a clear boundary — orphaned expressions, inline computations that belong in a named function, raw loops that should be a method, and values with no home.

```typescript
// ❌ Loose — what does this compute? What does 86400000 mean?
const x = Date.now() - createdAt.getTime() > 86400000;
if (x) { ... }

// ✅ Named and bounded
const ONE_DAY_MS = 86_400_000;

function isOlderThanOneDay(createdAt: Date): boolean {
  return Date.now() - createdAt.getTime() > ONE_DAY_MS;
}

if (isOlderThanOneDay(record.createdAt)) { ... }
```

Every piece of logic must have a clear name, a clear home, and a clear responsibility.

---

## Comments

**If you need a comment to explain what the code does, the code is not clean enough.**

Comments are not documentation for unclear logic. They are a last resort for explaining *why* a non-obvious decision was made — business rules, external constraints, known limitations. If a comment explains *what* the code does, rewrite the code until it explains itself.

### Rules

- **No explanatory headers.** Do not write blocks of comments at the top of a function or file explaining what it does. The name and structure should do that.
- **No section dividers with comments.** If you need `// --- fetch user ---` inside a function, the function is too long. Extract it.
- **No apology comments.** `// This is a bit hacky but it works` is a signal to fix the code, not to document it.
- **Comments explain why, never what.**
- **Never commit commented-out code.** Use version control for history.

```typescript
// ❌ Avoid — explains what, which the code already shows
// Increment the counter
counter++;

// ❌ Avoid — section divider hiding a function that should exist
// --- validate input ---
if (!input.name) throw new Error("...");
if (!input.email) throw new Error("...");

// ✅ Acceptable — explains a non-obvious why
// Downstream services crash on soft-deleted records — exclude them before passing
if (user.isDeleted) continue;

// ✅ Acceptable — documents a known external constraint
// The API returns 204 instead of 200 on updates — treat both as success
if (response.status === 204 || response.status === 200) { ... }
```

### The Test

Before adding any comment, ask: *"Could I rename something or extract a function so this comment is no longer needed?"*

If yes — do that instead.

---

## Error Handling

| Error type | Approach |
|---|---|
| **Unexpected / programming errors** | Throw exceptions — let them propagate or be caught at the boundary |
| **Expected / business errors** | Use a `Result` / `Either` pattern to make failure explicit in the return type |

```typescript
// Expected error — use Result
function parseAge(value: string): Result<number, string> {
  const n = parseInt(value);
  if (isNaN(n)) return Err("Invalid age");
  return Ok(n);
}

// Unexpected — throw
function getUser(id: string): User {
  const user = db.find(id);
  if (!user) throw new Error(`User ${id} not found — this should not happen`);
  return user;
}
```

---

## Generics

Use generics **only when they eliminate real duplication of logic** — not to be clever or flexible "in case" it's needed later (that's a YAGNI violation).

```typescript
// ✅ Justified — avoids repeating the same pagination logic per entity
interface Page<T> {
  items: T[];
  total: number;
  page: number;
}

// ✅ Justified — generic repository avoids one class per entity
interface IRepository<T> {
  findById(id: string): Promise<T | null>;
  save(entity: T): Promise<void>;
}
```

Constrain generics when the type isn't truly open:

```typescript
// ✅ Constrained — only entities with an id
function findById<T extends { id: string }>(list: T[], id: string): T | undefined {
  return list.find(item => item.id === id);
}
```

---

## Code Smells to Avoid

| Smell | Why it's a problem |
|---|---|
| Magic numbers/strings | Context-free values are unreadable and break single source of truth |
| Multiple abstraction levels in one function | Hard to read, test, and change independently |
| Nesting deeper than 2–3 levels | Signals missing early returns or extracted functions |
| Generic names (`data`, `info`, `temp`, `result`) | Communicate nothing about intent |
| Comments explaining WHAT the code does | The code is not clean enough — rewrite, don't comment |
| Comment blocks at the top of a function | The function name and structure should explain itself |
| Section-divider comments inside a function | The function is too long — extract |
| Commented-out code | Dead weight — delete it, use version control |
| Boolean flag parameters | Signal a function doing two things |
| Loose inline conditions in `if` statements | Bury intent — extract into a named function or variable |
| Logic with no clear name or home (loose code) | Unreadable and untestable — give it a function and a name |
| Functions that cannot be described in one sentence | Spaghetti — break responsibilities apart |

---

*Last updated: 2026-04-28*
