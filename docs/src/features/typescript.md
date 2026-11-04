# TypeScript & JavaScript Development

LunarVim includes comprehensive support for JavaScript, TypeScript, JSX, and TSX ecosystems.

---

## Language Server (`ts_ls` / `tsserver`)

LunarVim automatically provisions TypeScript language services.

To configure compiler preferences, create `~/.config/lvim/ftplugin/typescript.lua`:

```lua
-- ~/.config/lvim/ftplugin/typescript.lua
local opts = {
  settings = {
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
      },
    },
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

require("lvim.lsp.manager").setup("ts_ls", opts)
```

---

## Formatting & Linting (`prettier` & `eslint_d`)

Add `prettier` and `eslint_d` to `config.lua`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    name = "prettier",
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "css",
      "html",
    },
  },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    name = "eslint_d",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
})
```
