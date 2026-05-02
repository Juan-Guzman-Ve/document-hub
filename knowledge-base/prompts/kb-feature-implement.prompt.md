---
mode: 'agent'
description: 'Phase 4 — Execute approved tasks and produce implementation.md'
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are executing **Phase 4 — Implementation** of the Feature Development Workflow. Load the workflow definition and all implementation instruction files into your context now:

#file: [[feature-workflow|Feature Workflow]]
#file: [[coding-style|Coding Style]]
#file: [[principles|Software Principles]]
#file: [[design-patterns|Design Patterns]]
#file: [[testing-strategy|Testing Strategy]]
#file: [[git-conventions|Git Conventions]]
#file: [[agent-prompting|Agent Prompting]]

Follow each step below in order.

---

## Step 1 — Locate the feature folder

1. Read `copilot-instructions.md` at the repository root — extract the **Feature Folder** path, **Stack**, and any **Repo-Specific Conventions**
2. Check the current git branch: `git branch --show-current`
3. Find the feature folder matching the current branch name under the feature folder path

If no matching folder is found, stop and tell the human — the feature folder has not been created yet.

---

## Step 2 — Read the approved inputs

- `tasks.md` — required. If it does not exist or has `Status: Draft`, stop and tell the human that Phase 3 must be completed first using `/kb-feature-tasks`.
- `plan.md` — required for architectural context. Read fully before starting any task.
- `spec.md` — read for behavioral context and test scenario reference.

Confirm the task list to the human before starting: list all tasks and their current status. Ask: *"Are all tasks ready to start, or should any be skipped or deferred?"* Wait for confirmation.

---

## Step 3 — Execute tasks

Work through each task in `tasks.md` in order. For each task:

1. Set status to `in progress` in `tasks.md` before starting
2. Read the Task Detail section fully — understand what must be built and what tests must pass
3. Implement the task following `coding-style.md`, `principles.md`, `design-patterns.md`, `testing-strategy.md`, and `copilot-instructions.md`
4. Write the tests defined in the task's Test Cases section — do not defer tests to after implementation
5. Set status to `completed` in `tasks.md` once the task and its tests pass
6. Stop and report to the human if anything unexpected is found — do not make judgment calls or scope changes unilaterally

If a task cannot proceed:
- Set status to `blocked` in `tasks.md`
- Document the blocker in the Comment column
- Report to the human immediately — do not skip to the next task without instruction

Tasks may be delegated to backend or frontend developer subagents when independently scoped. Follow `agent-prompting.md` when writing the brief, and **always include the following instruction file references** so the subagent loads them before starting:

```
#file: [[coding-style|Coding Style]]
#file: [[principles|Software Principles]]
#file: [[design-patterns|Design Patterns]]
#file: [[testing-strategy|Testing Strategy]]
#file: [[git-conventions|Git Conventions]]
```

The subagent must confirm it has loaded these files before starting any implementation work.

---

## Step 4 — Draft implementation.md

Once all tasks reach `completed` or `blocked`, draft `implementation.md` following the template defined in `feature-workflow.md` Phase 4.

- **Execution Log** — one row per task with final status and notes
- **Deviations** — any case where implementation differed from `plan.md` and why; write "None" if there are none
- **Open Questions / Follow-up** — anything that came up requiring future attention; write "None" if there are none
- **Final Status** — summarize what was delivered and confirm all test cases in `tasks.md` are passing

Present the full draft to the human before writing anything to disk.

---

## Step 5 — Write and confirm

- If the human has corrections → revise and re-present
- If approved → write `implementation.md` to:
  ```
  {feature-folder-path}/{feature-name}-{ticket}/kb-feature-implementation.md
  ```
  Confirm the file was saved and show the full path.

---

## Step 6 — Hand off

Tell the human:

1. All tasks are complete and `implementation.md` is saved
2. List any blocked tasks and their documented reasons (if any)
3. List any open follow-up items (if any)
4. The feature is ready for human review and sign-off

> This is the final phase. The feature is not closed until the human explicitly confirms it is complete.
