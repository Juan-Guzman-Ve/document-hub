# Knowledge Base

> This is the main entry point for all agents. Before executing any task, read this index to understand what resources are available and where to find them.
> Everything an agent needs — instructions, agent definitions, and skills — lives inside this knowledge base.

---

## Structure

```
knowledge-base/
├── index.md              ← you are here
├── instructions/         ← how to work: principles, conventions, workflows
├── agents/               ← who does what: agent roles and responsibilities
├── prompts/              ← executable slash commands for VS Code Copilot Chat
└── skills/               ← how to execute specific recurring tasks
```

---

## Instructions

Rules and conventions that apply to all agents across all tasks. Consult the instructions index to find the right file for any given situation.

→ [[Document Hub/knowledge-base/instructions/index|Instructions Index]]

| File | Purpose |
|---|---|
| [[init-workflow\|Init Workflow]] | How to initialize `copilot-instructions.md` for a repo that has none |
| [[design-patterns\|Design Patterns]] | Pattern selection guide — problem → pattern |
| [[principles\|Principles]] | DRY, YAGNI, KISS, SOLID and more — the non-negotiables |
| [[coding-style\|Coding Style]] | Naming, functions, constants, error handling, generics |
| [[research-instructions\|Research Instructions]] | How to delegate research to subagents |
| [[git-conventions\|Git Conventions]] | Branching, commits, PRs |
| [[testing-strategy\|Testing Strategy]] | What to test, how to write tests, mocking strategy |
| [[project-structure\|Project Structure]] | How to discover and respect repo structure |
| [[agent-prompting\|Agent Prompting]] | How to brief and delegate tasks to subagents |
| [[feature-workflow\|Feature Workflow]] | Spec-Driven Development — 5-phase feature process |

---

## Agents

Definitions for each agent in the team — role, responsibilities, hierarchy, and which instructions they follow.

→ [[Document Hub/knowledge-base/agents/index| Agents Roster]]

| Agent                                            | Role                                                       |
| ------------------------------------------------ | ---------------------------------------------------------- |
| [[product-owner.agent\|Product Owner]]           | Owns the spec — defines what and why                       |
| [[staff-engineer.agent\|Staff Engineer]]         | Technical authority — architecture, code review, oversight |
| [[software-engineer.agent\|Software Engineer]]   | Plans features and breaks them into tasks                  |
| [[backend-developer.agent\|Backend Developer]]   | Implements backend tasks (C#/.NET, SQL)                    |
| [[frontend-developer.agent\|Frontend Developer]] | Implements frontend tasks (TypeScript, Angular)            |
| [[qa-engineer.agent\|QA Engineer]]               | Owns test quality and validation                           |

---

## Prompts

Executable slash commands for VS Code Copilot Chat. Type the command directly in chat — no explanation required.

→ [[Document Hub/knowledge-base/prompts/index|Prompts Index]]

| Command | What it does |
| --- | --- |
| `/research`        | Research a technical topic using parallel subagents                         |
| `/compress-context`| Compress and save feature context to `context/context-latest.md`            |
| `/create-feature`  | Start a new feature — create branch, scaffold feature folder and `proposal.md` |
| `/init-codespace`  | Initialize a repository — scan, confirm stack, generate `copilot-instructions.md` + `.code-workspace` |
| `/write-spec`      | Draft `spec.md` from the approved `proposal.md`                             |
| `/write-plan`      | Draft `plan.md` from the approved `spec.md`                                 |
| `/write-tasks`     | Break the approved `plan.md` into `tasks.md` with test cases                |
| `/implement`       | Execute approved tasks and produce `implementation.md`                      |
| `/eod`             | Generate an end-of-day progress summary for the current session             |

---

## Skills

Scoped instruction files for executing specific recurring tasks. Each skill defines a step-by-step execution guide for a particular type of work.

→ [[Document Hub/knowledge-base/skills/index|Skills Index]]

| Skill | What it does |
|---|---|
| [[skills/get-azure-work-item\|Get Azure Work Item]] | Retrieve a backlog ticket by ID or title and present it in a standard format |

---

## Guides

Human-facing documentation. These files are not loaded by agents — they are one-time reference material for developers setting up their environment.

| Guide | Purpose |
|---|---|
| [[guides/developer-environment-setup\|Developer Environment Setup]] | One-time machine setup — folder convention and VS Code agent registration |

---

## Quick Reference — Situation → Where to Look

| Situation                     | Go to                                                                                               |
| ----------------------------- | --------------------------------------------------------------------------------------------------- |
| Setting up a new machine      | [[guides/developer-environment-setup\|Developer Environment Setup]]                                 |
| Entering a repo with no setup | `/init-codespace` → [[init-workflow\|Init Workflow]]                                                |
| Starting a new feature        | `/create-feature` → [[feature-workflow\|Feature Workflow]] → [[Document Hub/knowledge-base/agents/index\|Agent Roster]] |
| Writing the spec              | `/write-spec` → [[feature-workflow\|Feature Workflow]]                                              |
| Writing the plan              | `/write-plan` → [[feature-workflow\|Feature Workflow]] → [[design-patterns\|Design Patterns]]       |
| Writing tasks                 | `/write-tasks` → [[feature-workflow\|Feature Workflow]] → [[testing-strategy\|Testing Strategy]]    |
| Implementing a feature        | `/implement` → [[feature-workflow\|Feature Workflow]]                                               |
| Writing or reviewing code     | [[coding-style\|Coding Style]] → [[principles\|Principles]]                                         |
| Designing a solution          | [[design-patterns\|Design Patterns]] → [[principles\|Principles]]                                   |
| Researching a problem         | `/research` → [[research-instructions\|Research Instructions]]                                      |
| Writing tests                 | [[testing-strategy\|Testing Strategy]]                                                              |
| Creating branches or commits  | [[git-conventions\|Git Conventions]]                                                                |
| Delegating to a subagent      | [[agent-prompting\|Agent Prompting]]                                                                |
| Working in an unfamiliar repo | [[project-structure\|Project Structure]]                                                            |
| Compressing / saving feature context | `/compress-context` → [[context-compression\|Context Compression]]                                 |
| Fetching a backlog ticket     | [[skills/get-azure-work-item\|Get Azure Work Item]]                                                 |

---

*Last updated: 2026-04-24*
