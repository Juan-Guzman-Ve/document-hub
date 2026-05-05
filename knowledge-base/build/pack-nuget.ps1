param(
    [string]$Version = '1.0.0',
    [string]$OutputDirectory = 'artifacts/nuget'
)

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir '..')
$nuspecPath = Join-Path $repoRoot 'knowledge-base.nuspec'

if (!(Test-Path $nuspecPath)) {
    throw "Nuspec not found: $nuspecPath"
}

$resolvedOutput = Join-Path $repoRoot $OutputDirectory
New-Item -ItemType Directory -Path $resolvedOutput -Force | Out-Null

$nuget = Get-Command nuget -ErrorAction SilentlyContinue
if (-not $nuget) {
    throw "nuget.exe is required. Install it and ensure 'nuget' is available on PATH."
}

& nuget pack $nuspecPath -Version $Version -OutputDirectory $resolvedOutput
if ($LASTEXITCODE -ne 0) {
    throw "nuget pack failed with exit code $LASTEXITCODE"
}

Write-Host "NuGet package created in: $resolvedOutput" -ForegroundColor Green
