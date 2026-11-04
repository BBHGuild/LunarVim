# Rust Development

LunarVim delivers an outstanding environment for Rust development with `rust-analyzer`, `rustfmt`, and `codelldb`.

---

## Language Server (`rust-analyzer`)

Opening any `.rs` file triggers automatic configuration of `rust_analyzer`.

### Customizing `rust-analyzer` Settings
To customize cargo features, proc macros, or clippy on save, create `~/.config/lvim/ftplugin/rust.lua`:

```lua
-- ~/.config/lvim/ftplugin/rust.lua
local opts = {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      inlayHints = {
        lifetimeElisionHints = { enable = true, useParameterNames = true },
      },
    },
  },
}

require("lvim.lsp.manager").setup("rust_analyzer", opts)
```

---

## Formatting

Rust formatting uses `rustfmt` by default. You can also specify `rustfmt` explicitly through `null-ls`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "rustfmt", filetypes = { "rust" } },
})
```

---

## Debugging (DAP with `codelldb`)

1. Install `codelldb` via Mason:
   ```vim
   :MasonInstall codelldb
   ```
2. Set breakpoints with `<leader>dt` and start debugging with `<leader>dc`.
