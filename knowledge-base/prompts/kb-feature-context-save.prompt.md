---
mode: 'agent'
description: 'Compress and persist the current feature context to context/latest.md'
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are compressing the current working context for this feature session. Load the full compression instructions now:

#file: [[context-compression|Context Compression]]

Follow each step below in order.

---

## Step 1 — Locate the feature folder

1. Read `copilot-instructions.md` at the repository root
2. Extract the **Feature Folder** path (e.g. `src/Features/`, `app/Features/`)
3. Check the current git branch: `git branch --show-current`
4. Find the feature folder that matches the current branch (`AB#{number}`) under the feature folder path

If no matching folder is found, stop and tell the human — the feature folder may not have been created yet (`/kb-feature-start` must be run first).

---

## Step 2 — Prepare the context folder

1. Check if `{feature-folder}/{feature-name}-AB#{number}/context/` exists
2. If it does not exist → create it
3. If `latest.md` already exists inside it → rename it to `{YYYY-MM-DD-HHmm}.md` using the current timestamp before proceeding

---

## Step 3 — Build the snapshot

Produce the contents of the new `latest.md` following the template defined in `context-compression.md`.

To fill it accurately:
- Read the feature phase files that exist (`proposal.md`, `spec.md`, `plan.md`, `tasks.md`, `implementation.md`) — use them as the source of truth for decisions and progress
- Derive the active phase from which files exist and their `Status:` fields
- Derive files created/modified from the current session and from `tasks.md` if implementation is in progress
- Write the **Current State** and **Next Action** sections based on where work stopped — be specific

Present the full draft of `latest.md` to the human before writing.

---

## Step 4 — Write and confirm

After the human approves (or if no corrections are requested within one exchange):

1. Write `latest.md` to `{feature-folder}/{feature-name}-AB#{number}/context/latest.md`
2. Confirm the file was saved and show the full path
3. If an old snapshot was renamed in Step 2, confirm that as well

Tell the human the context is saved and the session can be safely closed. When work resumes, the next agent will read `latest.md` to restore state instantly.
