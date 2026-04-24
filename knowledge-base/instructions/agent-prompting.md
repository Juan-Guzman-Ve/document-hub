# Agent Prompting

> **Purpose:** Define how the master agent must brief and delegate tasks to subagents — ensuring clear scope, consistent execution, and no assumptions.
> **Scope:** Master agent → subagent communication. Not about human → agent prompting.

---

## Core Problems This Document Prevents

- Subagents making assumptions when they can't find an answer
- Subagents continuing work beyond what was asked
- Subagents ignoring key instructions or the repo's conventions
- Ambiguous tasks being executed without clarification

---

## Hard Rules for Any Agent

These apply to every agent at every level:

1. **Do only what was asked.** Nothing more.
2. **Do not assume.** If something is unclear or missing, stop and ask.
3. **Do not invent.** If information cannot be found, report the gap — do not fill it with guesses.
4. **Suggestions are not implementations.** An agent may surface a suggestion, but must not act on it without approval.
5. **When ambiguous, stop.** Ask the human before proceeding. Do not interpret ambiguity as permission.
6. **Follow the repo's `copilot-instructions.md`** and any instruction files referenced within it.

---

## Task Brief Structure

When the master agent delegates a task to a subagent, the brief must always include these four elements:

### 1. Context
What the subagent needs to know before starting — repo conventions, relevant files, current state of the system, or any background that affects how the task should be done.

- Always reference the repo's `copilot-instructions.md` location if applicable
- Include which instruction files apply to this task (e.g., `coding-style.md`, `testing-strategy.md`)

### 2. Objective
A single, precise description of what the subagent must accomplish. If it cannot be stated in one sentence, it should be split into multiple tasks.

### 3. Constraints
What the subagent must **not** do. Explicit boundaries prevent scope creep.

- Files it must not touch
- Patterns or approaches to avoid
- Anything that requires human approval before acting

### 4. Expected Output
Exactly what the subagent must deliver when done — a file, a report, a code change, a list of findings. Be specific about format.

---

## Task Brief Template

```
## Context
[Background the subagent needs. Repo, relevant files, current state.]
[Instruction files to follow: link them explicitly.]
[Skill to use: if a specific skill file exists for this task, reference it here.]

## Objective
[One precise sentence describing what must be done.]

## Constraints
- [What not to do]
- [What requires approval before acting]
- [Scope boundaries]

## Expected Output
[Exact deliverable — format, location, content.]
```

---

## Skills

Subagents may be directed to use a **skill** — a scoped instruction file that defines how to perform a specific type of task (e.g., how to scaffold a feature, how to write a migration, how to generate a test suite).

- Skills are defined per-repo or globally and referenced from `copilot-instructions.md`
- When a skill exists for the task, the master agent **must** reference it in the brief
- If no skill exists yet, the master agent uses the general instruction files as guidance
- Skills are not yet defined — this section will be expanded as they are created

---

## Execution Flow for Subagents

Every subagent must follow this sequence:

```
1. Read the task brief fully before starting
2. Identify which instruction files and skills apply
3. Check the repo's copilot-instructions.md for repo-specific conventions
4. If anything is ambiguous → STOP. Report the ambiguity. Do not proceed.
5. Execute only what is in the Objective
6. Respect all Constraints — do not cross scope boundaries
7. Deliver the Expected Output as specified
8. Report back: what was done, what was not done, and any open questions
```

---

## Ambiguity Protocol

If a subagent encounters anything unclear during execution:

- **Stop immediately** — do not make a judgment call
- **Report the specific ambiguity** to the master agent
- **The master agent escalates to the human** — it does not resolve ambiguity on its own either

Neither the subagent nor the master agent resolves ambiguity through assumption.

---

## What a Subagent Reports Back

At the end of every task, the subagent must report:

| Section | Content |
|---|---|
| **Done** | What was completed, with references to files or outputs |
| **Not done** | Anything in scope that was not completed and why |
| **Deviations** | Any case where the subagent had to make a judgment call (should be rare) |
| **Open questions** | Anything that needs human input before the work can be considered finished |

---

*Last updated: 2026-04-21*
