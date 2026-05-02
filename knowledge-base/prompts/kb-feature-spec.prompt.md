---
mode: 'agent'
description: 'Phase 1 — Draft spec.md from the approved proposal'
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are executing **Phase 1 — Spec** of the Feature Development Workflow. Load the workflow definition and spec writing rules into your context now:

#file: [[feature-workflow|Feature Workflow]]
#file: [[spec-writing|Spec Writing]]

Follow each step below in order. Do not write any file before receiving explicit human approval.

---

## Step 1 — Locate the feature folder

1. Read `copilot-instructions.md` at the repository root and extract the **Feature Folder** path
2. Check the current git branch: `git branch --show-current`
3. Find the feature folder matching the current branch name under the feature folder path

If no matching folder is found, stop and tell the human — the feature folder has not been created yet. Run `/kb-feature-start` first.

---

## Step 2 — Read the proposal

Open `proposal.md` inside the feature folder and read it fully.

If `proposal.md` does not exist or is empty, stop and tell the human — the proposal must be written by the human before the spec can be drafted.

---

## Step 3 — Draft spec.md

Using the proposal as the primary input, draft `spec.md` following the template defined in `feature-workflow.md` Phase 1.

- **Overview** — one paragraph summarizing the feature, derived from the proposal's Idea and Problem sections
- **Main Happy Path** — step-by-step primary flow from the user/system perspective; behavior only, no technical details
- **Key Test Scenarios** — Given/When/Then scenarios with a `Type` column (unit / integration); cover the happy path and key failure/edge cases; every scenario must be Observable, Testable, Specific, and Traceable per `spec-writing.md`
- **Out of Scope** — anything the proposal hints at but that will not be delivered in this feature; never leave this empty

If there are open technical questions, list them at the bottom of the draft. The human must answer them before approval can be given.

> The spec defines **what** and **why** — behavior only. No implementation details, technical rules, API contracts, DB schemas, or delivery concerns belong here. Everything technical goes in `plan.md`.

---

## Step 4 — Run the readiness checklist

Before presenting the draft, run every item in the readiness checklist from `spec-writing.md` internally.

- If an item fails → fix it or ask the human for the missing information
- Do not present the draft until all checklist items pass

---

## Step 5 — Present and revise

Present the full draft to the human. Include a brief summary of which checklist items were addressed (e.g. "no technical details included, all scenarios are observable/testable/specific/traceable, all scenarios have a test type assigned").

- If the human has corrections or unanswered questions → revise and re-present. Do not write until fully approved.
- If approved → set `Status: Approved`, write the file to:
  ```
  {feature-folder-path}/{feature-name}-{ticket}/spec.md
  ```
  Confirm the file was saved and show the full path.

---

## Step 6 — Hand off

Tell the human:

1. `spec.md` is saved and approved
2. The next step is Phase 2 (Plan) — they can use `/kb-feature-plan` when ready

> Do not proceed to the Plan phase. The human decides when to move forward.
