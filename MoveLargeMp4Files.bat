@echo off
setlocal enabledelayedexpansion

:: Prompt the user to enter the source directory
set /p "SOURCE_DIRECTORY=Please enter the source directory: "

:: Prompt the user to enter the destination directory
set /p "DESTINATION_DIRECTORY=Please enter the destination directory: "

:: Prompt the user to enter the minimum file size in MB
set /p "MIN_SIZE_MB=Please enter the minimum file size in MB. Script will move every MP4 file equal or larger in size: "

:: Convert the minimum file size to bytes (1MB = 1048576 bytes)
set /a "MIN_SIZE=MIN_SIZE_MB*1048576"

:: Iterate over all .mp4 files in the source directory and its subdirectories
for /r "%SOURCE_DIRECTORY%" %%F in (*.mp4) do (
    :: Get the size of the current file
    for %%A in ("%%F") do set "FILE_SIZE=%%~zA"
    
    :: Check if the file size is greater than or equal to the minimum size
    if !FILE_SIZE! geq !MIN_SIZE! (
        :: Get the relative path starting from the source directory
        set "RELATIVE_PATH=%%~dpF"
        set "RELATIVE_PATH=!RELATIVE_PATH:%SOURCE_DIRECTORY%=!"
        
        :: Create a new variable for the destination directory of the file
        set "FILE_DESTINATION_DIRECTORY=!DESTINATION_DIRECTORY!\!RELATIVE_PATH!"
        
        :: Print the destination directory for debugging
        echo Destination directory: "!DESTINATION_DIRECTORY!"
        
        :: Create the file destination directory if it doesn't exist
        if not exist "!FILE_DESTINATION_DIRECTORY!" (
            mkdir "!FILE_DESTINATION_DIRECTORY!"
        ) else (
            echo Directory already exists
        )
        
        :: Print the source file path for debugging
        echo Source file: "%%F"
        
        :: Move the .mp4 file to the new folder in the relative path in the destination directory
        move "%%F" "!FILE_DESTINATION_DIRECTORY!\%%~nxF"
    )
)

:end
endlocal




