# Repository Init Workflow

> **Purpose:** Define the initialization process a master agent must follow when entering a repository that does not yet have a `copilot-instructions.md` referencing this knowledge base.
> **Trigger:** The agent detects that `copilot-instructions.md` is missing or does not contain a reference to the knowledge base instructions.

---

## How to Start This Workflow

Run this workflow by typing `/init-codespace` in VS Code Copilot Chat. The prompt is available in every repository via the global `chat.promptFilesLocations` user setting — see the Developer Environment Setup guide for how to configure this.

---

## Prerequisite — Developer Environment Setup

Before running this workflow, the developer must have completed the one-time machine setup:

→ [[../guides/developer-environment-setup|Developer Environment Setup]]

This ensures shared agents are available in VS Code before the workspace file exists.

---

## When This Workflow Applies

Run this workflow when **any** of the following is true:

- No `copilot-instructions.md` exists at the repository root
- `copilot-instructions.md` exists but does not reference the knowledge base (`Instructions/`, `agents/`)
- The agent cannot determine the feature folder location from existing documentation

Do **not** run this workflow if a valid `copilot-instructions.md` is already in place — follow it instead.

---

## Phase Overview

```
Discover → Confirm → Generate → Validate
    ↑           ↑         ↑          ↑
  agent       human     agent      human
  scans      answers   writes    approves
```

---

## Phase 1 — Discover

**Goal:** Understand the repository before asking any questions.

The agent must perform the following before prompting the human:

1. **Scan the root directory** — list top-level folders and files
2. **Detect the tech stack** — look for `package.json`, `*.csproj`, `*.sln`, `angular.json`, `tsconfig.json`, etc.
3. **Look for existing documentation** — README, existing `copilot-instructions.md`, any `docs/` or `wiki/` folders
4. **Identify candidate feature folders** — look for `Features/`, `features/`, `src/Features/`, or similar patterns already in use
5. **Detect Git submodules** — check for a `.gitmodules` file at the repo root. If found:
   - List all submodule names and their local paths
   - For each submodule, scan its root for: `package.json`, `*.csproj`, `*.sln`, `README.md`, `src/`, `lib/`, `shared/`, or similar signals of shared/common logic
   - Note which submodules appear to contain **shared or reusable code** vs. standalone services or tools

Include submodule findings in the **Discovery Summary**.

> If `.gitmodules` exists but submodule folders are empty (not yet initialized), note this explicitly. The agent must not assume submodule content — report the gap and ask the human.

---

## Phase 2 — Confirm

**Goal:** Gather the information that cannot be inferred automatically.

Present the Discovery Summary and ask the human to confirm or correct:

| Question | Why it's needed |
|---|---|
| What does this project do? (1–3 sentences) | Goes into the Overview section of `copilot-instructions.md` |
| What is the tech stack? (confirm or correct detected stack) | Goes into the Stack section |
| Where should the feature folder live? (confirm candidate or specify path) | Used by `feature-workflow.md` for all feature documents |
| Are there any repo-specific conventions that override the global instructions? | Goes into the Repo-Specific Conventions section |
| What is the internal path within your vault? (the folders between `obsidian\` and `knowledge-base\`, e.g. `document-hub`) | Used to build the relative path in the `.code-workspace` settings |
| *(If submodules detected)* What does each submodule provide? What shared logic or contracts does this repo consume from them? | Goes into the Submodules section — critical context for agents writing code that touches shared logic |
| *(Optional)* Are there any MCP database connections available for this repository? If yes, for each one provide: a connection name, the MCP server identifier, the database or schema it connects to, and what explorational purpose it serves. | Goes into the MCP Database Connections section — enables agents to query live data during research and explorational tasks scoped to this repo |

> The agent must not invent answers. If the human does not answer a question, leave the corresponding section as a clearly marked placeholder.

---

## Phase 3 — Generate

**Goal:** Create two files — `copilot-instructions.md` at the repository root, and a `.code-workspace` file that opens the repo and the Document Hub together in VS Code.

Both files are needed. The `copilot-instructions.md` configures the agent for this repo. The `.code-workspace` file solves the **file visibility problem**: agent definitions and instruction files live in the Document Hub, not in the repo — VS Code and Copilot can only access files that are part of the open workspace. By including both folders in one workspace file, all knowledge base files become visible to the agent without copying anything into the repo.

---

### 3a — `copilot-instructions.md` Template

```markdown
# {Project Name} — Copilot Instructions

## Overview
{1–3 sentence description of what this project does.}

---

## Stack

| Concern | Tool / Technology |
|---|---|
| Language / Runtime | {e.g. C# / .NET 8, TypeScript / Node 20} |
| Framework | {e.g. ASP.NET Core, Angular 17} |
| Data access | {e.g. Entity Framework Core, Dapper} |
| Key libraries | {e.g. MediatR, RxJS} |

---

## Folder Structure

| Folder | Scope |
|---|---|
| `{folder}/` | {description} |
| `{folder}/` | {description} |

---

## Feature Folder

All feature documents (spec, plan, tasks, implementation) are stored under:

```
{path/to/Features}/
└── {feature-name}-AB#{AZURE_ITEM_NUMBER}/
    ├── proposal.md
    ├── spec.md
    ├── plan.md
    ├── tasks.md
    └── implementation.md
```

---

## Submodules

*(Omit this section if the repo has no submodules.)*

This repository depends on the following Git submodules. Agents must be aware of shared logic provided by these modules before writing any code that touches their boundaries.

| Submodule | Local Path | What it provides |
|---|---|---|
| `{submodule-name}` | `{local/path}` | {What shared logic, contracts, or utilities this submodule exposes to this repo} |

### Agent rules for submodules

- **Do not duplicate logic** that already exists in a submodule — always check there first
- **Do not modify submodule files directly** from within this repo — changes to a submodule must be made in that submodule's own repository
- **If a submodule's API or contract needs to change** as part of a feature, stop and escalate to the Staff Engineer before proceeding

---

## MCP Database Connections

*(Omit this section if no MCP connections are configured for this repository.)*

The following connections are available for explorational and research tasks. Use them to inspect live data, validate assumptions, or trace how data flows through the system before writing code.

| Connection Name | MCP Server | Database / Schema | Use for |
|---|---|---|---|
| `{connection-name}` | `{mcp-server}` | `{database/schema}` | {what to explore with this connection} |

### Agent rules for MCP connections

- Use these connections for **read-only exploration** only — understanding data shape, validating assumptions, tracing data through the system
- Do not write, update, or delete data unless the human explicitly instructs it
- State which connection you are querying and why before executing any query
- Prefer targeted queries over broad scans — fetch only what is needed for the task

---

## Knowledge Base & Instructions

This repository uses the shared knowledge base. It is available in VS Code via
the workspace file — open `{repo-name}.code-workspace` to access it.

All agents must read and follow the instructions there. Key files:

| Instruction | Path (relative to Document Hub root) |
|---|---|
| Instructions Index | `knowledge-base/instructions/index.md` |
| Agent Roster | `knowledge-base/agents/index.md` |
| Feature Workflow | `knowledge-base/instructions/feature-workflow.md` |
| Git Conventions | `knowledge-base/instructions/git-conventions.md` |
| Coding Style | `knowledge-base/instructions/coding-style.md` |
| Principles | `knowledge-base/instructions/principles.md` |
| Design Patterns | `knowledge-base/instructions/design-patterns.md` |
| Testing Strategy | `knowledge-base/instructions/testing-strategy.md` |

---

## Repo-Specific Conventions

{Any overrides or additions to the global instructions. If none, write: "No overrides — follow global instructions."}

---

*Generated: {YYYY-MM-DD}*
*Last updated: {YYYY-MM-DD}*
```

---

### 3b — `.code-workspace` Template

Save this file as **`{repo-name}.code-workspace`** at the repository root (or one level above, alongside the repo folder — wherever is convenient for the human to open it from).

```json
{
  "folders": [
    {
      "name": "{repo-name}",
      "path": "."
    }
  ],
  "settings": {
    "github.copilot.chat.codeGeneration.instructions": [
      { "file": "../obsidian/{your-internal-path}/knowledge-base/instructions/coding-style.md" },
      { "file": "../obsidian/{your-internal-path}/knowledge-base/instructions/principles.md" }
    ],
    "github.copilot.chat.testGeneration.instructions": [
      { "file": "../obsidian/{your-internal-path}/knowledge-base/instructions/testing-strategy.md" },
      { "file": "../obsidian/{your-internal-path}/knowledge-base/instructions/coding-style.md" }
    ],
    "github.copilot.chat.reviewSelection.instructions": [
      { "file": "../obsidian/{your-internal-path}/knowledge-base/instructions/coding-style.md" },
      { "file": "../obsidian/{your-internal-path}/knowledge-base/instructions/principles.md" }
    ]
  }
}
```

**What the workspace file does:**

- Registers agents, instructions, and prompts from the knowledge base via relative paths — `..` navigates from the repo up to the shared root, then into the vault
- Paths work because `obsidian\` is always at the same level as repositories (the structural rule described in the Developer Environment Setup guide)
- Auto-loads core instruction files into Copilot's context for code generation, test generation, and code review

**Fill in before saving:**

| Placeholder | Replace with |
|---|---|
| `{repo-name}` | The repository name (e.g. `my-api`) |
| `{your-internal-path}` | The folder path inside your vault leading to `knowledge-base` (e.g. `document-hub`) — confirmed in Phase 2 |

**Known pitfalls — agents not appearing in the VS Code picker:**

| Mistake | Why it fails | Fix |
|---|---|---|
| Agent files in `.github/agents/` (not `agents/`) | This knowledge base stores agents in `knowledge-base/agents/` — `chat.agentFilesLocations` points there. Moving them to `.github/agents/` breaks discovery | Keep agents in `knowledge-base/agents/` |
| `chat.agentFilesLocations` with array format: `["path"]` | The setting uses object format `{ "path": true }` — array is silently ignored | Use object format as shown in the template |
| Opening the repo folder directly | Workspace settings in `.code-workspace` only apply when the workspace file is opened — the folder bypasses them | Open `{repo-name}.code-workspace`, not the folder |

---

## Phase 4 — Validate

**Goal:** Confirm both generated files are correct before any feature work begins.

Present the generated `copilot-instructions.md` and `.code-workspace` to the human and ask for explicit approval.

**Checklist before marking this phase complete:**

- [ ] Overview accurately describes the project
- [ ] Stack matches what is actually in use
- [ ] Folder structure reflects the real repo layout
- [ ] Feature folder path is confirmed and correct
- [ ] Knowledge base references point to the correct location
- [ ] Repo-specific conventions are noted (or explicitly marked as none)
- [ ] Submodules section present and accurate *(or explicitly omitted if no submodules)*
- [ ] MCP Database Connections section present and accurate *(or explicitly omitted if none configured)*
- [ ] `.code-workspace` includes the repo folder and the correct Document Hub path
- [ ] Human has opened the `.code-workspace` file in VS Code and confirmed both folders are visible

Once approved, both files are saved. The init workflow is complete.

> After approval, the agent must treat `copilot-instructions.md` as the authoritative entry point for all future work in this repository — as defined in `project-structure.md`.

---

## Hard Rules

- **Never generate `copilot-instructions.md` without human approval** — always go through Phase 2 and Phase 4
- **Never invent stack details or folder paths** — if uncertain, ask
- **Never proceed with feature work** (i.e., start `feature-workflow.md`) until init is complete and approved
- **Do not overwrite an existing `copilot-instructions.md`** without explicit human instruction — present a diff and ask first

---

## Relationship to Other Instructions

| Instruction | How it connects |
|---|---|
| `project-structure.md` | Defines the role and expected contents of `copilot-instructions.md` — read this first |
| `feature-workflow.md` | Depends on the feature folder path defined here |
| `git-conventions.md` | Branch naming applies from the moment init is complete |
| `agent-prompting.md` | Agents briefed for init sub-tasks must follow this structure |
| `research-instructions.md` | When MCP connections are defined, agents should use them as a first-party data source alongside web and documentation research |

---

*Last updated: 2026-04-22*
