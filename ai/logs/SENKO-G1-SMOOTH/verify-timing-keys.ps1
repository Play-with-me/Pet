param([Parameter(Mandatory=$true)][string]$Candidate, [Parameter(Mandatory=$true)][string]$Base)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$new = Get-Content (Join-Path $Candidate 'senko.anim.json') -Raw | ConvertFrom-Json
$old = Get-Content (Join-Path $Base 'senko.anim.json') -Raw | ConvertFrom-Json
function Get-GifDuration([string]$Path) {
    $gif = [Drawing.Image]::FromFile((Resolve-Path $Path).Path)
    try {
        $bytes = $gif.GetPropertyItem(0x5100).Value
        $total = 0
        for ($i=0; $i -lt $bytes.Length; $i+=4) { $total += [BitConverter]::ToUInt32($bytes,$i)*10 }
        return $total
    } finally { $gif.Dispose() }
}
$records = @()
$keyCount = 0
foreach ($property in $old.clips.PSObject.Properties) {
    $name = $property.Name
    $a = $property.Value
    $b = $new.clips.$name
    $changed = $a.frames -ne $b.frames
    for ($i=0; $i -lt $a.frames; $i++) {
        $j = if ($changed) { 2*$i } else { $i }
        $ha = (Get-FileHash (Join-Path $Base $a.files[$i]) -Algorithm SHA256).Hash
        $hb = (Get-FileHash (Join-Path $Candidate $b.files[$j]) -Algorithm SHA256).Hash
        if ($ha -ne $hb) { throw "Original PNG changed: $name/$i" }
        $keyCount++
    }
    $t1 = Get-GifDuration (Join-Path $Base "preview/$name.gif")
    $t2 = Get-GifDuration (Join-Path $Candidate "preview/$name.gif")
    $manifestDuration = ($b.preview_frame_ms | Measure-Object -Sum).Sum
    if ($t1 -ne $t2 -or $t2 -ne $manifestDuration) { throw "GIF/manifest duration changed: $name $t1 $t2 $manifestDuration" }
    if ($name -in @('walk_side','run_side')) {
        if ($b.stride_px*$b.frames -ne $a.stride_px*$a.frames -or ($b.sync -join ',') -ne '0,8') { throw 'Distance/sync changed' }
    }
    $records += [pscustomobject]@{clip=$name;old_frames=$a.frames;new_frames=$b.frames;old_ms=$t1;new_ms=$t2;keys_sha256_identical=$true}
}
if ($keyCount -ne 100) { throw 'Wrong original key count' }
[ordered]@{base=$Base;candidate=$Candidate;original_pngs_identical=$keyCount;clips=$records} | ConvertTo-Json -Depth 6 | Set-Content (Join-Path $PSScriptRoot 'timing-keys-verification.json') -Encoding utf8
$records | Format-Table -AutoSize
Write-Output 'PASS: 100 original PNG SHA256 identical; 28 actual GIF durations unchanged; distance/sync preserved.'
