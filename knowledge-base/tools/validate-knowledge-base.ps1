param(
    [string]$Root = ""
)

$errors = New-Object System.Collections.Generic.List[string]

if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = Join-Path $PSScriptRoot '..'
}

$resolvedRoot = (Resolve-Path -Path $Root).Path

function Get-MarkdownFiles {
    param([string]$BasePath)

    Get-ChildItem -Path $BasePath -Recurse -File -Filter "*.md" |
        Where-Object {
            $_.FullName -notmatch "[\\/](node_modules|\.git|\.obsidian|exports)[\\/]"
        }
}

function Get-FileText {
    param([string]$Path)

    try {
        $content = Get-Content -Path $Path -Raw -ErrorAction Stop
        if ($null -eq $content) {
            return ""
        }

        return $content
    }
    catch {
        Add-Error("Unable to read file: $Path")
        return ""
    }
}

function Add-Error([string]$message) {
    $errors.Add($message)
}

if (!(Test-Path $resolvedRoot)) {
    throw "Root path not found: $resolvedRoot"
}

$mdFiles = Get-MarkdownFiles -BasePath $resolvedRoot

# Rule 1: Forbidden filename/content drift around latest.md naming.
foreach ($file in $mdFiles) {
    $text = Get-FileText -Path $file.FullName
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
    $text = Get-FileText -Path $file.FullName
    $matches = [regex]::Matches($text, $linkPattern)
    foreach ($m in $matches) {
        $targetRaw = $m.Groups[1].Value.Trim()
        $targetNorm = $targetRaw -replace "\\", "/"

        $resolved = $false

        # Path-like links: try direct match by relative suffix.
        if ($targetNorm.Contains("/")) {
            $targetMd = if ($targetNorm.EndsWith(".md")) { $targetNorm } else { "$targetNorm.md" }
            $targetMd = $targetMd -replace "/", [System.IO.Path]::DirectorySeparatorChar
            $fullCandidates = Get-MarkdownFiles -BasePath $resolvedRoot |
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
$qaPath = Join-Path $resolvedRoot "agents/qa-engineer.agent.md"
if (Test-Path $qaPath) {
    $qaText = Get-FileText -Path $qaPath
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
    $text = Get-FileText -Path $file.FullName
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
