param(
    [string]$Destination = (Join-Path $HOME ".kb"),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Copy-DirectoryContent {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Dest
    )

    if (!(Test-Path $Source)) {
        throw "Source path not found: $Source"
    }

    New-Item -ItemType Directory -Path $Dest -Force | Out-Null
    Copy-Item -Path (Join-Path $Source '*') -Destination $Dest -Recurse -Force
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir '..')

if ((Test-Path $Destination) -and -not $Force) {
    throw "Target already exists: $Destination. Use -Force to overwrite."
}

if (Test-Path $Destination) {
    Remove-Item -Path $Destination -Recurse -Force
}

New-Item -ItemType Directory -Path $Destination -Force | Out-Null

$foldersToCopy = @(
    'agents',
    'applications',
    'guides',
    'instructions',
    'prompts',
    'skills',
    'tools'
)

foreach ($folder in $foldersToCopy) {
    Copy-DirectoryContent -Source (Join-Path $repoRoot $folder) -Dest (Join-Path $Destination $folder)
}

$filesToCopy = @(
    'index.md',
    'routing.md'
)

foreach ($file in $filesToCopy) {
    Copy-Item -Path (Join-Path $repoRoot $file) -Destination (Join-Path $Destination $file) -Force
}

Write-Host "Installed knowledge base to: $Destination" -ForegroundColor Green

# Register VS Code settings
$settingsPath = Join-Path $env:APPDATA 'Code\User\settings.json'
if (Test-Path $settingsPath) {
    $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json -AsHashtable

    $kbPath = $Destination.Replace('\', '/')

    if (-not $settings.ContainsKey('chat.agentFilesLocations'))        { $settings['chat.agentFilesLocations']        = @{} }
    if (-not $settings.ContainsKey('chat.instructionsFilesLocations')) { $settings['chat.instructionsFilesLocations'] = @{} }
    if (-not $settings.ContainsKey('chat.promptFilesLocations'))       { $settings['chat.promptFilesLocations']       = @{} }

    $settings['chat.agentFilesLocations']["$kbPath/agents"]        = $true
    $settings['chat.instructionsFilesLocations']["$kbPath/instructions"] = $true
    $settings['chat.promptFilesLocations']["$kbPath/prompts"]      = $true

    $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    Write-Host "VS Code settings updated: $settingsPath" -ForegroundColor Cyan
} else {
    Write-Host "VS Code settings.json not found at $settingsPath — add paths manually." -ForegroundColor Yellow
}
