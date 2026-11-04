# Language Servers (LSP)

LunarVim configures Neovim's native LSP client through `nvim-lspconfig` and manages binaries through `mason.nvim`.

---

## Automatic Server Installation

By default, LunarVim automatically triggers installation and configuration of the default LSP server when you first open a recognized filetype (e.g., opening a `.py` file automatically installs and attaches `pyright`).

To disable automatic installation and manage servers manually:
```lua
lvim.lsp.installer.setup.automatic_installation = false
```

Manage installed servers interactively using Mason:
```vim
:Mason
```

---

## Overriding Default Language Servers

LunarVim maintains a list of default servers. If multiple servers exist for a language (such as `pyright` vs `pylsp` vs `jedi_language_server`), you can switch by modifying `lvim.lsp.automatic_configuration.skipped_servers`:

```lua
-- Disable default pyright
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- Enable jedi_language_server
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)
```

> **Important:** Any modification to `skipped_servers` requires running `:LvimCacheReset` (or restarting with `lvim +LvimCacheReset`) to regenerate the filetype cache templates.

---

## Customizing LSP Server Options

To pass custom initialization options, capabilities, or settings to a specific LSP server, use LunarVim's LSP manager inside `~/.config/lvim/ftplugin/<filetype>.lua`:

```lua
-- ~/.config/lvim/ftplugin/lua.lua
local opts = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "lvim" },
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}

require("lvim.lsp.manager").setup("lua_ls", opts)
```

---

## Custom LSP Providers (e.g., Foundry `forge lsp`)

When a language tool provides its own built-in LSP (such as Foundry's `forge lsp` for Solidity), you can bypass Mason entirely and wire the command directly using `vim.lsp.start`:

```lua
-- In ftplugin/solidity.lua
local root_dir = vim.fs.root(0, { "foundry.toml", "remappings.txt", ".git" })
if root_dir then
  vim.lsp.start({
    name = "forge-lsp",
    cmd = { "forge", "lsp", "--stdio" },
    root_dir = root_dir,
    capabilities = require("lvim.lsp").get_common_capabilities(),
  })
end
```

---

## Diagnostics & Inspection

- `:LspInfo` — Displays attached LSP clients for the current buffer, root directory, and capabilities.
- `:LspLog` — Opens the active LSP log file (`~/.local/state/nvim/lsp.log`).
- `:checkhealth vim.lsp` — Runs Neovim's automated health checks for the LSP subsystem.
- `<leader>la` — Show available code actions.
- `<leader>lf` — Format current document.
- `gl` — Show line diagnostics in a floating window.
