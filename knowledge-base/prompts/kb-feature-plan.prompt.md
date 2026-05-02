---
mode: 'agent'
description: 'Phase 2 — Draft plan.md from the approved spec'
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are executing **Phase 2 — Plan** of the Feature Development Workflow. Load the workflow definition and relevant instruction files into your context now:

#file: [[feature-workflow|Feature Workflow]]
#file: [[design-patterns|Design Patterns]]
#file: [[principles|Software Principles]]
#file: [[coding-style|Coding Style]]
#file: [[project-structure|Project Structure]]

Follow each step below in order. Do not write any file before receiving explicit human approval.

---

## Step 1 — Locate the feature folder

1. Read `copilot-instructions.md` at the repository root — extract the **Feature Folder** path and the **Stack** section
2. Check the current git branch: `git branch --show-current`
3. Find the feature folder matching the current branch name under the feature folder path

If no matching folder is found, stop and tell the human — the feature folder has not been created yet.

---

## Step 2 — Read the approved spec

Open `spec.md` inside the feature folder and read it fully.

- If `spec.md` does not exist → stop. Phase 1 must be completed first using `/kb-feature-spec`.
- If `spec.md` has `Status: Draft` → stop. The spec must be approved before planning begins.

---

## Step 3 — Draft plan.md

Using the approved spec and the repo's confirmed stack from `copilot-instructions.md`, draft `plan.md` following the template defined in `feature-workflow.md` Phase 2.

- **Stack & Tools** — list only what is actually needed for this feature; no speculative dependencies (YAGNI)
- **Architecture & Design** — describe the layers, components, and data flow; select patterns from `design-patterns.md` only where they solve a concrete problem present in this feature
- **Components / Modules** — list every new or modified component with its responsibility and whether it is new or modified; use correct folder paths per `copilot-instructions.md` and `project-structure.md`
- **Data Design** — include only if the feature involves schema changes, new entities, or data contracts
- **External Dependencies** — include only if the feature integrates with APIs or services not already in the stack
- **Risks & Trade-offs** — be honest about complexity, unknowns, or design choices that carry risk

> The plan defines **how**. Keep it YAGNI-strict — only what this feature needs.

Present the full draft to the human before writing anything to disk.

---

## Step 4 — Revise and write

- If the human has corrections → revise and re-present. Do not write until fully approved.
- If approved → set `Status: Approved`, write the file to:
  ```
  {feature-folder-path}/{feature-name}-{ticket}/plan.md
  ```
  Confirm the file was saved and show the full path.

---

## Step 5 — Hand off

Tell the human:

1. `plan.md` is saved and approved
2. The next step is Phase 3 (Tasks) — they can use `/kb-feature-tasks` when ready

> Do not proceed to task breakdown. The human decides when to move forward.
