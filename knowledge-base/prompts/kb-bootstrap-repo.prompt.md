---
mode: 'agent'
description: 'Initialize a repository — scan codebase, confirm stack, generate copilot-instructions.md + .code-workspace'
documentType: 'prompt'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---

You are executing the **Repository Init Workflow**. Load the full workflow definition into your context now — it is the authoritative source for templates, rules, and hard constraints:

#file: [[init-workflow|Init Workflow Instructions]]

Execute the workflow exactly as defined in `init-workflow.md`.

Mandatory behavior:

1. Follow phases in order: Discover -> Confirm -> Generate -> Validate.
2. Do not generate or write files before explicit human approval in Validate.
3. Present both generated files in full before writing.
4. Do not invent missing project details; ask and keep placeholders when unanswered.
5. Do not proceed to feature work until init is complete and approved.

Expected outputs:

- Repository root `copilot-instructions.md`
- Repository root `{repo-name}.code-workspace`

If an existing `copilot-instructions.md` is present, present a diff and ask for explicit overwrite approval before writing.
