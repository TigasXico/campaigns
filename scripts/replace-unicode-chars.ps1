<#
.SYNOPSIS
Replace Unicode special chars with ASCII alternatives. All files.
#>

$files = Get-ChildItem -Recurse -File -Include '*.md','*.ps1','*.yaml','*.txt','*.json' |
    Where-Object { $_.FullName -notmatch '\.git' -and $_.FullName -notmatch 'node_modules' }

# Build replacements as string->string pairs to avoid char/string overloading issues
$replacements = @{}
$replacements[[string][char]0x2014] = ' - '   # EM DASH
$replacements[[string][char]0x2013] = '-'      # EN DASH
$replacements[[string][char]0x2192] = '->'     # RIGHT ARROW
$replacements[[string][char]0x2190] = '<-'     # LEFT ARROW
$replacements[[string][char]0x2500] = '-'      # BOX HORIZONTAL
$replacements[[string][char]0x251C] = '|'      # BOX VERTICAL AND RIGHT
$replacements[[string][char]0x2514] = '|'      # BOX UP AND RIGHT
$replacements[[string][char]0x2502] = '|'      # BOX VERTICAL
$replacements[[string][char]0x00B7] = '*'      # MIDDLE DOT
$replacements[[string][char]0x00B0] = ' deg'   # DEGREE
$replacements[[string][char]0x2022] = '*'      # BULLET
$replacements[[string][char]0x2026] = '...'    # ELLIPSIS
$replacements[[string][char]0x2018] = "'"       # LEFT SINGLE QUOTE
$replacements[[string][char]0x2019] = "'"       # RIGHT SINGLE QUOTE
$replacements[[string][char]0x201C] = '"'       # LEFT DOUBLE QUOTE
$replacements[[string][char]0x201D] = '"'       # RIGHT DOUBLE QUOTE
$replacements[[string][char]0xFE0F] = ''        # VARIATION SELECTOR (remove)

$fileCount = 0
$charCount = 0

foreach ($file in $files) {
    $c = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $c
    $changed = $false

    # Single char replacements
    foreach ($k in $replacements.Keys) {
        if ($c.Contains($k)) {
            $c = $c.Replace($k, $replacements[$k])
            $changed = $true
        }
    }

    # Emoji text replacements (regex)
    if ([regex]::IsMatch($c, [regex]::Unescape('\u2705'))) { $c = [regex]::Replace($c, [regex]::Unescape('\u2705'), '[ok]'); $changed = $true }
    if ([regex]::IsMatch($c, [regex]::Unescape('\u274C'))) { $c = [regex]::Replace($c, [regex]::Unescape('\u274C'), '[x]'); $changed = $true }
    if ([regex]::IsMatch($c, [regex]::Unescape('\u26A0'))) { $c = [regex]::Replace($c, [regex]::Unescape('\u26A0'), '[!]'); $changed = $true }
    if ([regex]::IsMatch($c, [regex]::Unescape('\u23F3'))) { $c = [regex]::Replace($c, [regex]::Unescape('\u23F3'), '[hourglass]'); $changed = $true }
    
    # Surrogate pairs (emoji like [ok][x]) - remove remaining
    $emojiRemaining = [regex]::Unescape('[\uD800-\uDBFF][\uDC00-\uDFFF]')
    if ([regex]::IsMatch($c, $emojiRemaining)) { $c = [regex]::Replace($c, $emojiRemaining, ''); $changed = $true }

    if ($changed) {
        Set-Content $file.FullName $c -Encoding UTF8 -NoNewline
        $fileCount++
    }
}

Write-Host "Modified $fileCount files"