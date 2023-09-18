@echo off
setlocal enabledelayedexpansion

:: Initialize variables
set "ERROR_COUNT=0"
set "FILE_COUNT=0"
set "TOTAL_SIZE=0"

:: Create a log file
set "LOG_FILE=ConversionLog.txt"
if exist "%LOG_FILE%" del "%LOG_FILE%"

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
        set "FILE_EXT=%%~xF"
        set "ORIGINAL_FILE_NAME=%%~nxF"

                :: Create a temporary file name
        set "TEMP_FILE_NAME=TempFile_!RANDOM!!RANDOM!"

        :: Extract the original file name without extension
        for %%A in ("%%F") do set "ORIGINAL_FILE_NAME=%%~nA"

        :: Convert the .mp4 file to PNG frames
        ffmpeg -i "%%F" "!FILE_PATH!!ORIGINAL_FILE_NAME!_frame%%04d.png" 2>> "!FILE_PATH!error.log"
        IF !ERRORLEVEL! NEQ 0 (
            echo An error occurred during FFmpeg conversion: %%F >> "%LOG_FILE%"
            type "!FILE_PATH!error.log" >> "%LOG_FILE%"
            set /a "ERROR_COUNT+=1"
            goto :cleanup
        )

        :: Check if at least one PNG frame was created successfully
        IF NOT EXIST "!FILE_PATH!!ORIGINAL_FILE_NAME!_frame0001.png" (
            echo No frames created during FFmpeg conversion: %%F >> "%LOG_FILE%"
            type "!FILE_PATH!error.log" >> "%LOG_FILE%"
            set /a "ERROR_COUNT+=1"
            goto :cleanup
        )

:: Convert the PNG frames to .gif using Gifski
set "GIF_NAME=!FILE_NAME!.gif"
set "GIF_PATH=!FILE_PATH!!ORIGINAL_FILE_NAME!.gif"
set "GIF_PATH=!GIF_PATH:\\?\UNC\=\\!"
gifski --fps !FPS_VAL! --quality !QUALITY_VAL! -o "!GIF_PATH!" "!FILE_PATH!!ORIGINAL_FILE_NAME!_frame"*.png 2>> "!FILE_PATH!error.log" >nul
IF !ERRORLEVEL! NEQ 0 (
    echo An error occurred during Gifski conversion: %%F >> "%LOG_FILE%"
    type "!FILE_PATH!error.log" >> "%LOG_FILE%"
    set /a "ERROR_COUNT+=1"
    goto :cleanup
)
echo gifski created !GIF_NAME!

        :: After creating the GIF, get its size in bytes and add it to the total
        for %%G in ("!FILE_PATH!!ORIGINAL_FILE_NAME!.gif") do set /a "TOTAL_SIZE+=%%~zG"

        :: Increment the file count
        set /a "FILE_COUNT+=1"

        :: Cleanup section
:cleanup
:: Add a small delay before attempting to delete the PNG frames
timeout /t 1 /nobreak >nul

:: Remove the PNG frames
del "!FILE_PATH!!ORIGINAL_FILE_NAME!_frame*.png"


        :: Rename the file back to its original name
        IF EXIST "!FILE_PATH!!TEMP_FILE_NAME!!FILE_EXT!" (
            ren "!FILE_PATH!!TEMP_FILE_NAME!!FILE_EXT!" "!ORIGINAL_FILE_NAME!"
        ) ELSE (
            echo Could not find temporary file to rename back: "!FILE_PATH!!TEMP_FILE_NAME!!FILE_EXT!" >> "%LOG_FILE%"
        )
    )
)

:: Convert the total size to gigabytes (1GB = 1073741824 bytes) and megabytes (1MB = 1048576 bytes)
set /a "TOTAL_SIZE_GB=TOTAL_SIZE/1073741824"
set /a "TOTAL_SIZE_MB=(TOTAL_SIZE%%1073741824)/1048576"

:: Display a summary at the end
echo.
echo Script completed.
IF %TOTAL_SIZE_GB% GTR 0 (
    echo Processed !FILE_COUNT! files totalling !TOTAL_SIZE_GB!.!TOTAL_SIZE_MB! GB with !ERROR_COUNT! errors.
) ELSE (
    echo Processed !FILE_COUNT! files totalling !TOTAL_SIZE_MB! MB with !ERROR_COUNT! errors.
)
echo Detailed log can be found in ConversionLog.txt
pause

:end
endlocal
