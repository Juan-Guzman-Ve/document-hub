# Prompts Index

> This document is the entry point for all executable prompt commands. Each prompt is available as a slash command in VS Code Copilot Chat via `chat.promptFilesLocations`. Type the command directly — no manual briefing required.

---

## How to Use

Prompts are invoked by typing their slash command in VS Code Copilot Chat. Some prompts accept inputs — VS Code will prompt for them automatically when the command is run.

---

## Prompts

### [[init-codespace.prompt|/init-codespace]]

Initializes a repository that has no `copilot-instructions.md` or no reference to the knowledge base. Runs the full 4-phase workflow: Discover (auto-scans the repo), Confirm (gathers stack and path details from the human), Generate (produces `copilot-instructions.md` + `.code-workspace`), and Validate (human approval before writing).

**When to use:** First time entering any unconfigured repository.
**Inputs:** None — discovery is automatic, confirmation is interactive.
**Reference:** [[init-workflow|Repository Init Workflow]]

---

### [[load-feature.prompt|/load-feature]]

Loads an existing feature by name or ticket code. Resolves the feature folder from `copilot-instructions.md`, reads every document present (`proposal.md`, `spec.md`, `plan.md`, `tasks.md`, `implementation.md`, and any context snapshot), determines the current phase, and presents a full status summary. Highlights any tasks already `in progress` so the human can resume immediately.

**When to use:** Any time you want to resume work on an existing feature or inspect its current state.
**Inputs:** Feature name (e.g. `user-authentication`) or feature code (e.g. `AB#1234` or just `1234`).
**Reference:** [[load-feature|Load Feature Instruction]], [[feature-workflow|Feature Development Workflow]]

---

### [[create-feature.prompt|/create-feature]]

Scaffolds a new feature from scratch. Fetches the Azure DevOps work item to seed the proposal with real ticket content, creates the `AB#{number}` branch, resolves the feature folder path from `copilot-instructions.md`, suggests a folder name from the ticket title, and generates a pre-filled `proposal.md` using the ticket description and acceptance criteria as a head start.

**When to use:** Starting any new feature backed by an Azure DevOps backlog item.
**Inputs:** Azure DevOps item number (prompted on run).
**Reference:** [[feature-workflow|Feature Development Workflow]], [[get-azure-work-item|Get Azure Work Item]]

---

### [[compress-context.prompt|/compress-context]]

Compresses the current feature session into a dense `context-latest.md` snapshot stored inside the feature's `context/` subfolder. Preserves previous snapshots by renaming them with a timestamp. Enables short context windows during active work and allows any future agent to resume the feature instantly by reading the latest snapshot.

**When to use:** Any time you want to trim the context window, pause a feature session, or hit a phase boundary.
**Inputs:** None — feature folder is resolved from the current git branch and `copilot-instructions.md`.
**Reference:** [[context-compression|Context Compression]]

---

### [[research.prompt|/research]]

Runs a structured technical research task using parallel subagents — one per source type (official docs, GitHub, technical blogs). Scopes the questions first, confirms with the human, then spawns all subagents in parallel and synthesizes a Research Summary with conclusions, gaps, and recommendations. Optionally saves a research note to the vault.

**When to use:** Any time a decision needs external validation before planning or implementation — especially during the Clarification phase of a feature.
**Inputs:** Research topic + stack/version context (both prompted on run).
**Reference:** [[research-instructions|Research Instructions]], [[agent-prompting|Agent Prompting]]

### [[write-spec.prompt|/write-spec]]

Executes Phase 1 of the Feature Development Workflow. Reads the human-authored `proposal.md` and drafts `spec.md` — defining what the feature is, the main happy path, key test scenarios, and what is out of scope. Presents the draft to the human before writing. Requires explicit approval before saving.

**When to use:** After `proposal.md` is written and the feature branch is active.
**Inputs:** None — reads `proposal.md` and `copilot-instructions.md` automatically.
**Reference:** [[feature-workflow|Feature Development Workflow]]

---

### [[write-plan.prompt|/write-plan]]

Executes Phase 2 of the Feature Development Workflow. Reads the approved `spec.md` and drafts `plan.md` — defining the technical approach: stack, architecture, components, data design, and risks. Applies `design-patterns.md` and `principles.md`. Presents the draft before writing and requires explicit approval.

**When to use:** After `spec.md` is approved.
**Inputs:** None — reads `spec.md` and `copilot-instructions.md` automatically.
**Reference:** [[feature-workflow|Feature Development Workflow]], [[design-patterns|Design Patterns]], [[principles|Software Principles]]

---

### [[write-tasks.prompt|/write-tasks]]

Executes Phase 3 of the Feature Development Workflow. Reads the approved `plan.md` and drafts `tasks.md` — breaking the plan into self-contained tasks, each with a precise description and test cases defined upfront in Given/When/Then format. Presents the draft before writing and requires explicit approval.

**When to use:** After `plan.md` is approved.
**Inputs:** None — reads `plan.md`, `spec.md`, and `copilot-instructions.md` automatically.
**Reference:** [[feature-workflow|Feature Development Workflow]], [[testing-strategy|Testing Strategy]]

---

### [[implement.prompt|/implement]]

Executes Phase 4 of the Feature Development Workflow. Works through each task in the approved `tasks.md`, implementing code and writing tests per the task's defined test cases. Updates task statuses in real time, stops and reports on blockers, and produces `implementation.md` as the completion record. When delegating to backend or frontend developer subagents, the brief always includes the full set of implementation instruction files so they operate with complete coding context.

**When to use:** After `tasks.md` is approved.
**Inputs:** None — reads `tasks.md`, `plan.md`, `spec.md`, and `copilot-instructions.md` automatically.
**Reference:** [[feature-workflow|Feature Development Workflow]], [[coding-style|Coding Style]], [[principles|Software Principles]], [[design-patterns|Design Patterns]], [[testing-strategy|Testing Strategy]], [[git-conventions|Git Conventions]]

### [[eod.prompt|/eod]]

Generates an end-of-day progress summary for the current session following `eod-instructions.md`. Output is plain text with a `[eod]` tag and a bullet list — no markdown — ready to paste directly into an Azure DevOps discussion item.

**When to use:** End of any work session.
**Inputs:** None — summarizes work done in the current session.
**Reference:** [[eod-instructions|EOD Summary Instructions]]

---

| Command             | When to use                                                             |
| ------------------- | ----------------------------------------------------------------------- |
| `/init-codespace`   | Entering a repo with no `copilot-instructions.md`                       |
| `/load-feature`     | Resuming or inspecting an existing feature by name or ticket code       |
| `/create-feature`   | Starting a new feature with an Azure backlog item                       |
| `/write-spec`       | Drafting `spec.md` after the proposal is ready                          |
| `/write-plan`       | Drafting `plan.md` after the spec is approved                           |
| `/write-tasks`      | Drafting `tasks.md` after the plan is approved                          |
| `/implement`        | Executing tasks and producing `implementation.md`                       |
| `/compress-context` | Saving context before pausing, resuming, or trimming the context window |
| `/research`         | Researching a technical topic before planning or implementation         |

| `/eod`              | Generate a plain-text end-of-day progress summary                       |

---

*Last updated: 2026-04-24*
