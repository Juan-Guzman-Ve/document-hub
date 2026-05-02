param(
    [ValidateSet('validate-all', 'sync-all', 'all')]
    [string]$Task = 'all'
)

$ErrorActionPreference = 'Stop'

$syncScript = Join-Path $PSScriptRoot 'sync-skills.ps1'
$validateScript = Join-Path $PSScriptRoot 'validate-knowledge-base.ps1'

function Invoke-SyncAll {
    if (!(Test-Path $syncScript)) {
        throw "Missing script: $syncScript"
    }

    Write-Host '[sync-all] Running skill sync...' -ForegroundColor Cyan
    pwsh $syncScript
}

function Invoke-ValidateAll {
    if (!(Test-Path $validateScript)) {
        throw "Missing script: $validateScript"
    }

    Write-Host '[validate-all] Running knowledge-base validation...' -ForegroundColor Cyan
    pwsh $validateScript
}

switch ($Task) {
    'sync-all' {
        Invoke-SyncAll
        break
    }
    'validate-all' {
        Invoke-ValidateAll
        break
    }
    'all' {
        Invoke-SyncAll
        Invoke-ValidateAll
        break
    }
}

Write-Host "Task completed: $Task" -ForegroundColor Green
