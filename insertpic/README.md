# Insert picture from clipboard

## Overview

This project provides a PowerShell script (`InsertPic.ps1`) and a corresponding registry file that allows you to save an image from the clipboard directly into the current directory or specified folder. The image is saved as a PNG file, and the script automatically checks for existing files, adding a numerical suffix if necessary. Additionally, the functionality is integrated into the Windows Explorer context menu for quick access.

### Components

1. **PowerShell Script (`InsertPic.ps1`)**  
   The PowerShell script extracts the image from the clipboard and saves it as a PNG file. If a file with the default name (`clipboard_image.png`) already exists, it appends a number to the filename (e.g., `clipboard_image_1.png`, `clipboard_image_2.png`, etc.).

2. **Registry File (`InsertPic.reg`)**  
   The registry file integrates the functionality of the script into the Windows context menu. After adding the registry entry, you can right-click in any directory and choose "Insert picture from clipboard into the current folder", which will execute the PowerShell script and save the clipboard image in that folder.

## Files

### 1. **PowerShell Script (`InsertPic.ps1`)**

This PowerShell script is responsible for:

- Saving the image from the clipboard to the current directory.
- Checking if the file already exists, and adding a suffix if necessary.
- Using the `System.Windows.Forms` library to access the clipboard contents.

**Key points:**

- The script checks if an image is present in the clipboard.
- It saves the image with a default name (`clipboard_image.png`), but if the file already exists, it will append a counter (e.g., `clipboard_image_1.png`).
- The script uses `System.Windows.Forms.Clipboard` for clipboard operations, which is available in Windows environments.

### 2. **Registry File (`InsertPic.reg`)**

This registry file adds an option to the Windows context menu, allowing you to right-click in a folder and quickly save the clipboard image using the PowerShell script.

#### Registry Content

```reg
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\shell\InsertPictureFromClipboard]
@="Insert picture from clipboard into the current folder"
"Icon"="imageres.dll,15"

[HKEY_CLASSES_ROOT\Directory\shell\InsertPictureFromClipboard\command]
@=powershell -ExecutionPolicy Bypass -File \"%commander_path%\\Scripts\\InsertPic.ps1\" -Path \"%V\""
```

**Explanation:**

- **[HKEY_CLASSES_ROOT\Directory\shell\InsertPictureFromClipboard]**: This defines a new option in the right-click context menu for directories in Windows Explorer.
  - `"@="Insert picture from clipboard into the current folder"` sets the text that will appear in the context menu.
  - `"Icon"="imageres.dll,15"` specifies the icon to display next to the menu item.
  
- **[HKEY_CLASSES_ROOT\Directory\shell\InsertPictureFromClipboard\command]**: This defines the command that will be executed when the user selects the context menu item.
  - `@=powershell -ExecutionPolicy Bypass -File \"%commander_path%\\Scripts\\InsertPic.ps1\" -Path \"%V\""` specifies that PowerShell will run the `InsertPic.ps1` script located at `%commander_path%\Scripts\InsertPic.ps1` when the menu option is selected.

### Installation

#### 1. **Add the Registry Entry**

To add the "Insert picture from clipboard into the current folder" option to the context menu:

1. Modify the registry file `InsertPic.reg`.
   - Replace `%commander_path%` with the actual path where your `InsertPic.ps1` script is located.
2. Save the file with a `.reg` extension (e.g., `InsertPic.reg`).
3. Double-click the `.reg` file to import the registry settings into your system.

#### 2. **Place the PowerShell Script**

- Save the `InsertPic.ps1` script to the directory specified in the registry (e.g., `%commander_path%\Scripts\`).
- Make sure the script is accessible by the path defined in the registry.

### Usage

After installing the registry entry and placing the script in the appropriate folder:

1. Open Windows Explorer and navigate to the folder where you want to save the image.
2. Right-click inside the folder and select "Insert picture from clipboard into the current folder" from the context menu.
3. The PowerShell script will execute, saving the clipboard image to the folder. If an image is already saved with the default name, a numerical suffix will be added to the file name (e.g., `clipboard_image_1.png`).

### Notes

- The script requires PowerShell to be installed and accessible on your system.
- If you encounter any permission issues, you may need to change the execution policy for PowerShell scripts. To allow the script to run, execute the following command in PowerShell (run as Administrator):

  ```powershell
  Set-ExecutionPolicy RemoteSigned
  ```

- Ensure that the clipboard contains an image before running the script, otherwise, it will not save anything.

