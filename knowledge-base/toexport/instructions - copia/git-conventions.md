# Git Conventions

> **Purpose:** Define how version control is used — branching, commits, and pull requests — to keep history clean and collaboration predictable.

---

## Branching Strategy

Simple trunk-based workflow — all work branches off `main` and merges back via PR.

```
main
 └── AB#1234   ← branch per backlog item, created by the agent
 └── AB#5678
```

| Branch | Purpose |
|---|---|
| `main` | Production-ready code. Never commit directly. |
| `AB#{AZURE_ITEM_NUMBER}` | All work — features, fixes, chores. Always branches off `main`. |

---

## Branch Naming

Branch names follow this format across **all repositories**:

```
AB#{AZURE_ITEM_NUMBER}
```

- `AB#` — stands for **Azure Backlog** — mandatory prefix in every repo
- `{AZURE_ITEM_NUMBER}` — the Azure DevOps backlog item ID linked to this branch

**Examples:**
```
AB#1234
AB#5678
AB#9012
```

> The nature of the work (feature, fix, chore, etc.) is communicated through the commit messages and the PR — not the branch name.

---

## Commit Messages — Conventional Commits

Format:

```
<type>(<scope>): <short description>

[optional body]

[optional footer]
```

### Types

| Type | When to use |
|---|---|
| `feat` | A new feature |
| `fix` | A bug fix |
| `chore` | Maintenance tasks (dependencies, config, tooling) |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `test` | Adding or updating tests |
| `docs` | Documentation only changes |
| `style` | Formatting, whitespace — no logic change |
| `perf` | Performance improvements |
| `ci` | CI/CD configuration changes |

### Scope

Always include the scope when the change is localized to a module, feature, or layer:

```
feat(auth): add JWT refresh token support
fix(orders): correct total calculation on discount
chore(deps): update TypeScript to 5.4
```

### Description rules

- Use **imperative mood**: `add`, `fix`, `update`, `remove` — not `added`, `fixes`, `updating`
- Keep the subject line under **72 characters**
- Do not end with a period
- The body (if needed) explains **why**, not what — the diff shows what

---

## Pull Requests

All work is merged into `main` via PR. The human creates and approves the PR.

### Rules

- **One thing per PR.** A PR that does multiple unrelated things is harder to review and harder to revert.
- **Always requires review** before merging. Do not self-merge without review.
- **Squash merge** into `main`. Each PR becomes a single, clean commit.
- **No force push** on `main`.

### PR Description

Every PR must include:

1. **What** — a short summary of the change
2. **Why** — the context or problem being solved
3. **How** — notable implementation decisions or trade-offs (optional for small PRs)
4. **Testing** — how the change was verified

Template:

```markdown
## What
Brief description of the change.

## Why
Context, linked ticket, or problem being solved.

## How (optional)
Any non-obvious implementation choices or trade-offs.

## Testing
How this was verified (manual test, unit test, etc.)
```

---

## Hard Rules

- **Never commit directly to `main`** — always through a PR
- **Never force push** on `main`
- **Never use generic commit messages** like `fix`, `update`, `wip`, `changes`
- **Keep commits atomic** — one logical change per commit (before squash)
- **Delete branches** after merging

---

*Last updated: 2026-04-22*
