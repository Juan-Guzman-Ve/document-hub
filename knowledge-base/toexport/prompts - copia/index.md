# Prompts Index

> This document is the entry point for all executable prompt commands. Each prompt is available as a slash command in VS Code Copilot Chat via `chat.promptFilesLocations`. Type the command directly — no manual briefing required.

---

## How to Use

Prompts are invoked by typing their slash command in VS Code Copilot Chat. Some prompts accept inputs — VS Code will prompt for them automatically when the command is run.

---

## Prompts

### [[init-codespace|/init-codespace]]

Initializes a repository that has no `copilot-instructions.md` or no reference to the knowledge base. Runs the full 4-phase workflow: Discover (auto-scans the repo), Confirm (gathers stack and path details from the human), Generate (produces `copilot-instructions.md` + `.code-workspace`), and Validate (human approval before writing).

**When to use:** First time entering any unconfigured repository.
**Inputs:** None — discovery is automatic, confirmation is interactive.
**Reference:** [[init-workflow|Repository Init Workflow]]

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

---

## Quick Reference

| Command             | When to use                                                             |
| ------------------- | ----------------------------------------------------------------------- |
| `/init-codespace`   | Entering a repo with no `copilot-instructions.md`                       |
| `/create-feature`   | Starting a new feature with an Azure backlog item                       |
| `/compress-context` | Saving context before pausing, resuming, or trimming the context window |
| `/research`         | Researching a technical topic before planning or implementation         |

---

*Last updated: 2026-04-23*
