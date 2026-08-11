# Generates a readable category-level mermaid graph from graph_data.json
# Shows each lore category as a node, with edge counts between them

param(
    [string]$GraphDataPath = (Join-Path $PSScriptRoot "..\cache\graph_data.json"),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\cache\category_web.mmd")
)

# Read graph data
$json = Get-Content $GraphDataPath -Raw
$data = $json | ConvertFrom-Json

$catOrder = [string[]]$data.categoryOrder
$nodeCats = [string[]]$data.nodeCategories
$edges = [object[]]$data.edges

# Category display names
$catNames = @{
    'lore'           = 'Lore Topics'
    'Deity'          = 'Deities'
    'NPC'            = 'NPCs'
    'PC'             = 'Player Characters'
    'organization'   = 'Organizations'
    'location'       = 'Locations'
    'event'          = 'Events'
    'item'           = 'Items'
    'campaign_note'  = 'GM Notes'
}

# Count entities per category
$catCounts = @{}
foreach ($c in $catOrder) { $catCounts[$c] = 0 }
foreach ($nc in $nodeCats) { $catCounts[$nc]++ }

# Build category index
$catIdx = @{}
for ($i = 0; $i -lt $catOrder.Count; $i++) { $catIdx[$catOrder[$i]] = $i }
$n = $catOrder.Count

# Initialize symmetric matrix (all zeros)
$matrix = @()
for ($i = 0; $i -lt $n; $i++) {
    $row = @()
    for ($j = 0; $j -lt $n; $j++) { $row += 0 }
    $matrix += ,$row
}

# Count directional relationships
foreach ($e in $edges) {
    $sc = $nodeCats[$e.from]
    $tc = $nodeCats[$e.to]
    $si = $catIdx[$sc]
    $ti = $catIdx[$tc]
    if (($null -eq $si) -or ($null -eq $ti) -or ($si -eq $ti)) { continue }
    $matrix[$si][$ti]++
}

# Make symmetric (i += j, j = i)
for ($i = 0; $i -lt $n; $i++) {
    for ($j = $i+1; $j -lt $n; $j++) {
        $v = $matrix[$i][$j] + $matrix[$j][$i]
        $matrix[$i][$j] = $v
        $matrix[$j][$i] = $v
    }
}

# Build mermaid code
$lines = [System.Collections.ArrayList]@()
[void]$lines.Add('graph LR')
[void]$lines.Add('')

# Add category nodes with entity count
foreach ($c in $catOrder) {
    $cnt = $catCounts[$c]
    $label = "$($catNames[$c]) ($cnt)"
    [void]$lines.Add("  $c[""$label""]")
}
[void]$lines.Add('')

# Add edges between categories
for ($i = 0; $i -lt $n; $i++) {
    for ($j = $i+1; $j -lt $n; $j++) {
        $v = $matrix[$i][$j]
        if ($v -gt 0) {
            $src = $catOrder[$i]
            $tgt = $catOrder[$j]
            $label = "$v connections"
            [void]$lines.Add("  $src -- $label --> $tgt")
        }
    }
}

# Write output
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$content = $lines -join "`r`n"
[System.IO.File]::WriteAllText($OutputPath, $content, $utf8NoBom)

Write-Host "Category graph written to $OutputPath"
Write-Host "Categories: $n"
Write-Host "Edges: $(($lines | Where-Object { $_ -match '--.*-->' } | Measure-Object).Count)"