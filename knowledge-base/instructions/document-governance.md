---
documentType: 'note'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Document Governance

> **Purpose:** Keep the knowledge base consistent, searchable, and conflict-free as it grows.

---

## Canonical Hierarchy

When content overlaps, apply this authority order:

1. `instructions/` (canonical rules)
2. `agents/` (role interpretation)
3. `prompts/` (execution orchestration)

---

## Frontmatter Metadata

Every markdown document must include frontmatter metadata with these keys:

- `documentType`
- `owner`
- `phase`
- `appliesTo`
- `canonical`
- `version`
- `supersedes`

Use values that are concise and searchable.

---

## Prompt/Instruction Duplication Rule

Prompts should be orchestration-first:

- Keep complete policy and hard constraints in `instructions/`
- In prompts, reference the relevant instruction and section instead of duplicating full rule text
- Duplicate only short operational reminders required for execution flow

---

## Link Style

Use consistent, relative Obsidian links:

- Prefer `folder/file` or `file` style targets in wikilinks
- Avoid vault-specific prefixes such as `Document Hub/...`
- Keep link targets stable when renaming files

---

## Instruction Naming Strategy

Instruction files must be descriptive, topic-first, and stable.

- Format: `<topic>-<artifact>.md` when possible
- Allowed artifact suffixes: `-workflow`, `-strategy`, `-writing`, `-conventions`, `-compression`, `-prompting`
- Index files are reserved names: `index.md`
- Do not include tool/vendor names in instruction filenames
- Prefer evolution over churn: keep existing stable names unless the current name is ambiguous

Examples:

- `init-workflow.md`
- `testing-strategy.md`
- `git-conventions.md`

---

## Prompt Naming Strategy

Prompts must use a knowledge-base namespace and action-oriented naming.

- File format: `kb-<area>-<action>.prompt.md`
- Slash command format: `/kb-<area>-<action>`
- Keep command stem equal to filename stem
- Use `feature` area for feature lifecycle commands
- Use short verbs: `start`, `load`, `spec`, `plan`, `tasks`, `implement`, `save`, `bootstrap`, `research`

Examples:

- `kb-bootstrap-repo.prompt.md` -> `/kb-bootstrap-repo`
- `kb-feature-start.prompt.md` -> `/kb-feature-start`
- `kb-feature-context-save.prompt.md` -> `/kb-feature-context-save`

---

## Change-log Footer Convention

All instruction and agent rule files should end with:

```markdown
---

*Change reason: {short reason}*
*Impacted files: {comma-separated paths or "none"}*
*Last updated: {YYYY-MM-DD}*
```

---

## Validation

Run these checks after updates:

```powershell
pwsh ./knowledge-base/tools/validate-knowledge-base.ps1
pwsh ./knowledge-base/tools/sync-skills.ps1
```

One-command aliases:

```powershell
pwsh ./knowledge-base/tools/task-alias.ps1 validate-all
pwsh ./knowledge-base/tools/task-alias.ps1 sync-all
pwsh ./knowledge-base/tools/task-alias.ps1 all
```

---

*Last updated: 2026-05-01*
