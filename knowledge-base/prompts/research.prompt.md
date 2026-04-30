---
mode: 'agent'
description: 'Research a technical topic using parallel subagents — one per source type'
inputs:
  - id: topic
    description: 'What to research (e.g. "Oracle pagination strategies in .NET", "Angular signals best practices")'
    type: promptString
  - id: context
    description: 'Tech stack and version context (e.g. ".NET 8, Oracle 19c, Dapper")'
    type: promptString
---

You are conducting a technical research task. Load the research instructions into your context now:

#file:.[[research-instructions| Research Instructions]]

Also load the agent prompting guide so subagents are briefed correctly:

#file:..[[agent-prompting|Agent Prompting]]

**Research topic:** ${input:topic}
**Stack / context:** ${input:context}

Follow each step below in order.

---

## Step 1 — Scope the research

Before spawning any subagents, define the research scope:

1. Break `${input:topic}` into **specific, answerable questions** — no vague asks
2. Determine which source types are relevant for each question:
   - **Codebase** — **always include this for implementation questions.** The current repo is the primary context: its stack, conventions, and existing patterns define what a correct answer looks like for this project. The codebase subagent reads `copilot-instructions.md` first to understand the repo, then explores the relevant layers.
   - **Official docs** — for APIs, configuration, language specs, framework behavior
   - **GitHub** — for real-world usage, issues, changelogs, undocumented behavior
   - **Technical blogs** — for patterns, trade-offs, and real-world experience
3. Present the scoped question list to the human and ask: *"Does this cover what you need, or should any question be added, removed, or rephrased?"*

Wait for confirmation before proceeding.

---

## Step 2 — Spawn subagents in parallel

For each confirmed question, spawn one subagent per source type following the briefing format from `research-instructions.md`.

Each subagent brief must include:
- The specific question (precise and scoped)
- The assigned source type
- The stack/version context: `${input:context}`
- The required report format: Findings → Sources → Limitations → Recommendations

Run all subagents **in parallel** — do not wait for one to finish before starting the next.

---

## Step 3 — Synthesize the reports

After all subagents return, synthesize their findings following `research-instructions.md`:

1. Use codebase findings as the **implementation context** — external findings must be interpreted through the lens of what the repo already does. If the codebase already has a pattern, external sources inform refinement, not replacement.
2. Resolve conflicts using source priority: Codebase > Official Docs > GitHub > Blogs
3. Identify gaps — questions that could not be answered confidently
4. Produce a **Research Summary** in this format:

```
## Research Summary — {topic}

**Date:** {YYYY-MM-DD}
**Stack:** {context}

### Conclusions
Bullet list of confident, source-backed conclusions.

### Gaps / Unresolved Questions
Bullet list of what could not be answered. For each gap, state why (no source found, conflicting sources, outdated information).

### Recommendations
What to do next — decisions this research supports, or what needs to be asked of the human before proceeding.

### Sources
- [Source name](url) — YYYY-MM-DD
```

---

## Step 4 — Save a research note (optional)

Ask the human: *"Should I save these findings as a research note?"*

If yes — ask where to save it (project folder, topic area, or default to the current feature folder if working inside a feature). Create the note using the Research Note Format from `research-instructions.md`.

---

## Step 5 — Hand off

Present the Research Summary. If there are gaps that block a decision, surface them clearly and recommend the human answer them before proceeding to the next phase (e.g. Clarification or Plan).

> Do not proceed to implementation or planning based on unverified or speculative findings — follow the hard rules in `research-instructions.md`.
