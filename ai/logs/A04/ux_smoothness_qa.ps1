$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$outDir = Join-Path $PSScriptRoot "."
$sheetPath = Join-Path $outDir "A04-transition-smoothness-sheet.png"
$continuityPath = Join-Path $outDir "A04-motion-continuity-preview.png"

Write-Output "=== A-04 UX & SMOOTHNESS ACCEPTANCE VERIFICATION ==="
Write-Output "Canvas spec: width=0.60, height=1.04, origin=(0.30, 0.52)"
Write-Output "Target overlay window: 154 x 267 px (scale_percent = 44%, visible stickman ~ 130 x 257 px)"

function SmoothStep([double]$u) {
    $t = [Math]::Max(0.0, [Math]::Min(1.0, $u))
    return $t * $t * (3.0 - 2.0 * $t)
}

function Lerp([double]$a, [double]$b, [double]$t) {
    return $a + ($b - $a) * $t
}

function LerpPt([double[]]$a, [double[]]$b, [double]$t) {
    return @(
        (Lerp $a[0] $b[0] $t),
        (Lerp $a[1] $b[1] $t)
    )
}

# Define the 8 canonical poses in C-02/A-03 model space (Y up, foot anchor at y = -0.50)
$poses = @(
    @{
        Name = "1. Idle"
        Behavior = "Behavior::Idle"
        Sx = 1.00; Sy = 1.00; PivotY = -0.50
        Head = @(0.00, 0.38); Neck = @(0.00, 0.26); Hip = @(0.00, -0.13)
        Shoulder = @(0.00, 0.20)
        HandL = @(-0.22, -0.04); HandR = @(0.22, -0.04)
        FootL = @(-0.16, -0.486); FootR = @(0.16, -0.486)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    },
    @{
        Name = "2. Walk"
        Behavior = "Behavior::Walk"
        Sx = 1.00; Sy = 1.00; PivotY = -0.50
        Head = @(0.025, 0.38); Neck = @(0.015, 0.26); Hip = @(0.00, -0.13)
        Shoulder = @(0.015, 0.20)
        HandL = @(-0.19, 0.02); HandR = @(0.21, -0.06)
        FootL = @(-0.19, -0.486); FootR = @(0.18, -0.450)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    },
    @{
        Name = "3. Chase"
        Behavior = "Behavior::Chase"
        Sx = 0.98; Sy = 1.01; PivotY = -0.50
        Head = @(0.050, 0.375); Neck = @(0.035, 0.255); Hip = @(0.00, -0.13)
        Shoulder = @(0.030, 0.20)
        HandL = @(-0.22, 0.10); HandR = @(0.23, 0.08)
        FootL = @(-0.21, -0.460); FootR = @(0.21, -0.486)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    },
    @{
        Name = "4. ClimbWall"
        Behavior = "Behavior::ClimbRight"
        Sx = 0.98; Sy = 1.01; PivotY = 0.00
        Head = @(0.03, 0.375); Neck = @(0.02, 0.255); Hip = @(0.01, -0.13)
        Shoulder = @(0.02, 0.20)
        HandL = @(-0.14, 0.14); HandR = @(0.20, 0.30)
        FootL = @(-0.15, -0.46); FootR = @(0.18, -0.35)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    },
    @{
        Name = "5. Fall Stretch"
        Behavior = "Behavior::Physics (Fall)"
        Sx = 0.92; Sy = 1.14; PivotY = 0.00
        Head = @(0.00, 0.33); Neck = @(0.00, 0.21); Hip = @(0.00, -0.13)
        Shoulder = @(0.00, 0.16)
        HandL = @(-0.19, 0.28); HandR = @(0.19, 0.28)
        FootL = @(-0.11, -0.43); FootR = @(0.11, -0.43)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    },
    @{
        Name = "6. Land Squash"
        Behavior = "Behavior::Physics (Land)"
        Sx = 1.10; Sy = 0.78; PivotY = -0.50
        Head = @(0.00, 0.38); Neck = @(0.00, 0.26); Hip = @(0.00, -0.13)
        Shoulder = @(0.00, 0.20)
        HandL = @(-0.24, -0.06); HandR = @(0.24, -0.06)
        FootL = @(-0.18, -0.486); FootR = @(0.18, -0.486)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    },
    @{
        Name = "7. Evade / Sulk"
        Behavior = "Behavior::Evade"
        Sx = 1.05; Sy = 0.86; PivotY = -0.50
        Head = @(-0.03, 0.36); Neck = @(-0.01, 0.24); Hip = @(0.00, -0.16)
        Shoulder = @(-0.01, 0.19)
        HandL = @(0.11, 0.05); HandR = @(-0.11, 0.05)
        FootL = @(-0.17, -0.486); FootR = @(0.17, -0.486)
        Color = [System.Drawing.Color]::FromArgb(255, 89, 13, 13)
    },
    @{
        Name = "8. Recover"
        Behavior = "Behavior::Idle (Recover)"
        Sx = 0.99; Sy = 1.02; PivotY = -0.50
        Head = @(0.00, 0.375); Neck = @(0.00, 0.255); Hip = @(0.00, -0.13)
        Shoulder = @(0.00, 0.20)
        HandL = @(-0.21, -0.02); HandR = @(0.21, -0.02)
        FootL = @(-0.16, -0.486); FootR = @(0.16, -0.486)
        Color = [System.Drawing.Color]::FromArgb(255, 20, 20, 20)
    }
)

function TransformPoint([double[]]$pt, [double]$sx, [double]$sy, [double]$pivotY) {
    $x = $pt[0] * $sx
    $y = $pivotY + ($pt[1] - $pivotY) * $sy
    return @($x, $y)
}

# 1. Verify transition smoothness across all consecutive pose pairs (8 transitions x 12 frames = 96 blend frames at 60 FPS)
$maxJointStepModel = 0.0
$maxJointStepPx = 0.0
$minX = 999.0; $maxX = -999.0
$minY = 999.0; $maxY = -999.0
$totalBlendFrames = 0
$scalePxPerUnitX = 154.0 / 0.60
$scalePxPerUnitY = 267.0 / 1.04

for ($idx = 0; $idx -lt $poses.Count; $idx++) {
    $pA = $poses[$idx]
    $pB = $poses[($idx + 1) % $poses.Count]
    $prevJoints = $null
    for ($step = 0; $step -le 12; $step++) {
        $u = [double]$step / 12.0
        $alpha = SmoothStep $u
        $sx = Lerp $pA.Sx $pB.Sx $alpha
        $sy = Lerp $pA.Sy $pB.Sy $alpha
        $pivotY = Lerp $pA.PivotY $pB.PivotY $alpha

        $joints = @(
            (TransformPoint (LerpPt $pA.Head $pB.Head $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.Neck $pB.Neck $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.Hip $pB.Hip $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.Shoulder $pB.Shoulder $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.HandL $pB.HandL $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.HandR $pB.HandR $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.FootL $pB.FootL $alpha) $sx $sy $pivotY),
            (TransformPoint (LerpPt $pA.FootR $pB.FootR $alpha) $sx $sy $pivotY)
        )

        # Check head outer ring & limb radius bounds in CanvasInfo [-0.30..0.30] x [-0.52..0.52]
        $headC = $joints[0]
        $rOutX = 0.12 * $sx
        $rOutY = 0.12 * $sy
        $minX = [Math]::Min($minX, $headC[0] - $rOutX)
        $maxX = [Math]::Max($maxX, $headC[0] + $rOutX)
        $minY = [Math]::Min($minY, $headC[1] - $rOutY)
        $maxY = [Math]::Max($maxY, $headC[1] + $rOutY)

        for ($j = 1; $j -lt $joints.Count; $j++) {
            $pt = $joints[$j]
            $minX = [Math]::Min($minX, $pt[0] - 0.014 * $sx)
            $maxX = [Math]::Max($maxX, $pt[0] + 0.014 * $sx)
            $minY = [Math]::Min($minY, $pt[1] - 0.014 * $sy)
            $maxY = [Math]::Max($maxY, $pt[1] + 0.014 * $sy)
        }

        if ($null -ne $prevJoints) {
            $totalBlendFrames++
            for ($j = 0; $j -lt $joints.Count; $j++) {
                $dx = $joints[$j][0] - $prevJoints[$j][0]
                $dy = $joints[$j][1] - $prevJoints[$j][1]
                $distModel = [Math]::Sqrt($dx * $dx + $dy * $dy)
                $distPx = [Math]::Sqrt(($dx * $scalePxPerUnitX) * ($dx * $scalePxPerUnitX) + ($dy * $scalePxPerUnitY) * ($dy * $scalePxPerUnitY))
                if ($distModel -gt $maxJointStepModel) { $maxJointStepModel = $distModel }
                if ($distPx -gt $maxJointStepPx) { $maxJointStepPx = $distPx }
            }
        }
        $prevJoints = $joints
    }
}

Write-Output ("Transition blend frames evaluated: {0}" -f $totalBlendFrames)
Write-Output ("Envelope X across all transitions: [{0:F4}, {1:F4}] within [-0.3000, +0.3000]" -f $minX, $maxX)
Write-Output ("Envelope Y across all transitions: [{0:F4}, {1:F4}] within [-0.5200, +0.5200]" -f $minY, $maxY)
Write-Output ("Max inter-frame joint displacement at 60 FPS (200ms blend): {0:F4} model units ({1:F2} px/frame)" -f $maxJointStepModel, $maxJointStepPx)

if ($minX -lt -0.30 -or $maxX -gt 0.30 -or $minY -lt -0.52 -or $maxY -gt 0.52) {
    throw "Canvas bounds exceeded during pose transitions!"
}
if ($maxJointStepPx -gt 16.0) {
    throw "Excessive inter-frame joint jump detected!"
}

# 2. Render 8-cell Transition Smoothness Sheet (1232 x 267 px)
$cellW = 154
$cellH = 267
$bmp = New-Object System.Drawing.Bitmap(($cellW * $poses.Count), $cellH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear([System.Drawing.Color]::FromArgb(255, 246, 248, 252))

$gridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 215, 222, 232), 1.0)
$floorPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 170, 182, 198), 1.5)
$fontTitle = New-Object System.Drawing.Font("Segoe UI", 8.0, [System.Drawing.FontStyle]::Bold)
$fontSub = New-Object System.Drawing.Font("Consolas", 6.8, [System.Drawing.FontStyle]::Regular)
$textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 45, 55, 72))
$subBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 95, 108, 128))

function ToScreenPt([int]$cellIndex, [double[]]$modelPt) {
    $ox = $cellIndex * $cellW
    $px = $ox + (($modelPt[0] + 0.30) / 0.60) * $cellW
    $py = ((0.52 - $modelPt[1]) / 1.04) * $cellH
    return New-Object System.Drawing.PointF([single]$px, [single]$py)
}

for ($i = 0; $i -lt $poses.Count; $i++) {
    $p = $poses[$i]
    $ox = $i * $cellW
    $g.DrawRectangle($gridPen, $ox, 0, $cellW - 1, $cellH - 1)
    $floorY = ((0.52 - (-0.50)) / 1.04) * $cellH
    $g.DrawLine($floorPen, $ox + 6, [single]$floorY, $ox + $cellW - 6, [single]$floorY)

    $pen = New-Object System.Drawing.Pen($p.Color, 7.2)
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round

    $head = TransformPoint $p.Head $p.Sx $p.Sy $p.PivotY
    $neck = TransformPoint $p.Neck $p.Sx $p.Sy $p.PivotY
    $hip = TransformPoint $p.Hip $p.Sx $p.Sy $p.PivotY
    $sh = TransformPoint $p.Shoulder $p.Sx $p.Sy $p.PivotY
    $hl = TransformPoint $p.HandL $p.Sx $p.Sy $p.PivotY
    $hr = TransformPoint $p.HandR $p.Sx $p.Sy $p.PivotY
    $fl = TransformPoint $p.FootL $p.Sx $p.Sy $p.PivotY
    $fr = TransformPoint $p.FootR $p.Sx $p.Sy $p.PivotY

    $g.DrawLine($pen, (ToScreenPt $i $neck), (ToScreenPt $i $hip))
    $g.DrawLine($pen, (ToScreenPt $i $sh), (ToScreenPt $i $hl))
    $g.DrawLine($pen, (ToScreenPt $i $sh), (ToScreenPt $i $hr))
    $g.DrawLine($pen, (ToScreenPt $i $hip), (ToScreenPt $i $fl))
    $g.DrawLine($pen, (ToScreenPt $i $hip), (ToScreenPt $i $fr))

    $headScreen = ToScreenPt $i $head
    $rx = [single](0.106 * $p.Sx * ($cellW / 0.60))
    $ry = [single](0.106 * $p.Sy * ($cellH / 1.04))
    $g.DrawEllipse($pen, $headScreen.X - $rx, $headScreen.Y - $ry, $rx * 2.0, $ry * 2.0)

    $g.DrawString($p.Name, $fontTitle, $textBrush, [single]($ox + 6), [single]4.0)
    $g.DrawString(("Sx={0:F2} Sy={1:F2}" -f $p.Sx, $p.Sy), $fontSub, $subBrush, [single]($ox + 6), [single]($cellH - 16))
    $pen.Dispose()
}

$bmp.Save($sheetPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

# 3. Render 4-panel Motion Continuity & Onion-Skin Preview (616 x 267 px)
$bmp2 = New-Object System.Drawing.Bitmap(($cellW * 4), $cellH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g2 = [System.Drawing.Graphics]::FromImage($bmp2)
$g2.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g2.Clear([System.Drawing.Color]::FromArgb(255, 28, 34, 45))

$transitionsToPreview = @(
    @{ Title = "Idle -> Walk"; From = 0; To = 1 },
    @{ Title = "Walk -> Chase"; From = 1; To = 2 },
    @{ Title = "Fall -> Land Squash"; From = 4; To = 5 },
    @{ Title = "Evade -> Recover"; From = 6; To = 7 }
)

$lightTitleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 235, 242, 250))
$darkGridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 58, 68, 86), 1.0)
$darkFloorPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 95, 115, 145), 1.5)

for ($panel = 0; $panel -lt 4; $panel++) {
    $tr = $transitionsToPreview[$panel]
    $pA = $poses[$tr.From]
    $pB = $poses[$tr.To]
    $ox = $panel * $cellW
    $g2.DrawRectangle($darkGridPen, $ox, 0, $cellW - 1, $cellH - 1)
    $floorY = ((0.52 - (-0.50)) / 1.04) * $cellH
    $g2.DrawLine($darkFloorPen, $ox + 6, [single]$floorY, $ox + $cellW - 6, [single]$floorY)

    foreach ($u in @(0.0, 0.33, 0.67, 1.0)) {
        $alpha = SmoothStep $u
        $sx = Lerp $pA.Sx $pB.Sx $alpha
        $sy = Lerp $pA.Sy $pB.Sy $alpha
        $pivotY = Lerp $pA.PivotY $pB.PivotY $alpha

        $aVal = [int](55 + 200 * $u)
        $col = if ($u -lt 0.99) {
            [System.Drawing.Color]::FromArgb($aVal, 110, 195, 255)
        } else {
            [System.Drawing.Color]::FromArgb(255, 255, 255, 255)
        }
        $pen = New-Object System.Drawing.Pen($col, [single](5.5 + 1.7 * $u))
        $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
        $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round

        $head = TransformPoint (LerpPt $pA.Head $pB.Head $alpha) $sx $sy $pivotY
        $neck = TransformPoint (LerpPt $pA.Neck $pB.Neck $alpha) $sx $sy $pivotY
        $hip = TransformPoint (LerpPt $pA.Hip $pB.Hip $alpha) $sx $sy $pivotY
        $sh = TransformPoint (LerpPt $pA.Shoulder $pB.Shoulder $alpha) $sx $sy $pivotY
        $hl = TransformPoint (LerpPt $pA.HandL $pB.HandL $alpha) $sx $sy $pivotY
        $hr = TransformPoint (LerpPt $pA.HandR $pB.HandR $alpha) $sx $sy $pivotY
        $fl = TransformPoint (LerpPt $pA.FootL $pB.FootL $alpha) $sx $sy $pivotY
        $fr = TransformPoint (LerpPt $pA.FootR $pB.FootR $alpha) $sx $sy $pivotY

        $g2.DrawLine($pen, (ToScreenPt $panel $neck), (ToScreenPt $panel $hip))
        $g2.DrawLine($pen, (ToScreenPt $panel $sh), (ToScreenPt $panel $hl))
        $g2.DrawLine($pen, (ToScreenPt $panel $sh), (ToScreenPt $panel $hr))
        $g2.DrawLine($pen, (ToScreenPt $panel $hip), (ToScreenPt $panel $fl))
        $g2.DrawLine($pen, (ToScreenPt $panel $hip), (ToScreenPt $panel $fr))

        $headScreen = ToScreenPt $panel $head
        $rx = [single](0.106 * $sx * ($cellW / 0.60))
        $ry = [single](0.106 * $sy * ($cellH / 1.04))
        $g2.DrawEllipse($pen, $headScreen.X - $rx, $headScreen.Y - $ry, $rx * 2.0, $ry * 2.0)
        $pen.Dispose()
    }
    $g2.DrawString($tr.Title, $fontTitle, $lightTitleBrush, [single]($ox + 6), [single]4.0)
}

$bmp2.Save($continuityPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g2.Dispose()
$bmp2.Dispose()

Write-Output "Saved visual sheets:"
Write-Output (" - {0} (1232x267 px)" -f $sheetPath)
Write-Output (" - {0} (616x267 px)" -f $continuityPath)
Write-Output "RESULT=PASSED"
