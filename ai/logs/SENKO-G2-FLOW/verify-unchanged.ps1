param([string]$Base,[string]$Candidate)
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$old=Get-Content (Join-Path $Base 'senko.anim.json') -Raw | ConvertFrom-Json
$new=Get-Content (Join-Path $Candidate 'senko.anim.json') -Raw | ConvertFrom-Json
$replaced=@('walk_side','run_side')
function DurationMs([string]$Path) {
    $gif=[Drawing.Image]::FromFile((Resolve-Path $Path).Path)
    try {$bytes=$gif.GetPropertyItem(0x5100).Value;$total=0;for($i=0;$i -lt $bytes.Length;$i+=4){$total += [BitConverter]::ToUInt32($bytes,$i)*10};return $total} finally {$gif.Dispose()}
}
$hashCount=0;$records=@()
foreach($property in $old.clips.PSObject.Properties) {
    $name=$property.Name;$a=$property.Value;$b=$new.clips.$name
    if($name -notin $replaced) {
        if($a.frames -ne $b.frames){throw "Unrelated clip changed: $name"}
        for($i=0;$i -lt $a.frames;$i++) {
            $ha=(Get-FileHash (Join-Path $Base $a.files[$i]) -Algorithm SHA256).Hash
            $hb=(Get-FileHash (Join-Path $Candidate $b.files[$i]) -Algorithm SHA256).Hash
            if($ha -ne $hb){throw "Unrelated PNG changed: $name/$i"};$hashCount++
        }
    }
    $before=DurationMs (Join-Path $Base "preview/$name.gif")
    $after=DurationMs (Join-Path $Candidate "preview/$name.gif")
    if(($name -notin $replaced -and $before -ne $after) -or $after -ne ($b.preview_frame_ms | Measure-Object -Sum).Sum){throw "Changed timing: $name"}
    if($a.ms -eq 0) {
        if($name -notin $replaced -and $a.stride_px*$a.frames -ne $b.stride_px*$b.frames){throw "Changed cycle distance: $name"}
        if(($b.sync -join ',') -ne "0,$($b.frames/2)"){throw "Wrong sync: $name"}
    }
    $records += [pscustomobject]@{clip=$name;replaced=($name -in $replaced);old_frames=$a.frames;new_frames=$b.frames;old_ms=$before;new_ms=$after}
}
if($hashCount -ne 201){throw "Wrong unchanged PNG count: $hashCount"}
[ordered]@{unchanged_pngs_identical=$hashCount;replaced_clips=$replaced;clips=$records} | ConvertTo-Json -Depth 7 | Set-Content (Join-Path $PSScriptRoot 'unchanged-verification.json') -Encoding utf8
$records | Format-Table -AutoSize
Write-Output 'PASS: 201 unrelated PNGs byte-identical; 43 unrelated GIF durations preserved; distance/sync preserved.'

