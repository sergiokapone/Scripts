@echo off
::chcp 65001
REM runtime variables parsing
Setlocal EnableDelayedExpansion
REM path;cli;app


:: Downloading Video from Internet into %downloads% via URL in the Clipboard
:: Notes:
:: ffmpeg and ffprobe required for merging separate video and audio files
::                    as well as for various post-processing tasks
:: for correct function put yt-dlp and ffmpeg executables next to .cmd or in %path%
:: Downloads:
:: yt-dlp Builds -- https://github.com/yt-dlp/yt-dlp/releases
:: ffmpeg Builds -- https://github.com/yt-dlp/FFmpeg-Builds/releases

:: Locate %downloads% folder
for /f "tokens=2,*" %%c in (
'reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v {374DE290-123F-4565-9164-39C4925E467B}'
) do set downloads=%%d

:: Get url from the clipboard
for /f "delims=" %%i in ('powershell -command "Get-Clipboard"') do set url=%%i

if ERRORLEVEL 1 (goto ERROR) else (goto OK)

:ERROR
echo.
:: if there's no url wait 7 seconds then exit
@echo there's no url in the clipboard, exiting
ping -n 8 ::1 >nul
exit/b

:OK
yt-dlp.exe -f "b" "%url%" --autonumber-size 3  -P %~1 -o "%%(autonumber)s - %%(title).100s.%%(ext)s" ::--no-part
echo ------------------------------------
echo Downloaded in %~1
echo ------------------------------------

exit/b
