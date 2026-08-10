<#
.SYNOPSIS
Deep-validate that EVERY related: entry in EVERY entity file has a 
meaningful description (not just a bare entity ID, empty, or trivial).
#>

$entitiesDir = "cache/entities"
$files = Get-ChildItem $entitiesDir -Recurse -Filter "*.md" | Where-Object { $_.Name -notmatch '^_' }
$totalFiles = $files.Count
$totalEntries = 0
$totalBare = 0
$totalEmpty = 0
$totalTrivial = 0
$totalOk = 0

$issueFiles = @()
$bareEntries = @()
$emptyEntries = @()
$trivialEntries = @()

foreach ($file in $files) {
    $c = Get-Content $file.FullName -Raw -Encoding UTF8
    $fmMatch = [regex]::Match($c, "^---\r?\n(.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $fmMatch.Success) { continue }
    
    $frontmatter = $fmMatch.Groups[1].Value
    
    # Extract related: section
    $relatedBlock = [regex]::Match($frontmatter, "(?<=^|\n)related:\n(.*?)(?=\n\S|$)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $relatedBlock.Success) { continue }
    
    $lines = $relatedBlock.Groups[1].Value -split "`n"
    foreach ($line in $lines) {
        $trimmed = $line.Trim()
        if ($trimmed -match '^- (.+)$') {
            $entry = $matches[1]
            $totalEntries++
            
            # Check format: has colon? If yes, what's after it?
            $colonPos = $entry.IndexOf(':')
            
            if ($colonPos -lt 0) {
                # No colon at all - bare entity ID
                $totalBare++
                $bareEntries += @{ file = $file.Name; entity = $entry; desc = "NONE (no colon)" }
                continue
            }
            
            $targetId = $entry.Substring(0, $colonPos).Trim()
            $desc = $entry.Substring($colonPos + 1).Trim()
            
            if ([string]::IsNullOrWhiteSpace($desc)) {
                # Colon but nothing after it
                $totalEmpty++
                $emptyEntries += @{ file = $file.Name; entity = $targetId; desc = "EMPTY" }
                continue
            }
            
            if ($desc.Length -lt 5) {
                # Trivially short description
                $totalTrivial++
                $trivialEntries += @{ file = $file.Name; entity = $targetId; desc = "'$desc'" }
                continue
            }
            
            $totalOk++
        }
    }
}

# Output
Write-Host "=" * 60
Write-Host "DEEP DESCRIPTION VALIDATION"
Write-Host "=" * 60
Write-Host ""
Write-Host "Files scanned:   $totalFiles"
Write-Host "Related entries: $totalEntries"
Write-Host ""
Write-Host "OK (good desc):  $totalOk"
Write-Host ""

if ($totalBare -gt 0) {
    Write-Host "[x] BARE ENTITY ID (no colon at all): $totalBare" -ForegroundColor Red
    foreach ($e in $bareEntries) { 
        $path = (Get-ChildItem $entitiesDir -Recurse -Filter $e.file | Select-Object -First 1).FullName
        $shortPath = $path -replace [regex]::Escape($entitiesDir), "~entities"
        Write-Host "   $($e.entity) in $shortPath" -ForegroundColor Red 
    }
}

if ($totalEmpty -gt 0) {
    Write-Host "[x] EMPTY DESCRIPTION (colon but nothing after): $totalEmpty" -ForegroundColor Red
    foreach ($e in $emptyEntries) { 
        $path = (Get-ChildItem $entitiesDir -Recurse -Filter $e.file | Select-Object -First 1).FullName
        $shortPath = $path -replace [regex]::Escape($entitiesDir), "~entities"
        Write-Host "   $($e.entity) in $shortPath" -ForegroundColor Red 
    }
}

if ($totalTrivial -gt 0) {
    Write-Host "[!]  TRIVIAL DESCRIPTION (< 5 chars): $totalTrivial" -ForegroundColor Yellow
    foreach ($e in $trivialEntries) { 
        $path = (Get-ChildItem $entitiesDir -Recurse -Filter $e.file | Select-Object -First 1).FullName
        $shortPath = $path -replace [regex]::Escape($entitiesDir), "~entities"
        Write-Host "   $($e.entity) in $shortPath : $($e.desc)" -ForegroundColor Yellow 
    }
}

Write-Host ""
if ($totalBare -eq 0 -and $totalEmpty -eq 0 -and $totalTrivial -eq 0) {
    Write-Host "[ok] ALL $totalEntries entries have meaningful descriptions!" -ForegroundColor Green
} else {
    Write-Host "Total issues: $($totalBare + $totalEmpty + $totalTrivial) / $totalEntries entries" -ForegroundColor Yellow
}