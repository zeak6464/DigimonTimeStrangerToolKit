@echo off
title Lua Decompiler - DTS Creator
python lua_decompiler_gui.py
if errorlevel 1 (
    echo.
    echo Press any key to exit...
    pause >nul
)

