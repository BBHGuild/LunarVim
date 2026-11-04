# Python Development

LunarVim offers a complete Python environment with automatic virtualenv detection, LSP diagnostics, formatting, and interactive debugging.

---

## Language Servers

By default, LunarVim configures `pyright`. Alternatives include `pylsp` and `jedi_language_server`.

### Configuring `pyright`
Create `~/.config/lvim/ftplugin/python.lua` to customize type-checking rigor:

```lua
-- ~/.config/lvim/ftplugin/python.lua
local opts = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

require("lvim.lsp.manager").setup("pyright", opts)
```

---

## Formatters & Linters

Configure `black`, `isort`, and `flake8` inside `config.lua`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "black", filetypes = { "python" } },
  { name = "isort", filetypes = { "python" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { name = "flake8", filetypes = { "python" } },
})
```

---

## Debugging (DAP with `debugpy`)

1. Install `debugpy` via Mason:
   ```vim
   :MasonInstall debugpy
   ```
2. Set breakpoints with `<leader>dt` and press `<leader>dc` to launch the debugger.
