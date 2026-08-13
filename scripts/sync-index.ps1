<#
.SYNOPSIS
  Syncs cache/_index.md with the actual entity files on disk.

.DESCRIPTION
  Scans all entity .md files under cache/, reads their YAML frontmatter,
  detects duplicates, missing entries, and orphans, then rebuilds _index.md
  with a clean, sorted table.

  Designed to be run BEFORE every git commit to keep the index in sync.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\sync-index.ps1
#>

param(
  [string]$ProjectRoot = (Resolve-Path "$PSScriptRoot\..")
)

$indexPath    = Join-Path $ProjectRoot "cache\_index.md"
$entitiesRoot = Join-Path $ProjectRoot "cache"

# ---------- helpers ----------
function Read-Frontmatter {
  param([string]$Path)
  $content = Get-Content $Path -Raw -Encoding UTF8
  if (-not $content) { return $null }

  # Strip BOM from content
  $content = $content.TrimStart("`u{FEFF}")
  # Normalize line endings
  $content = $content -replace "`r`n", "`n"

  # Match frontmatter between --- markers
  if (-not ($content -match '(?s)^---\n(.+?)\n---')) { return $null }

  $hash = @{}
  foreach ($line in ($Matches[1] -split "`n")) {
    if ($line -match "^(\w+):\s*'(.+)'")  { $hash[$Matches[1]] = $Matches[2].Trim(); continue }
    if ($line -match '^(\w+):\s*"(.+)"')  { $hash[$Matches[1]] = $Matches[2].Trim(); continue }
    if ($line -match '^(\w+):\s*(.+)')    { $hash[$Matches[1]] = $Matches[2].Trim(); continue }
  }
  return $hash
}

# ---------- scan disk ----------
Write-Host "[scan] Scanning $entitiesRoot ..." -ForegroundColor Cyan
$files = Get-ChildItem $entitiesRoot -Recurse -Filter "*.md"
$disk = @{}  # id -> { id, type, name, status, updated, path }

foreach ($f in $files) {
  # Skip root-level files (_index.md, _session_continuity.md)
  if ($f.Directory.Name -eq 'cache') { continue }

  $fm = Read-Frontmatter $f.FullName
  if (-not $fm -or -not $fm['id']) {
    Write-Host "  [warn] $($f.Name) has no valid frontmatter (skipping)" -ForegroundColor Yellow
    continue
  }
  $id = $fm['id']
  $diskType = $fm['type'];    if (-not $diskType) { $diskType = 'unknown' }
  $diskName = $fm['name'];    if (-not $diskName) { $diskName = $id }
  $diskStat = $fm['status'];  if (-not $diskStat) { $diskStat = 'draft' }
  $diskUpd  = $fm['updated']; if (-not $diskUpd)  { $diskUpd  = (Get-Date -Format 'yyyy-MM-dd') }

  $disk[$id] = @{
    id      = $id
    type    = $diskType
    name    = $diskName
    status  = $diskStat
    updated = $diskUpd
  }
}

Write-Host "  Found $($disk.Count) valid entity files on disk." -ForegroundColor Green

# ---------- parse current index ----------
Write-Host "[scan] Parsing current $indexPath ..." -ForegroundColor Cyan
$indexLines = @()
if (Test-Path $indexPath) { $indexLines = Get-Content $indexPath -Encoding UTF8 }
$tableRows = @()
$inTable = $false
$tableStarted = $false

foreach ($line in $indexLines) {
  if ($line -match '^\|\s*ID\s*\|') {
    $tableStarted = $true
    $inTable = $true
    continue
  }
  if ($tableStarted -and $line -match '^\|---') { continue }
  if (-not $inTable) { continue }
  if ($line -match '^\|\s*(\w+)\s*\|\s*(\w+)\s*\|\s*(.+?)\s*\|\s*(\w+)\s*\|\s*(\d{4}-\d{2}-\d{2})\s*\|$') {
    $tableRows += @{
      id      = $Matches[1]
      type    = $Matches[2]
      name    = $Matches[3].Trim()
      status  = $Matches[4]
      updated = $Matches[5]
    }
  }
}

Write-Host "  Found $($tableRows.Count) rows in current index." -ForegroundColor Green

# ---------- detect issues ----------
$indexIds = $tableRows | ForEach-Object { $_.id }

$duplicates = $indexIds | Group-Object | Where-Object { $_.Count -gt 1 }
$missing    = $disk.Keys | Where-Object { $_ -notin $indexIds } | Sort-Object
$orphans    = $indexIds | Where-Object { $_ -notin $disk.Keys } | Select-Object -Unique | Sort-Object

if ($duplicates) {
  Write-Host "[issues] Duplicates found:" -ForegroundColor Yellow
  $duplicates | ForEach-Object { Write-Host "         $($_.Name) appears $($_.Count) times" }
}
if ($missing) {
  Write-Host "[issues] Missing from index:" -ForegroundColor Yellow
  $missing | ForEach-Object { Write-Host "         $_" }
}
if ($orphans) {
  Write-Host "[issues] Orphaned in index (no file on disk):" -ForegroundColor Yellow
  $orphans | ForEach-Object { Write-Host "         $_" }
}

if (-not $duplicates -and -not $missing -and -not $orphans) {
  Write-Host "[ok] Index is already in sync. No changes needed." -ForegroundColor Green
  # Still regenerate to clean trailing whitespace/garbage
  # But only if the file is clean already, skip
  if (-not (Get-Content $indexPath | Where-Object { $_ -match '^\s*# WorldAnvil' }) -or
      (Get-Content $indexPath | Measure-Object).Count -le 91) {
    exit 0
  }
  Write-Host "[info] Trailing garbage detected - cleaning up anyway." -ForegroundColor Cyan
}

# ---------- rebuild table ----------
Write-Host "[build] Rebuilding index table ..." -ForegroundColor Cyan

# Start with all disk entries, sorted by id
$sorted = $disk.Keys | Sort-Object

$newRows = foreach ($id in $sorted) {
  $e = $disk[$id]
  $padName = if ($e.name.Length -gt 40) { $e.name.Substring(0,37) + "..." } else { $e.name }
  "| {0,-36} | {1,-14} | {2,-40} | {3,-6} | {4,-10} |" -f $e.id, $e.type, $padName, $e.status, $e.updated
}

# ---------- write new index ----------
$header = @(
  "# WorldAnvil Lore Cache  -  Entity Index",
  "",
  "| ID | Type | Name | Status | Updated |",
  "|----|------|------|--------|---------|"
)

$output = $header + $newRows

# Write as UTF8 without BOM, with CRLF endings
# Write as UTF8 without BOM, with CRLF endings
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$contentToWrite = ($output -join "`r`n")
# Trim any trailing blank lines
$contentToWrite = $contentToWrite.TrimEnd()
[System.IO.File]::WriteAllText($indexPath, $contentToWrite, $utf8NoBom)

Write-Host ""
Write-Host "[done] Index updated at $indexPath" -ForegroundColor Green
Write-Host ""
Write-Host "Summary of changes:"
if ($duplicates) { Write-Host "  - Removed $($duplicates.Count) duplicate entr(y/ies)" }
if ($missing)    { Write-Host "  - Added $($missing.Count) missing entr(y/ies): $($missing -join ', ')" }
if ($orphans)    { Write-Host "  - Removed $($orphans.Count) orphaned entr(y/ies): $($orphans -join ', ')" }
Write-Host "  - Total rows: $(($newRows | Measure-Object).Count)"
Write-Host ""

# ---------- validation ----------
$newLineCount = (Get-Content $indexPath -Encoding UTF8 | Measure-Object).Count
Write-Host "[valid] New file: $newLineCount lines." -ForegroundColor Cyan