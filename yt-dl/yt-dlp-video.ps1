# Downloading Video from Internet into %downloads% via URL in the Clipboard
# Notes:
# ffmpeg and ffprobe required for merging separate video and audio files
#                    as well as for various post-processing tasks
# for correct function put yt-dlp and ffmpeg executables next to .ps1 or in %path%
# Downloads:
# yt-dlp Builds -- https://github.com/yt-dlp/yt-dlp/releases
# ffmpeg Builds -- https://github.com/yt-dlp/FFmpeg-Builds/releases

param (
    [string]$OutputPath
)

$downloads = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders').{ 374DE290-123F-4565-9164-39C4925E467B }

Write-Host "Start downloading a VIDEO file" -ForegroundColor Green


# Проверка, существует ли папка
if (-not (Test-Path $OutputPath)) {
    Write-Host "The specified folder does not exist. Use the default path: $downloads" -ForegroundColor Red
    $OutputPath = "$downloads"  # Если нет, использовать путь по умолчанию
}

# Get url from the clipboard
$url = Get-Clipboard

function Wait-ForEnterKey {
    Write-Host "Press Enter key to continue... " -NoNewLine
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

if ($url) {
    & yt-dlp.exe `
        -f "bestvideo+bestaudio/best" `
        $url `
        --autonumber-size 3 `
        -o "$OutputPath\%(autonumber)s - %(title).100s.%(ext)s" `
        --write-url-link `
        --merge-output-format mkv

    if ($LASTEXITCODE -ne 0) {
        Wait-ForEnterKey
    }
    else {
        Write-Host "------------------------------------"
        Write-Host "Downloaded in $OutputPath" -ForegroundColor Green
        Write-Host "------------------------------------"
    }
    Start-Sleep -Seconds 1
    Set-Clipboard -Value $null
}
else {
    Write-Host "There's no URL in the clipboard, exiting" -ForegroundColor Red
    Wait-ForEnterKey
}

