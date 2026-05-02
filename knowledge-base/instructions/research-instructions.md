---
documentType: 'instruction'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Research Instructions

> **Purpose:** Define how the master agent must conduct technical research using subagents, keeping the main context window clean and focused.

---

## Core Philosophy

- **Never assume. Never invent.** If information cannot be found from a reliable source, stop and ask the human.
- **Prefer simple answers.** Do not propose complex solutions when a simpler one exists or when confidence is low.
- **Transparency over completeness.** It is better to report a gap than to fill it with speculation.

---

## When to Delegate to a Subagent

The master agent must delegate research tasks to subagents whenever:

- Answering the task requires fetching or reading external sources
- The research could grow the context window significantly
- Multiple independent sources need to be checked in parallel
- The task is clearly scoped and can be described as a self-contained question

The master agent **does not** research inline. It defines the task, delegates, and synthesizes the report.

---

## Subagent Strategy — One Agent Per Source Type

Each subagent is assigned **one source type** to keep results focused and composable. The master agent decides which source types are relevant for a given research task.

| Source type         | What the subagent does                                                                                                              |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Official docs**   | Reads the official documentation for the technology/library in question                                                             |
| **GitHub**          | Searches repos, issues, PRs, changelogs, or source code                                                                             |
| **Technical blogs** | Finds relevant articles from recognized engineering blogs                                                                           |
| **MCP database**    | Queries the repository's configured MCP database connections to inspect schemas, validate assumptions, or trace data flow — **read-only** |
| **Codebase**        | Explores the current repository to find existing usage patterns, conventions, and implementations — **read-only**                   |

The master agent may spawn one or more subagents depending on the complexity and scope of the task. The MCP database source is only available when connections are defined in the repository's `copilot-instructions.md`. The codebase source is only applicable when running inside a repository.

---

## MCP Database Exploration

When a repository's `copilot-instructions.md` defines MCP database connections, the master agent may use them as a first-party research source — they reflect the actual data the system works with, making them the ground truth for any data-shape or schema question.

### When to use a database subagent

- Understanding a table's structure before writing code that touches it
- Confirming that a column, relationship, or constraint exists as assumed
- Tracing how data flows across tables or schemas
- Answering questions about current data state (value distributions, null rates, record counts)

### How to brief a database subagent

Include in the brief:

1. **Which connection to use** — reference the connection name from `copilot-instructions.md` exactly
2. **The specific question** — scoped and precise (e.g. "What columns does the `orders` table have and which are nullable?")
3. **What to return** — schema findings, relevant data patterns, and any unexpected constraints or relationships

### Extended report format for database subagents

In addition to the standard Findings / Sources / Limitations / Recommendations format, database subagents must include:

- **Queries executed** — the exact read queries run, so the master agent can verify them
- **Schema snapshot** — tables, columns, types, nullability, and key relationships relevant to the question
- **Data observations** — notable patterns, unexpected values, or constraints discovered

---

## Codebase Exploration

When the research question is implementation-oriented — *"how should I implement X in this repo?"* — the **current repository is the primary context**. Before any external source can give a useful answer, the agent must understand the repo it is working in: its structure, its tech stack, its established patterns, and what already exists.

The codebase subagent does not just look for a specific symbol or file. Its job is to **read the repo as a collaborator would on their first day**: understand the architecture, identify the conventions already in place, and surface any existing implementation of the concept being researched. Only with that context can external findings be translated into something that fits this specific project.

### When to use a codebase subagent

Use a codebase subagent whenever the question has an implementation dimension — i.e., the answer will eventually affect code written in this repo. This includes:

- "How should I implement X here?" — the codebase defines the expected approach
- "Is there already a pattern for X in this project?" — avoids duplication and enforces consistency
- "What libraries, utilities, or abstractions does this repo already use for X?" — external research is irrelevant if we already have a solution
- "How is Y structured across this codebase?" — understanding a layer before adding to it

> When in doubt, always spawn a codebase subagent. It costs nothing and prevents proposing patterns that conflict with what the team already does.

### How to brief a codebase subagent

The subagent must explore the repo systematically, not just search for a keyword. Include in the brief:

1. **Start with `copilot-instructions.md`** — instruct the agent to read this first. It is the repo's map: stack, folder structure, feature conventions, and registered tools. Everything else is explored relative to what this file reveals.
2. **The specific question** — what concept, pattern, or library to investigate (e.g. "how is Dapper used for data access?")
3. **The scope** — if the question is layer-specific, narrow the search (e.g. "look in the infrastructure and data access layers"); otherwise explore broadly
4. **What to return** — a repo overview, relevant file paths, code snippets illustrating the pattern, and a summary of the conventions observed

### Execution flow for the codebase subagent

The subagent must follow this order:

1. Read `copilot-instructions.md` — understand the repo's structure, stack, and conventions
2. Identify the relevant folders and layers based on the research question
3. Search and read files to find existing patterns or implementations
4. Report findings with concrete file references and code examples

### Extended report format for codebase subagents

In addition to the standard Findings / Sources / Limitations / Recommendations format, codebase subagents must include:

- **Repo overview** — a brief summary of the relevant parts of the repo: stack, folder structure, key layers (from `copilot-instructions.md`)
- **Files explored** — paths searched and specific files read
- **Code references** — relevant snippets with file path and line range, illustrating the pattern found
- **Pattern summary** — a concise description of the convention or approach already established in the codebase, which external research must align with

---

## How to Brief a Subagent

When spawning a subagent, the master agent must provide:

1. **The specific question** — precise and scoped, not vague
2. **The source type** — which kind of source to use
3. **The technology context** — stack, version if known, language
4. **What to return** — findings, limitations, and recommendations (see report format below)

> The brief must be detailed enough that the subagent can act autonomously without asking follow-up questions.

---

## Subagent Report Format

Every subagent must return a report with the following structure:

### Findings
What was found. Facts only — no interpretation. Include direct quotes or references where relevant.

### Sources
List of sources consulted with URLs and dates (or last-updated date if available). Prefer sources that are dated; flag any undated sources explicitly.

### Limitations
What the subagent could **not** find or verify. Be explicit about gaps.

### Recommendations
Based solely on findings — no speculation. If confidence is low, state it. If the question cannot be answered confidently, recommend asking the human.

---

## Master Agent Responsibilities After Research

After receiving subagent reports, the master agent:

1. **Synthesizes** the findings into a coherent summary being concise, and if there are comparisons its better to have tables.
2. **Resolves conflicts** between sources (prefer database > official docs > GitHub > blogs — see Source Priority)
3. **Identifies gaps** — if a critical question is unanswered, asks the human before proceeding
4. **Does not proceed** with implementation based on unverified or speculative findings
5. **Saves a research note** to the vault if the findings are worth preserving

---

## Source Priority

When sources conflict, use this order:

1. **MCP database connections** — for questions about data structure, schema, or runtime data state, this is the ground truth. Prefer it over all other sources when the question is about what actually exists in the system.
2. **Codebase** — for questions about how something is implemented or should be implemented in this project, the existing code is the ground truth. It reflects the team's established conventions and what is already in production.
3. **Official documentation** — authoritative for API behavior, library usage, and technology specifics
4. **GitHub source / issues / changelogs** — useful for undocumented behavior, bugs, and version-specific details
5. **Technical blogs** (dev.to, official engineering blogs, well-known authors) — useful for patterns and real-world usage
6. **Avoid:** undated sources, anonymous posts, AI-generated content presented as fact

> Database connections are only applicable to data-shape questions. Codebase exploration is only applicable to implementation and convention questions. For technology or API questions, official docs remain the top source.

---

## Research Note Format (Obsidian)

When findings are worth saving, the master agent creates a note. Location is decided by the master agent based on context (project folder, topic area, etc.).

```markdown
# [Topic]

**Date:** YYYY-MM-DD
**Status:** Draft | Verified | Superseded

## Summary
One paragraph. What was researched and what was concluded.

## Key Findings
- Bullet points only. Facts, not opinions.

## Sources
- [Source name](url) — YYYY-MM-DD

## Limitations & Open Questions
- What could not be answered
- What still needs to be validated

## Recommendation
What to do next, or what decision this research supports.
```

---

## Hard Rules

- **MCP database connections are read-only — non-negotiable.** Never execute INSERT, UPDATE, DELETE, DROP, TRUNCATE, or any other write or destructive operation. If a research task seems to require writing data, stop immediately and ask the human. There are no exceptions.
- **Do not invent APIs, functions, or behaviors** that were not confirmed in a source
- **Do not recommend a solution that is disproportionately complex** for the problem at hand
- **If a source is outdated** (>2 years for fast-moving ecosystems), flag it explicitly and look for a newer one
- **If research yields no confident answer**, report limitations and ask the human — do not guess

---

*Last updated: 2026-04-27*


---

*Change reason: 2026-05-01 consistency and governance update*
*Impacted files: knowledge-base-wide policy alignment*