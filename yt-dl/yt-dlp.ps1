# Downloading Video from Internet into %downloads% via URL in the Clipboard
# Notes:
# ffmpeg and ffprobe required for merging separate video and audio files
#                    as well as for various post-processing tasks
# for correct function put yt-dlp and ffmpeg executables next to .ps1 or in %path%
# Downloads:
# yt-dlp Builds -- https://github.com/yt-dlp/yt-dlp/releases
# ffmpeg Builds -- https://github.com/yt-dlp/FFmpeg-Builds/releases

# Locate %downloads% folder
$downloads = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders').{ 374DE290-123F-4565-9164-39C4925E467B }

# Get url from the clipboard
$url = Get-Clipboard

function Wait-ForEnterKey {
    Write-Host "Press Enter key to continue... " -NoNewLine
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

if ($url) {
    & yt-dlp.exe -f "bestvideo+bestaudio/best" $url --autonumber-size 3 -P $args[0] -o "%(autonumber)s - %(title).100s.%(ext)s" --write-url-link --merge-output-format mkv
    if ($LASTEXITCODE -ne 0) {
        Wait-ForEnterKey
    }
    else {
        Write-Output "------------------------------------"
        Write-Output "Downloaded in $args"
        Write-Output "------------------------------------"
    }
    Set-Clipboard -Value $null
}
else {
    Write-Output "There's no URL in the clipboard, exiting"
    Wait-ForEnterKey
}

