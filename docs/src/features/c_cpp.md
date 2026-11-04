# C & C++ Development

LunarVim delivers an optimized C/C++ development environment via `clangd`, `clang-format`, and `codelldb`.

---

## Language Server (`clangd`)

To configure `clangd` arguments (such as background indexing and compile-commands paths), configure in `~/.config/lvim/ftplugin/c.lua` or `cpp.lua`:

```lua
-- ~/.config/lvim/ftplugin/cpp.lua
local opts = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
}

require("lvim.lsp.manager").setup("clangd", opts)
```

---

## Formatting (`clang-format`)

Register `clang-format` in `config.lua`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "clang_format", filetypes = { "c", "cpp" } },
})
```

---

## Debugging (`codelldb`)

1. Install `codelldb` with `:MasonInstall codelldb`.
2. Place breakpoints with `<leader>dt` and launch execution via `<leader>dc`.
