@echo off
setlocal enabledelayedexpansion

:: Prompt the user to enter the directory to start the search
set /p "DIRECTORY=Please enter the directory to search for .mp4 files: "

:: Prompt the user to enter the maximum file size in MB for conversion
set /p "MAX_SIZE_MB=Please enter the maximum file size in MB for conversion (e.g., 20): "

:: Convert the maximum file size to bytes (1MB = 1048576 bytes)
set /a "MAX_SIZE=MAX_SIZE_MB*1048576"

:: Set the default values for quality and frame rate
set "QUALITY_VAL=100"
set "FPS_VAL=30"

:: Iterate over all .mp4 files in the directory and its subdirectories
for /r "%DIRECTORY%" %%F in (*.mp4) do (
    
    :: Get the size of the current file
    for %%A in ("%%F") do set "FILE_SIZE=%%~zA"
    
    :: Check if the file size is less than the maximum size
    if !FILE_SIZE! lss !MAX_SIZE! (
        
        :: Get the full path of the current file without extension
        set "FILE_PATH=%%~dpF"
        set "FILE_NAME=%%~nF"
        
        :: Convert the .mp4 file to PNG frames
        ffmpeg -i "%%F" "!FILE_PATH!!FILE_NAME!frame%%04d.png"

        :: Convert the PNG frames to .gif using Gifski
        gifski --fps !FPS_VAL! --quality !QUALITY_VAL! -o "!FILE_PATH!!FILE_NAME!.gif" "!FILE_PATH!!FILE_NAME!frame"*.png

        :: Remove the PNG frames
        del "!FILE_PATH!!FILE_NAME!frame*.png"
    )
)

:end
endlocal
