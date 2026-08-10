$master = Get-Content 'cache/_master_relationships_map.md' -Raw -Encoding UTF8
$ids = @('lolth_the_spider_queen','thalkis','aloria','kaelthor','vesper','aurelius','the_raven_queen','crassian','cosmology_and_the_planes')
foreach ($id in $ids) {
    $pat = [regex]::Escape("## $id") + ' \[\w+\]\r?\n(.*?)(?=\r?\n## |\z)'
    $sec = [regex]::Match($master, $pat, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if ($sec.Success) {
        $rels = [regex]::Matches($sec.Groups[1].Value, '- \S+\s+\S\s+(\S+)\s+\[(\w+)\]')
        Write-Host "$id : $($rels.Count) relationships in master map"
    } else {
        Write-Host "$id : section not found"
    }
}

# Also count total missing from deity files
Write-Host "`n-- Counting all broken-frontmatter missing rels --"
$total = 0
foreach ($id in $ids) {
    $pat = [regex]::Escape("## $id") + ' \[\w+\]\r?\n(.*?)(?=\r?\n## |\z)'
    $sec = [regex]::Match($master, $pat, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if ($sec.Success) {
        $rels = [regex]::Matches($sec.Groups[1].Value, '- \S+\s+\S\s+(\S+)\s+\[(\w+)\]')
        $total += $rels.Count
    }
}
Write-Host "Total relationships from broken-frontmatter entities: $total"