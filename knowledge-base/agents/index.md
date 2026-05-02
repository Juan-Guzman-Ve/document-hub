---
documentType: 'agent'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Agent Roster

> This folder contains the definitions for all agents in the team. Each agent has a defined role, responsibilities, hierarchy position, and the instruction files they must follow.

---

## Team Hierarchy

```
Product Owner
    └── Staff Engineer
          ├── Software Engineer
          │     ├── Backend Developer
          │     └── Frontend Developer
          └── QA Engineer
```

---

## Agents

| Agent              | Role                                                                                        | File                         |
| ------------------ | ------------------------------------------------------------------------------------------- | ---------------------------- |
| Product Owner      | Defines what to build and why. Owns the spec.                                               | [[product-owner.agent]]      |
| Staff Engineer     | Coordinates the team, owns architecture, reviews plans and code.                            | [[staff-engineer.agent]]     |
| Software Engineer  | Plans features, designs solutions, breaks down tasks.                                       | [[software-engineer.agent]]  |
| Backend Developer  | Implements backend tasks (C#/.NET, SQL).                                                    | [[backend-developer.agent]]  |
| Frontend Developer | Implements frontend tasks (TypeScript, Angular).                                            | [[frontend-developer.agent]] |
| QA Engineer        | Owns test quality, writes E2E tests, supplements integration gaps, and validates execution. | [[qa-engineer.agent]]        |

---

## Phase → Agent Ownership

| Phase (feature-workflow) | Owner                        | Participants                                                                                                      |
| ------------------------ | ---------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| Spec                     | Product Owner                | Product Owner (author), Staff Engineer (review)                                                                   |
| Plan                     | Software Engineer            | Staff Engineer (approval)                                                                                         |
| Tasks                    | Software Engineer            | Backend Dev, Frontend Dev, QA Engineer                                                                            |
| Implementation           | Backend / Frontend Developer | QA Engineer (E2E tests + integration gap coverage + automation if spec requires it), Staff Engineer (code review) |

---

*Last updated: 2026-05-01*


---

*Change reason: 2026-05-01 consistency and governance update*
*Impacted files: knowledge-base-wide policy alignment*