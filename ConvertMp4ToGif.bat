@echo off
setlocal enabledelayedexpansion

:: Prompt the user to enter the directory to start the search
set /p "DIRECTORY=Please enter the directory to search for .mp4 files: "

:: Prompt the user to enter the maximum file size in MB for conversion
set /p "MAX_SIZE_MB=Please enter the maximum file size in MB for conversion (e.g., 20): "

:: Prompt the user to select GIF quality
echo Select GIF quality:
echo 1. 320px
echo 2. 480px
echo 3. 640px (default)
echo 4. 800px
echo 5. 1024px
set /p "QUALITY=Enter the number corresponding to the desired quality: "

:: Convert the maximum file size to bytes (1MB = 1048576 bytes)
set /a "MAX_SIZE=MAX_SIZE_MB*1048576"

:: Set the default scale value to 320
set "SCALE=320"

:: Update the scale value based on user's choice
if %QUALITY% == 1 set "SCALE=320"
if %QUALITY% == 2 set "SCALE=480"
if %QUALITY% == 4 set "SCALE=800"
if %QUALITY% == 5 set "SCALE=1024"

:: The for /r command is used to iterate over all .mp4 files in the specified directory and its subdirectories.
:: Iterate over all .mp4 files in the directory and its subdirectories
for /r "%DIRECTORY%" %%F in (*.mp4) do (
    
    :: The %%~zA modifier is used to get the size of the current file in bytes.
    :: Get the size of the current file
    for %%A in ("%%F") do set "FILE_SIZE=%%~zA"
    
    :: Check if the file size is less than the maximum size
    if !FILE_SIZE! lss !MAX_SIZE! (
        :: The %%~dpF and %%~nF modifiers are used to get the full path and name of the current file without the extension, respectively.
        :: Get the full path of the current file without extension
        set "FILE_PATH=%%~dpF"
        set "FILE_NAME=%%~nF"
        
        :: Convert the .mp4 file to .gif with the selected quality
        ffmpeg -i "%%F" -vf "fps=10,scale=!SCALE!:-1" -c:v gif "!FILE_PATH!!FILE_NAME!.gif"
    )
)

:end
endlocal




