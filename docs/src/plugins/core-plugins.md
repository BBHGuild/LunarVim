# Core Plugins Reference

LunarVim includes a carefully curated, optimized suite of core plugins configured to work together seamlessly out of the box.

---

## Core Infrastructure & Package Management

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **lazy.nvim** | `folke/lazy.nvim` | Modern declarative plugin manager with lazy loading and lockfile pinning |
| **plenary.nvim** | `nvim-lua/plenary.nvim` | Essential utility library (asynchronous I/O, path manipulation, jobs) |
| **structlog.nvim** | `Tastyep/structlog.nvim` | Structured, leveled logging system for LunarVim internals (`:LvimLog`) |
| **mason.nvim** | `mason-org/mason.nvim` | In-editor package manager for LSP servers, DAP debuggers, linters, and formatters |
| **mason-lspconfig.nvim** | `williamboman/mason-lspconfig.nvim` | Seamless bridge between Mason and `nvim-lspconfig` |

---

## Language Server Protocol (LSP) & Syntax

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **nvim-lspconfig** | `neovim/nvim-lspconfig` | Quickstart configurations and hooks for Neovim's built-in LSP client |
| **none-ls.nvim** | `nvimtools/none-ls.nvim` | Injects external linters and formatters as standard LSP diagnostics and code actions |
| **nlsp-settings.nvim** | `tamago324/nlsp-settings.nvim` | Allows persistent LSP configuration via JSON/YAML files |
| **schemastore.nvim** | `b0o/schemastore.nvim` | JSON and YAML schema catalog integration for `jsonls` and `yamlls` |
| **nvim-treesitter** | `nvim-treesitter/nvim-treesitter` | Incremental syntax tree parsing for precise highlighting, folding, and indentation |
| **nvim-ts-context-commentstring** | `JoosepAlviste/nvim-ts-context-commentstring` | Context-aware commenting inside embedded languages (e.g. JSX in JS, HTML in Vue) |

---

## Fuzzy Finding & Navigation

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **telescope.nvim** | `nvim-telescope/telescope.nvim` | Highly extensible fuzzy finder for files, live grep, buffers, git commits, and symbols |
| **telescope-fzf-native.nvim** | `nvim-telescope/telescope-fzf-native.nvim` | C-based compiled FZF sorter for high-performance fuzzy finding |
| **nvim-tree.lua** | `nvim-tree/nvim-tree.lua` | Fast, customizable file explorer sidebar with git status badges |
| **project.nvim** | `ahmedkhalf/project.nvim` | Automatically detects project roots using pattern matching (`.git`, `Makefile`, etc.) |

---

## Autocompletion & Snippets

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **nvim-cmp** | `hrsh7th/nvim-cmp` | Modular, extensible autocompletion engine |
| **cmp-nvim-lsp** | `hrsh7th/cmp-nvim-lsp` | LSP source for `nvim-cmp` |
| **cmp-buffer** | `hrsh7th/cmp-buffer` | Buffer words source for `nvim-cmp` |
| **cmp-path** | `hrsh7th/cmp-path` | Filesystem paths source for `nvim-cmp` |
| **cmp_luasnip** | `saadparwaiz1/cmp_luasnip` | LuaSnip integration source for `nvim-cmp` |
| **LuaSnip** | `L3MON4D3/LuaSnip` | Feature-rich snippet engine supporting dynamic nodes and transformations |
| **friendly-snippets** | `rafamadriz/friendly-snippets` | Preconfigured snippet catalog covering dozens of programming languages |

---

## UI, Statusline & Editor Enhancements

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **which-key.nvim** | `folke/which-key.nvim` | Interactive popup displaying available keybindings as you type |
| **lualine.nvim** | `nvim-lualine/lualine.nvim` | Blazing-fast statusline with modular components |
| **bufferline.nvim** | `akinsho/bufferline.nvim` | Snappy tab bar showing open buffers with close buttons and diagnostic icons |
| **nvim-web-devicons** | `nvim-tree/nvim-web-devicons` | Filetype and folder icons used across NvimTree, Telescope, and Bufferline |
| **alpha-nvim** | `goolord/alpha-nvim` | Fast, customizable startup dashboard and greeter |
| **toggleterm.nvim** | `akinsho/toggleterm.nvim` | Multiple floating or split terminal management |
| **nvim-navic** | `SmiteshP/nvim-navic` | Breadcrumb code context indicator in the winbar showing current function/class |
| **indent-blankline.nvim** | `lukas-reineke/indent-blankline.nvim` | Indentation guides for visual clarity |
| **vim-illuminate** | `RRethy/vim-illuminate` | Automatically highlights other occurrences of the word or symbol under the cursor |

---

## Git Integration

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **gitsigns.nvim** | `lewis6991/gitsigns.nvim` | Gutter diff signs, hunk staging, hunk reverting, inline blame, and diff popups |

---

## Debugging (DAP)

| Plugin | Repository | Purpose |
| :--- | :--- | :--- |
| **nvim-dap** | `mfussenegger/nvim-dap` | Debug Adapter Protocol client implementation for interactive debugging |
| **nvim-dap-ui** | `rcarriga/nvim-dap-ui` | Rich multi-pane debugger UI (watches, scopes, breakpoints, stacks, and console) |
