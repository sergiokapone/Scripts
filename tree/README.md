# PowerShell Directory Tree Generator

This PowerShell script generates a visual representation of the directory structure for a given path, excluding unnecessary files and directories like `.venv`, `__pycache__`, and `.git`. The output can be customized by sorting the items either by type (directories first) or by name.

## Features

- **Excludes common directories**: Automatically ignores `.venv`, `__pycache__`, and `.git`.
- **Customizable sorting**: You can choose to sort the directory tree by type (directories first) or alphabetically by name.
- **Recursive listing**: Displays the structure of directories and subdirectories in a tree format.
- - **Context Menu Integration**: Adds an option to generate the directory tree directly from the context menu in Windows Explorer.

## Usage

To run the script, use PowerShell and specify optional parameters.

### Parameters

- **`Path`** (optional): The path to the directory you want to list. Defaults to the current directory (`"."`).
- **`SortBy`** (optional): Defines how the items should be sorted:
  - `"type"`: Sort by type, with directories appearing before files, both sorted alphabetically.
  - `"name"`: Sort alphabetically by name (both files and directories).

### Example Usage

1. **Generate a directory tree for the current directory, sorted by type (directories first)**:

   ```powershell
   .\Get-Tree.ps1
    ```
  
2. **Generate a directory tree for a specific path, sorted alphabetically by name**:

   ```powershell
   .\Get-Tree.ps1 -Path "C:\MyProject" -SortBy "name"
   
   ```

3. **Generate a directory tree for a specific path, sorted by type (directories first)**:

   ```powershell
   .\Get-Tree.ps1 -Path "C:\MyProject" -SortBy "type"
   
   ```

### Example Output

Sorted by Type (Directories First):

```txt
C:\MyProject
├── src/
│   ├── app/
│   │   ├── module1/
│   │   └── module2/
│   └── utils/
├── README.md
└── .git/
```

Sorted Alphabetically by Name:

```txt
C:\MyProject
├── .git/
├── README.md
└── src/
    ├── app/
    │   ├── module1/
    │   └── module2/
    └── utils/
```

### Context Menu Integration (Windows Only)

You can add an entry to the Windows Explorer context menu to easily generate the directory tree for any folder.

#### Adding to the Context Menu

1. Create a registry file `GenerateDirectoryTree.reg` with the following content:

   ```reg
   Windows Registry Editor Version 5.00

   [HKEY_CLASSES_ROOT\Directory\shell\GenerateDirectoryTree]
   @="Генерация дерева каталогов"

   [HKEY_CLASSES_ROOT\Directory\shell\GenerateDirectoryTree\command]
   @=powershell -NoExit -ExecutionPolicy Bypass -File \"%commander_path%\\Scripts\\tree.ps1\" -Path \"%V\"

   ```

2. Explanation:
   - `[HKEY_CLASSES_ROOT\Directory\shell\GenerateDirectoryTree]`: This key defines the entry in the context menu when you right-click on a directory.
   - `@="Catalog tree generation"`: This is the name that will be displayed in the context menu (translated as "Generate Directory Tree").
   - `[HKEY_CLASSES_ROOT\Directory\shell\GenerateDirectoryTree\command]`: This key specifies the command to execute when the context menu option is clicked. It calls PowerShell to run your script.

3. Steps to use:
   - Save the above content into a `.reg` file (e.g., `GenerateDirectoryTree.reg`).
   - Double-click the `.reg` file to add the entry to your Windows registry.
   - Now, when you right-click on any folder, you will see an option named "Генерация дерева каталогов" in the context menu. Clicking on it will run the script and generate the directory tree for that folder.

#### Notes on Context Menu Integration:

- Make sure to adjust the path to your `tree.ps1` script `(%commander_path%\\Scripts\\tree.ps1)` to reflect the actual location on your system.
- You can customize the context menu label by modifying the string "Генерация дерева каталогов" in the .reg file.

### Notes

- The script excludes the following directories by default: `.venv`, `__pycache__`, and `.git`. You can adjust the list of excluded directories by modifying the script.
- Directories are displayed with a trailing slash (`/`) to distinguish them from files.
- The script works recursively, so subdirectories will be shown indented under their parent directories.


### License

This project is licensed under the MIT License.