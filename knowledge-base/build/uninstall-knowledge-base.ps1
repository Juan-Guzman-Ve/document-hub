param(
    [string]$Destination = (Join-Path $HOME ".kb")
)

$ErrorActionPreference = 'Stop'

if (!(Test-Path $Destination)) {
    Write-Host "Nothing to remove. Path does not exist: $Destination" -ForegroundColor Yellow
    exit 0
}

Remove-Item -Path $Destination -Recurse -Force
Write-Host "Removed: $Destination" -ForegroundColor Green
