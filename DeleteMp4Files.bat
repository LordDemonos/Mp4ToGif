@echo off
setlocal

:: Prompt the user to enter the directory to search for .mp4 files
set /p "DIRECTORY=Please enter the directory to search for .mp4 files: "

:: Prompt the user to enter the file size criteria
set /p "FILE_SIZE_CRITERIA=Please enter the file size in MB to consider (enter 'all' to target all files): "

:: If the user entered a number, convert it to bytes
if not "%FILE_SIZE_CRITERIA%"=="all" (
    set /a "FILE_SIZE_CRITERIA_BYTES=FILE_SIZE_CRITERIA*1048576"
)

:: Prompt the user to specify whether to delete files larger or smaller than the specified size
if not "%FILE_SIZE_CRITERIA%"=="all" (
    set /p "SIZE_OPTION=Do you want to delete files larger or smaller than the specified size? (enter 'larger' or 'smaller') You will be shown a list of files and prompted one final time before deletion occurrs.: "
)

:: List all .mp4 files in the directory and its subdirectories
echo List of .mp4 files found:
for /r "%DIRECTORY%" %%F in (*.mp4) do (
    :: Get the size of the current file
    for %%A in ("%%F") do set "FILE_SIZE=%%~zA"
    
    :: Check the file size criteria and list the file
    if "%FILE_SIZE_CRITERIA%"=="all" (
        echo %%F
    ) else if "%SIZE_OPTION%"=="larger" (
        if !FILE_SIZE! gtr !FILE_SIZE_CRITERIA_BYTES! (
            echo %%F
        )
    ) else if "%SIZE_OPTION%"=="smaller" (
        if !FILE_SIZE! lss !FILE_SIZE_CRITERIA_BYTES! (
            echo %%F
        )
    )
)

:: Ask the user for confirmation before deleting the files
set /p "CONFIRM=Do you want to delete all listed files? (yes/no): "

if /i "%CONFIRM%" equ "yes" (
    for /r "%DIRECTORY%" %%F in (*.mp4) do (
        :: Get the size of the current file
        for %%A in ("%%F") do set "FILE_SIZE=%%~zA"
        
        :: Check the file size criteria and delete the file
        if "%FILE_SIZE_CRITERIA%"=="all" (
            del "%%F"
        ) else if "%SIZE_OPTION%"=="larger" (
            if !FILE_SIZE! gtr !FILE_SIZE_CRITERIA_BYTES! (
                del "%%F"
            )
        ) else if "%SIZE_OPTION%"=="smaller" (
            if !FILE_SIZE! lss !FILE_SIZE_CRITERIA_BYTES! (
                del "%%F"
            )
        )
    )
    echo All listed files have been deleted.
) else (
    echo Operation cancelled by the user.
)

:end
endlocal

