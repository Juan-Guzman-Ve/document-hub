# Research Instructions

> **Purpose:** Define how the master agent must conduct technical research using subagents, keeping the main context window clean and focused.
> **WHEN USING MCP TOOLS ON REASEARCH TASK DO NOT PERFORM ANY INSERT/UPDATE/DELETE OPERATION NEVEER!**

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

| Source type         | What the subagent does                                                                                                |
| ------------------- | --------------------------------------------------------------------------------------------------------------------- |
| **Official docs**   | Reads the official documentation for the technology/library in question                                               |
| **GitHub**          | Searches repos, issues, PRs, changelogs, or source code                                                               |
| **Technical blogs** | Finds relevant articles from recognized engineering blogs                                                             |
| Database            | Find relevante information on the actual structures of the database using mcp oracle connections defined by the human |

The master agent may spawn one, two, or all three subagents depending on the complexity and scope of the task.

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

1. **Synthesizes** the findings into a coherent summary
2. **Resolves conflicts** between sources (prefer official docs > GitHub > blogs)
3. **Identifies gaps** — if a critical question is unanswered, asks the human before proceeding
4. **Does not proceed** with implementation based on unverified or speculative findings
5. **Saves a research note** to the vault if the findings are worth preserving

---

## Source Priority

When sources conflict, use this order:

1. **Official documentation** — authoritative, always preferred
2. **GitHub source / issues / changelogs** — useful for undocumented behavior, bugs, and version-specific details
3. **Technical blogs** (dev.to, official engineering blogs, well-known authors) — useful for patterns and real-world usage
4. **Avoid:** undated sources, anonymous posts, AI-generated content presented as fact

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

- **Do not invent APIs, functions, or behaviors** that were not confirmed in a source
- **Do not recommend a solution that is disproportionately complex** for the problem at hand
- **If a source is outdated** (>2 years for fast-moving ecosystems), flag it explicitly and look for a newer one
- **If research yields no confident answer**, report limitations and ask the human — do not guess

---

*Last updated: 2026-04-20*
