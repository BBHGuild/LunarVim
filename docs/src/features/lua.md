# Lua Development

Because LunarVim and Neovim are heavily built on Lua, Lua development has premier tooling with automatic detection of Neovim runtime APIs.

---

## Language Server (`lua_ls`)

LunarVim configures `lua_ls` (formerly `sumneko_lua`) with workspace definitions pre-populated for Neovim's runtime files.

To customize diagnostics and third-party checks, configure in `~/.config/lvim/ftplugin/lua.lua`:

```lua
-- ~/.config/lvim/ftplugin/lua.lua
local opts = {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim", "lvim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

require("lvim.lsp.manager").setup("lua_ls", opts)
```

---

## Formatting (`stylua`)

Register `stylua` in `config.lua`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "stylua", filetypes = { "lua" } },
})
```
