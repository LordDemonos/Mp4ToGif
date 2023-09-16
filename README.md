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

## GIF Quality Options

When running the `ConvertMp4ToGif.bat` script, you can choose the quality of the generated GIF files. The quality is determined by the scaling factor, which affects the width of the output GIF. Here are the available quality options:

- **320 pixels wide:** This option is suitable for smaller GIFs with a width of 320 pixels. It provides a good balance between file size and quality. Use this for smaller GIFs.

- **480 pixels wide:** Choose this option for medium-sized GIFs with a width of 480 pixels. It offers improved quality and is ideal for medium-sized animations.

- **640 pixels wide:** Select this option for high-quality GIFs with a width of 640 pixels. Use it when you want the best quality and are not concerned about file size.

### Estimated Size Differences

Here's an estimation of the size differences you can expect for the three quality options based on a typical 1-minute video:

| Quality Option      | Approx. GIF Size (MB) |
|---------------------|-----------------------|
| 320 pixels wide     | 6.55                  |
| 480 pixels wide     | 13.1                  |
| 640 pixels wide     | 26.2                  |

Keep in mind that these are approximate values, and the actual size may vary depending on the content of your videos. You can choose the quality option that best suits your needs and preferences.

Feel free to experiment with different quality settings to achieve the desired balance between GIF quality and file size.

## Prerequisite: Installing FFmpeg

Before using the provided batch scripts, you'll need to install FFmpeg, a powerful multimedia framework that allows you to manipulate video and audio files, including converting videos to GIFs. Follow these steps to install FFmpeg:

### Windows Installation

1. **Download FFmpeg:** Visit the official FFmpeg website's [download page](https://www.ffmpeg.org/download.html) and choose the "Windows Builds" section.

2. **Choose a Build:** Select a build that suits your system architecture (32-bit or 64-bit) and download it. If you're unsure, the 64-bit version is a safe choice for most modern Windows systems.

3. **Extract the Archive:** After downloading, extract the contents of the downloaded archive to a directory on your computer.

4. **Add FFmpeg to System Path (Optional):** To use FFmpeg from any command prompt window, you can add the FFmpeg directory to your system's PATH environment variable. To do this, follow these steps:
   
   - Right-click on "This PC" or "My Computer" and select "Properties."
   - Click on "Advanced system settings" on the left sidebar.
   - In the "System Properties" window, click the "Environment Variables" button.
   - Under "System variables," find the "Path" variable and click "Edit."
   - Click "New" and add the path to the directory where you extracted FFmpeg.
   - Click "OK" to save your changes.

5. **Verify Installation:** Open a new command prompt window and type the following command to verify the FFmpeg installation:

   ```bash
   ffmpeg -version

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
