# Custom Keybindings

LunarVim provides dedicated tables for customizing keybindings across standard Vim modes, Which-key menus, and LSP buffer mappings.

---

## Leader Key

The leader key defaults to `Space`. To change it, set `lvim.leader` in `config.lua`:

```lua
lvim.leader = "space"
```

---

## Standard Neovim Mappings (`lvim.keys`)

Mappings are organized by mode table:
- `lvim.keys.normal_mode`
- `lvim.keys.insert_mode`
- `lvim.keys.visual_mode`
- `lvim.keys.term_mode`
- `lvim.keys.command_mode`

### Adding Mappings
```lua
-- Fast escape from Insert mode with 'jj'
lvim.keys.insert_mode["jj"] = "<ESC>"

-- Reload configuration in Normal mode
lvim.keys.normal_mode["<leader>r"] = ":LvimReload<CR>"

-- Center screen when jumping half pages
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

-- Quick buffer kill with Shift+X
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"

-- Move visual selection with auto-indent
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"
```

### Removing Default Mappings
To disable a default mapping, assign it `false`:
```lua
-- Disable default window navigation mappings
lvim.keys.normal_mode["<C-h>"] = false
lvim.keys.normal_mode["<C-j>"] = false
lvim.keys.normal_mode["<C-k>"] = false
lvim.keys.normal_mode["<C-l>"] = false
```

---

## Which-Key Mappings (`lvim.builtin.which_key.mappings`)

Which-key manages keybindings that begin with `<leader>`. When adding mappings to this table, do **not** prepend `<leader>`—it is applied automatically.

### Adding Single Actions
```lua
-- Maps <leader>P to Telescope projects
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>Telescope projects<CR>", "Projects"
}

-- Maps <leader>r to reload configuration
lvim.builtin.which_key.mappings["r"] = {
  "<cmd>LvimReload<CR>", "Reload Config"
}
```

### Adding Nested Submenus
```lua
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics & Trouble",
  t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
}
```

### Disabling a Which-Key Binding
```lua
-- Disables <leader>w (save file)
lvim.builtin.which_key.mappings["w"] = {}
```

---

## LSP Buffer Mappings (`lvim.lsp.buffer_mappings`)

LSP buffer mappings attach to buffers with an active LSP client and take precedence over global mappings.

```lua
-- Remap hover documentation to 'H'
lvim.lsp.buffer_mappings.normal_mode["H"] = {
  vim.lsp.buf.hover, "Hover Documentation"
}

-- Disable a default LSP binding (e.g. remove 'K' so it can be used for custom navigation)
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.keys.normal_mode["K"] = "<Cmd>echo 'Reclaimed K'<CR>"
```

---

## Inspecting Active Mappings

To diagnose mapping conflicts or verify which plugin bound a key:
```vim
:verbose nmap <leader>r
:verbose imap jj
```
To view all mapped keys:
```vim
:map
```
Or use Telescope's interactive fuzzy finder:
```text
<leader>sk
```
