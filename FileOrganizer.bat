@echo off
setlocal enabledelayedexpansion

:: Initialize error counters
set "ArchiveErrors=0"
set "MoveFileErrors=0"
set "DeleteFolderErrors=0"
set "PictureMoveErrors=0"
set "VideoMoveErrors=0"

:: Prompt the user for the source directory
set /p "SourceDir=Please enter the source directory: "

:: Check if the directory exists
if not exist "%SourceDir%" (
    echo The directory does not exist.
    exit /b
)

:: Initialize variables
set "Password="
set "RemoveArchives=0"
set "KeepFile="

:: Check if there are any archive files in the directory
dir /b "%SourceDir%\*.zip" "%SourceDir%\*.rar" "%SourceDir%\*.7z" "%SourceDir%\*.tar.gz" "%SourceDir%\*.jar" "%SourceDir%\*.cab" "%SourceDir%\*.dmg" "%SourceDir%\*.kgb" >nul 2>nul
if %errorlevel% neq 0 (
    echo No archives found.
    goto :MoveFiles
)

:: Extract archive files in place using 7-Zip
set "ArchiveFound=0"
for %%F in (%SourceDir%\*.zip, %SourceDir%\*.rar, %SourceDir%\*.7z, %SourceDir%\*.tar.gz, %SourceDir%\*.jar, %SourceDir%\*.cab, %SourceDir%\*.dmg, %SourceDir%\*.kgb) do (
    set "ArchiveFound=1"
    echo Extracting archive: %%~nxF
    set "Password="
    :PasswordLoop
    if not defined Password (
        set /p "Password=Enter password for archive %%~nxF (or press Enter if no password): "
    )
    "C:\Program Files\7-Zip\7z.exe" x "%%F" -o"%%~dpF" -p"!Password!"
    if !errorlevel! neq 0 (
        set /a ArchiveErrors+=1
        if "!Password!"=="" (
            echo Archive does not require a password.
            goto :PasswordLoop
        )
        set "Password="
        set /p "UserInput=Invalid password. Do you want to mark it for removal or keep it? (m/k): "
        if /i "!UserInput!"=="m" (
            echo Marking archive for removal: %%~nxF
            echo Y | del "%%F" > nul
        ) else (
            echo Keeping archive: %%~nxF
            set "KeepFile=%%F"
        )
        goto :PasswordLoop
    )
)

if "!ArchiveFound!"=="0" (
    echo No archives found.
    goto :MoveFiles
)

:: Move remaining archives to the recycling bin
for %%F in (%SourceDir%\*.zip, %SourceDir%\*.rar, %SourceDir%\*.7z, %SourceDir%\*.tar.gz, %SourceDir%\*.jar, %SourceDir%\*.cab, %SourceDir%\*.dmg, %SourceDir%\*.kgb) do (
    if not "%%F"=="!KeepFile!" (
        echo Moving archive to recycling bin: %%~nxF
        PowerShell -Command "[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('%%F', [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs, [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin)"
        if %errorlevel% neq 0 (
            set /a ArchiveErrors+=1
        )
    )
)

:MoveFiles
:: Move all files from subdirectories to the source directory
for /r "%SourceDir%" %%F in (*) do (
    if not "%%~dpF"=="%SourceDir%\" (
        echo Moving file: %%~nxF
        move "%%F" "%SourceDir%"
        if %errorlevel% neq 0 (
            set /a MoveFileErrors+=1
        )
    )
)

:: Check and delete empty subdirectories
set "TempFile=%TEMP%\EmptyDirs.txt"
if exist "%TempFile%" del "%TempFile%"

for /d /r "%SourceDir%" %%D in (*) do (
    if "%%D" neq "%SourceDir%" (
        dir /b "%%D" | findstr "^" >nul || (
            echo Folder to delete: %%D
            echo %%D >> "%TempFile%"
        )
    )
)

if exist "%TempFile%" (
    type "%TempFile%"
    set /p "UserInput=Do you want to delete all these folders? (y/n): "
    if /i "!UserInput!"=="y" (
        for /f "delims=" %%D in ('type "%TempFile%"') do (
            rmdir "%%D"
            if %errorlevel% neq 0 (
                set /a DeleteFolderErrors+=1
            )
        )
    )
    del "%TempFile%"
)

:: Create Pictures subdirectory and move image files
if not exist "%SourceDir%\Pictures" (
    mkdir "%SourceDir%\Pictures"
)
for %%F in ("%SourceDir%\*.jpg", "%SourceDir%\*.jpeg", "%SourceDir%\*.png", "%SourceDir%\*.gif", "%SourceDir%\*.bmp", "%SourceDir%\*.tiff", "%SourceDir%\*.webp", "%SourceDir%\*.psd", "%SourceDir%\*.raw", "%SourceDir%\*.heif", "%SourceDir%\*.indd", "%SourceDir%\*.jpeg2000", "%SourceDir%\*.svg", "%SourceDir%\*.ai", "%SourceDir%\*.eps", "%SourceDir%\*.pdf") do (
    echo Moving image file: %%~nxF
    move "%%F" "%SourceDir%\Pictures"
    if %errorlevel% neq 0 (
        set /a PictureMoveErrors+=1
    )
)

:: Create Videos subdirectory and move video files and subtitles
if not exist "%SourceDir%\Videos" (
    mkdir "%SourceDir%\Videos"
)
for %%F in ("%SourceDir%\*.webm", "%SourceDir%\*.mpg", "%SourceDir%\*.mp2", "%SourceDir%\*.mpeg", "%SourceDir%\*.mpe", "%SourceDir%\*.mpv", "%SourceDir%\*.ogg", "%SourceDir%\*.mp4", "%SourceDir%\*.m4p", "%SourceDir%\*.m4a", "%SourceDir%\*.m4v", "%SourceDir%\*.avi", "%SourceDir%\*.wmv", "%SourceDir%\*.mov", "%SourceDir%\*.qt", "%SourceDir%\*.flv", "%SourceDir%\*.swf", "%SourceDir%\*.srt", "%SourceDir%\*.sbv", "%SourceDir%\*.ssa", "%SourceDir%\*.ttml", "%SourceDir%\*.dfxp", "%SourceDir%\*.vtt", "%SourceDir%\*avchd") do (
    echo Moving video file: %%~nxF
    move "%%F" "%SourceDir%\Videos"
    if %errorlevel% neq 0 (
        set /a VideoMoveErrors+=1
    )
)

:: At the end of your script, add a summary section like this:
echo.
echo ====== Script Summary ======
echo Archive Errors: !ArchiveErrors!
echo File Move Errors: !MoveFileErrors!
echo Folder Deletion Errors: !DeleteFolderErrors!
echo Picture Move Errors: !PictureMoveErrors!
echo Video Move Errors: !VideoMoveErrors!
echo ============================

echo Script completed.
pause
