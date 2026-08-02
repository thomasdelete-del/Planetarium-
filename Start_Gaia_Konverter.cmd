@echo off
title Gaia-DR3-Konverter
cd /d "%~dp0"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0GaiaServer.ps1"
if errorlevel 1 (
  echo.
  echo Der Starter konnte nicht ausgefuehrt werden.
  pause
)
