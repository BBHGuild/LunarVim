# Plugins Management

LunarVim uses [folke/lazy.nvim](https://github.com/folke/lazy.nvim) as its declarative plugin engine.

---

## Installing User Plugins

To add plugins, append plugin specification tables to `lvim.plugins` inside `~/.config/lvim/config.lua`:

```lua
lvim.plugins = {
  -- Simple repo string
  { "tpope/vim-surround" },

  -- Lazy-load on filetype with custom config
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Plugin with dependencies and options table
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true,
    },
  },
}
```

After modifying `lvim.plugins`, press `<leader>r` (or execute `:LvimReload`) to synchronize plugins automatically.

---

## Managing Plugins via `:Lazy`

LunarVim includes interactive Lazy commands accessible from the command line or Which-Key (`<leader>p`):

| Key | Command | Description |
| :--- | :--- | :--- |
| `<leader>pi` | `:Lazy install` | Install missing plugins |
| `<leader>ps` | `:Lazy sync` | Synchronize and update all plugins |
| `<leader>pc` | `:Lazy clean` | Remove uninstalled plugins from disk |
| `<leader>pu` | `:Lazy update` | Check and pull updates |
| `<leader>pp` | `:Lazy profile` | Profile startup times per plugin |
| `<leader>pl` | `:Lazy log` | View recent git commits and plugin updates |

---

## Configuring Built-in Core Plugins

LunarVim exposes configuration options for all out-of-the-box core plugins through the `lvim.builtin` namespace:

```lua
-- Adjust Telescope fuzzy finder width and cutoff
lvim.builtin.telescope.defaults.layout_config.width = 0.90
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 80

-- Adjust nvim-tree view options
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 30

-- Adjust autocompletion keyword length
lvim.builtin.cmp.completion.keyword_length = 2
```

### Disabling a Core Plugin
Set `active = false` on the target plugin:
```lua
lvim.builtin.alpha.active = false       -- Disable greeter / start dashboard
lvim.builtin.terminal.active = false    -- Disable toggleterm
lvim.builtin.dap.active = false         -- Disable debugging subsystem
```

> **Note:** Disabling a core plugin takes effect upon restarting LunarVim.

---

## Plugin Version Pinning & Supply Chain Security

Core plugin commits are pinned to verified, tested revisions in `snapshots/default.json` and `lazy-lock.json` to prevent broken upstream updates and supply-chain tampering.

To run LunarVim against the latest unpinned upstream commits of core plugins, launch with `LVIM_DEV_MODE=1`:
```bash
LVIM_DEV_MODE=1 lvim
```
