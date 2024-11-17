param (
    [string]$OutputPath = "$env:USERPROFILE\Downloads"  # Путь по умолчанию
)

# Проверка, существует ли папка
if (-not (Test-Path $OutputPath)) {
    Write-Output "Указанная папка не существует. Используйте путь по умолчанию: $env:USERPROFILE\Downloads"
    $OutputPath = "$env:USERPROFILE\Downloads"  # Если нет, использовать путь по умолчанию
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
    & yt-dlp.exe -f "bestaudio" $url --autonumber-size 3 -o $outputTemplate -x --audio-format mp3 --audio-quality 3202K --embed-thumbnail --add-metadata

    if ($LASTEXITCODE -ne 0) {
        Wait-ForEnterKey
    }
    else {
        Write-Output "------------------------------------"
        Write-Output "Аудиофайл успешно загружен и конвертирован в MP3 в: $OutputPath"
        Write-Output "------------------------------------"
    }
    Set-Clipboard -Value $null
}
else {
    Write-Output "В буфере обмена нет URL, выход."
    Wait-ForEnterKey
}

