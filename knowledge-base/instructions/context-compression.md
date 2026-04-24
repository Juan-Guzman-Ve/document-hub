# Context Compression

> **Purpose:** Define how an agent must compress and persist its working context during a feature session. Compressed context enables short, focused context windows and allows any future agent to resume work on a feature without re-reading the full conversation history.
> **Applies to:** Any agent actively working on a feature using the feature workflow.

---

## When to Compress

Compress context when **any** of the following occurs:

- The human explicitly requests a context compression (e.g. "compress context", "save context", `/compress-context`)
- The agent detects the context window is becoming large and unwieldy
- The human is about to pause work on the feature and may resume in a future session
- A phase boundary is reached (e.g. Spec approved → moving to Plan)

---

## Where to Store

Context files live inside the active feature folder, under a `context/` subfolder:

```
{feature-folder-path}/
└── {feature-name}-AB#{number}/
    ├── proposal.md
    ├── spec.md
    ├── plan.md
    ├── tasks.md
    ├── implementation.md
    └── context/
        ├── context-latest.md       ← always the most recent snapshot
        ├── context-2026-04-23-1430.md  ← previous snapshots (renamed on each compress)
        └── context-2026-04-23-1200.md
```

The feature folder path is defined in the repo's `copilot-instructions.md` under the **Feature Folder** section.

---

## Versioning Strategy

Each time compression runs:

1. If `context-latest.md` **already exists** → rename it to `context-{YYYY-MM-DD-HHmm}.md` (use the current timestamp)
2. Create a new `context-latest.md` with the current snapshot
3. Never delete old snapshots — they serve as an audit trail

When resuming a feature, always read `context-latest.md`. Only read older snapshots if instructed by the human or if `context-latest.md` is missing.

---

## What to Include in `context-latest.md`

The compressed context must be dense but complete — a future agent reading only this file must be able to resume work without any other conversation history.

### Template

```markdown
# Context Snapshot — {Feature Name}

**Ticket:** AB#{number}
**Compressed at:** {YYYY-MM-DD HH:mm}
**Active phase:** {Phase name and number from feature-workflow.md}

---

## Feature Summary
One paragraph describing what this feature does and why it exists.
Taken from the approved spec — do not rewrite, do not expand.

---

## Progress

| Phase | Status | Notes |
|---|---|---|
| Branch check | done / skipped | Branch: AB#{number} |
| Proposal | done | |
| Spec | done / in progress / not started | |
| Clarification | done / skipped / in progress | |
| Plan | done / in progress / not started | |
| Tasks | done / in progress / not started | |
| Implementation | in progress / not started | {X of Y tasks completed} |

---

## Key Decisions
Bullet list of the most important technical and product decisions made so far.
Each item must be self-contained — include enough context to understand the decision without reading the full conversation.

- {decision}: {rationale}
- {decision}: {rationale}

---

## Files Created or Modified
List every file created or meaningfully changed during this session.

| File | Change |
|---|---|
| `{path}` | Created / Modified — {one-line description} |

---

## Current State
What is happening right now — the exact point where work stopped.
Be specific: which task, which file, which step within the active phase.

---

## Next Action
The single next thing the agent must do when work resumes.
One sentence. Specific enough to act on immediately.

---

## Open Questions / Blockers
Any unresolved questions or blockers that must be addressed before proceeding.

- {question or blocker}
```

---

## Rules

- **Never summarize decisions vaguely** — if a pattern was chosen, name it; if a path was agreed, write the path
- **Never omit files created or modified** — the file list must be accurate enough to reconstruct what changed
- **Always resolve the feature folder path from `copilot-instructions.md`** before writing — never hardcode a path
- **Never overwrite `context-latest.md` without first renaming the existing one** — history must be preserved
- **The snapshot must be self-contained** — assume the next agent has zero conversation history

---

## How a Resuming Agent Uses Context

When a new session starts on a feature that has a `context/` folder:

1. Read `context-latest.md` before any other action
2. Present a brief resume summary to the human:
   - Active phase
   - Current state
   - Next action
3. Ask: *"Ready to continue from here?"* — wait for confirmation before proceeding
4. Do not re-read full phase documents unless the human asks or a decision needs verification

---

## Relationship to Other Instructions

| Instruction | How it connects |
|---|---|
| `feature-workflow.md` | Defines the phases referenced in the Progress table |
| `project-structure.md` | Defines how to locate `copilot-instructions.md` and the feature folder path |

---

*Last updated: 2026-04-23*
