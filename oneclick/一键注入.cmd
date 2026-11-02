@echo off
chcp 65001 >nul
title Lucy Menu zh-CN
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%~dp0Inject.ps1"
set "inject_exit=%errorlevel%"
echo.
pause
exit /b %inject_exit%
