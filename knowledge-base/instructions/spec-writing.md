---
documentType: 'instruction'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Spec Writing

> **Purpose:** Define the rules the agent must apply when drafting `spec.md`. The spec is a **behavioral document** — it defines what the feature does and why it exists. Technical decisions, implementation details, API contracts, and delivery concerns belong in the plan, not the spec.
> **Used by:** `/kb-feature-spec` prompt, Phase 1 of the Feature Development Workflow.

---

## Hard Boundary — What the Spec Is NOT

The spec must never contain:

- Technical implementation choices (patterns, frameworks, libraries, DB schemas)
- API contract definitions (endpoints, request/response shapes, status codes)
- Infrastructure or deployment concerns
- Delivery obligations (migrations, client refreshes)
- Business rules expressed as code logic or conditions

If any of these appear in the draft, remove them. They belong in `plan.md`.

The spec is approved when it describes **what the system must do and why** — completely, clearly, and without any implementation detail.

---

## Acceptance Criteria Rules

Every scenario in the **Key Test Scenarios** section must satisfy all four properties:

| Property | Definition |
|---|---|
| **Observable** | Describes a visible outcome — state change, response, UI update — not internal implementation |
| **Testable** | Can be verified with a unit or integration test |
| **Specific** | Uses concrete values or states, not vague terms like "works correctly" or "handles properly" |
| **Traceable** | Can be linked to exactly one test when implementation begins |

**Examples:**

```
// Bad — vague, not testable
"The study metrics should load correctly."

// Bad — technical, belongs in plan.md
"The ETL job calls watson.designsubject with designsubjectid > 0 to count subjects."

// Good — behavioral, observable, specific
"When the nightly job runs for a study with 3 subjects and 2 treatments,
the statistics record for that study shows SubjectsCount = 3 and TreatmentsCount = 2."
```

If a scenario cannot be stated concretely without referencing implementation details, the behavior is not well-understood yet. Ask the human to clarify the expected outcome — do not include vague or technical scenarios.

---

## Test Coverage Expectations

Scenarios in the spec map to one of two test types:

| Test type | What it covers |
|---|---|
| **Unit** | A single function, method, or class in isolation — transformation logic, derivation rules, validation, error handling |
| **Integration** | A full service flow using real dependencies — the service method called end-to-end against a real or test DB, a real HTTP client, or a real background job |

Every scenario must have a `Type` assigned. Do not add E2E tests unless the proposal explicitly calls for them or the human requests it.

---

## Readiness Checklist

Before presenting any draft to the human, the agent must run this checklist internally. If any item fails, fix it or ask the human for the missing information. Do not present an incomplete spec.

- [ ] No technical implementation details appear anywhere in the draft
- [ ] No API contracts, endpoint definitions, or DB schema details are present
- [ ] Every scenario in Key Test Scenarios is Observable, Testable, Specific, and Traceable
- [ ] Every scenario has a `Type` assigned (unit / integration)
- [ ] No scenario uses vague language ("works correctly", "handles properly", "loads as expected")
- [ ] No scenario describes internal implementation (queries, patterns, method names)
- [ ] Out of Scope section is explicitly filled — not omitted
- [ ] All open questions are listed at the bottom of the draft

---

*Last updated: 2026-04-24*



---

*Change reason: 2026-05-01 consistency and governance update*
*Impacted files: knowledge-base-wide policy alignment*