# Instructions Index

> This document is the entry point for all agent instructions. Use it to locate the right reference file for a given task. Each linked document contains its own detailed summary and rules.

---

## How to Use

Before executing any task, identify which instruction files are relevant and follow their guidelines. Multiple files may apply to a single task.

---

## Instruction Files

### [[design-patterns|Design Patterns]]
Preferred patterns (Repository, Strategy, DI, CQRS, etc.) with problem-first guidance — when to use them and when not to. Use this when designing a solution or evaluating an architectural approach.

---

### [[principles|Principles]]
Core software principles: DRY, YAGNI, KISS, SOLID, Separation of Concerns, and more. Includes a priority hierarchy for when principles conflict. Use this as a baseline for every design and implementation decision.

---

### [[coding-style|Coding Style]]
Rules for writing clean code: naming conventions (TypeScript and C#), function design, constants, abstraction levels, error handling, generics, and code smells to avoid. Use this whenever writing or reviewing code.

---

### [[research-instructions|Research Instructions]]
How the master agent must conduct research using subagents — one subagent per source type (official docs, GitHub, blogs). Defines the report format (findings, limitations, recommendations) and hard rules (never invent, never assume). Use this whenever a task requires external research.

---

### [[git-conventions|Git Conventions]]
Git Flow branching strategy, branch naming format, Conventional Commits with scope, PR rules, and merge strategy. Use this when creating branches, writing commits, or opening pull requests.

---

### [[testing-strategy|Testing Strategy]]
Unit, integration, and E2E testing philosophy. Tests must tell a story using named functions — no loose logic in test cases. Covers what to test, what to skip, Given/When/Then structure, and mocking strategy. Use this when writing or reviewing tests.

---

### [[project-structure|Project Structure]]
Project structure is defined per repository in each repo's `copilot-instructions.md`, which acts as a knowledge base index. This file explains how agents must discover and use that index, and what it should contain. Use this before creating or moving any file in a repository.

---

### [[agent-prompting|Agent Prompting]]
How the master agent must brief and delegate tasks to subagents. Defines the task brief structure (context, objective, constraints, expected output), the execution flow subagents must follow, the ambiguity protocol, and the report format. Use this whenever delegating a task to a subagent.

---

### [[init-workflow|Repository Init Workflow]]
How to initialize a repository's `copilot-instructions.md` when one does not exist or does not reference the knowledge base. Defines a 4-phase process: Discover, Confirm, Generate, Validate — ending with human approval. Use this as the **first step** when entering any unconfigured repository.

> **Executable form:** use the `/init-codespace` prompt in VS Code Copilot Chat to run this workflow directly — no manual briefing required.

---

### [[context-compression|Context Compression]]
Defines when and how to compress working context during a feature session. Specifies the `context/` folder structure inside the feature folder, the versioning strategy (`context-latest.md` + timestamped snapshots), and the snapshot template an agent must fill. Also defines how a resuming agent reads and restores context.

> **Executable form:** use the `/compress-context` prompt in VS Code Copilot Chat to run compression directly.

---

### [[feature-workflow|Feature Development Workflow]]
Spec-Driven Development (SDD) process for implementing new features. Defines sequential phases — each with a file template and a human approval gate. Use this whenever starting work on a new feature.

> **Executable form:** use the `/create-feature` prompt in VS Code Copilot Chat to scaffold a new feature — branch, folder, and `proposal.md` created in one command.

---

## Quick Reference — Task → Instruction File

| Task                                            | Files to consult                                |
| ----------------------------------------------- | ----------------------------------------------- |
| Entering a repo with no copilot-instructions.md | `/init-codespace` prompt, init-workflow         |
| Designing a feature or architecture             | design-patterns, principles                     |
| Writing or reviewing code                       | coding-style, principles                        |
| `/research`        | Research a technical topic before planning or implementation        |
| Researching a technology or problem             | research-instructions                           |
| Creating branches or commits                    | git-conventions                                 |
| Writing tests                                   | testing-strategy, coding-style                  |
| Prompting or briefing an agent                  | agent-prompting, research-instructions          |
| Starting a new project                          | project-structure, principles                   |
| Compressing feature context             | `/compress-context` prompt, context-compression              |
| Implementing a new feature              | `/create-feature` prompt, feature-workflow, design-patterns, coding-style |
