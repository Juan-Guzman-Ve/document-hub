---
documentType: 'instruction'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# EOD Summary Instructions

> **Purpose:** Define how to produce an end-of-day progress summary when asked.
> **Applies to:** Any agent or human writing a daily summary for a feature or task.

---

## What an EOD Summary Is

A factual, short description of work completed during the session. It is not a status report, not a pitch, not a changelog with outcomes explained.

---

## Rules

- **Describe actions, not outcomes.** Write what was done, not what it enables or improves.
- **No marketing tone.** Do not use words like "allowing", "enabling", "improving", "ensuring", or "so that".
- **No outcome justification.** Do not explain why something matters or what it unlocks. State what happened.
- **Short.** Each bullet is one sentence. No paragraphs.
- **Factual.** Only mention things that actually happened in the session. Do not pad with context or intent.

**Bad:**
> "Resolved Q1 (MasterStudy extraction), which allows the plan phase to proceed without ambiguity."

**Good:**
> "Resolved Q1 (MasterStudy extraction) by querying the Oracle package source in WatsonAID."

---

## Format

```
[eod]

• {action taken}
• {action taken}
• {action taken}
```

Plain text only — no markdown, no bold, no headers beyond the `[eod]` tag. Output must be pasteable directly into an Azure DevOps discussion item.

---

## What to Cover (when applicable)

Pull from the session's actual work. Common items:

- Documents created or updated (proposal, spec, plan, tasks)
- Research conducted and what source was used
- Decisions or questions resolved, and how
- Test scenarios written or changed
- Code written or changed

Do not include:
- Items that were not touched in the session
- Items that are planned but not yet started
- Explanations of why something was done

---

*Last updated: 2026-04-24*


---

*Change reason: 2026-05-01 consistency and governance update*
*Impacted files: knowledge-base-wide policy alignment*