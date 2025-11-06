# foldergen.nvim

https://github.com/user-attachments/assets/50a0abf0-69f4-4020-a02c-6778bf9c19c1

`foldergen.nvim` is a **Neovim plugin** that generates folders and empty files from a **tree-style structure** pasted in a buffer.

---

## Features

* Generate nested folders and files from a tree-style text.
* Friendly error messages for empty buffers or invalid input.
* Works with files (lines ending in extensions) and folders.
* Supports tree characters (`│ ├ └ ─`) or simple indentation.

---

## Installation

Using **Lazy.nvim**:

```lua
{
  "NitroVim/foldergen.nvim",
  config = function()
    -- Create user command
    vim.api.nvim_create_user_command("FolderGen", function()
      require("foldergen").generate_from_text()
    end, {})

    -- Keymap: <leader>gf to generate folder structure
    vim.keymap.set("n", "<leader>gf", ":FolderGen<CR>", { desc = "Generate folder structure" })
  end,
}
```

---

## Usage

1. Open a new buffer:

```vim
:e structure.txt
```

2. Paste your **tree-style folder structure**. Example:

```
my-app
├── src
│   ├── components
│   │   └── Button
│   │       ├── Button.jsx
│   │       └── Button.css
│   └── pages
│       └── Home.jsx
├── public
│   └── index.html
```

3. Run the command:

```vim
:FolderGen
```

4. Or press the key mapping:

```
<leader>gf
```

---

## Messages

* Success: `Tree-style folder structure generated successfully!`
* Empty buffer: `Buffer is empty! Please paste your tree structure first.`
* Invalid input: `No tree-style structure detected. Generation skipped.`
* Folder/file creation errors: `Could not create: <path> (<error message>)`

---

## Notes

* **Files**: Lines with extensions (e.g., `.js`, `.html`) are created as empty files.
* **Folders**: Lines without extensions are created as directories.
* **Comments**: Lines starting with `#` or trailing `# comment` are ignored.
* **Indentation**: Supports spaces and tree characters (`│ ├ └ ─`).

---

## License

[MIT License](./LICENSE)
