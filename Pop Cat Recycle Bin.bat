@echo off
setlocal enabledelayedexpansion

REM Get current script directory
set "scriptDir=%~dp0"

REM Auto-elevate to administrator
if not "%1"=="am_admin" (
    powershell -Command "Start-Process -FilePath '%0' -ArgumentList 'am_admin' -Verb RunAs"
    exit /b
)

echo ============================================
echo Universal Pop Cat Recycle Bin Icon Setup
echo ============================================
echo Script Location: %scriptDir%
echo.

REM Auto-detect icon files in script directory
set "closedIcon="
set "openIcon="

REM Look for common filename patterns
for %%f in ("%scriptDir%*.ico") do (
    set "filename=%%~nf"
    echo !filename! | findstr /i "close" >nul && set "closedIcon=%%f"
    echo !filename! | findstr /i "open" >nul && set "openIcon=%%f"
    if "!closedIcon!"=="" (
        echo !filename! | findstr /i "cat.*closed\|closed.*cat" >nul && set "closedIcon=%%f"
    )
    if "!openIcon!"=="" (
        echo !filename! | findstr /i "cat.*open\|open.*cat" >nul && set "openIcon=%%f"
    )
)

REM If auto-detection failed, try first two .ico files found
if "!closedIcon!"=="" or "!openIcon!"=="" (
    echo Auto-detection incomplete, scanning all .ico files...
    set /a count=0
    for %%f in ("%scriptDir%*.ico") do (
        set /a count+=1
        if !count! equ 1 set "closedIcon=%%f"
        if !count! equ 2 set "openIcon=%%f"
        echo Found: %%~nxf
    )
)

REM Validate files exist
if not exist "!closedIcon!" (
    echo ERROR: Closed mouth icon not found!
    echo Please ensure you have an icon file with 'close' or 'closed' in the name
    echo Or place exactly 2 .ico files in the same folder as this script
    pause
    exit /b 1
)

if not exist "!openIcon!" (
    echo ERROR: Open mouth icon not found!
    echo Please ensure you have an icon file with 'open' in the name  
    echo Or place exactly 2 .ico files in the same folder as this script
    pause
    exit /b 1
)

echo.
echo Icons detected:
echo   Empty Bin (Open Mouth): !openIcon!
echo   Full Bin (Closed Mouth): !closedIcon!
echo.
echo This will set:
echo   - Empty Recycle Bin = Open Cat Mouth
echo   - Full Recycle Bin = Closed Cat Mouth
echo.
pause

echo Creating permanent icon storage...
set "safeDir=C:\Icons\PopCat"
if not exist "%safeDir%" (
    mkdir "%safeDir%" 2>nul
    if !errorLevel! equ 0 (
        echo [OK] Created safe directory: %safeDir%
    ) else (
        echo [WARN] Could not create C:\Icons\PopCat, using current location
        set "safeDir=%scriptDir%"
    )
) else (
    echo [OK] Safe directory already exists: %safeDir%
)

echo Copying icons to safe location...
copy "!closedIcon!" "%safeDir%\" >nul 2>&1
copy "!openIcon!" "%safeDir%\" >nul 2>&1

REM Update icon paths to safe location
for %%f in ("!closedIcon!") do set "closedIconName=%%~nxf"
for %%f in ("!openIcon!") do set "openIconName=%%~nxf"
set "closedIcon=%safeDir%\!closedIconName!"
set "openIcon=%safeDir%\!openIconName!"

echo [OK] Icons safely stored in: %safeDir%
echo.
echo Applying Pop Cat icons to Recycle Bin...
echo.

REM Registry key path
set "regkey=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon"

REM Set default icon (closed mouth)
reg add "%regkey%" /ve /t REG_EXPAND_SZ /d "!closedIcon!,0" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo [OK] Default icon set to closed mouth
) else (
    echo [FAIL] Failed to set default icon
)

REM Set empty recycle bin icon (open mouth - cat is hungry/empty)
reg add "%regkey%" /v "empty" /t REG_EXPAND_SZ /d "!openIcon!,0" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo [OK] Empty bin icon set to open mouth
) else (
    echo [FAIL] Failed to set empty icon
)

REM Set full recycle bin icon (closed mouth - cat is satisfied/full)
reg add "%regkey%" /v "full" /t REG_EXPAND_SZ /d "!closedIcon!,0" /f >nul 2>&1
if !errorLevel! equ 0 (
    echo [OK] Full bin icon set to closed mouth
) else (
    echo [FAIL] Failed to set full icon
)

echo.
echo Registry modifications completed!
echo.

echo Refreshing desktop...
REM Force desktop and icon cache refresh
ie4uinit.exe -show
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe

echo.
echo ============================================
echo Setup Complete! ^_^
echo ============================================
echo.
echo Your Recycle Bin now shows:
echo   [EMPTY] Empty Bin = Open Cat Mouth (hungry cat!)
echo   [FULL] Full Bin = Closed Cat Mouth (satisfied cat!)
echo.
echo If icons don't update immediately:
echo   1. Press F5 to refresh desktop
echo   2. Or restart Windows Explorer
echo   3. Or restart your computer
echo.
echo To revert: Delete registry key at
echo %regkey%
echo.
echo WARNING: Keep your icon files safe!
echo If you delete the .ico files, your Recycle Bin will show
echo white paper icons. Always backup your icons or keep this
echo folder in a permanent location like:
echo   - C:\Icons\PopCat\
echo   - Documents\Desktop Icons\
echo   - Or any folder you won't accidentally delete
echo.
echo Press any key to exit...
pause >nul
