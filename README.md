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

## Example: Complex Project Structure

You can paste a full project tree in the buffer, like this:

```
project-root
├── public
│   ├── index.html
│   ├── favicon.ico
│   └── assets
│       ├── images
│       │   ├── logo.png
│       │   └── banner.jpg
│       └── fonts
│           ├── Roboto.ttf
│           └── OpenSans.ttf
├── src
│   ├── api
│   │   ├── axios.js
│   │   └── userApi.js
│   ├── app
│   │   ├── store.js
│   │   └── rootReducer.js
│   ├── components
│   │   ├── Button
│   │   │   ├── Button.jsx
│   │   │   └── Button.css
│   │   ├── Modal
│   │   │   ├── Modal.jsx
│   │   │   └── Modal.css
│   │   ├── Navbar
│   │   │   ├── Navbar.jsx
│   │   │   └── Navbar.css
│   │   └── Form
│   │       ├── Input.jsx
│   │       ├── Input.css
│   │       ├── Select.jsx
│   │       └── Select.css
│   ├── features
│   │   ├── auth
│   │   │   ├── authSlice.js
│   │   │   ├── Login.jsx
│   │   │   └── Register.jsx
│   │   └── dashboard
│   │       ├── dashboardSlice.js
│   │       └── Dashboard.jsx
│   ├── hooks
│   │   ├── useAuth.js
│   │   ├── useFetch.js
│   │   └── useDebounce.js
│   ├── layouts
│   │   ├── MainLayout.jsx
│   │   └── AuthLayout.jsx
│   ├── pages
│   │   ├── Home.jsx
│   │   ├── About.jsx
│   │   ├── Contact.jsx
│   │   └── Profile
│   │       ├── Profile.jsx
│   │       └── ProfileSettings.jsx
│   ├── services
│   │   ├── firebase.js
│   │   └── stripe.js
│   ├── utils
│   │   ├── helpers.js
│   │   ├── validators.js
│   │   ├── dateUtils.js
│   │   └── formatUtils.js
│   ├── context
│   │   ├── ThemeContext.jsx
│   │   └── AuthContext.jsx
│   └── constants
│       ├── routes.js
│       └── appConfig.js
├── tests
│   ├── unit
│   │   ├── Button.test.js
│   │   └── Modal.test.js
│   └── integration
│       ├── App.test.js
│       └── Dashboard.test.js
├── .env
├── package.json
├── package-lock.json
├── tailwind.config.js
├── postcss.config.js
└── README.md
```

This shows that `foldergen.nvim` can handle **deeply nested and complex project trees**, like a full React project with assets, components, pages, context, hooks, services, tests, and configs.

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
