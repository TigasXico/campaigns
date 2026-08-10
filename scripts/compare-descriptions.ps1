<#
.SYNOPSIS
For every relationship in the master map, compare the description against the
description in the entity file's "related:" field. Report cases where the master
map has MORE detail/context than the entity file.
#>

$masterPath = "cache/_master_relationships_map.md"
$entitiesDir = "cache/entities"

$masterContent = Get-Content $masterPath -Raw -Encoding UTF8

Write-Host "=" * 65
Write-Host "COMPARING: Master Map descriptions vs Entity File descriptions"
Write-Host "=" * 65

# Parse master map
$sections = [regex]::Matches($masterContent, "## (\S+) \[\w+\]\r?\n(.*?)(?=\r?\n## |\z)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
$masterRels = @{}  # entity_id -> @{ target_id = @{ type = ''; desc = '' } }

foreach ($sec in $sections) {
    $eid = $sec.Groups[1].Value
    $body = $sec.Groups[2].Value
    $targets = @{}
    $relLines = [regex]::Matches($body, "- (\S+)\s+->\s+(\S+)\s+\[(\w+)\](?:\s*:\s*(.*))?")
    foreach ($rel in $relLines) {
        $tid = $rel.Groups[2].Value
        $desc = if ($rel.Groups[4].Success) { $rel.Groups[4].Value.Trim() } else { "" }
        $targets[$tid] = $desc
    }
    if ($targets.Count -gt 0) { $masterRels[$eid] = $targets }
}

# Index entity files
$fileIndex = @{}
Get-ChildItem $entitiesDir -Recurse -Filter "*.md" | ForEach-Object {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $fileIndex[$name] = $_.FullName
}

# For each master map entity/relationship, compare
$totalOk = 0
$totalMismatch = 0
$totalMissingFile = 0
$totalMissingRelated = 0
$issues = @()
$masterOnly = @()  # descriptions in master but NOT in entity file (master has more info)
$masterBetter = @()  # descriptions in both, but master has better/more detailed version

foreach ($eid in $masterRels.Keys) {
    if (-not $fileIndex.ContainsKey($eid)) {
        foreach ($tid in $masterRels[$eid].Keys) {
            $totalMissingFile++
            $issues += "FILE-MISSING: $eid -X $tid (master: '$($masterRels[$eid][$tid])')"
        }
        continue
    }
    
    # Parse entity file related: field
    $c = Get-Content $fileIndex[$eid] -Raw -Encoding UTF8
    $fmMatch = [regex]::Match($c, "^---\r?\n(.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $fmMatch.Success) { 
        foreach ($tid in $masterRels[$eid].Keys) {
            $totalMissingFile++
            $issues += "NO-FM: $eid -X $tid (master: '$($masterRels[$eid][$tid])')"
        }
        continue 
    }
    
    $relBlock = [regex]::Match($fmMatch.Groups[1].Value, "(?<=^|\n)related:\n(.*?)(?=\n\S|$)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $relBlock.Success) {
        foreach ($tid in $masterRels[$eid].Keys) {
            $totalMissingRelated++
            $issues += "NO-REL: $eid -X $tid (master: '$($masterRels[$eid][$tid])')"
        }
        continue
    }
    
    # Build file's related map
    $fileRels = @{}
    $entryLines = [regex]::Matches($relBlock.Groups[1].Value, "^\s+-\s+(.+?)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    foreach ($entry in $entryLines) {
        $line = $entry.Groups[1].Value.Trim()
        $colonPos = $line.IndexOf(':')
        if ($colonPos -gt 0) {
            $tid = $line.Substring(0, $colonPos).Trim()
            $desc = $line.Substring($colonPos + 1).Trim()
            $fileRels[$tid] = $desc
        } else {
            $fileRels[$line] = ""
        }
    }
    
    # Compare each master relationship
    foreach ($tid in $masterRels[$eid].Keys) {
        $masterDesc = $masterRels[$eid][$tid]
        if (-not $fileRels.ContainsKey($tid)) {
            $totalMissingRelated++
            $issues += "MISSING: $eid -X $tid (master: '$masterDesc')"
            continue
        }
        
        $fileDesc = $fileRels[$tid]
        
        # Compare: is anything in master that's NOT in file?
        $masterWords = $masterDesc -split '\s+' | ForEach-Object { $_.Trim().ToLower() } | Where-Object { $_.Length -gt 3 }
        $fileWords = $fileDesc -split '\s+' | ForEach-Object { $_.Trim().ToLower() } | Where-Object { $_.Length -gt 3 }
        
        # Check for significant unique content in master not present in file
        $uniqueToMaster = @()
        # Check for key phrases (4+ char words or proper nouns)
        foreach ($word in $masterWords) {
            $normalized = $word.Trim('()[]{},.;:''""')
            if ($normalized.Length -ge 5 -and $normalized -notin @('their', 'through', 'between', 'across', 'within', 'after', 'about', 'under', 'above', 'being', 'these', 'those', 'which')) {
                # Check if this word or a close variant exists in file description
                $found = $false
                foreach ($fw in $fileWords) {
                    if ($fw -eq $normalized -or $fw.StartsWith($normalized) -or $normalized.StartsWith($fw)) {
                        $found = $true
                        break
                    }
                }
                if (-not $found) {
                    $uniqueToMaster += $word
                }
            }
        }
        
        # Also check length ratio - if master is significantly longer
        $masterLen = $masterDesc.Length
        $fileLen = $fileDesc.Length
        
        if ($uniqueToMaster.Count -gt 0 -or ($masterLen -gt $fileLen * 1.5 -and $masterLen -gt 30)) {
            $totalMismatch++
            $masterBetter += @{ entity = $eid; target = $tid; master = $masterDesc; file = $fileDesc; unique = $uniqueToMaster }
        } else {
            $totalOk++
        }
    }
}

# Output results
Write-Host ""
Write-Host "Comparisons:"
Write-Host "  OK (entity file has >= context): $totalOk"
Write-Host "  Master has MORE context:          $totalMismatch"
Write-Host "  Missing in entity file:           $totalMissingRelated"
Write-Host "  Missing entity file:              $totalMissingFile"
Write-Host ""

if ($totalMismatch -gt 0) {
    Write-Host "[!]  MASTER MAP HAS MORE CONTEXT THAN ENTITY FILES:" -ForegroundColor Yellow
    Write-Host "   You should update the entity files before stripping the master map."
    Write-Host ""
    $counter = 0
    foreach ($item in $masterBetter | Sort-Object { $_.entity }) {
        $counter++
        Write-Host "[$counter] $($item.entity) -> $($item.target)" -ForegroundColor Yellow
        Write-Host "   MASTER: $($item.master)" -ForegroundColor Cyan
        Write-Host "   FILE:   $($item.file)" -ForegroundColor Gray
        if ($item.unique.Count -gt 0) {
            Write-Host "   UNIQUE TO MASTER: $($item.unique -join ', ')" -ForegroundColor Red
        }
        Write-Host ""
    }
}

if ($totalMissingRelated -gt 0) {
    Write-Host "[!]  ENTRIES IN MASTER MAP BUT NOT IN ENTITY FILES:" -ForegroundColor Yellow
    foreach ($issue in $issues | Where-Object { $_ -like 'MISSING*' }) {
        Write-Host "   $issue" -ForegroundColor Red
    }
    Write-Host ""
}

if ($totalMismatch -eq 0 -and $totalMissingRelated -eq 0 -and $totalMissingFile -eq 0) {
    Write-Host "ALL DESCRIPTIONS MATCH - safe to strip master map descriptions!" -ForegroundColor Green
} else {
    Write-Host "--- Summary of required entity file updates ---" -ForegroundColor Cyan
    Write-Host "Files to update: $totalMismatch (add missing context from master map)"
    Write-Host "Relationships to add to related: $totalMissingRelated"
}