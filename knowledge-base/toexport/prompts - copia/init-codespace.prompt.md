---
mode: 'agent'
description: 'Initialize a repository — scan codebase, confirm stack, generate copilot-instructions.md + .code-workspace'
---

You are executing the **Repository Init Workflow**. Load the full workflow definition into your context now — it is the authoritative source for templates, rules, and hard constraints:

#file: [[init-workflow|Init Workflow Instructions]]

Follow every phase in order. Do not skip phases. Do not generate any files before receiving explicit human approval in Phase 4.

---

## Phase 1 — Discover

Do all of the following **before asking the human anything**:

1. List all top-level files and folders in the current repository root
2. Detect the tech stack — look for: `package.json`, `*.csproj`, `*.sln`, `angular.json`, `tsconfig.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `requirements.txt`, `Dockerfile`
3. Find existing documentation — look for: `README.md`, `copilot-instructions.md`, `docs/`, `wiki/`
4. Identify candidate feature folders — look for: `Features/`, `features/`, `src/Features/`, `modules/`, `pages/`, `apps/`
5. Check for `.gitmodules` — if present:
   - List all submodule names and their local paths
   - For each submodule, scan its root for shared-code signals: `package.json`, `*.csproj`, `src/`, `lib/`, `shared/`
   - Note which submodules appear to contain shared/reusable logic vs. standalone tools
   - If submodule folders are empty (not yet initialized), report this explicitly — do not assume content

Then present a **Discovery Summary** in this format before proceeding:

```
## Discovery Summary

**copilot-instructions.md present:** yes / no
**Tech stack detected:** ...
**Feature folder candidates:** ...
**Existing docs:** ...
**Submodules:** none | (name → local path, apparent purpose)
```

---

## Phase 2 — Confirm

Ask the human the following questions. Wait for all answers before generating anything.

1. What does this project do? *(1–3 sentences — goes into the Overview section)*
2. Is the detected tech stack correct? Any corrections or additions?
3. Where should the feature folder live? *(confirm a candidate or specify the path)*
4. Are there any repo-specific conventions that override the global instructions?
5. What is the internal path within your vault? *(the folders between `obsidian\` and `knowledge-base\` — e.g. `document-hub`)*
6. *(If submodules were detected)* What does each submodule provide? What shared logic or contracts does this repo consume from it?
7. *(Optional)* Are there any MCP database connections available for this repository? If yes, for each one provide: a connection name, the MCP server identifier, the database or schema it connects to, and what the agent should use it for.

> Do not invent answers. If the human skips a question, leave the corresponding section as a clearly marked placeholder.

---

## Phase 3 — Generate

Using the confirmed answers, produce both files using the templates defined in `init-workflow.md` sections 3a and 3b.

**File 1 — `copilot-instructions.md`** (at repository root)
Use template section 3a. Substitute all `{placeholders}` with confirmed values. Include the Submodules section only if submodules are present. Include the MCP Database Connections section only if connections were provided in Phase 2.

**File 2 — `{repo-name}.code-workspace`** (at repository root)
Use template section 3b. Set `{repo-name}` and `{your-internal-path}` from Phase 2 answers.

**Present both files in full to the human before writing anything to disk.**

---

## Phase 4 — Validate

Walk through this checklist with the human before writing files:

- [ ] Overview accurately describes the project
- [ ] Stack matches what is actually in use
- [ ] Folder structure reflects the real repo layout
- [ ] Feature folder path is confirmed and correct
- [ ] Knowledge base references point to the correct location
- [ ] Repo-specific conventions are noted (or explicitly marked as none)
- [ ] Submodules section is present and accurate *(or explicitly omitted if no submodules)*
- [ ] MCP Database Connections section is present and accurate *(or explicitly omitted if none configured)*
- [ ] `.code-workspace` includes the repo folder and the correct Document Hub path

Ask for **explicit approval**. Write both files only after approval is given.

Once saved, confirm the file paths and announce that the init workflow is complete. From this point, treat `copilot-instructions.md` as the authoritative entry point for all future work in this repository.

---

## Hard Rules (from init-workflow.md — enforced here)

- **Never generate files without human approval** — always complete Phases 2 and 4 first
- **Never invent stack details, folder paths, or submodule descriptions** — ask if uncertain
- **Never proceed to feature work** until init is complete and approved
- **Do not overwrite an existing `copilot-instructions.md`** without explicit instruction — present a diff and ask first
