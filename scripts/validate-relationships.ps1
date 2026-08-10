<#
.SYNOPSIS
Validates that all relationships in _master_relationships_map.md are present
and described in the corresponding entity files' `related:` frontmatter.
#>

$ErrorActionPreference = 'Continue'
$masterPath = "cache/_master_relationships_map.md"
$entitiesDir = "cache/entities"

Write-Host "`n" + ("=" * 47) -ForegroundColor Cyan
Write-Host " VALIDATING RELATIONSHIPS" -ForegroundColor Cyan
Write-Host ("=" * 47) -ForegroundColor Cyan

# -- Step 1: Parse master map --
Write-Host "`nParsing master map ..." -NoNewline

$masterContent = Get-Content $masterPath -Raw -Encoding UTF8

# Parse sections: ## entity_id [type] followed by lines until next ## or end
$sections = [regex]::Matches($masterContent, "## (\S+) \[(\w+)\]\r?\n(.*?)(?=\r?\n## |\z)", [System.Text.RegularExpressions.RegexOptions]::Singleline)

$masterRelations = @{}

foreach ($section in $sections) {
    $entityId = $section.Groups[1].Value
    $body = $section.Groups[3].Value
    $targets = @{}
    
    # Parse relationship lines - pattern: "- relationship_type <arrow> target_id [target_type] <dash> description"
    # Using non-word char as separator instead of matching specific Unicode chars
    $relLines = [regex]::Matches($body, "- (\S+)\s+->\s+(\S+)\s+\[(\w+)\](?:\s*:\s*(.*))?")
    foreach ($rel in $relLines) {
        $targetId = $rel.Groups[2].Value
        $targetType = $rel.Groups[3].Value
        $desc = $rel.Groups[4].Value.Trim()
        $targets[$targetId] = @{ type = $targetType; desc = $desc }
    }
    $masterRelations[$entityId] = $targets
}

$totalRels = 0; $masterRelations.Values | ForEach-Object { $totalRels += $_.Count }
Write-Host " $($masterRelations.Count) entities, $totalRels relationships"

# -- Step 2: Index entity files --
Write-Host "Indexing entity files ..." -NoNewline

$fileIndex = @{}
$files = Get-ChildItem $entitiesDir -Recurse -Filter "*.md"
foreach ($file in $files) {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $fileIndex[$name] = @{ path = $file.FullName; related = @{} }
}

$foundCount = 0; $notFound = @()
foreach ($eid in $masterRelations.Keys) {
    if ($fileIndex.ContainsKey($eid)) { $foundCount++ }
    else { $notFound += $eid }
}

Write-Host " $foundCount / $($masterRelations.Count) files found"

if ($notFound.Count -gt 0) {
    Write-Host "`n  MISSING FILES:" -ForegroundColor Red
    foreach ($id in $notFound) { Write-Host "   - $id ($($masterRelations[$id].Count) relationships orphaned)" -ForegroundColor Red }
}

# -- Step 3: Parse related: frontmatter from each entity file --
Write-Host "Parsing 'related:' frontmatter ..." -NoNewline

$parseErrors = @()
foreach ($eid in $masterRelations.Keys) {
    if (-not $fileIndex.ContainsKey($eid)) { continue }
    
    $content = Get-Content $fileIndex[$eid].path -Raw -Encoding UTF8
    $fmMatch = [regex]::Match($content, "^---\r?\n(.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $fmMatch.Success) { $parseErrors += $eid; continue }
    
    $frontmatter = $fmMatch.Groups[1].Value
    $relatedBlock = [regex]::Match($frontmatter, "(?<=^|\n)related:\n(.*?)(?=\n\S|$)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    if (-not $relatedBlock.Success) { continue }
    
    $relatedEntries = @{}
    $entryLines = [regex]::Matches($relatedBlock.Groups[1].Value, "^\s+-\s+(.+?)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    foreach ($entry in $entryLines) {
        $line = $entry.Groups[1].Value.Trim()
        $colonPos = $line.IndexOf(':')
        if ($colonPos -gt 0) {
            $tid = $line.Substring(0, $colonPos).Trim()
            $desc = $line.Substring($colonPos + 1).Trim()
            $relatedEntries[$tid] = $desc
        } else {
            $relatedEntries[$line] = ""
        }
    }
    $fileIndex[$eid].related = $relatedEntries
}

Write-Host " done"
if ($parseErrors.Count -gt 0) {
    Write-Host "  Parse errors (no frontmatter): $($parseErrors -join ', ')" -ForegroundColor Yellow
}

# -- Step 4: Validate --
Write-Host ("`n" + "=" * 47) -ForegroundColor Cyan
Write-Host " RESULTS" -ForegroundColor Cyan
Write-Host ("=" * 47) -ForegroundColor Cyan

$totalMissing = 0
$totalBare = 0
$orphanedRels = 0
$issueCount = 0

# Track all issues for summary
$allIssues = @()

foreach ($eid in $masterRelations.Keys) {
    if (-not $fileIndex.ContainsKey($eid)) {
        $orphanedRels += $masterRelations[$eid].Count
        continue
    }
    
    $masterTargets = $masterRelations[$eid]
    $fileTargets = $fileIndex[$eid].related
    $fileShort = $fileIndex[$eid].path -replace [regex]::Escape($entitiesDir), "~entities"
    
    $missing = @()
    $bare = @()
    
    foreach ($tid in $masterTargets.Keys) {
        if (-not $fileTargets.ContainsKey($tid)) {
            $missing += $tid
        } elseif ([string]::IsNullOrWhiteSpace($fileTargets[$tid])) {
            $bare += $tid
        }
    }
    
    if ($missing.Count -gt 0 -or $bare.Count -gt 0) {
        $issueCount++
        Write-Host "`n[$issueCount] $eid" -ForegroundColor Yellow
        
        if ($missing.Count -gt 0) {
            Write-Host "   [x] NOT IN related: $($missing -join ', ')" -ForegroundColor Red
            $totalMissing += $missing.Count
            $allIssues += @{ entity = $eid; type = 'missing'; targets = $missing }
        }
        if ($bare.Count -gt 0) {
            Write-Host "   [x] NO DESCRIPTION: $($bare -join ', ')" -ForegroundColor Red
            $totalBare += $bare.Count
            $allIssues += @{ entity = $eid; type = 'bare'; targets = $bare }
        }
    }
}

# -- Summary --
Write-Host "`n" + ("=" * 47) -ForegroundColor Cyan
Write-Host " SUMMARY" -ForegroundColor Cyan
Write-Host ("=" * 47) -ForegroundColor Cyan

Write-Host "`nEntities in master map:     $($masterRelations.Count)"
Write-Host "Total relationships:         $totalRels"
Write-Host "Files found:                 $foundCount / $($masterRelations.Count)"

if ($notFound.Count -gt 0) {
    Write-Host "`n[!]  MISSING FILES: $($notFound.Count)" -ForegroundColor Yellow
    foreach ($id in $notFound) { Write-Host "   $id -> $($masterRelations[$id].Count) relationships orphaned" }
}
if ($issueCount -gt 0) {
    Write-Host "`n[!]  ENTITIES WITH ISSUES: $issueCount" -ForegroundColor Yellow
    Write-Host "   Missing from related:    $totalMissing" -ForegroundColor Yellow
    Write-Host "   Missing descriptions:    $totalBare" -ForegroundColor Yellow
} else {
    Write-Host "`n[ok] ALL RELATIONSHIPS VALIDATED" -ForegroundColor Green
    Write-Host "   Every entity file has all master-map relationships" -ForegroundColor Green
    Write-Host "   with descriptions in their 'related:' field." -ForegroundColor Green
}

Write-Host ""
