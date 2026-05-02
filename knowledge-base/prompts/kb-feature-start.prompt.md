---
mode: 'agent'
description: 'Start a new feature — fetch ticket, create branch, scaffold folder and proposal.md'
inputs:
  - id: azureItemNumber
    description: 'Azure DevOps backlog item number (e.g. 1234)'
    type: promptString
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are starting a new feature using the Feature Development Workflow. Load it and the required skills into your context now:

#file: [[feature-workflow|Feature Workflow]]
#file: [[get-azure-work-item.skill|Get Azure Work Item Information]]
#file: [[new-feature-branch.skill|New Feature Branch]]

The Azure DevOps backlog item number for this feature is: **AB#${input:azureItemNumber}**

Follow each step below in order.

---

## Step 1 — Fetch the work item

Using the `get-azure-work-item` skill, fetch the full details of work item **${input:azureItemNumber}**.

Follow the skill's execution flow exactly — use Path A (lookup by ID). Present the work item to the human in the standard format defined by the skill before proceeding.

If the item is not found, stop and report the error — do not proceed without confirmed ticket data.

---

## Step 2 — Read the repo configuration

Open `copilot-instructions.md` at the repository root and locate the **Feature Folder** section.
Extract the exact path where feature folders must be created (e.g. `src/Features/`, `app/Features/`).

If `copilot-instructions.md` is missing or has no Feature Folder section, stop and tell the human — the repo must be initialized first using `/kb-bootstrap-repo`.

---

## Step 3 — Create the branch

Run `git branch --show-current` to check the current branch.

- **If already on `AB#${input:azureItemNumber}`** → proceed to Step 4
- **If on any other branch** → use the `new-feature-branch` skill to create the branch.

Follow the skill's execution flow exactly — confirm the branch name with the human before running the script, then verify the branch is active before proceeding.

---

## Step 4 — Get the feature name

Suggest a kebab-case feature name derived from the work item title fetched in Step 1.

Ask the human: **"Does this name work, or would you like to change it?"**

Wait for confirmation or a corrected name. The folder name must follow the pattern:
```
{kebab-case-feature-name}-AB#{azureItemNumber}
```

Example: `user-authentication-AB#1234`

---

## Step 5 — Create the feature folder

Create the folder at the path extracted in Step 2:
```
{feature-folder-path}/{kebab-case-feature-name}-AB#${input:azureItemNumber}/
```

Inside it, create `proposal.md` using the template from `feature-workflow.md` Phase 0, pre-filled with:
- `{Feature Name}` → the confirmed feature name
- `{BACKLOG_TICKET_NUMBER}` → `AB#${input:azureItemNumber}`
- `{Date}` → today's date
- `Idea` → populated from the work item **Description**
- `Problem / Motivation` → populated from the work item **Acceptance Criteria** (reframed as motivation if needed)
- `Known Constraints or Preferences` → leave empty for the human to fill in
- `Open Questions` → leave empty for the human to fill in

> The goal is to give the human a head start — the ticket content seeds the proposal so they only need to add nuance, not re-type what they already wrote in Azure DevOps.

---

## Step 6 — Human confirmation gate for Proposal

Show the generated `proposal.md` to the human and ask for explicit confirmation:

**"Please review `proposal.md`. Should I treat this proposal as approved and ready for Phase 1 (Spec)?"**

- If the human requests changes, update `proposal.md` and ask again.
- Do not start Phase 1 until the human explicitly confirms the proposal is ready.

---

## Step 7 — Hand off to the human

Tell the human:

1. The branch `AB#${input:azureItemNumber}` is active
2. The feature folder has been created at `{full-path}`
3. `proposal.md` has been pre-filled from the Azure work item — review it, adjust as needed
4. Once satisfied with `proposal.md`, they can return to start Phase 1 (Spec)

> Do not proceed to Phase 1 until the human explicitly says the proposal is ready.
> From this point, follow `feature-workflow.md` phase by phase, with a human approval gate at each phase.

