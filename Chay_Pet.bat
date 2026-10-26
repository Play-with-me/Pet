@echo off
chcp 65001 >nul
title Senko-san Desktop Companion
cd /d "%~dp0"

set "EXE_PATH=%~dp0BongoCat\target\debug\examples\companion_senko.exe"
set "ASSETS_PATH=%~dp0resources\characters\senko"

if not exist "%EXE_PATH%" goto :COMPILE

echo =============================================================
echo   Khoi dong Senko-san (Kitsune Anime Desktop Companion)
echo =============================================================
echo - Chuot trai : Nhac Senko len, tha roi hoac nem theo vat ly
echo - Hanh vi tu dong :
echo     * Dung quan sat, lac dau, ngoe ngoay tai hoac ngoi nghiem
echo     * Di dao tung tang tren thanh Taskbar
echo     * Bam va leo 2 ben mep man hinh
echo     * Duoi theo con tro chuot hoac ne tranh khi chuot lao nhanh
echo     * Gio 2 tay chong mat khi bi nhac len tren khong
echo - Chuot phai : Menu Tam dung / Tiep tuc, Ve vi tri an toan, Thoat
echo =============================================================
echo.

"%EXE_PATH%" "%ASSETS_PATH%" 3600

if errorlevel 1 (
    echo.
    echo [Loi] Chuong trinh gap su co.
    pause
)
exit /b 0

:COMPILE
echo Dang bien dich Senko Companion va khoi dong...
set "PATH=%PATH%;%USERPROFILE%\.cargo\bin"
cargo run --manifest-path BongoCat/Cargo.toml --locked -p bongocat-overlay --example companion_senko -- "%ASSETS_PATH%" 3600
if errorlevel 1 (
    echo.
    echo [Loi] Bien dich hoac khoi dong that bai!
    pause
)
