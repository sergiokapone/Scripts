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

    $TreeOutput = ""  # Переменная для накопления текста дерева

    # Пробегаемся по каждому элементу
    for ($i = 0; $i -lt $Items.Count; $i++) {
        $Item = $Items[$i]
        $IsLastItem = $i -eq $Items.Count - 1
        $Symbol = if ($IsLastItem) { "└──" } else { "├──" }

        # Формируем вывод строки для файла или директории
        $TreeOutput += "$Prefix$Symbol $($Item.Name)" 
        if ($Item.PSIsContainer) {
            $TreeOutput += "/"  # Добавляем слэш, чтобы указать, что это директория
            # Рекурсивно обрабатываем поддиректории
            $newPrefix = if ($IsLastItem) { "$SubPrefix    " } else { "$SubPrefix│   " }
            $TreeOutput += "`n"  # Перенос строки перед рекурсией
            $TreeOutput += Get-Tree -Path $Item.FullName -Prefix $newPrefix -SubPrefix $newPrefix -IsLast:$IsLastItem
        } else {
            $TreeOutput += "`n"  # Печатаем пустую строку для файла
        }
    }

    return $TreeOutput
}

# Получаем полный путь к текущей директории
$CurrentPath = (Get-Item -Path $Path).FullName

# Получаем текст дерева для указанной директории
$TreeText = Get-Tree -Path $Path

# Добавляем полный путь в начало текста дерева
$TreeOutput = "$CurrentPath`n$TreeText"

# Копируем дерево в буфер обмена
$TreeOutput | Set-Clipboard

# Выводим дерево в консоль
Write-Host $TreeOutput
