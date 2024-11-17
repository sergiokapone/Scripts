# Путь к сохранению изображения
$outputPath = Join-Path -Path (Get-Location) -ChildPath "clipboard_image.png"

# Проверка на существование файла и добавление префикса, если файл уже существует
$counter = 1
while (Test-Path $outputPath) {
    $outputPath = Join-Path -Path (Get-Location) -ChildPath ("clipboard_image_$counter.png")
    $counter++
}

# Добавляем тип для работы с буфером обмена
Add-Type -AssemblyName System.Windows.Forms

# Проверяем, есть ли изображение в буфере обмена
if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
    # Сохранение изображения из буфера обмена
    $image = [System.Windows.Forms.Clipboard]::GetImage()
    $image.Save($outputPath)

    Write-Host "-1- Изображение успешно сохранено в файл: $outputPath"
} else {
    Write-Host "-0- Буфер обмена пуст или не содержит изображения."
}

