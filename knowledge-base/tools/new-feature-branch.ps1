# new-feature-branch.ps1
# Creates a new feature branch based on main.
# Usage: pwsh ./knowledge-base/tools/new-feature-branch.ps1 -BranchName "AB#1234-user-authentication"

param(
    [Parameter(Mandatory = $true)]
    [string]$BranchName
)

$ErrorActionPreference = 'Stop'

Write-Host "Switching to main..."
git checkout main

Write-Host "Pulling latest from main..."
git pull

Write-Host "Creating branch '$BranchName'..."
git checkout -b $BranchName

Write-Host "Done. Now on branch: $(git branch --show-current)"
