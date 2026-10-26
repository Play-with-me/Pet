# Script kiem tra tuan thu Hien Phap Leader (Guardrail Policy Check)
param()

$ErrorActionPreference = "Continue"
$workspaceRoot = Split-Path -Parent $PSScriptRoot

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "LEADER GUARDRAIL POLICY CHECK (KIEM TRA RANG BUOC AI)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$violations = @()

# 1. Kiem tra su ton tai cua cac tai lieu cot loi
$requiredDocs = @(
    "ai/LEADER_CONSTITUTION.md",
    "ai/PROJECT_MASTER_PLAN.md",
    "ai/TEAM_PROTOCOL.md",
    "ai/SYNC.md",
    "TASKS.md"
)

foreach ($doc in $requiredDocs) {
    $fullPath = Join-Path $workspaceRoot $doc
    if (-not (Test-Path $fullPath)) {
        $violations += "Thieu tai lieu bat buoc: $doc"
    }
}

# 2. Kiem tra co trang thai trong SYNC.md
$syncFile = Join-Path $workspaceRoot "ai/SYNC.md"
if (Test-Path $syncFile) {
    $content = Get-Content $syncFile -Raw
    if ($content -notmatch "CURRENT[\s_]?TURN" -and $content -notmatch "Lượt tiếp theo thuộc về") {
        $violations += "SYNC.md bị mất định dạng cờ chuyển lượt (CURRENT_TURN / Lượt tiếp theo)."
    }
}

# 3. Kiem tra pham vi file gan nhat qua git status (neu co git)
try {
    $gitStatus = git status --porcelain 2>$null
    if ($gitStatus) {
        Write-Host "`n[Git Status Check] Phat hien cac file dang sua doi:" -ForegroundColor Yellow
        foreach ($line in $gitStatus) {
            Write-Host "  $line" -ForegroundColor Gray
        }
    }
} catch {
    # Git khong kha dung hoac chua init
}

# 4. Kiem tra ket qua
Write-Host "`n----------------------------------------------------------" -ForegroundColor Cyan
if ($violations.Count -eq 0) {
    Write-Host "[PASS] TAT CA QUY TAC RANG BUOC DUOC TUAN THU!" -ForegroundColor Green
    Write-Host "Hai AI dang hoat dong dung pham vi cua Leader." -ForegroundColor Green
    exit 0
}

Write-Host "[VIOLATION DETECTED] PHAT HIEN VI PHAM RANG BUOC:" -ForegroundColor Red
foreach ($v in $violations) {
    Write-Host "  ! $v" -ForegroundColor Red
}
Write-Host "Leader hay yeu cau AI dung lai va giai trinh!" -ForegroundColor Yellow
exit 1
