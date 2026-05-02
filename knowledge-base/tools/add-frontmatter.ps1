param(
    [string]$Root = "knowledge-base"
)

$files = Get-ChildItem -Path $Root -Recurse -File -Filter "*.md"

function Get-DocType([string]$relativePath) {
    if ($relativePath -match "^instructions/") { return "instruction" }
    if ($relativePath -match "^agents/") { return "agent" }
    if ($relativePath -match "^prompts/") { return "prompt" }
    if ($relativePath -match "^skills/") { return "skill" }
    if ($relativePath -match "^guides/") { return "guide" }
    if ($relativePath -match "^applications/") { return "application" }
    return "note"
}

$rootPath = (Resolve-Path $Root).Path

foreach ($file in $files) {
    $full = $file.FullName
    $relative = $full.Substring($rootPath.Length + 1).Replace("\", "/")
    $docType = Get-DocType $relative
    $canonical = "true"

    $meta = [ordered]@{
        documentType = $docType
        owner = "knowledge-base"
        phase = "n/a"
        appliesTo = "all"
        canonical = $canonical
        version = "1.0"
        supersedes = "none"
    }

    $raw = Get-Content -Path $full -Raw
    $newRaw = $raw

    if ($raw -match "^(?s)---`r?`n(.*?)`r?`n---`r?`n") {
        $front = $Matches[1]
        $frontLines = $front -split "`r?`n"
        $has = @{}
        foreach ($line in $frontLines) {
            if ($line -match "^([A-Za-z0-9_\-]+):") {
                $has[$Matches[1]] = $true
            }
        }

        $missing = @()
        foreach ($k in $meta.Keys) {
            if (-not $has.ContainsKey($k)) {
                $missing += "${k}: '$($meta[$k])'"
            }
        }

        if ($missing.Count -gt 0) {
            $replacement = "---`n$front`n" + ($missing -join "`n") + "`n---`n"
            $newRaw = [regex]::Replace(
                $raw,
                "^(?s)---`r?`n(.*?)`r?`n---`r?`n",
                [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $replacement },
                1
            )
        }
    }
    else {
        $frontmatter = @(
            "---",
            "documentType: '$docType'",
            "owner: 'knowledge-base'",
            "phase: 'n/a'",
            "appliesTo: 'all'",
            "canonical: '$canonical'",
            "version: '1.0'",
            "supersedes: 'none'",
            "---",
            ""
        ) -join "`n"

        $newRaw = $frontmatter + $raw
    }

    if ($newRaw -ne $raw) {
        Set-Content -Path $full -Value $newRaw -NoNewline
    }
}

Write-Host "Frontmatter normalization complete for $($files.Count) files."
