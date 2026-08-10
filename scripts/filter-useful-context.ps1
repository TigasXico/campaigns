<#
.SYNOPSIS
Filter the 162 "master has more context" cases to identify only the ones
where the master map has genuinely useful info not present in the entity file.
Outputs a actionable list sorted by entity.
#>

$masterPath = "cache/_master_relationships_map.md"
$entitiesDir = "cache/entities"

$masterContent = Get-Content $masterPath -Raw -Encoding UTF8

# Parse master map
$sections = [regex]::Matches($masterContent, "## (\S+) \[\w+\]\r?\n(.*?)(?=\r?\n## |\z)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
$masterRels = @{}

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

# For each entity/target, compare master vs file description
# Tag as: TRIVIAL (wording only), USEFUL (master has extra info), MISSING (not in related: at all)
$results = @()

foreach ($eid in $masterRels.Keys) {
    if (-not $fileIndex.ContainsKey($eid)) { continue }
    
    $c = Get-Content $fileIndex[$eid] -Raw -Encoding UTF8
    $fmMatch = [regex]::Match($c, "^---\r?\n(.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $fmMatch.Success) { continue }
    
    $relBlock = [regex]::Match($fmMatch.Groups[1].Value, "(?<=^|\n)related:\n(.*?)(?=\n\S|$)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $relBlock.Success) { continue }
    
    $fileRels = @{}
    $entryLines = [regex]::Matches($relBlock.Groups[1].Value, "^\s+-\s+(.+?)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    foreach ($entry in $entryLines) {
        $line = $entry.Groups[1].Value.Trim()
        $colonPos = $line.IndexOf(':')
        if ($colonPos -gt 0) {
            $tid = $line.Substring(0, $colonPos).Trim()
            $desc = $line.Substring($colonPos + 1).Trim()
            $fileRels[$tid] = $desc
        } else { $fileRels[$line] = "" }
    }
    
    foreach ($tid in $masterRels[$eid].Keys) {
        $masterDesc = $masterRels[$eid][$tid]
        if (-not $fileRels.ContainsKey($tid)) {
            $results += @{ entity = $eid; target = $tid; tag = "MISSING"; master = $masterDesc; file = "" }
            continue
        }
        $fileDesc = $fileRels[$tid]
        
        # Normalize for comparison
        $mNorm = $masterDesc.ToLower().Trim().TrimEnd('.')
        $fNorm = $fileDesc.ToLower().Trim().TrimEnd('.')
        
        # Check for key phrases/context in master that's not in file
        $masterPhrases = $masterDesc -split '(?<=[.,;])|\s{2,}' | ForEach-Object { $_.Trim() } | Where-Object { $_.Length -gt 10 }
        $filePhrases = $fileDesc
        $uniquePhrases = @()
        foreach ($phrase in $masterPhrases) {
            $phraseWords = $phrase -replace '[^a-zA-Z\s]', '' -split '\s+' | Where-Object { $_.Length -gt 2 -and $_ -notin @('the','and','for','was','but','not','all','its','has','had','his','her','are','can','from','that','with','this','they','their','been','have','were','which','about','would','could','should','than','then','into','also','over','after','before','very','just','some','each','both','more','most','other','such','only','same','too','very','well','here','there','when','where','what','who','how','why') }
            $uniqueWords = $phraseWords | Where-Object { $_ -notin @('their','through','between','across','within','after','about','under','above','being','these','those','which','because','without','during','against','around','before','below','beneath','beside','beyond','inside','outside','upon','while','every','either','neither','another','enough','almost','quite','rather','whatever','whenever','wherever','however','whatever') -and -not ($fileDesc -match $_ -or ($_ -match '^[a-z]+$' -and $fileDesc.ToLower() -match [regex]::Escape($_))) }
            if ($uniqueWords.Count -gt 0) {
                $uniquePhrases += @{ text = $phrase; unique = $uniqueWords }
            }
        }
        
        # Also check for whole-sentence differences
        $masterSentences = $masterDesc -split '[.!?]\s*' | Where-Object { $_.Trim().Length -gt 15 }
        $fileSentences = $fileDesc -split '[.!?]\s*' | Where-Object { $_.Trim().Length -gt 15 }
        
        $uniqueSentences = @()
        foreach ($ms in $masterSentences) {
            $msTrim = $ms.Trim().ToLower()
            $found = $false
            foreach ($fs in $fileSentences) {
                $fsTrim = $fs.Trim().ToLower()
                if ($msTrim -eq $fsTrim -or $fsTrim.Contains($msTrim) -or $msTrim.Contains($fsTrim)) {
                    $found = $true; break
                }
            }
            if (-not $found) { $uniqueSentences += $ms.Trim() }
        }
        
        $fileSentencesUnique = @()
        foreach ($fs in $fileSentences) {
            $fsTrim = $fs.Trim().ToLower()
            $found = $false
            foreach ($ms in $masterSentences) {
                $msTrim = $ms.Trim().ToLower()
                if ($fsTrim -eq $msTrim -or $msTrim.Contains($fsTrim) -or $fsTrim.Contains($msTrim)) { $found = $true; break }
            }
            if (-not $found) { $fileSentencesUnique += $fs.Trim() }
        }
        
        # Categorize
        if ($uniqueSentences.Count -eq 0 -and $uniquePhrases.Count -eq 0) {
            $tag = "TRIVIAL"
        } elseif ($uniquePhrases.Count -gt 0) {
            # Check if the unique phrases are just synonyms (e.g., "originated" vs "fragment")
            $allUnique = @()
            $uniquePhrases | ForEach-Object { $allUnique += $_.unique }
            
            # Check if file already has equivalent info
            $reallyUnique = $allUnique | Where-Object { 
                $_.Length -ge 5 -and 
                $_ -notin @('fragment','subdivided','pantheon','fragments','subdivision','originated','serves','ordered','paladins') -and
                -not ($fileDesc -match [regex]::Escape($_))
            }
            
            if ($reallyUnique.Count -gt 0 -or $uniqueSentences.Count -gt 0) {
                $tag = "USEFUL"
            } else {
                $tag = "TRIVIAL"
            }
        } else {
            $tag = "TRIVIAL"
        }
        
        $results += @{ 
            entity = $eid; target = $tid; tag = $tag; 
            master = $masterDesc; file = $fileDesc;
            uniqueSentences = $uniqueSentences -join ' | '
            uniqueWords = if ($uniquePhrases.Count -gt 0) { ($uniquePhrases | ForEach-Object { $_.unique }) -join ', ' } else { "" }
        }
    }
}

# Output
Write-Host "=" * 65
Write-Host "CATEGORIZED COMPARISON RESULTS"
Write-Host "=" * 65
Write-Host ""
Write-Host "TRIVIAL (same meaning, different wording): $(($results | Where-Object { $_.tag -eq 'TRIVIAL' }).Count)"
Write-Host "USEFUL (master has extra context):          $(($results | Where-Object { $_.tag -eq 'USEFUL' }).Count)"
Write-Host "MISSING (not in entity file):               $(($results | Where-Object { $_.tag -eq 'MISSING' }).Count)"
Write-Host ""

$useful = $results | Where-Object { $_.tag -eq 'USEFUL' } | Sort-Object entity, target
$counter = 0
foreach ($item in $useful) {
    $counter++
    Write-Host "[$counter] $($item.entity) -> $($item.target)" -ForegroundColor Yellow
    Write-Host "   MASTER: $($item.master)" -ForegroundColor Cyan
    Write-Host "   FILE:   $($item.file)" -ForegroundColor Gray
    if ($item.uniqueSentences) { Write-Host "   UNIQUE: $($item.uniqueSentences)" -ForegroundColor Green }
    if ($item.uniqueWords) { Write-Host "   WORDS:  $($item.uniqueWords)" -ForegroundColor DarkGreen }
    Write-Host ""
}

Write-Host "---"
Write-Host "Summary: $counter useful context merges needed"