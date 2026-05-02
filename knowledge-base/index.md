---
documentType: 'index'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Knowledge Base

> This is the main entry point for all agents. Before executing any task, read this index to understand what resources are available and where to find them.
> Everything an agent needs — instructions, agent definitions, and skills — lives inside this knowledge base.

---

## Structure

```
knowledge-base/
├── index.md              ← you are here
├── routing.md            ← fast task-to-file routing table
├── instructions/         ← how to work: principles, conventions, workflows
├── agents/               ← who does what: agent roles and responsibilities
├── prompts/              ← executable slash commands for VS Code Copilot Chat
└── skills/               ← how to execute specific recurring tasks
```

---

## Authority Model

When files disagree, resolve ambiguity using this order:

1. **Instructions** — canonical rules and constraints
2. **Agents** — role interpretation and responsibility split
3. **Prompts** — executable orchestration of workflows

If there is a conflict between levels, the higher level wins.

---

## Instructions

Rules and conventions that apply to all agents across all tasks. Consult the instructions index to find the right file for any given situation.

→ [[instructions/index|Instructions Index]]

| File | Purpose |
|---|---|
| [[init-workflow|Init Workflow]] | How to initialize `copilot-instructions.md` for a repo that has none |
| [[design-patterns|Design Patterns]] | Pattern selection guide — problem → pattern |
| [[principles|Principles]] | DRY, YAGNI, KISS, SOLID and more — the non-negotiables |
| [[coding-style|Coding Style]] | Naming, functions, constants, error handling, generics |
| [[research-instructions|Research Instructions]] | How to delegate research to subagents |
| [[git-conventions|Git Conventions]] | Branching, commits, PRs |
| [[testing-strategy|Testing Strategy]] | What to test, how to write tests, mocking strategy |
| [[project-structure|Project Structure]] | How to discover and respect repo structure |
| [[agent-prompting|Agent Prompting]] | How to brief and delegate tasks to subagents |
| [[feature-workflow|Feature Workflow]] | Spec-Driven Development — 5-phase feature process |
| [[load-feature|Load Feature]] | How to locate, load, and summarize an existing feature for resumption |
| [[spec-writing|Spec Writing]] | Template and rules for writing `spec.md` |
| [[context-compression|Context Compression]] | When and how to compress working context into `context/latest.md` |
| [[eod-instructions|EOD Instructions]] | How to produce an end-of-day progress summary |
| [[document-governance|Document Governance]] | Authority model, metadata, link style, and consistency conventions |

---

## Agents

Definitions for each agent in the team — role, responsibilities, hierarchy, and which instructions they follow.

→ [[agents/index|Agent Roster]]

| Agent                                            | Role                                                       |
| ------------------------------------------------ | ---------------------------------------------------------- |
| [[product-owner.agent|Product Owner]]           | Owns the spec — defines what and why                       |
| [[staff-engineer.agent|Staff Engineer]]         | Technical authority — architecture, code review, oversight |
| [[software-engineer.agent|Software Engineer]]   | Plans features and breaks them into tasks                  |
| [[backend-developer.agent|Backend Developer]]   | Implements backend tasks (C#/.NET, SQL)                    |
| [[frontend-developer.agent|Frontend Developer]] | Implements frontend tasks (TypeScript, Angular)            |
| [[qa-engineer.agent|QA Engineer]]               | Owns test quality and validation                           |

---

## Prompts

Executable slash commands for VS Code Copilot Chat. Type the command directly in chat — no explanation required.

→ [[prompts/index|Prompts Index]]

| Command | What it does |
| --- | --- |
| `/kb-research`        | Research a technical topic using parallel subagents                         |
| `/kb-feature-context-save`| Compress and save feature context to `context/latest.md`                    |
| `/kb-feature-load`   | Resume an existing feature — locate folder, load all documents, present status summary |
| `/kb-feature-start`  | Start a new feature — create branch, scaffold feature folder and `proposal.md` |
| `/kb-bootstrap-repo`  | Initialize a repository — scan, confirm stack, generate `copilot-instructions.md` + `.code-workspace` |
| `/kb-feature-spec`      | Draft `spec.md` from the approved `proposal.md`                             |
| `/kb-feature-plan`      | Draft `plan.md` from the approved `spec.md`                                 |
| `/kb-feature-tasks`     | Break the approved `plan.md` into `tasks.md` with test cases                |
| `/kb-feature-implement`       | Execute approved tasks and produce `implementation.md`                      |
| `/kb-eod`             | Generate an end-of-day progress summary for the current session             |

---

## Skills

Scoped instruction files for executing specific recurring tasks. Each skill defines a step-by-step execution guide for a particular type of work.

→ [[skills/index|Skills Index]]

| Skill | What it does |
|---|---|
| [[skills/get-azure-work-item.skill|Get Azure Work Item]] | Retrieve a backlog ticket by ID or title and present it in a standard format |
| [[skills/new-feature-branch.skill|New Feature Branch]] | Create a feature branch from `main` — confirms name, pulls latest, checks out new branch |

---

## Guides

Human-facing documentation. These files are not loaded by agents — they are one-time reference material for developers setting up their environment.

| Guide | Purpose |
|---|---|
| [[guides/developer-environment-setup|Developer Environment Setup]] | One-time machine setup — folder convention and VS Code agent registration |

---

## Tooling

| Script | Purpose |
|---|---|
| `tools/validate-knowledge-base.ps1` | Validates naming drift, include directives, link targets, ownership contradictions, and key term typos |
| `tools/sync-skills.ps1` | Syncs exported skill copies from canonical files in `skills/` |
| `tools/task-alias.ps1` | Runs `validate-all`, `sync-all`, or `all` from a single command |
| `tools/new-feature-branch.ps1` | Script used by the New Feature Branch skill — not invoked directly by agents |

---

## Quick Reference — Situation → Where to Look

| Situation                     | Go to                                                                                               |
| ----------------------------- | --------------------------------------------------------------------------------------------------- |
| Setting up a new machine      | [[guides/developer-environment-setup|Developer Environment Setup]]                                 |
| Entering a repo with no setup | `/kb-bootstrap-repo` → [[init-workflow|Init Workflow]]                                                |
| Resuming an existing feature  | `/kb-feature-load` → [[load-feature|Load Feature]]                                          |
| Starting a new feature        | `/kb-feature-start` → [[feature-workflow|Feature Workflow]] → [[agents/index|Agent Roster]] |
| Writing the spec              | `/kb-feature-spec` → [[feature-workflow|Feature Workflow]]                                              |
| Writing the plan              | `/kb-feature-plan` → [[feature-workflow|Feature Workflow]] → [[design-patterns|Design Patterns]]       |
| Writing tasks                 | `/kb-feature-tasks` → [[feature-workflow|Feature Workflow]] → [[testing-strategy|Testing Strategy]]    |
| Implementing a feature        | `/kb-feature-implement` → [[feature-workflow|Feature Workflow]]                                               |
| Writing or reviewing code     | [[coding-style|Coding Style]] → [[principles|Principles]]                                         |
| Designing a solution          | [[design-patterns|Design Patterns]] → [[principles|Principles]]                                   |
| Researching a problem         | `/kb-research` → [[research-instructions|Research Instructions]]                                      |
| Writing tests                 | [[testing-strategy|Testing Strategy]]                                                              |
| Creating branches or commits  | [[git-conventions|Git Conventions]]                                                                |
| Delegating to a subagent      | [[agent-prompting|Agent Prompting]]                                                                |
| Working in an unfamiliar repo | [[project-structure|Project Structure]]                                                            |
| Compressing / saving feature context | `/kb-feature-context-save` → [[context-compression|Context Compression]]                                 |
| Fetching a backlog ticket     | [[skills/get-azure-work-item.skill|Get Azure Work Item]]                                           |
| I need the fastest path       | [[routing|Routing]]                                                                                  |

---

*Last updated: 2026-05-01*
