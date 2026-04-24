# Design Patterns

> **Purpose:** Reference guide for pattern selection. Patterns are applied **only when they solve a concrete, existing problem** — not preemptively.
> **Languages in scope:** TypeScript / JavaScript, C# / .NET
> **Paradigm:** Mixed OOP + Functional

---

## How to Use This Document

Each pattern is described with:
- **Problem it solves** — the concrete scenario that justifies using it
- **When to use** — clear signals that this pattern is appropriate
- **When NOT to use** — over-engineering traps to avoid
- **Notes** — language-specific tips or variations

---

## Patterns

### Repository

**Problem:** You want to decouple data access logic from business logic, so the source (DB, API, in-memory) can change without affecting the rest of the code.

**When to use:**
- You have domain models that need to be persisted or retrieved
- You want to make data access testable via mocks or in-memory implementations
- Multiple layers need to access the same data without knowing the source

**When NOT to use:**
- Simple CRUD apps where the data layer has no real complexity
- When adding it just wraps an ORM without providing real abstraction

**Notes:**
- Prefer generic repositories: `IRepository<T>` / `Repository<T>` to avoid repetition per entity
- Avoid leaking query language (SQL, LINQ expressions) outside the repository boundary

---

### Strategy

**Problem:** You have multiple algorithms or behaviors that can be swapped at runtime, and using conditionals (`if/switch`) to select them makes the code rigid.

**When to use:**
- You find yourself writing `if type === 'A' do X, if type === 'B' do Y` repeatedly
- Behaviors need to be interchangeable without changing the caller
- You want to add new behaviors without modifying existing code

**When NOT to use:**
- When there are only 2 variants and they won't grow — a simple conditional is clearer
- When the strategy objects have no state and the logic is trivial

**Notes:**
- In TypeScript/JS, strategies can be plain functions instead of classes: `(input: T) => Output`
- Combine with Dependency Injection to inject the strategy at composition root

---

### Decorator

**Problem:** You want to add responsibilities to an object dynamically without modifying its class or creating a deep inheritance chain.

**When to use:**
- Cross-cutting concerns: logging, caching, validation, authorization wrapping a core behavior
- You need to compose behaviors at runtime

**When NOT to use:**
- When the behavior is always applied — just put it in the base implementation
- When it creates too many small wrapper classes with unclear ownership

**Notes:**
- In TypeScript, class decorators or higher-order functions both work; prefer HOFs for pure functions
- In C#, interfaces + wrapper classes are the standard approach

---

### Factory / Abstract Factory

**Problem:** Object creation logic is complex or depends on conditions, and spreading `new` calls across the codebase makes it hard to change.

**When to use:**
- Construction involves multiple steps or conditional logic
- You want to centralize object creation to a single place
- Creating families of related objects that must be used together (Abstract Factory)

**When NOT to use:**
- When construction is trivial — a plain `new` is more readable
- When DI container already manages object lifetimes and creation

**Notes:**
- Static factory methods (`User.create(...)`) are a lightweight alternative for simple cases
- Abstract Factory is appropriate when you need to swap entire families (e.g., different DB providers)

---

### Builder

**Problem:** An object requires many optional parameters or a complex construction sequence, making constructors unreadable.

**When to use:**
- More than 3–4 optional parameters in an object
- Construction requires a specific order or validation between steps
- You want to produce different representations of the same construction process

**When NOT to use:**
- When the object is simple — use an options object `{ }` literal instead
- When a factory or plain constructor is sufficient

**Notes:**
- In TypeScript, a fluent builder pattern with method chaining reads naturally
- In test code, builders are excellent for creating test fixtures with sensible defaults

---

### Command

**Problem:** You need to encapsulate a request as an object so it can be queued, logged, undone, or handled by different handlers.

**When to use:**
- Implementing undo/redo functionality
- Queuing operations for deferred execution
- Separating the request from its executor (e.g., CQRS write side)
- Auditing — every action is a recorded command object

**When NOT to use:**
- When a simple function call is sufficient and decoupling is not needed
- Small scripts or utilities without audit/undo requirements

**Notes:**
- In a CQRS setup, Commands represent write intentions and should be immutable value objects
- Keep commands as plain data objects (no logic); logic lives in the handler

---

### CQRS (Command Query Responsibility Segregation)

**Problem:** A single model handling both reads and writes becomes complex because read and write optimizations conflict.

**When to use:**
- Applications where read models and write models have very different shapes
- High-traffic systems where reads and writes need independent scaling
- When you already have Commands and need a clean way to handle queries separately

**When NOT to use:**
- Simple CRUD applications — CQRS adds significant complexity for no gain
- Small teams or early-stage projects where iteration speed matters more than architecture
- When the read and write models are essentially the same

**Notes:**
- Start without CQRS; migrate to it when the complexity justifies it
- Does not require Event Sourcing — they are separate patterns

---

### Dependency Injection (DI)

**Problem:** Classes depend on concrete implementations, making them hard to test and tightly coupled.

**When to use:**
- Any class that has external dependencies (DB, services, configs, HTTP clients)
- When you want to swap implementations without modifying consumers (e.g., test doubles)
- As the default wiring mechanism in any non-trivial application

**When NOT to use:**
- Utility functions with no side effects — pure functions don't need DI
- Over-injecting simple values (primitives, constants) that don't change

**Notes:**
- Inject interfaces, not concrete classes
- Use the DI container at the composition root only — avoid Service Locator pattern
- In C#, use constructor injection as the default; avoid property injection except for optional dependencies
- In TypeScript/NestJS or similar, rely on the framework's DI container

---

## Quick Reference: Problem → Pattern

| Problem | Pattern |
|---|---|
| Too many conditionals for behavior selection | Strategy |
| Complex object creation logic | Factory / Abstract Factory |
| Many optional constructor params | Builder |
| Decoupling data access from business logic | Repository |
| Adding cross-cutting concerns dynamically | Decorator |
| Encapsulating and deferring requests | Command |
| Separating read and write models | CQRS |
| Decoupling classes from their dependencies | Dependency Injection |

---

## A Note on Generics

Generics enhance several of these patterns (e.g., `IRepository<T>`, `IHandler<TCommand>`). The principles and rules for writing and constraining generics are covered in [coding-style.md](coding-style.md).

---

*Last updated: 2026-04-20*
