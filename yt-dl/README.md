# YouTube Downloader Scripts with Context Menu Integration

This repository contains PowerShell scripts and a registry file to simplify downloading video and audio from YouTube or other platforms supported by [yt-dlp](https://github.com/yt-dlp/yt-dlp). The scripts support seamless integration into the Windows context menu for quick access.

## Features

- **Video Downloader (`yt-dlp.ps1`)**  
  Downloads the best available video and audio and merges them into a single `.mkv` file.

- **Audio Downloader (`yt-dlp-audio.ps1`)**  
  Downloads the best available audio, converts it to `.mp3` format with embedded metadata and thumbnails.

- **Context Menu Integration (`youtube-dlp.reg`)**  
  Adds options to the Windows context menu for downloading video or audio directly from a clipboard URL.

## Prerequisites

1. **yt-dlp**: Download the latest version from [yt-dlp releases](https://github.com/yt-dlp/yt-dlp/releases).  
2. **ffmpeg**: Required for merging video and audio files. Download from [FFmpeg Builds](https://www.gyan.dev/ffmpeg/builds/).  
3. **PowerShell**: Ensure you have PowerShell installed on your system (default on Windows 10 and later).  
4. **Administrator Rights**: Required for registry modifications to enable the context menu.

## Setup Instructions

1. **Place Executables**  
   Ensure `yt-dlp.exe` and `ffmpeg.exe` are either:
   - Located in the same folder as the `.ps1` scripts.
   - Added to your system's `%PATH%`.

2. **Edit Script Paths**  
   - Update the paths in the `youtube-dlp.reg` file to match the location of your `yt-dlp.ps1` and `yt-dlp-audio.ps1` scripts.

3. **Apply Registry Changes**  
   Run `youtube-dlp.reg` by double-clicking it or using the command:

   ```powershell
   regedit.exe youtube-dlp.reg
   ```

## Usage

### Context Menu Options

- **Download Video**  
  Right-click on a folder in File Explorer, and select **"Скачать видео по ссылке из буфера"**.  
  This will download the video corresponding to the URL currently in your clipboard to the selected folder.

- **Download Audio**  
  Right-click on a folder in File Explorer, and select **"Скачать аудио по ссылке из буфера"**.  
  This will download and convert the audio to `.mp3`, saving it in the selected folder.

### Running Scripts Directly

You can also run the scripts directly from PowerShell. For example:

```powershell
powershell -ExecutionPolicy Bypass -File "path\to\yt-dlp.ps1" "output\path"
powershell -ExecutionPolicy Bypass -File "path\to\yt-dlp-audio.ps1" -OutputPath "output\path"
```

### Running Script with Total commander Buttons

If you want to use scripts as buttons, copy the text of the button and paste it into the panel.

To download the video:

```text
TOTALCMD#BAR#DATA
powershell -ExecutionPolicy Bypass -File %Utility%\yt-dl\yt-dlp-video.ps1
"%P\"
%Utility%\yt-dl\yt-dlp.exe
Download VIDEO from Youtube (from buffer)
.

-1

```

To download the audio:

```text
TOTALCMD#BAR#DATA
powershell -ExecutionPolicy Bypass -File %Utility%\yt-dl\yt-dlp-audio.ps1
"%P\"
%Utility%\yt-dl\yt-dlp.exe
Скачать AUDIO с Youtube (from buffer)
.

-1

```

As always, replace the appropriate script file paths with your own.

## Notes

- Ensure the URL is copied to your clipboard before using the scripts.  
- The scripts automatically clear the clipboard after processing the URL.  
- If an error occurs, the script will wait for user input before exiting.

## Example Output Structure

- **Video Downloads**:  
  `[001 - Video Title.mkv]`  
  Includes the video title, up to 100 characters, and ensures files are numbered sequentially.

- **Audio Downloads**:  
  `[Song Title.mp3]`  
  Includes metadata (artist, album, etc.) and an embedded thumbnail, if available.

## License

These scripts are provided under the MIT License. See the `LICENSE` file for details.
