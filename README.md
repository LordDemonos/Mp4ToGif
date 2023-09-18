# Batch File Scripts for Managing Downloaded Files

This suite of batch files is designed to streamline the management of a large volume of downloaded files, typically accumulated through tools like JDownloader2 or RipMe2. Initially, the `FileOrganizer.bat` sifts through the clutter, segregating files into distinct 'Videos' and 'Pictures' folders, thus setting the stage for further file manipulations. Following this, the `ConvertMp4ToGif.bat` comes into play, transforming manageable MP4 files into GIF format for seamless integration into slideshow viewers like XnView MP. Lastly, the `MoveLargeMp4Files.bat` and `DeleteMp4Files.bat` grant users the discretion to either archive substantial MP4 files for future reference or purge smaller, now redundant, MP4 files, maintaining a clean and organized directory.

## Table of Contents

- [Batch File Scripts for Managing Downloaded Files](#batch-file-scripts-for-managing-downloaded-files)
  - [FileOrganizer.bat](#fileorganizerbat)
    - [Description](#description)
    - [Features](#features)
      - [Archive File Extraction](#archive-file-extraction)
      - [File and Folder Organization](#file-and-folder-organization)
  - [Prerequisites](#prerequisites)
    - [1. 7-Zip](#1-7-zip)
    - [2. Windows Environment](#2-windows-environment)
    - [3. Data Backup](#3-data-backup)
    - [4. Script Testing](#4-script-testing)
    - [Usage](#usage)
  - [ConvertMp4ToGif.bat](#convertmp4togifbat)
    - [Use Case](#use-case)
    - [Approximation of GIF File Size](#approximation-of-gif-file-size)
    - [Estimated Size Differences](#estimated-size-differences)
    - [OpenGL Support](#opengl-support)
    - [Enhanced Error Handling](#enhanced-error-handling)
    - [Conversion Summary](#conversion-summary)
  - [Prerequisite: Installing FFmpeg](#prerequisite-installing-ffmpeg)
    - [Windows Installation](#windows-installation)
    - [Instructions](#instructions)
  - [ConvertMp4ToHQGif.bat](#convertmp4tohqgifbat)
    - [Use Case](#use-case-1)
    - [Prerequisite: Installing Gifski CLI](#prerequisite-installing-gifski-cli)
      - [Step 1: Download and Install Gifski](#step-1-download-and-install-gifski)
      - [Step 2: Add Gifski to the Environment Variables](#step-2-add-gifski-to-the-environment-variables)
      - [Step 3: Verify the Installation](#step-3-verify-the-installation)
    - [Instructions](#instructions-1)
  - [MoveLargeMp4Files.bat](#movelargemp4filesbat)
    - [Use Case](#use-case-2)
    - [Instructions](#instructions-2)
  - [DeleteMp4Files.bat](#deletemp4filesbat)
    - [Use Case](#use-case-3)
    - [Instructions](#instructions-3)

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
- Categorizes video and subtitle files (webm, mpg, mp2, mpeg, mpe, mpv, ogg, mp4, m4p, m4v, m4a, avi, wmv, mov, qt, flv, swf, srt, sbv, ssa, ttml, dfxp, vtt, avchd) into a "Videos" subdirectory.
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

#### OpenGL Support

The `ConvertMp4ToGif.bat` and `ConvertMp4ToHQGif.bat` scripts have been upgraded to support OpenGL acceleration, which can potentially speed up the conversion process. To make use of this feature, ensure that your system supports OpenGL and that the necessary drivers are up-to-date.

#### Enhanced Error Handling

We have implemented robust error handling mechanisms to ensure the scripts run smoothly even when encountering issues during the conversion process. The scripts are now equipped to identify and report errors more effectively, allowing for a smoother user experience.

#### Conversion Summary

At the end of the conversion process, the scripts will now provide a detailed summary that includes the following information:

1. **Number of Files Created:** A count of the new GIF files that have been created during the current session.
2. **Total Size of New GIFs:** The cumulative file size of the newly created GIFs, helping you to manage your storage space more effectively.
3. **Error Summary:** A concise report of any errors encountered during the conversion process, along with suggestions for potential resolutions.

This summary aims to give you a comprehensive overview of the conversion session, helping you to track the progress and manage your files more efficiently.

## Prerequisite: Installing FFmpeg

Before utilizing the provided batch scripts, you'll need to install FFmpeg, a powerful multimedia framework that facilitates the manipulation of video and audio files, including the conversion of videos to GIFs. Here are the steps to install FFmpeg:

### Windows Installation

1. **Download FFmpeg:** Visit the [FFmpeg Official Website](https://www.ffmpeg.org/download.html) to download the latest version. Choose the "Windows Builds" section to find the appropriate build for your system.

2. **Choose a Build:** Select a build that suits your system architecture (32-bit or 64-bit) and download it. If you're unsure, the 64-bit version is a safe choice for most modern Windows systems.

3. **Extract the Archive:** After downloading, extract the contents of the downloaded archive to a directory on your computer.

4. **Add FFmpeg to System Path (Optional):** To use FFmpeg from any command prompt window, you can add the FFmpeg directory to your system's PATH environment variable. Follow these steps to do so:

   - Right-click on "This PC" or "My Computer" and select "Properties."
   - Click on "Advanced system settings" on the left sidebar.
   - In the "System Properties" window, click the "Environment Variables" button.
   - Under "System variables," find the "Path" variable and click "Edit."
   - Click "New" and add the path to the directory where you extracted FFmpeg.
   - Click "OK" to save your changes.

5. **Verify Installation:** To confirm that FFmpeg has been installed successfully, open a new command prompt window and type the following command:

   ```bash
   ffmpeg -version
   ```

### Instructions

- Open the Command Prompt as an administrator.
- Navigate to the script's location using the cd command.
- Execute the script with the command: ConvertMp4ToGif.bat.
- Follow the prompts to specify the directory for the search and the minimum file size in MB for conversion.

## ConvertMp4ToHQGif.bat

### Use Case

This script leverages the capabilities of [Gifski](https://gif.ski/), a high-quality GIF encoder, to convert MP4 files to high-quality GIFs. Gifski utilizes pngquant's features to create efficient cross-frame palettes and temporal dithering, allowing for the production of GIFs with thousands of colors per frame. It also offers functionalities to resize animations and adjust compression levels. This script is configured to enforce maximum quality settings, resulting in larger file sizes for the generated GIFs. Users should monitor the file size of the resulting GIFs closely to manage storage effectively.

**Note:** This script requires both Gifski and FFmpeg to function correctly. Please ensure that you have followed the [FFmpeg installation instructions](#prerequisite-installing-ffmpeg) provided earlier in this README before using `ConvertMp4ToHQGif.bat`.

### Prerequisite: Installing Gifski CLI

#### Step 1: Download and Install Gifski

- Visit the [Gifski website](https://gif.ski/) to download the latest version of the Gifski command-line tool (CLI).
- Extract the downloaded file to a preferred location on your computer (e.g., `C:\Gifski\`).

#### Step 2: Add Gifski to the Environment Variables

- Right-click on "This PC" or "My Computer" on your desktop or in File Explorer, and select "Properties".
- Click on "Advanced system settings" on the left sidebar.
- In the System Properties window, click on the "Environment Variables..." button near the bottom right.
- Under the "System variables" section, find and select the "Path" variable, then click on the "Edit..." button.
- Click on the "New" button and paste the path to the folder where you extracted Gifski (e.g., `C:\Gifski\`).
- Click "OK" to close each of the windows.

#### Step 3: Verify the Installation

- Open a new command prompt (type `cmd` in the Windows search bar and press Enter).
- Type `gifski -h` and press Enter. This command should display the help information for Gifski, indicating that it has been successfully added to the system path.

### Instructions

1. Open the Command Prompt as an administrator.
2. Navigate to the directory where the script is located using the `cd` command.
3. Run the script using the command: `ConvertMp4ToHQGif.bat`.
4. Follow the prompts to specify the directory for the search and the minimum file size in MB for conversion. Note that this script enforces maximum quality settings, resulting in larger GIF file sizes.

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
