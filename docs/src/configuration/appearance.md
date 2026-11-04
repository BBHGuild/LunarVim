# Appearance & Statusline

LunarVim features built-in theme support and a modular statusline powered by `lualine.nvim`.

---

## Colorschemes

To select a colorscheme, set `lvim.colorscheme` in `config.lua`:

```lua
lvim.colorscheme = "lunar"
```

Common built-in colorschemes:
- `lunar` (Default)
- `tokyonight` / `tokyonight-night` / `tokyonight-storm` / `tokyonight-day`
- `onedarker`
- `desert`

You can test installed colorschemes interactively by pressing `<leader>sc` (Telescope colorschemes) or `<leader>sp` (with real-time live preview).

### Transparent Backgrounds
To make window backgrounds transparent:
```lua
lvim.transparent_window = true
```

---

## Statusline (Lualine)

LunarVim uses `lualine.nvim` as its default statusline engine.

### Layout Styles
LunarVim supports three layout presets via `lvim.builtin.lualine.style`:
- `"lvim"` (Default): LunarVim's custom streamlined statusline
- `"default"`: Standard Lualine layout
- `"none"`: Minimal / blank statusline

```lua
lvim.builtin.lualine.style = "lvim"
```

### Components
LunarVim provides pre-configured statusline components accessible via `require("lvim.core.lualine.components")`:
- `mode`: Current Vim mode (NORMAL, INSERT, VISUAL, etc.)
- `branch`: Current Git branch
- `filename`: Relative file path and modified status
- `diff`: Git additions, modifications, and deletions
- `diagnostics`: LSP errors, warnings, and hints
- `treesitter`: Active Treesitter parser indicator
- `lsp`: Attached LSP client names
- `location`: Cursor line and column numbers
- `progress`: Percentage through current buffer
- `spaces`: Buffer indentation type and width

### Customizing Statusline Sections
```lua
local components = require("lvim.core.lualine.components")

-- Add spaces and location to section y
lvim.builtin.lualine.sections.lualine_y = {
  components.spaces,
  components.location,
}

-- Override statusline theme
lvim.builtin.lualine.options.theme = "tokyonight"
```
