param(
    [string]$PackageId = 'DocumentHub.KnowledgeBase',
    [string]$Version = '1.0.0',
    [string]$Source = 'https://api.nuget.org/v3/index.json',
    [string]$Destination = (Join-Path $HOME '.kb'),
    [string]$DownloadDirectory = '.tmp/knowledge-base-nuget',
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$nuget = Get-Command nuget -ErrorAction SilentlyContinue
if (-not $nuget) {
    throw "nuget.exe is required. Install it and ensure 'nuget' is available on PATH."
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir '..')
$resolvedDownloadDir = Join-Path $repoRoot $DownloadDirectory
New-Item -ItemType Directory -Path $resolvedDownloadDir -Force | Out-Null

& nuget install $PackageId -Version $Version -Source $Source -OutputDirectory $resolvedDownloadDir -NonInteractive
if ($LASTEXITCODE -ne 0) {
    throw "nuget install failed with exit code $LASTEXITCODE"
}

$packageRoot = Join-Path $resolvedDownloadDir "$PackageId.$Version"
if (!(Test-Path $packageRoot)) {
    throw "Package folder not found after install: $packageRoot"
}

$installerPath = Join-Path $packageRoot 'tools/install-from-nupkg.ps1'
if (!(Test-Path $installerPath)) {
    throw "Installer not found in package: $installerPath"
}

$installerArgs = @{
    PackageRoot = $packageRoot
    Destination = $Destination
}

if ($Force) {
    $installerArgs['Force'] = $true
}

& $installerPath @installerArgs
if ($LASTEXITCODE -ne 0) {
    throw "Package installer failed with exit code $LASTEXITCODE"
}

Write-Host "Completed NuGet install to: $Destination" -ForegroundColor Green
