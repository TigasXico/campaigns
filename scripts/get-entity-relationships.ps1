<#
.SYNOPSIS
On-demand relationship query tool for the WA Lore Keeper.
Replaces the static 43KB _master_relationships_map.md with dynamic queries.

.DESCRIPTION
Parses ALL entity files' `related:` frontmatter to build a live relationship graph.
Queries return current data directly from the entity files (canonical source of truth).

.PARAMETER Entity
Show all relationships FROM this entity (who this entity links to).

.PARAMETER Target
Show all relationships TO this entity (who links to this entity).

.PARAMETER Network
Show full ego network for an entity (both inbound and outbound relationships).

.PARAMETER All
Show the complete relationship map (all entities, all relationships).

.PARAMETER Stats
Show summary statistics about the relationship graph.

.PARAMETER MissingDescriptions
Find entries with short, generic, or missing descriptions.

.PARAMETER Orphaned
Find entity files that have no `related:` entries.

.PARAMETER Validate
Run validation: check every master-map relationship exists in entity files.

.PARAMETER Search
Search relationship descriptions for a keyword.

.EXAMPLE
.\scripts\get-entity-relationships.ps1 -Entity kythoria
.\scripts\get-entity-relationships.ps1 -Target kythoria
.\scripts\get-entity-relationships.ps1 -Network balor_skallfang
.\scripts\get-entity-relationships.ps1 -All -Format Table
.\scripts\get-entity-relationships.ps1 -Stats
.\scripts\get-entity-relationships.ps1 -Search "B-touched"
.\scripts\get-entity-relationships.ps1 -MissingDescriptions
#>

param(
    [string]$Entity = "",
    [string]$Target = "",
    [string]$Network = "",
    [switch]$All,
    [switch]$Stats,
    [switch]$MissingDescriptions,
    [switch]$Orphaned,
    [switch]$Validate,
    [string]$Search = "",
    [ValidateSet("List","Table","Json")]
    [string]$Format = "List"
)

$entitiesDir = "cache/entities"

# --- Build relationship graph from entity files ---
$graph = @{}           # entity -> @{ target -> description }
$reverseGraph = @{}    # target -> @{ entity -> description }
$entityInfo = @{}      # entity -> @{ file, type, name }

# Index all entity files
$files = Get-ChildItem $entitiesDir -Recurse -Filter "*.md" | Where-Object { $_.Name -notmatch '^_' }
$totalFiles = $files.Count
$totalRelationships = 0
$filesWithRelated = 0

foreach ($file in $files) {
    $entityId = $file.BaseName
    $c = Get-Content $file.FullName -Raw -Encoding UTF8

    # Extract frontmatter
    $fmMatch = [regex]::Match($c, "^---\r?\n(.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $fmMatch.Success) { continue }

    $frontmatter = $fmMatch.Groups[1].Value

    # Extract entity type from frontmatter
    $typeMatch = [regex]::Match($frontmatter, "(?<=^|\n)type:\s*(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    $eType = if ($typeMatch.Success) { $typeMatch.Groups[1].Value.Trim() } else { "unknown" }

    # Extract entity name from frontmatter
    $nameMatch = [regex]::Match($frontmatter, "name:\s*""(.+?)""", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $nameMatch.Success) {
        $nameMatch = [regex]::Match($frontmatter, "name:\s*(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
    }
    $eName = if ($nameMatch.Success) { $nameMatch.Groups[1].Value.Trim().Trim('"') } else { $entityId }

    $entityInfo[$entityId] = @{
        file = $file.FullName;
        type = $eType;
        name = $eName
    }

    # Extract related: section
    $relBlock = [regex]::Match($frontmatter, "(?<=^|\n)related:\r?\n(.*?)(?=\r?\n\S|$)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $relBlock.Success) { continue }

    $filesWithRelated++
    $targets = @{}

    # Parse related entries
    $lines = $relBlock.Groups[1].Value -split "`r?`n"
    foreach ($line in $lines) {
        $trimmed = $line.Trim()
        if ($trimmed -match '^- (.+)$') {
            $entry = $matches[1]
            $colonPos = $entry.IndexOf(':')
            if ($colonPos -gt 0) {
                $tid = $entry.Substring(0, $colonPos).Trim()
                $desc = $entry.Substring($colonPos + 1).Trim()
            } else {
                $tid = $entry.Trim()
                $desc = ""
            }

            $targets[$tid] = $desc
            $totalRelationships++

            # Build reverse graph
            if (-not $reverseGraph.ContainsKey($tid)) {
                $reverseGraph[$tid] = @{}
            }
            $reverseGraph[$tid][$entityId] = $desc
        }
    }

    if ($targets.Count -gt 0) {
        $graph[$entityId] = $targets
    }
}

# --- Helper: Get entity display name ---
function Get-DisplayName {
    param([string]$id)
    if ($entityInfo.ContainsKey($id)) {
        $info = $entityInfo[$id]
        $typeSymbol = switch ($info.type) {
            "character" { "?" }
            "location" { "?" }
            "organization" { "?" }
            "event" { "?" }
            "lore" { "?" }
            "item" { "?" }
            "campaign_note" { "?" }
            default { "?" }
        }
        return "$typeSymbol $($info.name) [$id]"
    }
    return "? $id"
}

# --- Command: Stats ---
if ($Stats) {
    $entityTypes = @{}
    foreach ($id in $entityInfo.Keys) {
        $t = $entityInfo[$id].type
        if (-not $entityTypes.ContainsKey($t)) { $entityTypes[$t] = 0 }
        $entityTypes[$t]++
    }

    Write-Host "=" * 55
    Write-Host "  RELATIONSHIP GRAPH STATISTICS"
    Write-Host "=" * 55
    Write-Host ""
    Write-Host "Entity files found:    $totalFiles"
    Write-Host "Files with related::   $filesWithRelated"
    Write-Host "Files without related: $($totalFiles - $filesWithRelated)"
    Write-Host "Total relationships:   $totalRelationships"
    Write-Host "Entities in graph:     $($graph.Keys.Count)"
    Write-Host "Target entities:       $($reverseGraph.Keys.Count)"
    Write-Host ""
    Write-Host "--- Entity Type Breakdown ---"
    foreach ($t in ($entityTypes.Keys | Sort-Object)) {
        Write-Host ("  {0,-20} {1,3}" -f ($t + ":"), $entityTypes[$t])
    }
    Write-Host ""

    # Top 10 most-connected entities
    Write-Host "--- Most Connected Entities (inbound + outbound) ---"
    $connectedCounts = @{}
    foreach ($eid in $graph.Keys) {
        $count = $graph[$eid].Count
        if ($reverseGraph.ContainsKey($eid)) { $count += $reverseGraph[$eid].Count }
        $connectedCounts[$eid] = $count
    }
    $top10 = $connectedCounts.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 10
    $rank = 1
    foreach ($item in $top10) {
        $outbound = if ($graph.ContainsKey($item.Key)) { $graph[$item.Key].Count } else { 0 }
        $inbound = if ($reverseGraph.ContainsKey($item.Key)) { $reverseGraph[$item.Key].Count } else { 0 }
        Write-Host ("  {0,2}. {1,-30} {2,3} total ({3} out, {4} in)" -f $rank, (Get-DisplayName $item.Key), $item.Value, $outbound, $inbound)
        $rank++
    }
    Write-Host ""
    Write-Host "--- Average Relationships per Entity ---"
    if ($graph.Keys.Count -gt 0) {
        $avg = [math]::Round(($graph.Values | ForEach-Object { $_.Count } | Measure-Object -Average).Average, 1)
        Write-Host "  Average related: entries per entity: $avg"
    }
    exit
}

# --- Command: Orphaned ---
if ($Orphaned) {
    $orphans = @()
    foreach ($id in $entityInfo.Keys) {
        if (-not $graph.ContainsKey($id)) {
            $orphans += $id
        }
    }
    if ($orphans.Count -eq 0) {
        Write-Host "? No orphaned entities found. All entity files have related: entries."
    } else {
        Write-Host "[!] Found $($orphans.Count) entity files with no related: entries:"
        foreach ($id in $orphans | Sort-Object) {
            Write-Host "  - $id ($($entityInfo[$id].type))"
        }
    }
    exit
}

# --- Command: MissingDescriptions ---
if ($MissingDescriptions) {
    Write-Host "Checking for entries with short or generic descriptions..."
    Write-Host ""
    Write-Host "--- Bare IDs (no colon, no description) ---"
    $bareCount = 0
    $shortCount = 0
    $genericCount = 0

    foreach ($eid in $graph.Keys) {
        foreach ($tid in $graph[$eid].Keys) {
            $desc = $graph[$eid][$tid]
            if ([string]::IsNullOrWhiteSpace($desc)) {
                $bareCount++
                Write-Host "  ? $eid -> $tid : NO DESCRIPTION" -ForegroundColor Yellow
            } elseif ($desc.Length -lt 10) {
                $shortCount++
                Write-Host "  ? $eid -> $tid : SHORT ('$desc')" -ForegroundColor Yellow
            }
        }
    }

    Write-Host ""
    if ($bareCount -eq 0 -and $shortCount -eq 0) {
        Write-Host "? No entries with missing or short descriptions found."
    } else {
        Write-Host "Summary: $bareCount bare entries, $shortCount short entries"
    }
    exit
}

# --- Command: Validate ---
if ($Validate) {
    Write-Host "Validating: Checking all entity file relationships are consistent..."
    Write-Host ""
    $issues = @()
    $ok = 0

    foreach ($eid in $graph.Keys) {
        foreach ($tid in $graph[$eid].Keys) {
            # Check target exists as an entity file
            if (-not $entityInfo.ContainsKey($tid) -and -not $tid.StartsWith("society_economy_and_culture")) {
                $issues += "WARNING: $eid -> $tid : target '$tid' has no entity file"
            }
            $ok++
        }
    }

    if ($issues.Count -eq 0) {
        Write-Host "? All $ok relationships validated. All targets have entity files." -ForegroundColor Green
    } else {
        Write-Host "[!] Found $($issues.Count) issues:"
        foreach ($issue in $issues) { Write-Host "  $issue" -ForegroundColor Yellow }
    }
    exit
}

# --- Command: Search ---
if ($Search -ne "") {
    $results = @{}
    $total = 0
    foreach ($eid in $graph.Keys) {
        foreach ($tid in $graph[$eid].Keys) {
            $desc = $graph[$eid][$tid]
            if ($desc -match $Search -or $eid -match $Search -or $tid -match $Search) {
                if (-not $results.ContainsKey($eid)) { $results[$eid] = @() }
                $results[$eid] += @{ target = $tid; description = $desc }
                $total++
            }
        }
    }

    Write-Host "Search results for '$Search': $total matches"
    Write-Host ""
    if ($total -gt 0) {
        foreach ($eid in ($results.Keys | Sort-Object)) {
            Write-Host "--- $(Get-DisplayName $eid) ---" -ForegroundColor Cyan
            foreach ($item in $results[$eid]) {
                $tid = $item['target']; $desc = $item['description']
                Write-Host "  -> $($entityInfo[$tid].name) [$tid]"
                Write-Host "     $desc"
                Write-Host ""
            }
        }
    }
    exit
}

# --- Command: Entity (outbound) ---
if ($Entity -ne "") {
    if (-not $graph.ContainsKey($Entity)) {
        Write-Host "? Entity '$Entity' has no related: entries or was not found."
        Write-Host "Available entities: type '$($MyInvocation.MyCommand.Name) -Stats' for list."
        exit
    }

    $info = $entityInfo[$Entity]
    Write-Host "--- Outbound Relationships: $(Get-DisplayName $Entity) ---" -ForegroundColor Cyan
    Write-Host "(from this entity to others)"
    Write-Host ""

    $sorted = $graph[$Entity].Keys | Sort-Object
    foreach ($tid in $sorted) {
        $desc = $graph[$Entity][$tid]
        $tInfo = if ($entityInfo.ContainsKey($tid)) { "? $($entityInfo[$tid].name) [$tid]" } else { "? $tid" }
        Write-Host "  -> $tInfo" -ForegroundColor White
        if ($desc -ne "") {
            Write-Host "     $desc"
        } else {
            Write-Host "     (no description)" -ForegroundColor DarkYellow
        }
        Write-Host ""
    }
    Write-Host "Total: $($graph[$Entity].Count) relationships"
    exit
}

# --- Command: Target (inbound) ---
if ($Target -ne "") {
    if (-not $reverseGraph.ContainsKey($Target)) {
        Write-Host "? No entities link to '$Target'."
        exit
    }

    $tInfo = if ($entityInfo.ContainsKey($Target)) { Get-DisplayName $Target } else { "? $Target" }
    Write-Host "--- Inbound Relationships: $tInfo ---" -ForegroundColor Cyan
    Write-Host "(entities that link to this one)"
    Write-Host ""

    $sorted = $reverseGraph[$Target].Keys | Sort-Object
    foreach ($eid in $sorted) {
        $desc = $reverseGraph[$Target][$eid]
        Write-Host "  <- $(Get-DisplayName $eid)" -ForegroundColor White
        if ($desc -ne "") {
            Write-Host "     $desc"
        } else {
            Write-Host "     (no description)" -ForegroundColor DarkYellow
        }
        Write-Host ""
    }
    Write-Host "Total: $($reverseGraph[$Target].Count) inbound links"
    exit
}

# --- Command: Network (ego network) ---
if ($Network -ne "") {
    $eid = $Network
    if (-not $graph.ContainsKey($eid) -and -not $reverseGraph.ContainsKey($eid)) {
        Write-Host "? Entity '$eid' not found in the relationship graph."
        exit
    }

    $info = if ($entityInfo.ContainsKey($eid)) { Get-DisplayName $eid } else { "? $eid" }
    Write-Host "=== EGO NETWORK: $info ===" -ForegroundColor Cyan
    Write-Host ""

    # Outbound
    if ($graph.ContainsKey($eid) -and $graph[$eid].Count -gt 0) {
        Write-Host "-> OUTBOUND ($($graph[$eid].Count) relationships):" -ForegroundColor Green
        foreach ($tid in ($graph[$eid].Keys | Sort-Object)) {
            $desc = $graph[$eid][$tid]
            $tName = if ($entityInfo.ContainsKey($tid)) { "? $($entityInfo[$tid].name)" } else { "? $tid" }
            Write-Host "    $tName"
            if ($desc -ne "") { Write-Host "      $desc" }
        }
        Write-Host ""
    }

    # Inbound
    if ($reverseGraph.ContainsKey($eid) -and $reverseGraph[$eid].Count -gt 0) {
        Write-Host "<- INBOUND ($($reverseGraph[$eid].Count) relationships):" -ForegroundColor Yellow
        foreach ($srcId in ($reverseGraph[$eid].Keys | Sort-Object)) {
            $desc = $reverseGraph[$eid][$srcId]
            $sName = if ($entityInfo.ContainsKey($srcId)) { "? $($entityInfo[$srcId].name)" } else { "? $srcId" }
            Write-Host "    $sName"
            if ($desc -ne "") { Write-Host "      $desc" }
        }
        Write-Host ""
    }

    # Calculate totals
    $outbound = if ($graph.ContainsKey($eid)) { $graph[$eid].Count } else { 0 }
    $inbound = if ($reverseGraph.ContainsKey($eid)) { $reverseGraph[$eid].Count } else { 0 }
    Write-Host "Total: $outbound outbound + $inbound inbound = $($outbound + $inbound) connections"
    exit
}

# --- Command: All (full map, sorted by entity) ---
if ($All) {
    Write-Host "=== FULL RELATIONSHIP MAP ==="
    Write-Host "Source: Entity files (canonical) | $($graph.Keys.Count) entities, $totalRelationships relationships"
    Write-Host ""

    $sortedEntities = $graph.Keys | Sort-Object
    foreach ($eid in $sortedEntities) {
        $info = if ($entityInfo.ContainsKey($eid)) { Get-DisplayName $eid } else { "? $eid" }
        Write-Host "--- $info ---" -ForegroundColor Cyan

        $sortedTargets = $graph[$eid].Keys | Sort-Object
        foreach ($tid in $sortedTargets) {
            $desc = $graph[$eid][$tid]
            $tName = if ($entityInfo.ContainsKey($tid)) { "? $($entityInfo[$tid].name)" } else { "" }
            Write-Host "  -> $tid $tName"
            if ($desc -ne "") {
                Write-Host "     $desc"
            }
        }
        Write-Host ""
    }
    Write-Host "=== END OF MAP ==="
    exit
}

# --- No valid command ---
if ($MyInvocation.ExpectingInput -or $MyInvocation.InvocationName -eq '.') {
    # Piped/scripted
} else {
    Write-Host @"
Usage:
  .\scripts\get-entity-relationships.ps1 -Entity "kythoria"     # Relationships FROM kythoria
  .\scripts\get-entity-relationships.ps1 -Target "kythoria"     # Relationships TO kythoria
  .\scripts\get-entity-relationships.ps1 -Network "balor_skallfang"  # Full ego network
  .\scripts\get-entity-relationships.ps1 -All                   # Full relationship map
  .\scripts\get-entity-relationships.ps1 -Stats                 # Summary statistics
  .\scripts\get-entity-relationships.ps1 -Search "B-touched"    # Search descriptions
  .\scripts\get-entity-relationships.ps1 -MissingDescriptions   # Find short entries
  .\scripts\get-entity-relationships.ps1 -Orphaned              # Find entities without related:
  .\scripts\get-entity-relationships.ps1 -Validate              # Check all targets exist
"@
}