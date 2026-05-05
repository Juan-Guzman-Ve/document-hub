param(
    [Parameter(Mandatory = $true)][string]$PackageDirectory,
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$ApiKey
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

if (!(Test-Path $PackageDirectory)) {
    throw "Package directory not found: $PackageDirectory"
}

$packages = Get-ChildItem -Path $PackageDirectory -Filter '*.nupkg' |
    Where-Object { $_.Name -notlike '*.symbols.nupkg' }

if (-not $packages) {
    throw "No .nupkg files found in $PackageDirectory"
}

foreach ($package in $packages) {
    Write-Host "Pushing $($package.FullName)"
    nuget push $package.FullName -Source $Source -ApiKey $ApiKey -SkipDuplicate -NonInteractive

    if ($LASTEXITCODE -ne 0) {
        throw "nuget push failed for $($package.Name) with exit code $LASTEXITCODE"
    }
}
