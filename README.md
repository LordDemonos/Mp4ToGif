# Batch File Scripts for Managing MP4 Files

This collection of batch files assists in managing and converting MP4 files in various ways. The primary focus is on converting MP4 files to GIF format, followed by scripts to move large MP4 files and to delete MP4 files as per user discretion.

## ConvertMp4ToGif.bat

### Use Case
This script is designed to convert MP4 files to GIF format. It allows users to specify a directory where it will search for MP4 files (including subdirectories) and convert them to GIF format if they are below a specified size limit.

### Approximation of GIF File Size
Before using the script, it's beneficial to understand the approximate size of the resulting GIF files. Here is a chart that provides an estimation:

```
MP4 File Size (MB) | Approx. Duration (sec) | Estimated GIF Size (MB) | Estimated GIF Size (Bytes)
-------------------|------------------------|-------------------------|------------------------------
5                  | 60 (1 minute)          | 6.55                    | 6,871,449 bytes
10                 | 120 (2 minutes)        | 13.1                    | 13,742,898 bytes
15                 | 180 (3 minutes)        | 19.65                   | 20,614,347 bytes
20                 | 240 (4 minutes)        | 26.2                    | 27,485,796 bytes
60                 | 720 (12 minutes)       | 78.6                    | 82,457,388 bytes
100                | 1200 (20 minutes)      | 131                     | 137,428,976 bytes
150                | 1800 (30 minutes)      | 196.5                   | 206,143,472 bytes
```

### Instructions
1. Open Command Prompt as an administrator.
2. Navigate to the directory where the script is located using the `cd` command.
3. Run the script using the command: `ConvertMp4ToGif.bat`.
4. Follow the prompts to enter the directory to start the search and the minimum file size in MB for conversion.

## MoveLargeMp4Files.bat

### Use Case
This script is intended to move MP4 files from a specified directory (including subdirectories) to another directory if they are equal to or larger in size than the user-specified minimum size. It maintains the organization based on a unique identifier in the directory structure. The script creates a new folder in the destination directory with the name of the second deepest subfolder in the source directory and moves the MP4 files into this new folder.

### Instructions
1. Open Command Prompt as an administrator.
2. Navigate to the directory where the script is located using the `cd` command.
3. Run the script using the command: `MoveLargeMp4Files.bat`.
4. Follow the prompts to enter the source and destination directories, as well as the minimum file size in MB.

## DeleteMp4Files.bat

### Use Case
This script is designed to delete MP4 files from a specified directory (including subdirectories) based on user criteria. Users can specify the minimum file size to retain or delete all MP4 files in the directory.

### Instructions
1. Open Command Prompt as an administrator.
2. Navigate to the directory where the script is located using the `cd` command.
3. Run the script using the command: `DeleteMp4Files.bat`.
4. Follow the prompts to enter the directory to search for .mp4 files and specify the file size criteria. You can choose to delete files larger, smaller, or equal to the specified size, or delete all .mp4 files.
