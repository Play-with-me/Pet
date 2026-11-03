param([Parameter(Mandatory=$true)][string]$Candidate)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$candidatePath = (Resolve-Path -LiteralPath $Candidate).Path
$manifest = Get-Content -LiteralPath (Join-Path $candidatePath 'senko.anim.json') -Raw | ConvertFrom-Json
if ($manifest.canvas[0] -ne 80 -or $manifest.canvas[1] -ne 80 -or $manifest.scale -ne 4) { throw 'Invalid manifest geometry' }
$colors = [Collections.Generic.HashSet[int]]::new()
$records = [Collections.Generic.List[object]]::new()
$clips = [Collections.Generic.List[object]]::new()
$total = 0
foreach ($property in $manifest.clips.PSObject.Properties) {
    $clipName = $property.Name
    $clip = $property.Value
    if ($clip.frames -ne $clip.files.Count) { throw "Wrong frame count in $clipName" }
    $unique = [Collections.Generic.HashSet[string]]::new()
    $visualUnique = [Collections.Generic.HashSet[string]]::new()
    foreach ($relative in $clip.files) {
        $path = Join-Path $candidatePath $relative
        $image = [Drawing.Bitmap]::new($path)
        try {
            if ($image.Width -ne 80 -or $image.Height -ne 80) { throw "Wrong PNG dimensions: $relative" }
            $opaque = 0
            $argb = [int[]]::new(6400)
            $bbox = @(80,80,0,0)
            for ($y=0; $y -lt 80; $y++) {
                for ($x=0; $x -lt 80; $x++) {
                    $pixel = $image.GetPixel($x,$y)
                    $argb[$y*80+$x] = $pixel.ToArgb()
                    if ($pixel.A -ne 0 -and $pixel.A -ne 255) { throw "Soft alpha in $relative" }
                    [void]$colors.Add($pixel.ToArgb())
                    if ($pixel.A -eq 255) {
                        $opaque++
                        $bbox[0] = [Math]::Min($bbox[0],$x)
                        $bbox[1] = [Math]::Min($bbox[1],$y)
                        $bbox[2] = [Math]::Max($bbox[2],$x)
                        $bbox[3] = [Math]::Max($bbox[3],$y)
                        if ($pixel.R -gt 200 -and $pixel.B -gt 150 -and $pixel.G -lt 100) { throw "Magenta remains: $relative" }
                    }
                }
            }
            if ($opaque -lt 100 -or $bbox[0] -eq 0 -or $bbox[2] -eq 79 -or $bbox[1] -eq 0 -or $bbox[3] -gt 76) { throw "Empty or clipped output: $relative" }
            $hash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
            [void]$unique.Add($hash)
            $bytes = [byte[]]::new(25600)
            [Buffer]::BlockCopy($argb,0,$bytes,0,25600)
            $sha = [Security.Cryptography.SHA256]::Create()
            try { $visualHash = [Convert]::ToHexString($sha.ComputeHash($bytes)) } finally { $sha.Dispose() }
            [void]$visualUnique.Add($visualHash)
            $records.Add([pscustomobject]@{file=$relative;sha256=$hash;opaque=$opaque;bbox=$bbox})
            $total++
        } finally { $image.Dispose() }
    }
    $gifPath = Join-Path $candidatePath "preview/$clipName.gif"
    $gif = [Drawing.Image]::FromFile($gifPath)
    try {
        $dimension = [Drawing.Imaging.FrameDimension]::new($gif.FrameDimensionsList[0])
        $gifFrames = $gif.GetFrameCount($dimension)
        if ($gifFrames -ne $clip.frames -or $gif.Width -ne 320 -or $gif.Height -ne 320) { throw "GIF mismatch: $clipName" }
    } finally { $gif.Dispose() }
    if ($visualUnique.Count -ne $clip.frames) { throw "Duplicate pixel frame in $clipName" }
    $clips.Add([pscustomobject]@{clip=$clipName;png_frames=$clip.frames;unique_png=$unique.Count;unique_pixel_images=$visualUnique.Count;gif_frames=$gifFrames})
}
if ($total -ne 233 -or $clips.Count -ne 45 -or $colors.Count -gt 32) { throw 'Pack validation failed' }
$report = [ordered]@{candidate=$candidatePath;frames=$total;clips=$clips.Count;shared_rgba_colors=$colors.Count;clip_details=$clips;files=$records}
$report | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'asset-verification.json') -Encoding utf8
$clips | Format-Table -AutoSize
Write-Output "PASS: $total frames, $($clips.Count) clips, $($colors.Count) RGBA colors; 45 GIFs decoded by Windows GDI+."


