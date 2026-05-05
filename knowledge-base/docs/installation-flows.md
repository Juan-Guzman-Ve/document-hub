# Installation Flows

This document explains all supported installation paths for the Knowledge Base.

## Prerequisites

- PowerShell 7 (`pwsh`)
- `nuget.exe` on PATH for NuGet-based flow
- VS Code installed (optional but recommended)

## Flow 1: Consumer Install from NuGet Feed

Use this when package `DocumentHub.KnowledgeBase` is already published to a feed.

From repository root:

```powershell
pwsh -NoProfile -File ./build/install-knowledge-base-from-nuget.ps1 -PackageId "DocumentHub.KnowledgeBase" -Version "1.0.0" -Source "https://api.nuget.org/v3/index.json" -Force
```

What happens:

1. Script validates `nuget.exe` availability.
2. Package is downloaded under `.tmp/knowledge-base-nuget`.
3. Script invokes `build/install-from-nupkg.ps1` from inside the extracted package.
4. Content is copied into `~/.kb`.
5. VS Code user settings are updated automatically with:
   - `~/.kb/agents`
   - `~/.kb/instructions`
   - `~/.kb/prompts`

## Flow 2: Contributor Install from Local Source

Use this when working directly in this repository.

From repository root:

```powershell
pwsh -NoProfile -File ./build/install-knowledge-base.ps1 -Force
```

What happens:

1. Script copies source folders from this repo into `~/.kb`.
2. VS Code user settings are updated automatically.

## Flow 3: Install from Local .nupkg (Not Published Yet)

Use this when package is not on a public feed yet.

1. Pack locally:

```powershell
pwsh -NoProfile -File ./build/pack-nuget.ps1 -Version "1.0.0"
```

2. Install from local folder feed:

```powershell
pwsh -NoProfile -File ./build/install-knowledge-base-from-nuget.ps1 -PackageId "DocumentHub.KnowledgeBase" -Version "1.0.0" -Source "./artifacts/nuget" -Force
```

## Verify Installation

Check these paths exist:

- `~/.kb/agents`
- `~/.kb/instructions`
- `~/.kb/prompts`

Check VS Code user settings (`%APPDATA%\\Code\\User\\settings.json`) includes:

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

## Troubleshooting

### Package not found on NuGet

If you see:

- `Package 'DocumentHub.KnowledgeBase 1.0.0' is not found ...`

Then either:

1. Package is not published to that feed yet.
2. Version is wrong.
3. Package source URL/path is wrong.

Recommended fix during development: use local source `./artifacts/nuget` after running `build/pack-nuget.ps1`.
