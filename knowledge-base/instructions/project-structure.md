---
documentType: 'instruction'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Project Structure

> **Purpose:** Define how agents must discover and respect the structure of any repository, and establish the role of each repo's `copilot-instructions.md` as its knowledge base entry point.

---

## Core Rule

**Project structure is defined per repository.** There is no single universal folder layout. Before creating, moving, or organizing any file, an agent must consult the repository's `copilot-instructions.md`.

---

## Agent Behavior

### When entering a repository

1. **Locate `copilot-instructions.md`** at the root of the repository
2. **Read it fully** — it is the knowledge base index for that repo
3. **Follow the structure, conventions, and references** defined there before taking any action

### If `copilot-instructions.md` does not exist

**Ask the human** before making any structural assumptions. Do not invent a folder layout or apply a default structure without confirmation.

---

## The Role of `copilot-instructions.md`

Each repository's `copilot-instructions.md` acts as a **knowledge base index** — not a full documentation file, but a map that points to the relevant instructions, skills, and conventions that apply to that repo.

It should contain:

- **Project overview** — what the repo does in 1–3 sentences
- **Folder structure** — list of top-level folders with the scope of each one
- **References** — links to instruction files, skill files, or other documents the agent must follow for this repo
- **Stack and tools** — languages, frameworks, and key libraries in use
- **Any repo-specific conventions** that override or extend the general instructions

---

## The Role of `{repo-name}.code-workspace`

Because the knowledge base (agent definitions, instruction files) lives outside the repository, VS Code and Copilot cannot access those files unless they are part of the open workspace.

Each repository should have a **`.code-workspace` file** that opens both the repo folder and the `knowledge-base` folder together as a multi-root workspace. This makes all knowledge base files — including agent role definitions — visible to the agent without duplicating them into the repo.

- Generated as part of the **init workflow** (`init-workflow.md`)
- Stored at the repository root (or alongside it)
- The human opens this file instead of the repo folder directly when working with Copilot
- Contains VS Code settings that pre-load key instruction files into Copilot context automatically

### Template

```markdown
# [Project Name] — Copilot Instructions

## Overview
Brief description of what this project does.

## Stack
- Language / Runtime:
- Framework:
- Key libraries:

## Folder Structure
| Folder | Scope |
|---|---|
| `src/` | ... |
| `tests/` | ... |

## Instructions & References
- [General Instructions Index](../path/to/instructions/index.md)
- [Additional skill or instruction files specific to this repo]

## Repo-Specific Conventions
Any overrides or additions to the general instructions.
```

---

## General Structural Principles

These apply when starting a **greenfield project** or when the repo's `copilot-instructions.md` does not specify otherwise:

- **Use Clean Architecture layers** as the default starting point: separate domain, application, infrastructure, and presentation concerns
- **Respect the existing structure** in brownfield projects — do not reorganize without explicit instruction
- **Do not mix production code with test files** in the same folder unless the repo explicitly does so
- **Configuration files belong at the project root** unless the repo uses a dedicated config folder

---

*Last updated: 2026-04-22*


---

*Change reason: 2026-05-01 consistency and governance update*
*Impacted files: knowledge-base-wide policy alignment*