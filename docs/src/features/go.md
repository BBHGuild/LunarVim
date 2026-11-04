# Go Development

LunarVim configures `gopls` for Go development with full support for modules, static analysis, formatting, and debugging.

---

## Language Server (`gopls`)

Create `~/.config/lvim/ftplugin/go.lua` to enable advanced `gopls` features:

```lua
-- ~/.config/lvim/ftplugin/go.lua
local opts = {
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
}

require("lvim.lsp.manager").setup("gopls", opts)
```

---

## Formatting & Linting

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "gofumpt", filetypes = { "go" } },
  { name = "goimports", filetypes = { "go" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { name = "golangci_lint", filetypes = { "go" } },
})
```

---

## Debugging (DAP with `delve`)

Install `delve` via Mason:
```vim
:MasonInstall delve
```
Set breakpoints with `<leader>dt` and start debugging sessions with `<leader>dc`.
