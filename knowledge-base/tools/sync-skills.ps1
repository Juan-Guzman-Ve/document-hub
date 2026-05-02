param(
    [string]$Root = "knowledge-base"
)

$sourceDir = Join-Path $Root "skills"
$targetDir = Join-Path $Root "exports/skills"

if (!(Test-Path $sourceDir)) {
    throw "Source folder not found: $sourceDir"
}

if (!(Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$sourceFiles = Get-ChildItem -Path $sourceDir -File -Filter "*.skill.md"

foreach ($file in $sourceFiles) {
    $targetPath = Join-Path $targetDir $file.Name
    Copy-Item -Path $file.FullName -Destination $targetPath -Force
}

# Remove stale exported files that no longer exist in source.
$sourceNames = $sourceFiles.Name
Get-ChildItem -Path $targetDir -File -Filter "*.skill.md" |
    Where-Object { $_.Name -notin $sourceNames } |
    Remove-Item -Force

Write-Host "Synced $($sourceFiles.Count) skill files to '$targetDir'."
