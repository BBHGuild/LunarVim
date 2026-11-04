# Editor Options & Variables

Editor behavior and Vimscript variables are configured in `config.lua` using Neovim's standard Lua interfaces (`vim.opt` and `vim.g`).

---

## Neovim Options (`vim.opt`)

Use `vim.opt` to adjust buffer, window, and global settings:

```lua
-- Line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.number = true          -- Show current line number

-- Indentation
vim.opt.tabstop = 2            -- 2 spaces for a tab
vim.opt.shiftwidth = 2         -- 2 spaces for autoindent
vim.opt.expandtab = true       -- Convert tabs to spaces

-- Search behavior
vim.opt.ignorecase = true      -- Case-insensitive search
vim.opt.smartcase = true       -- Case-sensitive if capital letters are present
vim.opt.hlsearch = true        -- Highlight search matches

-- Appearance & Scrolling
vim.opt.scrolloff = 8          -- Minimal lines to keep above and below cursor
vim.opt.sidescrolloff = 8      -- Minimal columns to keep to left and right
vim.opt.wrap = false           -- Prevent line wrapping
vim.opt.cmdheight = 1          -- Neovim command bar height

-- Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99         -- Start with all folds open
```

### Inspecting Option Values
To inspect the value of any option from inside LunarVim:
```vim
:lua print(vim.inspect(vim.opt.shiftwidth:get()))
```

---

## Neovim Variables (`vim.g`, `vim.env`)

Variables exposed by plugins or Neovim internals can be read or written via scope-specific tables:

| Table | Scope | Example |
| :--- | :--- | :--- |
| `vim.g` | Global variables (`g:`) | `vim.g.mapleader = " "` |
| `vim.b` | Buffer-local variables (`b:`) | `vim.b.autoformat = false` |
| `vim.w` | Window-local variables (`w:`) | `vim.w.statusline = "..."` |
| `vim.t` | Tabpage-local variables (`t:`) | `vim.t.custom_layout = true` |
| `vim.env` | Process environment variables | `vim.env.PATH = vim.env.PATH .. ":/opt/bin"` |
| `vim.v` | Predefined Vim variables (`v:`) | `vim.v.shell_error` |

### Example: Setting Global Plugin Flags
```lua
-- Disable netrw (recommended since NvimTree is used)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Custom environment variable for formatters
vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc")
```
