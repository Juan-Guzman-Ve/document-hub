param(
    [string]$Root = "knowledge-base"
)

$errors = New-Object System.Collections.Generic.List[string]

function Add-Error([string]$message) {
    $errors.Add($message)
}

if (!(Test-Path $Root)) {
    throw "Root path not found: $Root"
}

$mdFiles = Get-ChildItem -Path $Root -Recurse -File -Filter "*.md"

# Rule 1: Forbidden filename/content drift around latest.md naming.
foreach ($file in $mdFiles) {
    $text = Get-Content -Path $file.FullName -Raw
    if ($text -match "context-latext\.md") {
        Add-Error("Typo 'context-latext.md' found in: $($file.FullName)")
    }
    if ($text -match "context-latest\.md") {
        Add-Error("Legacy filename 'context-latest.md' found in: $($file.FullName)")
    }
}

# Rule 2: Include directive format.
foreach ($file in $mdFiles) {
    $lines = Get-Content -Path $file.FullName
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ($line -match "^#file:") {
            if ($line -notmatch "^#file:\s*\[\[[^\]]+\]\]") {
                Add-Error("Invalid #file include format in $($file.FullName):$($i + 1)")
            }
        }
    }
}

# Rule 3: Broken Obsidian wikilinks.
$nameToPath = @{}
foreach ($file in $mdFiles) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    if (-not $nameToPath.ContainsKey($base)) {
        $nameToPath[$base] = @()
    }
    $nameToPath[$base] += $file.FullName
}

$linkPattern = "\[\[([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]"
foreach ($file in $mdFiles) {
    $text = Get-Content -Path $file.FullName -Raw
    $matches = [regex]::Matches($text, $linkPattern)
    foreach ($m in $matches) {
        $targetRaw = $m.Groups[1].Value.Trim()
        $targetNorm = $targetRaw -replace "\\", "/"

        $resolved = $false

        # Path-like links: try direct match by relative suffix.
        if ($targetNorm.Contains("/")) {
            $targetMd = if ($targetNorm.EndsWith(".md")) { $targetNorm } else { "$targetNorm.md" }
            $targetMd = $targetMd -replace "/", [System.IO.Path]::DirectorySeparatorChar
            $fullCandidates = Get-ChildItem -Path $Root -Recurse -File -Filter "*.md" |
                Where-Object {
                    ($_.FullName -replace "\\", "/").ToLower().EndsWith(($targetMd -replace "\\", "/").ToLower())
                }
            if ($fullCandidates.Count -ge 1) {
                $resolved = $true
            }
        }
        else {
            # Bare link by note name.
            if ($nameToPath.ContainsKey($targetNorm)) {
                $resolved = $true
            }
        }

        if (-not $resolved) {
            Add-Error("Broken wikilink '$targetRaw' in: $($file.FullName)")
        }
    }
}

# Rule 4: Contradictory ownership statement checks.
$qaPath = Join-Path $Root "agents/qa-engineer.agent.md"
if (Test-Path $qaPath) {
    $qaText = Get-Content -Path $qaPath -Raw
    if (($qaText -match "not delegated to developers") -and ($qaText -match "developers are primary authors of integration tests")) {
        Add-Error("Contradictory QA ownership statements found in: $qaPath")
    }
}

# Rule 5: Key terms typo protection.
$keyTermTypos = @(
    "copilo-instructions",
    "copilo instructions",
    "context-latext"
)

foreach ($file in $mdFiles) {
    $text = Get-Content -Path $file.FullName -Raw
    foreach ($typo in $keyTermTypos) {
        if ($text -match [regex]::Escape($typo)) {
            Add-Error("Key term typo '$typo' found in: $($file.FullName)")
        }
    }
}

if ($errors.Count -gt 0) {
    Write-Host "Validation failed with $($errors.Count) issue(s):" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    exit 1
}

Write-Host "Validation passed: no issues found." -ForegroundColor Green
exit 0
