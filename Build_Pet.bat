@echo off
setlocal
set "PATH=%USERPROFILE%\.cargo\bin;%PATH%"
cd /d "%~dp0BongoCat"
just senko-build
exit /b %ERRORLEVEL%
