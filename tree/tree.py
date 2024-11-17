import os
import argparse


IGNORE_DIRS = [".venv", "__pycache__", ".git"]


def generate_tree(directory, prefix=""):
    """
    Generate a directory tree representation for the specified directory.

    Args:
        directory (str): The path to the directory for which the tree is generated.
        prefix (str, optional): The prefix to prepend to each line in the tree (used for formatting).

    Returns:
        List[str]: A list of strings representing the directory tree.

    Note:
        This function recursively traverses the directory and its subdirectories to create the tree.
        The tree lines are formatted using prefixes to indicate the directory hierarchy.
        The tree includes both files and directories.

    """
    
    files = os.listdir(directory)

    sort_type = args.sort

    if sort_type == "type":
        files.sort(key=lambda x: (not os.path.isdir(os.path.join(directory, x)), x))
    elif sort_type == "name":
        files.sort()

    tree_lines = []  # Список рядків дерева

    for index, file in enumerate(files):
        path = os.path.join(directory, file)
        is_last = index == len(files) - 1

        if file in IGNORE_DIRS:  # Проверка, нужно ли проигнорировать текущую директорию
            continue

        if is_last:
            node = prefix + "└── " + file + ("/" if os.path.isdir(path) else "")
            sub_prefix = prefix + "    "  # Префікс для піддиректорій
        else:
            node = prefix + "├── " + file + ("/" if os.path.isdir(path) else "")
            sub_prefix = prefix + "│   "  # Префікс для піддиректорій

        tree_lines.append(node)

        if os.path.isdir(path):
            next_prefix = sub_prefix + ""  # Додатковий префікс для вкладених файлів
            sub_tree = generate_tree(path, prefix=next_prefix)
            tree_lines.extend(sub_tree)

    return tree_lines


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate ASCII tree based on a directory structure."
    )
    parser.add_argument(
        "directory", metavar="DIRECTORY", type=str, help="path to the directory"
    )
    parser.add_argument(
        "-w",
        "--write",
        metavar="FILE",
        type=str,
        help="write the tree to the specified file",
    )
    parser.add_argument(
        "-s",
        "--sort",
        choices=["type", "name"],
        default="type",
        help="sort the tree by type (directories first) or by name (default: type)",
    )

    args = parser.parse_args()
    directory_path = args.directory

    tree = generate_tree(directory_path)
    tree_output = "\n".join(tree)

    if args.write:
        output_file = os.path.join(directory_path, args.write)
        with open(output_file, "w", encoding="utf-8") as file:
            file.write(tree_output)
        print(f"Tree has been written to '{output_file}' file.")
    else:
        print(tree_output)
