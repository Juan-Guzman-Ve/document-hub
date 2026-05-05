---
documentType: 'skill'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Skill — New Feature Branch

> **Purpose:** Create a new feature branch by switching to `main`, pulling the latest changes, and checking out a new branch with the correct name.
> **Triggered by:** Any request to start a new feature or create a branch from `main`.

---

## When to Use This Skill

Use this skill whenever:

- The user wants to start work on a new feature or ticket
- A new branch needs to be created from an up-to-date `main`
- The `/kb-feature-start` prompt reaches the branch creation step

---

## Input Resolution

| Input type | Example | Notes |
|---|---|---|
| Feature code + name | `AB#1234-user-authentication` | Preferred — follows git conventions |
| Feature code only | `AB#1234` | Acceptable if name is not yet known |
| Name only | `user-authentication` | Use only if no ticket exists |

Branch naming must follow [[git-conventions|Git Conventions]]. If the user provides a raw ticket number, expand it to `AB#{number}-{slug}` where the slug is derived from the ticket title.

---

## Execution Flow

1. Confirm the branch name with the user before running: *"I'll create branch `{branchName}` from `main`. Confirm?"*
2. Run the script:

```powershell
pwsh "$HOME/.kb/tools/new-feature-branch.ps1" -BranchName "{branchName}" -RepoPath "."
```

3. Verify the output confirms the correct branch is now active
4. Report the result: *"Branch `{branchName}` created and checked out."*

---

## Error Handling

| Situation | Action |
|---|---|
| Uncommitted changes on current branch | Stop. Report: *"There are uncommitted changes on the current branch. Commit or stash them before switching."* |
| `main` pull fails (network / auth) | Stop. Report the git error verbatim and ask the user to resolve it manually. |
| Branch already exists | Report: *"Branch `{branchName}` already exists. Use `/kb-feature-load` to resume it instead."* |
