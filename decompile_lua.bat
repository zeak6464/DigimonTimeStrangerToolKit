@echo off
setlocal enabledelayedexpansion

set UNLUAC_JAR=unluac_2023_12_24.jar
set INPUT_DIR=New folder
set OUTPUT_DIR=decompiled_lua

REM Create output directory
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Check if unluac jar exists
if not exist "%UNLUAC_JAR%" (
    echo Error: unluac jar not found at %UNLUAC_JAR%
    pause
    exit /b 1
)

echo Starting to decompile Lua files...
echo.

REM Process all .lua files
set /a count=0
for %%f in ("%INPUT_DIR%\*.lua") do (
    set /a count+=1
    set "filename=%%~nf"
    set "outputfile=%OUTPUT_DIR%\!filename!.lua"
    
    echo [!count!] Decompiling: %%~nxf
    
    java -jar "%UNLUAC_JAR%" "%%f" > "!outputfile!" 2>nul
    if exist "!outputfile!" (
        echo   Successfully decompiled to: !outputfile!
    ) else (
        echo   Failed to decompile: %%~nxf
    )
)

echo.
echo Decompilation complete!
echo Processed %count% files
echo Output files are in: %OUTPUT_DIR%\
pause
