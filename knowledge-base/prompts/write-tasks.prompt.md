---
mode: 'agent'
description: 'Phase 3 — Break the approved plan into tasks.md with test cases'
---

You are executing **Phase 3 — Tasks** of the Feature Development Workflow. Load the workflow definition and relevant instruction files into your context now:

#file: [[feature-workflow|Feature Workflow]]
#file: [[testing-strategy|Testing Strategy]]
#file: [[coding-style|Coding Style]]

Follow each step below in order. Do not write any file before receiving explicit human approval.

---

## Step 1 — Locate the feature folder

1. Read `copilot-instructions.md` at the repository root and extract the **Feature Folder** path
2. Check the current git branch: `git branch --show-current`
3. Find the feature folder matching the current branch name under the feature folder path

If no matching folder is found, stop and tell the human — the feature folder has not been created yet.

---

## Step 2 — Read the approved plan

Open `plan.md` inside the feature folder and read it fully.

- If `plan.md` does not exist → stop. Phase 2 (Plan) must be completed first using `/write-plan`.
- If `plan.md` has `Status: Draft` → stop. The plan must be approved before task breakdown begins.

Also read `spec.md` for context — the Key Test Scenarios defined there must be reflected in the test cases of this phase.

---

## Step 3 — Draft tasks.md

Using the approved plan and the spec's key test scenarios, draft `tasks.md` following the template defined in `feature-workflow.md` Phase 3.

**Task List:**
- Each task maps directly to a component or module from `plan.md`
- Tasks must be self-contained and independently completable where possible
- Every task starts with status `not started`
- Note dependencies between tasks in the Comment column if they exist

**Task Detail (per task):**
- **What** — a precise, single-paragraph description of what the task delivers
- **Test Cases** — define all test cases upfront in Given/When/Then format per `testing-strategy.md`; include the test type (unit / integration / e2e) for each; cover the happy path and key failure/edge cases; derive from `spec.md` Key Test Scenarios where applicable

> Test cases are defined here, before implementation. This is not optional.

Present the full draft to the human before writing anything to disk.

---

## Step 4 — Revise and write

- If the human has corrections → revise and re-present. Do not write until fully approved.
- If approved → set `Status: Approved`, write the file to:
  ```
  {feature-folder-path}/{feature-name}-{ticket}/tasks.md
  ```
  Confirm the file was saved and show the full path.

---

## Step 5 — Hand off

Tell the human:

1. `tasks.md` is saved and approved
2. The next step is Phase 4 (Implementation) — they can use `/implement` when ready

> Do not begin implementation. The human decides when to move forward.
