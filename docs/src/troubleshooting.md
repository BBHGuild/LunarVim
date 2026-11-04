# Troubleshooting & Diagnostics

This guide provides technical steps to diagnose and resolve common issues encountered in LunarVim.

---

## Quick Diagnostic Commands

Run these inside LunarVim to inspect system and editor state:
- `:LvimInfo` — Summarizes active configuration, attached LSP servers, formatters, linters, and plugins.
- `:checkhealth` — Runs Neovim's automated diagnostic suite across core components.
- `:LspInfo` — Displays attached LSP clients, capabilities, and buffer status.
- `:LspLog` — Opens the active LSP log file.
- `:Mason` — Displays installed tools, versions, and update statuses.

---

## Log File Locations

| Component | Path | Description |
| :--- | :--- | :--- |
| **LunarVim Core Log** | `~/.local/state/nvim/lvim.log` (or `~/.cache/lvim/log/lvim.log`) | Internal LunarVim logs and bootstrap errors |
| **LSP Log** | `~/.local/state/nvim/lsp.log` | Communication between Neovim and LSP servers |
| **Mason Binaries** | `~/.local/share/lunarvim/mason/bin` | Installed language server and debugger binaries |

To open the default log directly from Which-Key:
```text
<leader>Lld   (View default log)
<leader>Lll   (View LSP log)
```

---

## Common Issues & Resolutions

### 1. Old Cache & Template Inconsistencies
When changing `lvim.lsp.automatic_configuration.skipped_servers` or updating core settings, stale cache files can prevent changes from loading:
```vim
:LvimCacheReset
```
Or from the shell:
```bash
lvim +LvimCacheReset
```

### 2. Corrupted or Out-of-Sync Plugins
If a plugin update was interrupted or contains syntax conflicts:
```bash
# Clean and resync within LunarVim:
:Lazy sync
:Lazy clean

# Hard reset Lazy packages if needed:
rm -rf ~/.local/share/lunarvim/site/pack/lazy
lvim +Lazy sync
```

### 3. Treesitter Query Errors (`Invalid node type...`)
If Neovim or Treesitter grammars are out of sync:
```vim
:TSUpdateSync <language>
```
For example, for Solidity:
```vim
:TSUpdateSync solidity
```

### 4. Position Encoding Warning (`symbols_to_items must be called with valid position encoding`)
In Neovim 0.10/0.11+, LSP clients report character offsets according to the negotiated encoding. Telescope's master branch handles this natively. Verify that `telescope.nvim` in `snapshots/default.json` and `lazy-lock.json` is pinned to commit `a17d611` or newer.

### 5. Slow Startup or Terminal Lag with Fish Shell
Vim plugins often execute POSIX shell commands. If your default shell is `fish`, set the shell for Neovim back to standard `/bin/sh` in `~/.config/lvim/config.lua`:
```lua
vim.opt.shell = "/bin/sh"
```

### 6. Colorscheme Looking Washed Out or Incorrect
Ensure your terminal emulator supports true 24-bit color:
```lua
vim.opt.termguicolors = true
```
And verify that `$TERM` inside your terminal is set to `xterm-256color` or `tmux-256color`.

### 7. Keybinding Collisions in Embedded Environments (Antigravity 2.0)
If using LunarVim inside Antigravity 2.0, standard `<C-j>` (Toggle Terminal), `<C-k>` (Conversation Picker), and `<C-l>` (Focus Input) are intercepted by the host IDE. 

Use the conflict-free navigation alternatives:
- **Window Navigation**: `<leader>W` menu in Which-Key, or native `<C-w>h/j/k/l/w`, or `[w` / `]w`.
- **Buffer Navigation**: `<S-l>` / `<S-h>` or `[b` / `]b` or `<leader>bn` / `<leader>bb`.
- **Insert Mode Escape**: Press `jj` to escape insert mode instantly.
- **Reload Config**: Press `<leader>r`.
