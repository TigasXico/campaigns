<#
.SYNOPSIS
1. Replace Unicode chars in master map
2. Fix broken frontmatter in 11 files
#>

Write-Host "Fix 1: Replace Unicode chars in master map" -ForegroundColor Cyan

$path = "cache/_master_relationships_map.md"
$c = Get-Content $path -Raw -Encoding UTF8

$arrowCount = [regex]::Matches($c, [char]0x2192).Count
$dashCount = [regex]::Matches($c, [char]0x2014).Count

$c = $c -replace [char]0x2192, "->"
$c = $c -replace [char]0x2014, ":"

Set-Content $path $c -Encoding UTF8 -NoNewline
Write-Host "Replaced $arrowCount arrows and $dashCount em dashes"

Write-Host "`nFix 2: Add missing frontmatter closing ---" -ForegroundColor Cyan

$deityDir = "cache/entities/characters/Deity"
$brokenFiles = @(
    "aloria.md", "aurelius.md", "crassian.md", "kaelthor.md",
    "lolth_the_spider_queen.md", "thalkis.md", "the_raven_queen.md",
    "tyra.md", "vesper.md", "vorn.md"
)

$fixed = 0

function Add-FrontmatterClose {
    param($FilePath)
    $c = Get-Content $FilePath -Raw -Encoding UTF8
    $closing = "---"
    $lines = $c -split "`n"
    
    # Find where frontmatter ends: after last line that starts with space or word-char, before blank line then heading
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match "^\s*$" -and $i -lt $lines.Count - 1 -and $lines[$i+1] -match "^##") {
            $lines[$i] = $closing
            $result = $lines -join "`n"
            Set-Content $FilePath $result -Encoding UTF8 -NoNewline
            return $true
        }
    }
    return $false
}

foreach ($f in $brokenFiles) {
    $fp = Join-Path $deityDir $f
    if (-not (Test-Path $fp)) { Write-Host "  $f not found"; continue }
    if (Add-FrontmatterClose $fp) {
        Write-Host "  $f fixed" -ForegroundColor Green
        $fixed++
    } else {
        Write-Host "  $f could not be auto-fixed" -ForegroundColor Red
    }
}

# Also fix cosmology_and_the_planes.md
Write-Host "`ncosmology_and_the_planes.md ..." -NoNewline
$fp = "cache/entities/lore/cosmology_and_the_planes.md"
if (Add-FrontmatterClose $fp) {
    Write-Host " fixed" -ForegroundColor Green
    $fixed++
} else {
    Write-Host " could not auto-fix" -ForegroundColor Red
}

Write-Host "`nDone. Fixed $fixed files" -ForegroundColor Cyan