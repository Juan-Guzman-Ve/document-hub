---
mode: 'agent'
description: 'Load an existing feature — locate the folder, read all documents, and present a full status summary'
inputs:
  - id: featureIdentifier
    description: 'Feature name (e.g. user-authentication) or feature code (e.g. AB#1234 or just 1234)'
    type: promptString
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are loading an existing feature. Load the feature-loading instruction into your context now:

#file: [[load-feature|Load Feature Instruction]]

The human wants to work on the following feature: **${input:featureIdentifier}**

Follow each step below in order.

---

## Step 1 — Resolve the feature folder path

Read `copilot-instructions.md` at the repository root and extract the **Feature Folder** path.

If `copilot-instructions.md` is missing or has no Feature Folder section, stop and tell the human — the repo must be initialized first using `/kb-bootstrap-repo`.

---

## Step 2 — Locate the feature folder

Using the input `${input:featureIdentifier}`:

- If it is a number or matches the pattern `AB#\d+`, search for a folder whose name contains that code
- Otherwise, perform a case-insensitive substring match of `${input:featureIdentifier}` against all folder names under the feature folder path

Handle ambiguous or missing matches as defined in `load-feature.md` Step 2.

---

## Step 3 — Load all feature documents

Read every file present in the matched feature folder:

- `proposal.md`
- `spec.md`
- `plan.md`
- `tasks.md`
- `implementation.md`
- `context/latest.md` (if present)

Do not fail if any files are missing — note their absence.

---

## Step 4 — Determine the current phase

Using the presence and `Status` fields of the documents loaded in Step 3, determine the current phase as defined in `load-feature.md` Step 4.

---

## Step 5 — Present the feature summary

Present the full feature summary to the human using the format defined in `load-feature.md` Step 5.

Highlight any tasks that are currently `in progress` if `tasks.md` was loaded.

After presenting, tell the human you are ready to continue and ask what they would like to do next.

> Do not start any phase or modify any files. This command is read-only.
