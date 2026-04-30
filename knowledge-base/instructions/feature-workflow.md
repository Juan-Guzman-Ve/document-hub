
# Feature Development Workflow

> **Purpose:** Define the Spec-Driven Development (SDD) process that the master agent must follow when implementing a new feature. Each phase produces a document and requires explicit human approval before the next phase begins.
> **Applies to:** back-end, front-end, database, research, and testing features.

---

## Folder Structure

Every feature folder `features/` folder will be defined on the copilo-instructions.md of each repo . The master agent must create the feature folder before starting the spec:

```
location/
└── Features/
    └── {feature-name}-{backlog-ticket-number}/
        ├── proposal.md          ← written by human before the agent starts
        ├── spec.md
        ├── plan.md
        ├── tasks.md
        └── implementation.md
```

The folder name must match the pattern: `{kebab-case-feature-name}-{BACKLOG_TICKET_NUMBER}`.

---

## Phase Overview

```
[Branch Check] → Proposal → Spec → Plan → Tasks → Implementation
                    ↑          ↑      ↑       ↑          ↑
                  human      human  human   human       human
                  writes    approval approval approval  approval
```

Every phase ends with a **human approval gate.** The agent must not proceed to the next phase without explicit approval. If a phase is rejected, the agent revises and resubmits — it does not skip forward.

---

## Pre-Phase — Branch Check

**Goal:** Ensure the agent is operating on a valid feature branch before any work begins.

Before reading the `proposal.md` or starting any phase, the agent must:

1. **Check the current branch** — run `git branch --show-current` (or equivalent)
2. **Evaluate the branch name** against the naming convention in `git-conventions.md`:
   - Must follow the pattern: `AB#{AZURE_ITEM_NUMBER}`
3. **If already on a valid `AB#` branch** → proceed to Phase 0
4. **If on `main`, `develop`, or any non-`AB#` branch** → **stop and create a branch**

### Creating the branch

The agent must ask the human for the Azure DevOps backlog item number, then branch off `main` and switch to it:

```bash
git checkout main
git pull
git checkout -b AB#{AZURE_ITEM_NUMBER}
```

> **Rule:** Never start work on `main`. The agent must not proceed past this check without a valid `AB#` branch.

---

## Phase 0 — Proposal

**File:** `proposal.md`
**Goal:** Capture the human's initial idea for what is going to be built — rough, unrefined, and written before the agent does any work.

This is a **human-authored** document. The agent does not generate it. The proposal is an informal draft that gives enough context for the agent to start the Spec phase. It does not need to be complete or technically precise — its purpose is to communicate intent.

The proposal should answer, at a minimum:
- What is the rough idea or feature request?
- What problem or need does it address?
- Any known constraints, preferences, or non-negotiables the human has in mind?

### proposal.md Template

```markdown
# Proposal — {Feature Name}

**Ticket:** {BACKLOG_TICKET_NUMBER}  *(can be filled in later)*
**Date:** YYYY-MM-DD
**Author:** {Human Name}

---

## Idea
A free-form description of what you want to build. No format required — write as much or as little as you know.

## Problem / Motivation
Why does this need to exist? What is the pain point or opportunity?

## Known Constraints or Preferences *(optional)*
Anything the implementation must or must not do, based on what you already know.

## Open Questions *(optional)*
Anything you're unsure about that you want the agent to help clarify during the Spec phase.
```

**Approval gate:** The human submits `proposal.md` to start the workflow. The agent reads it and uses it as the primary input for drafting `spec.md`. No agent approval is needed on the proposal itself — it is the starting point, not a deliverable.

---

## Phase 1 — Spec

**File:** `spec.md`
**Goal:** Define the **what** and the **why**. No technical decisions yet.
**Rules:** All spec drafts must follow `spec-writing.md` — acceptance criteria quality, API contract rules, delivery obligations, and the readiness checklist.

The spec captures the feature from a product/behavior perspective:
- What is the feature about?
- What problem does it solve?
- What is the main happy path?
- What are the key test scenarios (behavior-level, not implementation-level)?

If the agent has technical questions that would affect the spec, it lists them at the bottom of `spec.md`. The human answers them inline and resubmits for approval, or corrects the spec directly. The spec is not approved until all questions are resolved.

### spec.md Template

```markdown
# Spec — {Feature Name}

**Ticket:** {BACKLOG_TICKET_NUMBER}
**Type:** back | front | back+front | database | research | testing
**Status:** Draft | Approved

---

## Overview
What this feature is and why it exists. One paragraph.

## Main Happy Path
Step-by-step description of the primary flow from the user/system perspective.
No technical details — behavior only.

1. ...
2. ...
3. ...

## Key Test Scenarios
Behavior-level scenarios (Given/When/Then). No implementation details.
Every scenario must be Observable, Testable, Specific, and Traceable (see spec-writing.md).

| # | Scenario | Given | When | Then | Type |
|---|---|---|---|---|---|
| 1 | Happy path | ... | ... | ... | unit / integration |
| 2 | ... | ... | ... | ... | unit / integration |

## Out of Scope
Anything explicitly excluded from this feature.
```

**Approval gate:** Human reviews `spec.md`. If the agent listed open questions, the human answers them inline and the agent revises before resubmitting. Approval is only given when the spec is complete and all questions are resolved.

---

## Phase 2 — Plan

**File:** `plan.md`
**Goal:** Define the **how** — architecture, stack decisions, and design for this feature.

Based on the approved spec and any clarifications, the agent produces the technical plan. This is where patterns, layers, tools, and design decisions are made explicit.

The agent must:
- Reference relevant instruction files (`design-patterns.md`, `coding-style.md`, etc.)
- Follow the repo's `copilot-instructions.md` for stack and structural conventions
- Propose only what is needed for this feature (YAGNI)




### plan.md Template

```markdown
# Plan — {Feature Name}

**Ticket:** {BACKLOG_TICKET_NUMBER}
**Status:** Draft | Approved

---

## Stack & Tools
Languages, frameworks, libraries, and external services involved in this feature.

| Concern | Tool / Approach |
|---|---|
| ... | ... |

## Architecture & Design
Description of the design — layers involved, patterns applied, data flow.

Reference relevant patterns from  [[design-patterns]] where applicable.

### Components / Modules
List the new or modified components and their responsibilities.

| Component | Responsibility | New / Modified |
|---|---|---|
| ... | ... | ... |

## Data Design *(if applicable)*
Schema changes, new entities, or data contracts involved.

## External Dependencies *(if applicable)*
APIs, services, or systems this feature integrates with.

## Risks & Trade-offs
Known risks or trade-offs in the proposed design.
```

**Approval gate:** Human reviews and approves `plan.md` before task breakdown begins.

---

## Phase 3 — Tasks

**File:** `tasks.md`
**Goal:** Break the approved plan into concrete, actionable tasks with test coverage defined upfront.

Each task must be:
- Self-contained and completable independently when possible
- Assigned a status that the agent keeps updated throughout implementation
- Paired with its expected test cases

### Task Statuses

| Status | Meaning |
|---|---|
| `not started` | Not yet begun |
| `in progress` | Currently being worked on |
| `completed` | Done and verified |
| `blocked` | Cannot proceed — see comment |

### tasks.md Template

```markdown
# Tasks — {Feature Name}

**Ticket:** {BACKLOG_TICKET_NUMBER}
**Status:** Draft | Approved | In Progress | Completed

---

## Task List

| # | Task | Summary | Status | Comment |
|---|---|---|---|---|
| 1 | ... | ... | not started | |
| 2 | ... | ... | not started | |

---

## Task Detail

### Task 1 — {Task Name}

**Status:** not started
**Comment:** —

#### What
Brief description of what this task implements.

#### Test Cases
| # | Scenario | Given | When | Then | Type |
|---|---|---|---|---|---|
| 1 | ... | ... | ... | ... | unit / integration / e2e |

---

### Task 2 — {Task Name}
...
```

**Approval gate:** Human reviews and approves `tasks.md` before implementation begins.

---

## Phase 4 — Implementation

**File:** `implementation.md`
**Goal:** Execute the approved tasks and produce a final report of what was done.

The agent works through `tasks.md` sequentially (or in parallel when tasks are independent), updating task statuses as it goes. When all tasks are done, it creates `implementation.md` as the completion record.

The agent must:
- Follow `coding-style.md` and `principles.md` at all times
- Follow `testing-strategy.md` when writing tests
- Update `tasks.md` status fields as each task progresses
- Stop and report to the master agent (who escalates to the human) if anything unexpected is found

### implementation.md Template

```markdown
# Implementation Report — {Feature Name}

**Ticket:** {BACKLOG_TICKET_NUMBER}
**Completed:** YYYY-MM-DD
**Status:** Completed | Completed with deviations | Blocked

---

## Execution Log

| Task | Status | Notes |
|---|---|---|
| Task 1 — {name} | completed | |
| Task 2 — {name} | completed | |

---

## Deviations
Any cases where implementation differed from the plan and why.

## Open Questions / Follow-up
Anything that came up during implementation that requires future attention.

## Final Status
Summary of what was delivered and whether all test cases defined in tasks.md are passing.
```

**Approval gate:** Human reviews `implementation.md` and confirms the feature is complete.

---

## Instruction Files by Feature Type

When creating the plan and tasks, the master agent must reference the relevant instruction files:

| Feature type | Instruction files to apply |
|---|---|
| Back-end | `design-patterns.md`, `coding-style.md`, `principles.md`, `testing-strategy.md` |
| Front-end | `coding-style.md`, `principles.md`, `testing-strategy.md` |
| Database | `principles.md`, `coding-style.md` |
| Research | `research-instructions.md` |
| Testing | `testing-strategy.md`, `coding-style.md` |

Always also check the repo's `copilot-instructions.md` for repo-specific instructions that override or extend these.

---

*Last updated: 2026-04-24*
