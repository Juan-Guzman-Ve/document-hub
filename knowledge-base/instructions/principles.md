# Software Principles

> **Purpose:** Core principles that guide every design and implementation decision.
> **Priority:** DRY, YAGNI, and SOLID are non-negotiable. Apply all others with judgment.

---

## Core Principles

### DRY — Don't Repeat Yourself ⭐

Every piece of knowledge must have a single, authoritative representation in the system.

**Practical note:** Before duplicating logic, ask if it belongs to a shared utility, a base class, or a generic abstraction. Duplication is only acceptable when two things *look* the same but represent different concepts that may evolve independently.

---

### YAGNI — You Aren't Gonna Need It ⭐

Don't build features, abstractions, or configuration options for requirements that don't exist yet.

**Practical note:** If it's not needed today and there's no concrete plan for it, don't build it. Speculative generality adds complexity with no current return. Remove it when refactoring.

---

### KISS — Keep It Simple, Stupid

Prefer the simplest solution that correctly solves the problem.

**Practical note:** If you need to explain your own code to understand it, it's too complex. Clever code is a liability. Write for the reader, not the compiler.

---

### SOLID ⭐

| Letter | Principle | Description |
|---|---|---|
| **S** | Single Responsibility | A class/module should have one reason to change |
| **O** | Open/Closed | Open for extension, closed for modification |
| **L** | Liskov Substitution | Subtypes must be substitutable for their base types |
| **I** | Interface Segregation | Prefer many small, specific interfaces over one large one |
| **D** | Dependency Inversion | Depend on abstractions, not concretions |

**Practical note:** Don't apply SOLID mechanically. Use it as a diagnostic tool — when a class is hard to test, change, or extend, identify which principle is being violated and refactor accordingly.

---

### Separation of Concerns

Different responsibilities should live in different modules, layers, or files. Mixing them creates tight coupling and reduces testability.

**Practical note:** A function that fetches data, transforms it, and renders it is doing three jobs. Split it. Each layer should only know what it needs to do its job.

---

### Composition over Inheritance

Prefer composing behaviors from smaller, focused units rather than extending base classes.

**Practical note:** Inheritance creates tight coupling between parent and child. Use it only when there is a true "is-a" relationship. For everything else, use interfaces, mixins, or higher-order functions.

---

### Law of Demeter — Principle of Least Knowledge

A module should only talk to its immediate dependencies, not to the dependencies of its dependencies.

**Practical note:** Avoid chains like `order.customer.address.city`. Each dot after the first is a red flag — you're reaching into internals you shouldn't know about. Expose what's needed through a clear interface.

---

### Fail Fast

Validate inputs and preconditions as early as possible. Surface errors immediately rather than letting them propagate silently.

**Practical note:** Check at system boundaries (API endpoints, function entries, service inputs). Don't let invalid state travel deep into the system before being caught. Throw or return errors early and explicitly.

---

### Single Source of Truth

Any piece of data or configuration should have exactly one authoritative source in the system.

**Practical note:** Derived values should be computed, not stored separately. Duplicated state always diverges. If two places must hold the same value, one of them is wrong — unify them.

---

## Hierarchy of Priority

When principles conflict, use this order as a guide:

1. **Correctness** — the code must be right first
2. **Clarity** — readable > clever
3. **DRY / Single Source of Truth** — no duplicate knowledge
4. **YAGNI** — no speculative complexity
5. **SOLID** — structure for maintainability and testability
6. **Everything else** — applied with judgment per context

---

*Last updated: 2026-04-20*
