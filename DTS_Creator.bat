@echo off
title DTS Creator - Ultimate Toolkit Launcher
echo.
echo ========================================
echo  DTS Creator - Ultimate Toolkit
echo ========================================
echo.
echo Starting launcher...
python DTS_Creator_Launcher.py
if errorlevel 1 (
    echo.
    echo ERROR: Failed to start DTS Creator Launcher
    echo.
    pause
)

