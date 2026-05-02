---
documentType: 'skill'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Skills Index

> This document is the entry point for all skills. Skills are scoped instruction files that define step-by-step execution guides for specific recurring tasks. Any agent can invoke a skill when the triggering condition is met.

---

## How to Use

Skills are not slash commands — they are reference files agents load when a matching task arises. An agent identifies the relevant skill from this index and follows its execution flow exactly.

Source of truth:

- Files in `knowledge-base/skills/` are canonical.
- Files in `knowledge-base/exports/` are generated mirrors for export workflows.
- Do not manually edit exported copies; run `tools/sync-skills.ps1`.

---

## Skills

### [[get-azure-work-item.skill|Get Azure Work Item]]

Retrieves a work item from the Azure DevOps backlog and presents it in a consistent, readable format. Supports lookup by numeric ID (`AB#1234`) or by title/keyword search. Handles ambiguous results by presenting options and asking the user to confirm before fetching full details.

**Triggered by:** Any request referencing a backlog ticket — by ID or by title.
**Tools used:** `mcp_microsoft_azu_wit_get_work_item`, `mcp_microsoft_azu_search_workitem`

---

### [[new-feature-branch.skill|New Feature Branch]]

Creates a new feature branch from an up-to-date `main` using `tools/new-feature-branch.ps1`. Confirms the branch name with the user, runs the script, and handles common error cases (uncommitted changes, pull failures, duplicate branches).

**Triggered by:** Any request to start a new feature or create a branch from `main`.
**Tools used:** `tools/new-feature-branch.ps1` (PowerShell)

---

## Quick Reference

| Skill | Triggered by |
| --- | --- |
| Get Azure Work Item | User provides a work item ID (`AB#...`) or title/keyword |
| New Feature Branch | User wants to start a feature or create a branch from `main` |

---

*Last updated: 2026-05-01*
