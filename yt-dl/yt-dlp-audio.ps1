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

# Проверка, существует ли папка
if (-not (Test-Path $OutputPath)) {
    Write-Output "The specified folder does not exist. Use the default path: $downloads"
    $OutputPath = "$downloads"  # Если нет, использовать путь по умолчанию
}

# Получение URL из буфера обмена
$url = Get-Clipboard

function Wait-ForEnterKey {
    Write-Host "Press Enter key to continue... " -NoNewLine
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

if ($url) {
    # Создание шаблона имени файла с указанным путем
    $outputTemplate = "$OutputPath\%(title).100s.%(ext)s"

    # Загрузка аудио и конвертация в MP3
    & yt-dlp.exe `
        -f "bestaudio" `
        $url `
        -o "$OutputPath\%(title).100s.%(ext)s" `
        -x `
        --audio-format "mp3" `
        --audio-quality "320k" `
        --autonumber-size 3 `
        --embed-thumbnail `
        --add-metadata

    if ($LASTEXITCODE -ne 0) {
        Wait-ForEnterKey
    }
    else {
        Write-Output "------------------------------------"
        Write-Output "The audio file was successfully downloaded and converted to MP3 in the: $OutputPath"
        Write-Output "------------------------------------"
    }
    Set-Clipboard -Value $null
}
else {
    Write-Output "There is no URL on the clipboard, the output."
    Wait-ForEnterKey
}

