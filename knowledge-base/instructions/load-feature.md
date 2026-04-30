
# Load Feature Instruction

> **Purpose:** Define how an agent must locate, load, and summarize all information for an existing feature when a human wants to resume or inspect it.
> **Applies to:** Any session where the human wants to work on a feature that has already been created.

---

## Overview

When the human provides a **feature name** or a **feature code** (e.g. `AB#1234`), the agent must:

1. Locate the correct feature folder
2. Load every document found inside it
3. Present a structured summary of the feature's current state
4. Stand ready to continue work from wherever the feature was left off

---

## Input Resolution

The human may provide either:

| Input type | Example | Match strategy |
|---|---|---|
| Feature code | `AB#1234`, `1234` | Match any folder whose name contains `AB#1234` |
| Feature name | `user-authentication` | Case-insensitive substring match against folder names |

If the input is an unformatted number (e.g. `1234`), treat it as a feature code and expand it to `AB#1234`.

---

## Step 1 — Resolve the Feature Folder Path

1. Read `copilot-instructions.md` at the repository root
2. Extract the **Feature Folder** path (e.g. `src/Features/`, `app/features/`)
3. If `copilot-instructions.md` is missing or has no Feature Folder section, stop and tell the human — the repo must be initialized first using `/init-codespace`

---

## Step 2 — Locate the Feature Folder

Search the feature folder path for a subfolder that matches the human's input using the strategy in [Input Resolution](#input-resolution).

**If exactly one match is found** → proceed with that folder.

**If multiple matches are found** → list all matches and ask the human to confirm which one to load.

**If no match is found** → report that no feature folder was found for the given name or code, list all existing feature folders to help the human, and stop.

---

## Step 3 — Load Feature Documents

Read every file present in the matched feature folder. The expected documents are:

| File | Phase | Required |
|---|---|---|
| `proposal.md` | Phase 0 | Optional — may not exist if feature was created manually |
| `spec.md` | Phase 1 | Optional |
| `plan.md` | Phase 2 | Optional |
| `tasks.md` | Phase 3 | Optional |
| `implementation.md` | Phase 4 | Optional |
| `context/context-latest.md` | Any | Optional — read if present |

Read every file that exists. Do not fail if any are missing — their absence is itself useful information about the current phase.

---

## Step 4 — Determine Current Phase

Based on which documents exist and their `Status` fields, determine the feature's current phase:

| Condition | Current phase |
|---|---|
| No documents, or only `proposal.md` | Phase 0 — Proposal |
| `spec.md` exists but is `Draft` or missing | Phase 1 — Spec in progress |
| `spec.md` is `Approved`, `plan.md` missing or `Draft` | Phase 2 — Plan in progress |
| `plan.md` is `Approved`, `tasks.md` missing or `Draft` | Phase 3 — Tasks in progress |
| `tasks.md` is `Approved` or `In Progress`, `implementation.md` missing | Phase 4 — Implementation in progress |
| `implementation.md` exists with `Status: Completed` | Feature complete |

---

## Step 5 — Present the Feature Summary

Present a structured summary to the human using this format:

```
## Feature Loaded — {Feature Name}

**Folder:** {full path to feature folder}
**Ticket:** {AB# number, or "not found" if absent}
**Current Phase:** {phase name}
**Next Step:** {what should happen next, e.g. "Resume /write-spec", "Continue /implement", "Feature is complete"}

---

### Document Status

| Document        | Status              |
|-----------------|---------------------|
| proposal.md     | Present / Missing   |
| spec.md         | Draft / Approved / Missing |
| plan.md         | Draft / Approved / Missing |
| tasks.md        | Draft / Approved / In Progress / Completed / Missing |
| implementation.md | Present / Missing |
| context snapshot | Present / Missing  |

---

### Summary
{2–4 sentence plain-language summary of what the feature is about, based on proposal.md or spec.md}

### Open Items
{Any open questions from the latest document, or "None"}
```

After presenting the summary, tell the human you are ready to continue and ask what they would like to do next.

---

## Rules

- **Never start any phase automatically.** Load and summarize only. Wait for the human to direct the next action.
- **Always load `context/context-latest.md` if it exists.** It may contain state from a previous session that supersedes earlier documents.
- **Do not modify any files during this command.** This is a read-only operation.
- **If `tasks.md` is loaded and has tasks `in progress`**, highlight those specifically so the human knows work was already in flight.

---

*Last updated: 2026-04-29*
