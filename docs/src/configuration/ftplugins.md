# Filetype Plugins (ftplugin)

Filetype plugins (`ftplugin`) execute configuration logic scoped strictly to buffers of a specific language or format.

Unlike global options or autocommands, settings defined in an `ftplugin` file apply only to that filetype, avoiding cross-language pollution and keeping startup snappy.

---

## Directory Structure

Place filetype scripts inside `~/.config/lvim/ftplugin/` (or within LunarVim's root `ftplugin/` directory):

```text
~/.config/lvim/
└── ftplugin/
    ├── c.lua
    ├── go.lua
    ├── python.lua
    ├── rust.lua
    └── solidity.lua
```

When Neovim opens a file whose `filetype` matches the filename (e.g., `solidity.lua` for `.sol` files), that script runs automatically.

---

## Setting Buffer-Local Options

Always use buffer-local setters such as `vim.opt_local` to avoid altering other open buffers:

```lua
-- ~/.config/lvim/ftplugin/python.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.colorcolumn = "88"
```

---

## Buffer-Local Keybindings

Use `buffer = 0` (or `buffer = true`) when mapping keys inside an `ftplugin`:

```lua
-- ~/.config/lvim/ftplugin/rust.lua
vim.keymap.set("n", "<leader>ct", "<cmd>!cargo test<CR>", {
  buffer = 0,
  desc = "Run Cargo Tests",
  silent = true,
})
```

---

## Language Server Setup in ftplugins

LunarVim uses `ftplugin` files to lazy-load LSP configurations on demand.

For example, our built-in Foundry Solidity integration initializes in `ftplugin/solidity.lua`:

```lua
-- ftplugin/solidity.lua
local status_ok, forge_lsp = pcall(require, "lvim.lsp.providers.forge_lsp")
if not status_ok then
  return
end

forge_lsp.setup()
```

This ensures that the language server and buffer listeners only initialize when a Solidity file is actively opened.
