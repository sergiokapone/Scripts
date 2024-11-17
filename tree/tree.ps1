param(
    [string]$Path = ".",
    [string]$SortBy = "ext"  # 'name' или 'ext' (по расширению файлов)
)

function Get-Tree {
    param (
        [string]$Path,
        [string]$Prefix = "",
        [string]$SubPrefix = "",
        [switch]$IsLast
    )

    # Получаем список файлов и директорий, исключая ненужные
    $Items = Get-ChildItem -LiteralPath $Path | Where-Object { $_.Name -notin ".venv", "__pycache__", ".git" }

    # Разделяем на директории и файлы
    $Directories = $Items | Where-Object { $_.PSIsContainer } | Sort-Object Name  # Директории всегда сортируются по имени
    $Files = $Items | Where-Object { -not $_.PSIsContainer }

    # Сортировка файлов
    if ($SortBy -eq "ext") {
        # Сортировка файлов по расширению (и затем по имени)
        $Files = $Files | Sort-Object Extension, Name
    } else {
        # Сортировка файлов по имени
        $Files = $Files | Sort-Object Name
    }

    # В корне директории идут первыми, затем файлы, сортированные по выбранному типу
    $Items = @($Directories) + @($Files)

    # Пробегаемся по каждому элементу
    for ($i = 0; $i -lt $Items.Count; $i++) {
        $Item = $Items[$i]
        $IsLastItem = $i -eq $Items.Count - 1
        $Symbol = if ($IsLastItem) { "└──" } else { "├──" }

        # Формируем вывод строки для файла или директории
        Write-Host "$Prefix$Symbol $($Item.Name)" -NoNewline
        if ($Item.PSIsContainer) {
            Write-Host "/"  # Добавляем слэш, чтобы указать, что это директория
            # Рекурсивно обрабатываем поддиректории
            $newPrefix = if ($IsLastItem) { "$SubPrefix    " } else { "$SubPrefix│   " }
            Get-Tree -Path $Item.FullName -Prefix $newPrefix -SubPrefix $newPrefix -IsLast:$IsLastItem
        } else {
            Write-Host ""  # Печатаем пустую строку для файла
        }
    }
}

# Вывод текущего каталога
Write-Host "$(Get-Item -Path $Path)"

# Запуск функции для указанной директории
Get-Tree -Path $Path

