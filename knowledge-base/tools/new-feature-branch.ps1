# new-feature-branch.ps1
# Creates a new feature branch based on main.
# Usage: pwsh "$HOME/.copilot/agents/knowledge-base/tools/new-feature-branch.ps1" -BranchName "AB#1234-user-authentication" -RepoPath "."

param(
    [Parameter(Mandatory = $true)]
    [string]$BranchName,

    [string]$RepoPath = "."
)

$ErrorActionPreference = 'Stop'

$resolvedRepoPath = Resolve-Path $RepoPath

if (!(Test-Path (Join-Path $resolvedRepoPath '.git'))) {
    throw "Not a git repository: $resolvedRepoPath"
}

Push-Location $resolvedRepoPath

try {
    Write-Host "Working repository: $resolvedRepoPath"

    Write-Host "Switching to main..."
    git checkout main

    Write-Host "Pulling latest from main..."
    git pull

    Write-Host "Creating branch '$BranchName'..."
    git checkout -b $BranchName

    Write-Host "Done. Now on branch: $(git branch --show-current)"
}
finally {
    Pop-Location
}
