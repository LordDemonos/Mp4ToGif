# Batch File Scripts for Managing Downloaded Files

This collection of batch files facilitates the management of downloaded files and the conversion of MP4 files in various ways. The primary focus is on converting MP4 files to GIF format, complemented by scripts to relocate large MP4 files and to remove MP4 files at the user's discretion.

## FileOrganizer.bat

### Description

FileOrganizer.bat is a comprehensive batch script designed to streamline file organization in a Windows environment. It conducts a series of operations, including archive extraction, file relocation, and categorization into designated folders based on file types, allowing user interaction at various stages for a controlled and customizable process.

### Features

- **Prompt for Source Directory**: Enables the user to designate the source directory for operations.

### Archive File Extraction

- Identifies common archive files (zip, rar, 7z, tar.gz, jar, cab, dmg, kgb) in the source directory and its subdirectories.
- Extracts the contents of identified archives in-place using 7-Zip.
- Manages password-protected archives by requesting the user's password input.
- Provides options to retain or remove the archive in case of incorrect password input.
- Relocates remaining archives to the recycling bin, excluding those marked for retention.

### File and Folder Organization

- Transfers all files from subdirectories to the source directory.
- Identifies and removes empty subdirectories with user consent.
- Categorizes image files (jpg, jpeg, png, gif, bmp, tiff, webp, psd, raw, heif, indd, jpeg2000, svg, ai, eps, pdf) into a "Pictures" subdirectory.
- Categorizes video files (webm, mpg, mp2, mpeg, mpe, mpv, ogg, mp4, m4p, m4v, m4a, avi, wmv, mov, qt, flv, swf, srt, sbv, ssa, ttml, dfxp, vtt, avchd) into a "Videos" subdirectory.
- Facilitates user interaction at various stages for a controlled organization process.
- Implements efficient error handling to ensure smooth operation, even with password-protected archives.

## Prerequisites

Before utilizing the FileOrganizer.bat script, ensure your system meets the following prerequisites:

### 1. 7-Zip

The script leverages 7-Zip, a file archiver with a high compression ratio, to handle various archive file formats. Follow these steps to install and configure 7-Zip:

- **Download**: Visit the [7-Zip Official Website](https://www.7-zip.org/) to download the latest version.
- **Installation**: Follow the installation wizard to install 7-Zip. By default, it installs in the C:\Program Files\7-Zip\ directory.
- **Script Configuration**: Adjust the script to match the 7-Zip installation directory. If installed in a different directory, update the script with the correct path. The relevant line in the script is:
  ```batch
  "C:\Program Files\7-Zip\7z.exe" x "%%F" -o"%%~dpF" -p"!Password!"
  ```

### 2. Windows Environment

The FileOrganizer.bat script operates exclusively on Windows systems. Ensure you have administrative privileges to execute batch scripts and manage files on your system.

### 3. Data Backup

Prior to running the script, it is strongly recommended to backup your data to prevent potential data loss.

### 4. Script Testing

Test the script with non-critical data before using it on important data to ensure its functionality and to acquaint yourself with its operations.

### Usage

Execute the script by either double-clicking on FileOrganizer.bat or running it from the command prompt. Follow the prompts to specify the source directory and provide necessary inputs during the script execution. Monitor the command prompt window for detailed information on the operations being performed and to provide inputs where necessary.

## ConvertMp4ToGif.bat

### Use Case

This script is crafted to convert MP4 files to GIF format. It enables users to specify a directory where it will search for MP4 files (including subdirectories) and convert them to GIF format if they are below a specified size limit.

### Approximation of GIF File Size

Understanding the approximate size of the resulting GIF files is beneficial before using the script. Here is a chart that provides an estimation:

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

### Estimated Size Differences

Here's an estimation of the size differences you can expect for the five quality options based on a typical 1-minute video:

```
| Quality Option            | Approx. GIF Size (MB) |
| ------------------------- | --------------------- |
| 320 pixels wide           | 6.55                  |
| 480 pixels wide           | 13.1                  |
| 640 pixels wide (default) | 26.2                  |
| 800 pixels wide           | 52.4                  |
| 1024 pixels wide          | 83.8                  |
```

Consider that these are approximate values, and the actual size may vary depending on the video content. Choose the quality option that best aligns with your needs and preferences.

Feel free to experiment with different quality settings to find the optimal balance between GIF quality and file size.

### Prerequisite: Installing FFmpeg

Before utilizing the batch scripts provided, ensure to install FFmpeg, a versatile multimedia framework that facilitates the manipulation of video and audio files, including video to GIF conversions. Follow these steps to install FFmpeg:

### Windows Installation

- Download FFmpeg: Visit the official FFmpeg website's download page and select the "Windows Builds" section.
- Choose a Build: Select a build compatible with your system architecture (32-bit or 64-bit) and download it. If uncertain, the 64-bit version is a safe choice for most modern Windows systems.
- Extract the Archive: After downloading, extract the archive contents to a directory on your computer.
- Add FFmpeg to System Path (Optional): To use FFmpeg from any command prompt window, add the FFmpeg directory to your system's PATH environment variable by following these steps:
- Right-click on "This PC" or "My Computer" and select "Properties."
- Click on "Advanced system settings" on the left sidebar.
- In the "System Properties" window, click the "Environment Variables" button.
- Under "System variables," find the "Path" variable and click "Edit."
- Click "New" and add the path to the directory where you extracted FFmpeg.
- Click "OK" to save your changes.

### Verify Installation: Open a new command prompt window and type the following command to verify the FFmpeg installation:

```batch
ffmpeg -version
```

### Instructions

- Open the Command Prompt as an administrator.
- Navigate to the script's location using the cd command.
- Execute the script with the command: ConvertMp4ToGif.bat.
- Follow the prompts to specify the directory for the search and the minimum file size in MB for conversion.

## MoveLargeMp4Files.bat

### Use Case

This script is devised to relocate MP4 files from a specified directory (including subdirectories) to another directory if they meet or exceed the user-defined minimum size. It preserves the organization based on a unique identifier in the directory structure, creating a new folder in the destination directory named after the second deepest subfolder in the source directory, and moves the MP4 files into this new folder.

### Instructions

- Open the Command Prompt as an administrator.
- Navigate to the script's location using the cd command.
- Execute the script with the command: MoveLargeMp4Files.bat.
- Follow the prompts to specify the source and destination directories, as well as the minimum file size in MB.

## DeleteMp4Files.bat

### Use Case

This script is crafted to remove MP4 files from a specified directory (including subdirectories) based on user criteria. Users can define the minimum file size to retain or opt to remove all MP4 files in the directory.

### Instructions

- Open the Command Prompt as an administrator.
- Navigate to the script's location using the cd command.
- Execute the script with the command: DeleteMp4Files.bat.
- Follow the prompts to specify the directory for .mp4 file search and determine the file size criteria. Options include deleting files larger, smaller, or equal to the specified size, or removing all .mp4 files.
