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
  - `"ext"`: Files sorted first by extension.
  - `"name"`: Sort files alphabetically by name.
Directories appearing before files both cases.

### Example Usage

1. **Generate a directory tree for a specific path, sorted files by extension by defaut**:

   ```powershell
   .\Get-Tree.ps1
    ```

2. **Generate a directory tree for a specific path, sorted alphabetically by name**:

   ```powershell
   .\Get-Tree.ps1 -Path "C:\Test" -SortBy "name"

   ```

   Example of output win option `-SortBy "name"`:

   ```txt
   C:\Test\
   ├── a/
   │   ├── a.abc
   │   ├── a.ps1
   │   ├── a.py
   │   ├── a.txt
   │   ├── b.abc
   │   ├── b.ps1
   │   ├── b.py
   │   ├── b.txt
   │   ├── c.abc
   │   ├── c.ps1
   │   ├── c.py
   │   └── c.txt
   ├── b/
   │   ├── a.abc
   │   ├── a.ps1
   │   ├── a.py
   │   ├── a.txt
   │   ├── b.abc
   │   ├── b.ps1
   │   ├── b.py
   │   ├── b.txt
   │   ├── c.abc
   │   ├── c.ps1
   │   ├── c.py
   │   └── c.txt
   ├── c/
   │   ├── a.abc
   │   ├── a.ps1
   │   ├── a.py
   │   ├── a.txt
   │   ├── b.abc
   │   ├── b.ps1
   │   ├── b.py
   │   ├── b.txt
   │   ├── c.abc
   │   ├── c.ps1
   │   ├── c.py
   │   └── c.txt
   ├── a.abc
   ├── a.ps1
   ├── a.py
   ├── a.txt
   ├── b.abc
   ├── b.ps1
   ├── b.py
   ├── b.txt
   ├── c.abc
   ├── c.ps1
   ├── c.py
   └── c.txt

   ```

3. **Generate a directory tree for a specific path, sorted by extension**:

   ```powershell
   .\Get-Tree.ps1 -Path "C:\Test" -SortBy "ext"

   ```

   Example of output win option `-SortBy "ext"`:

   ```txt
   C:\Test\
   ├── a/
   │   ├── a.abc
   │   ├── b.abc
   │   ├── c.abc
   │   ├── a.ps1
   │   ├── b.ps1
   │   ├── c.ps1
   │   ├── a.py
   │   ├── b.py
   │   ├── c.py
   │   ├── a.txt
   │   ├── b.txt
   │   └── c.txt
   ├── b/
   │   ├── a.abc
   │   ├── b.abc
   │   ├── c.abc
   │   ├── a.ps1
   │   ├── b.ps1
   │   ├── c.ps1
   │   ├── a.py
   │   ├── b.py
   │   ├── c.py
   │   ├── a.txt
   │   ├── b.txt
   │   └── c.txt
   ├── c/
   │   ├── a.abc
   │   ├── b.abc
   │   ├── c.abc
   │   ├── a.ps1
   │   ├── b.ps1
   │   ├── c.ps1
   │   ├── a.py
   │   ├── b.py
   │   ├── c.py
   │   ├── a.txt
   │   ├── b.txt
   │   └── c.txt
   ├── a.abc
   ├── b.abc
   ├── c.abc
   ├── a.ps1
   ├── b.ps1
   ├── c.ps1
   ├── a.py
   ├── b.py
   ├── c.py
   ├── a.txt
   ├── b.txt
   └── c.txt
   ```

### Context Menu Integration (Windows Only)

You can add an entry to the Windows Explorer context menu to easily generate the directory tree for any folder.

#### Adding to the Context Menu

1. Create a registry file `GenerateDirectoryTree.reg` with the following content:

   ```reg
   Windows Registry Editor Version 5.00

   [HKEY_CLASSES_ROOT\Directory\shell\GenerateDirectoryTree]
   @="Catalog tree generation"

   [HKEY_CLASSES_ROOT\Directory\shell\GenerateDirectoryTree\command]
   @=powershell -NoExit -ExecutionPolicy Bypass -File \"Parth\\to\\Get-Tree.ps1\" -Path \"%V\"

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
