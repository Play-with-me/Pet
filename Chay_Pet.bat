@echo off
setlocal
set "EXE_PATH=%~dp0BongoCat\target\release\examples\companion_senko.exe"
if not exist "%EXE_PATH%" (
    echo Chua co ban release. Hay chay Build_Pet.bat truoc.
    exit /b 1
)
start "" /d "%~dp0" "%EXE_PATH%" "%~dp0resources\characters\senko-v3-g2\candidate-v5-flow" 0
exit /b 0
