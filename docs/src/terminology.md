# Terminology

This reference defines the core components, protocols, and editor concepts utilized within LunarVim.

---

## Editor Protocols & Architecture

### LSP (Language Server Protocol)
A standardized, JSON-RPC-based protocol developed by Microsoft to decouple language intelligence from the editor.
- **Client**: Neovim's built-in LSP client (`vim.lsp`), managed in LunarVim through `nvim-lspconfig` and `lvim.lsp`.
- **Server**: An external process (e.g., `pyright`, `rust-analyzer`, `gopls`, `forge lsp`) that parses source code and returns completions, diagnostics, hover documentation, symbol definitions, and refactoring actions.

### DAP (Debug Adapter Protocol)
A protocol connecting Neovim to interactive debugging engines via `nvim-dap` and `nvim-dap-ui`. Enables stepping through execution, inspecting stack frames, evaluating expressions, and setting conditional breakpoints directly inside the editor.

### Treesitter
A concrete syntax tree parser generator (`tree-sitter`) embedded into Neovim via `nvim-treesitter`. Unlike regex-based highlighting, Treesitter parses actual abstract syntax trees in real time as code is typed, powering context-aware syntax highlighting, accurate indentation, code folding, and structural text objects.

### Mason
A package manager (`mason.nvim`) running inside Neovim that automates downloading, installing, and updating external third-party binaries, including LSP servers, DAP debuggers, linters, and formatters into `~/.local/share/lunarvim/mason/bin`.

### Null-ls / None-ls
A bridge plugin (`none-ls.nvim`) that wraps command-line utilities (such as `black`, `prettier`, `eslint`, `stylua`) and exposes them to Neovim as standard LSP servers, providing unified formatting, diagnostics, and code actions.

### Lazy.nvim
A modern, declarative plugin manager for Neovim that handles plugin cloning, version pinning, lockfiles (`lazy-lock.json`), lazy loading on specific events/filetypes, and profiling startup times.

---

## Neovim Concepts

### Buffer
An in-memory representation of a file or text stream. Multiple buffers can be loaded simultaneously, regardless of whether they are actively displayed in a window.

### Window
A viewport onto a buffer. A single buffer can be displayed in multiple windows simultaneously (e.g., split panes).

### Tabpage
A collection of windows. Unlike browser tabs, Neovim tabpages represent separate window layouts rather than individual files. LunarVim utilizes `bufferline.nvim` at the top of the interface to display active buffers as clickable tabs.

---

## Key Notation

LunarVim documentation uses standard Neovim key notation:

| Notation | Key | Description |
| :--- | :--- | :--- |
| `<leader>` | `Space` | Default leader prefix in LunarVim (`lvim.leader = "space"`) |
| `<CR>` | `Enter` / `Return` | Carriage return |
| `<ESC>` | `Escape` | Escape key |
| `<C-x>` | `Ctrl + x` | Control key held with key `x` |
| `<M-x>` | `Alt + x` / `Option + x` | Meta (Alt on Linux/Windows, Option on macOS) held with key `x` |
| `<S-x>` | `Shift + x` | Shift key held with key `x` |
| `<BS>` | `Backspace` | Backspace key |
| `<Tab>` | `Tab` | Tab key |
