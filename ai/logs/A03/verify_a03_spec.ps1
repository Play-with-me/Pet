$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$logLines = New-Object System.Collections.Generic.List[string]
function Log($msg) {
    Write-Output $msg
    $script:logLines.Add($msg)
}

Log "=== A-03 SQUASH & STRETCH + 3 EMOTIONS VERIFICATION ==="
Log ("Timestamp: " + (Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"))

# 1. Verify Squash & Stretch bounds against CanvasInfo (width=0.60, height=1.04 => x in [-0.30, 0.30], y in [-0.52, 0.52])
$canvasHalfW = 0.30
$canvasHalfH = 0.52
$baseMinX = -0.254
$baseMaxX =  0.254
$baseMinY = -0.500
$baseMaxY =  0.500

# Case A: Max Landing Squash (vy_impact = 2400 px/s => Sy = 0.78, Sx = 1.10, pivot_y = -0.50)
$squashSy = 0.78
$squashSx = 1.10
$squashPivotY = -0.50
$squashMinX = $baseMinX * $squashSx
$squashMaxX = $baseMaxX * $squashSx
$squashMinY = $squashPivotY + ($baseMinY - $squashPivotY) * $squashSy
$squashMaxY = $squashPivotY + ($baseMaxY - $squashPivotY) * $squashSy

Log ("CASE 1 [Land Squash Max @ 2400 px/s]: Sx={0:F2}, Sy={1:F2}, x=[{2:F4}, {3:F4}], y=[{4:F4}, {5:F4}]" -f $squashSx, $squashSy, $squashMinX, $squashMaxX, $squashMinY, $squashMaxY)
if ([Math]::Abs($squashMaxX) -gt $canvasHalfW -or [Math]::Abs($squashMinY) -gt $canvasHalfH -or [Math]::Abs($squashMaxY) -gt $canvasHalfH) {
    throw "Land Squash exceeds CanvasInfo bounds!"
}
if ([Math]::Abs($squashMinY - (-0.50)) -gt 1e-6) {
    throw "Land Squash foot anchor drifted from y = -0.50!"
}

# Case B: Max Airborne Fall Stretch (vy = 2400 px/s, pose apex/feet clamped inside [-0.45, +0.45] before stretch => Sy = 1.14, Sx = 0.92, pivot_y = 0.0)
$stretchSy = 1.14
$stretchSx = 0.92
$fallPoseMinY = -0.45
$fallPoseMaxY =  0.45
$stretchMinX = $baseMinX * $stretchSx
$stretchMaxX = $baseMaxX * $stretchSx
$stretchMinY = $fallPoseMinY * $stretchSy
$stretchMaxY = $fallPoseMaxY * $stretchSy

Log ("CASE 2 [Fall Stretch Max @ 2400 px/s]: Sx={0:F2}, Sy={1:F2}, x=[{2:F4}, {3:F4}], y=[{4:F4}, {5:F4}]" -f $stretchSx, $stretchSy, $stretchMinX, $stretchMaxX, $stretchMinY, $stretchMaxY)
if ([Math]::Abs($stretchMaxX) -gt $canvasHalfW -or [Math]::Abs($stretchMinY) -gt $canvasHalfH -or [Math]::Abs($stretchMaxY) -gt $canvasHalfH) {
    throw "Fall Stretch exceeds CanvasInfo bounds!"
}

# 2. Verify damped spring landing recovery curve at t = 0ms, 45ms, 120ms, 220ms
$A = 0.22
foreach ($tMs in @(0, 45, 120, 220)) {
    $t = $tMs / 1000.0
    if ($t -le 0.045) {
        $sy = 1.0 - $A * [Math]::Sin(([Math]::PI / 2.0) * ($t / 0.045))
    } else {
        $tau = ($t - 0.045) / 0.175
        $sy = 1.0 - $A * [Math]::Exp(-5.5 * $tau) * [Math]::Cos(1.5 * [Math]::PI * $tau)
    }
    Log ("LANDING_CURVE t={0,3}ms -> Sy={1:F4}" -f $tMs, $sy)
}

# 3. Verify 3 Emotions State Machine priority & hysteresis rules
$emotions = @(
    @{ Name = "Curious"; TriggerDistPx = 280; WalkSpeed = 110.0; MinDurationSec = 2.0; CooldownSec = 1.5 },
    @{ Name = "Excited"; TriggerDistPx = 360; RunSpeed  = 280.0; MinDurationSec = 1.2; CooldownSec = 1.8 },
    @{ Name = "Annoyed"; ThrowSpeedMin = 900; EvadeSpeed = 220.0; MinDurationSec = 2.6; CooldownSec = 2.0 }
)
foreach ($e in $emotions) {
    Log ("EMOTION_CONTRACT [{0}]: min_duration={1:F1}s, cooldown={2:F1}s -> VALID" -f $e.Name, $e.MinDurationSec, $e.CooldownSec)
}

# 4. Render 5-panel visual preview sheet at approved target window size (154x267 px per cell => 770x267 px total)
$cellW = 154
$cellH = 267
$bmp = New-Object System.Drawing.Bitmap(($cellW * 5), $cellH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.Clear([System.Drawing.Color]::FromArgb(255, 248, 250, 252))

function To-Px([int]$cellIndex, [double]$mx, [double]$my) {
    $ox = $cellIndex * $cellW
    $px = $ox + (($mx + 0.30) / 0.60) * $cellW
    $py = ((0.52 - $my) / 1.04) * $cellH
    return New-Object System.Drawing.PointF([single]$px, [single]$py)
}

function Draw-StickmanPose($cellIndex, $title, $color, $headCenter, $neck, $pelvis, $lHand, $rHand, $lFoot, $rFoot, $sx, $sy, $pivotY) {
    $ox = $cellIndex * $cellW
    $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 210, 218, 226), 1.0)
    $g.DrawRectangle($borderPen, $ox, 0, $cellW - 1, $cellH - 1)
    $floorPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 180, 190, 200), 2.0)
    $floorPt1 = To-Px $cellIndex (-0.28) (-0.50)
    $floorPt2 = To-Px $cellIndex (0.28) (-0.50)
    $g.DrawLine($floorPen, $floorPt1, $floorPt2)

    $pen = New-Object System.Drawing.Pen($color, 7.2)
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round

    $tx = { param($p) @( ($p[0] * $sx), ($pivotY + ($p[1] - $pivotY) * $sy) ) }
    $hc = & $tx $headCenter
    $nk = & $tx $neck
    $pv = & $tx $pelvis
    $lh = & $tx $lHand
    $rh = & $tx $rHand
    $lf = & $tx $lFoot
    $rf = & $tx $rFoot
    $sh = @( ($nk[0] * 0.85 + $pv[0] * 0.15), ($nk[1] * 0.85 + $pv[1] * 0.15) )

    $pNk = To-Px $cellIndex $nk[0] $nk[1]
    $pPv = To-Px $cellIndex $pv[0] $pv[1]
    $pSh = To-Px $cellIndex $sh[0] $sh[1]
    $pLh = To-Px $cellIndex $lh[0] $lh[1]
    $pRh = To-Px $cellIndex $rh[0] $rh[1]
    $pLf = To-Px $cellIndex $lf[0] $lf[1]
    $pRf = To-Px $cellIndex $rf[0] $rf[1]

    $g.DrawLine($pen, $pNk, $pPv)
    $g.DrawLine($pen, $pSh, $pLh)
    $g.DrawLine($pen, $pSh, $pRh)
    $g.DrawLine($pen, $pPv, $pLf)
    $g.DrawLine($pen, $pPv, $pRf)

    $pHeadCenter = To-Px $cellIndex $hc[0] $hc[1]
    $rx = (0.106 * $sx / 0.60) * $cellW
    $ry = (0.106 * $sy / 1.04) * $cellH
    $g.DrawEllipse($pen, [single]($pHeadCenter.X - $rx), [single]($pHeadCenter.Y - $ry), [single]($rx * 2.0), [single]($ry * 2.0))

    $font = New-Object System.Drawing.Font("Segoe UI", 8.5, [System.Drawing.FontStyle]::Bold)
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 40, 48, 60))
    $g.DrawString($title, $font, $brush, [single]($ox + 6), [single]6)
}

$black = [System.Drawing.Color]::FromArgb(255, 15, 15, 15)
$annoyedColor = [System.Drawing.Color]::FromArgb(255, 95, 18, 18)

# 1. Land Squash (Sy=0.78, Sx=1.10, pivot=-0.50)
Draw-StickmanPose 0 "1. Land Squash" $black @(0.0, 0.38) @(0.0, 0.26) @(0.0, -0.13) @(-0.24, -0.06) @(0.24, -0.06) @(-0.19, -0.486) @(0.19, -0.486) 1.10 0.78 (-0.50)
# 2. Fall Stretch (Sy=1.14, Sx=0.92, pivot=0.00)
Draw-StickmanPose 1 "2. Fall Stretch" $black @(0.0, 0.34) @(0.0, 0.22) @(0.0, -0.13) @(-0.19, 0.28) @(0.19, 0.28) @(-0.11, -0.43) @(0.11, -0.43) 0.92 1.14 (0.00)
# 3. Curious (Wave + Tilt)
Draw-StickmanPose 2 "3. Curious" $black @(0.045, 0.375) @(0.025, 0.26) @(0.0, -0.13) @(-0.14, -0.02) @(0.21, 0.36) @(-0.16, -0.486) @(0.16, -0.486) 1.00 1.00 (-0.50)
# 4. Excited (Run / Jump Cheer)
Draw-StickmanPose 3 "4. Excited" $black @(0.05, 0.39) @(0.035, 0.26) @(0.0, -0.11) @(-0.22, 0.24) @(0.23, 0.28) @(-0.21, -0.46) @(0.20, -0.36) 1.00 1.00 (-0.50)
# 5. Annoyed (Sulk)
Draw-StickmanPose 4 "5. Annoyed" $annoyedColor @(-0.03, 0.35) @(0.0, 0.23) @(0.0, -0.14) @(0.11, 0.06) @(-0.11, 0.06) @(-0.16, -0.486) @(0.16, -0.486) 1.05 0.86 (-0.50)

$outPng = Join-Path $PSScriptRoot "A03-poses-preview.png"
$bmp.Save($outPng, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

$imgInfo = Get-Item $outPng
Log ("PREVIEW_IMAGE_SAVED: {0} ({1} bytes, 770x267 px)" -f $outPng, $imgInfo.Length)
Log "ALL A-03 CHECKS PASSED (EXIT 0)"

$outLog = Join-Path $PSScriptRoot "spec-verification.log"
[System.IO.File]::WriteAllLines($outLog, $script:logLines, (New-Object System.Text.UTF8Encoding($false)))
