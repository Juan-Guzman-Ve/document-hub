---
documentType: 'guide'
owner: 'knowledge-base'
phase: 'n/a'
appliesTo: 'all'
canonical: 'true'
version: '1.0'
supersedes: 'none'
---
# Developer Environment Setup

> **Audience:** Human developers — not agents. Complete this once before working with this knowledge base.

---

## Overview

The agents and tooling in this system rely on one installation rule: the knowledge-base is installed once under your user profile and then reused across all repositories.

Canonical install location:

- Windows: `~/.kb`
- macOS/Linux: `~/.kb`

This removes any requirement to place repositories beside the knowledge-base repo source.

---

## Step 1 — Install the Knowledge Base

1. Install `nuget.exe` and ensure `nuget` is on PATH.
2. Run from this repository to download and install the published package:

```powershell
pwsh ./build/install-knowledge-base-from-nuget.ps1 -PackageId "DocumentHub.KnowledgeBase" -Version "1.0.0" -Force
```

If you are working directly from this repository source instead of a published package:

```powershell
pwsh ./build/install-knowledge-base.ps1 -Force
```

---

## Step 2 — Register Shared Resources in VS Code

Add the following three entries to your VS Code **user settings** — this is a one-time global setup that makes shared agents, instructions, and prompts available in every repository without needing to configure each workspace file.

Open your user settings file:

- **Windows:** `%APPDATA%\Code\User\settings.json`
- **macOS:** `~/Library/Application Support/Code/User/settings.json`
- **Linux:** `~/.config/Code/User/settings.json`

Add the entries using absolute paths in your user profile. This makes them work from any repository location.

```json
"chat.agentFilesLocations": {
  "~/.kb/agents": true
},
"chat.instructionsFilesLocations": {
  "~/.kb/instructions": true
},
"chat.promptFilesLocations": {
  "~/.kb/prompts": true
}
```

| Setting | What it enables |
|---|---|
| `chat.agentFilesLocations` | Shared agents appear in the VS Code agent picker in every repo |
| `chat.instructionsFilesLocations` | Shared instruction files are available to Copilot in every repo |
| `chat.promptFilesLocations` | Shared slash commands (`/kb-bootstrap-repo`, `/kb-feature-start`, etc.) work in every repo |

---

## What This Enables

Once complete:

- Shared agents (Staff Engineer, Product Owner, etc.) appear in the VS Code agent picker in **every repo** — no workspace file required
- You can run the init workflow on any repository immediately
- Repository location is unconstrained — repos can live on any drive/path

---

## Next Step

Once this setup is complete, you are ready to initialize any repository:

→ Run `/kb-bootstrap-repo` in VS Code Copilot Chat

---

*Last updated: 2026-05-04*
