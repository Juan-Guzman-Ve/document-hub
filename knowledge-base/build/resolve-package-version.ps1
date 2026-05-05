param(
    [string]$ManualVersion,
    [string]$GitRef,
    [int]$RunNumber,
    [string]$NuspecPath = 'knowledge-base.nuspec'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Assert-SemVer {
    param([Parameter(Mandatory = $true)][string]$Version)

    if ($Version -notmatch '^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z\-.]+)?$') {
        throw "Resolved version '$Version' is not a valid NuGet SemVer."
    }
}

$resolvedVersion = $null

if (-not [string]::IsNullOrWhiteSpace($ManualVersion)) {
    $resolvedVersion = $ManualVersion.Trim()
}
elseif ($GitRef -match '^refs/tags/v(.+)$') {
    $resolvedVersion = $Matches[1]
}
else {
    if (!(Test-Path $NuspecPath)) {
        throw "Nuspec file not found: $NuspecPath"
    }

    [xml]$nuspec = Get-Content -Path $NuspecPath -Raw
    $baseVersion = $nuspec.package.metadata.version

    if ([string]::IsNullOrWhiteSpace($baseVersion)) {
        throw "Cannot read base version from $NuspecPath"
    }

    $resolvedVersion = "$baseVersion-ci.$RunNumber"
}

Assert-SemVer -Version $resolvedVersion
Write-Output $resolvedVersion
