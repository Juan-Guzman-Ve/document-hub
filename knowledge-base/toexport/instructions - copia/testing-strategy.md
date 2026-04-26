# Testing Strategy

> **Purpose:** Define how, what, and when to test — with a focus on tests that tell a story and validate real behavior.
> **Tools:** Jest (TypeScript/JS), xUnit / NUnit / MSTest (C#), Playwright / Cypress (E2E)
> **Philosophy:** Test behavior, not implementation. Tests should read like a story of how the system works.

---

## Test Types

| Type | Scope | When to use |
|---|---|---|
| **Unit** | A single class or function in isolation | Core logic, domain rules, isolated transformations |
| **Integration** | A feature or flow using real dependencies | Background workers, service-to-DB flows, API clients |
| **E2E** | Full application from UI to backend | Critical user journeys, acceptance scenarios |

---

## Core Philosophy

### Tests tell a story

A test should describe a scenario a human can understand. Reading the test should explain what the system is supposed to do — not what lines of code it executes.

### No loose logic in test cases

A test case must not contain loose inline logic. Every setup step, assertion, and condition must be wrapped in a **descriptive named function** — the same way production code avoids loose conditions.

The test body itself should read like a story: high-level, intention-revealing calls only.

```typescript
// ❌ Avoid — loose logic scattered across the test body
it("should send a welcome email to new users", async () => {
  const user = { id: "1", email: "a@b.com", createdAt: new Date(), role: "user", verified: false };
  mockEmailService.send.mockResolvedValue(true);
  await onboardingService.handleNewUser(user);
  expect(mockEmailService.send).toHaveBeenCalledWith(
    expect.objectContaining({ to: "a@b.com", subject: expect.stringContaining("Welcome") })
  );
});

// ✅ Prefer — each step is a named, readable function
it("should send a welcome email to new users", async () => {
  // Given
  const user = aNewUnverifiedUser();
  givenEmailServiceWillSucceed();

  // When
  await onboardingService.handleNewUser(user);

  // Then
  thenWelcomeEmailWasSentTo(user.email);
});

function aNewUnverifiedUser(): User {
  return { id: "1", email: "a@b.com", createdAt: new Date(), role: "user", verified: false };
}

function givenEmailServiceWillSucceed() {
  mockEmailService.send.mockResolvedValue(true);
}

function thenWelcomeEmailWasSentTo(email: string) {
  expect(mockEmailService.send).toHaveBeenCalledWith(
    expect.objectContaining({ to: email, subject: expect.stringContaining("Welcome") })
  );
}
```

This applies equally in C# — use private helper methods for arrange and assert steps. The test method body should read at a single, high level of abstraction.

### Test behavior, not implementation

Test **what** the system does, not **how** it does it internally. If you can refactor the internals without changing the tests, the tests are well written. If every refactor breaks tests, they are testing implementation details.

### Entry point testing

For a feature or worker, the preferred approach is:

1. **Call the main entry point** (the principal function, method, or handler)
2. **Let the full execution run**
3. **Assert the outcomes** — state changes, return values, side effects

For flows where calling the full entry point isn't practical, call each step in sequence and assert at each boundary:

```
getElementFromDB → assert result → pass to next step → assert final outcome
```

This ensures tests reflect the real execution path, not a mocked-out simulation of it.

---

## What to Test

| Always test | Why |
|---|---|
| Domain / business logic | The core of the system — must be correct |
| Background workers and processors | Complex flows, high impact if broken |
| Service methods that orchestrate operations | Coordination logic is where bugs hide |
| External API client methods | Ensure contract with external systems is respected |
| Validation and transformation logic | Edge cases are common here |
| Error paths and failure handling | Confirm the system fails correctly, not silently |

---

## What NOT to Test

| Skip testing | Why |
|---|---|
| Constructors | No behavior — just wiring |
| Getters and setters | Plumbing, no logic |
| Scope guard functions (`isActiveUser`, `isEligible`) | Simple boolean checks; covered implicitly by callers |
| Framework internals | Trust the framework |
| Private implementation details | If they break, a behavioral test will catch it |

---

## Test Structure — Given / When / Then

All tests follow the **Given / When / Then** structure:

```
Given — the initial state or context
When  — the action or event that occurs
Then  — the expected outcome
```

### TypeScript (Jest) example

```typescript
describe("OrderProcessor", () => {
  it("should mark order as fulfilled when all items are shipped", async () => {
    // Given
    const order = buildOrder({ status: "pending", items: [buildItem({ shipped: true })] });
    const processor = new OrderProcessor(mockRepository);

    // When
    await processor.process(order);

    // Then
    expect(mockRepository.save).toHaveBeenCalledWith(
      expect.objectContaining({ status: "fulfilled" })
    );
  });
});
```

### C# (xUnit) example

```csharp
[Fact]
public async Task Process_ShouldMarkOrderFulfilled_WhenAllItemsAreShipped()
{
    // Given
    var order = OrderBuilder.Create().WithStatus("pending").WithAllItemsShipped().Build();
    var processor = new OrderProcessor(_mockRepository.Object);

    // When
    await processor.ProcessAsync(order);

    // Then
    _mockRepository.Verify(r => r.SaveAsync(It.Is<Order>(o => o.Status == "fulfilled")), Times.Once);
}
```

---

## Mocking Strategy

| Test type | Dependency approach |
|---|---|
| **Unit tests** | Mock all external dependencies (DB, APIs, services) |
| **Integration tests** | Use real implementations — actual DB (test instance), real HTTP clients, etc. |
| **E2E tests** | No mocks — full stack, real environment |

**Unit test mocking rules:**
- Only mock what crosses a boundary (I/O, network, time, randomness)
- Do not mock internal collaborators that can be instantiated cheaply
- Prefer constructor injection to make mocking straightforward

---

## Test Naming

Test names should describe the scenario, not the method:

```
// ❌ Avoid
"Process_Test"
"TestOrderFulfillment"

// ✅ Prefer
"should mark order as fulfilled when all items are shipped"
"should throw when order has no items"
"given a cancelled order, processing should be skipped"
```

Pattern: `should [expected behavior] when [condition]` or `given [context], [action] should [outcome]`

---

## Coverage

No fixed coverage target. Instead, apply this judgment:

- **Critical paths must be covered** — if it's in the business logic, it needs a test
- **Coverage for its own sake is a trap** — testing getters to hit 90% is wasted effort
- A feature is considered tested when its main flows (happy path + key failure paths) have passing tests

---

## Test File Location

Co-locate tests with the code they test or use a parallel `/tests` folder — follow the convention of the project. Agents must check the project's existing structure before creating test files.

---

*Last updated: 2026-04-20*
