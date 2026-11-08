# Keybindings

LunarVim configures ergonomic default keybindings organized around the `<leader>` key (`Space`) and interactive menus via `which-key.nvim`.

To search through all active keybindings at runtime, press:
```text
<leader>sk
```
or open the which-key menu by pressing `<leader>` and pausing.

---

## Essential Navigation & Operations

| Key | Mode | Description |
| :--- | :--- | :--- |
| `jj` | Insert | Fast escape to Normal mode |
| `<leader>r` | Normal | Reload LunarVim configuration (`:LvimReload`) |
| `<leader>e` | Normal | Toggle file tree explorer (`NvimTree`) |
| `<leader>w` | Normal | Save current buffer (`:w`) |
| `<leader>q` | Normal | Quit LunarVim (`:q`) |
| `<leader>c` | Normal | Close current buffer |
| `<leader>h` | Normal | Clear search highlighting (`:noh`) |
| `<leader>/` | Normal / Visual | Toggle comment on current line or selection |
| `<M-j>` | Normal / Visual | Move current line or selection down |
| `<M-k>` | Normal / Visual | Move current line or selection up |

---

## Buffer Navigation (Top Bar)

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<S-l>` / `L` | Normal | Switch to next buffer |
| `<S-h>` / `H` | Normal | Switch to previous buffer |
| `]b` | Normal | Jump to next buffer |
| `[b` | Normal | Jump to previous buffer |
| `<leader>b` | Normal | Open buffer menu in Which-Key |

---

## Window Management & Navigation

All window navigation is engineered to be conflict-free with host IDE shortcuts (such as Antigravity 2.0).

| Key | Mode | Description |
| :--- | :--- | :--- |
| `Alt-h` (`<M-h>`) | Normal / Term / Insert | Move cursor to left window |
| `Alt-j` (`<M-j>`) | Normal / Term / Insert | Move cursor to lower window |
| `Alt-k` (`<M-k>`) | Normal / Term / Insert | Move cursor to upper window |
| `Alt-l` (`<M-l>`) | Normal / Term / Insert | Move cursor to right window |
| `]w` | Normal | Cycle to next window |
| `[w` | Normal | Cycle to previous window |
| `<leader>W` | Normal | Open Window menu in Which-Key (`h`, `j`, `k`, `l`, `s`, `v`, `c`, `o`, `=`) |
| `<C-w>h` | Normal / Term | Move cursor to left window |
| `<C-w>j` | Normal / Term | Move cursor to lower window |
| `<C-w>k` | Normal / Term | Move cursor to upper window |
| `<C-w>l` | Normal / Term | Move cursor to right window |
| `<C-w>w` | Normal / Term | Cycle to next window |
| `<C-Up>` | Normal | Resize split height (-2) |
| `<C-Down>` | Normal | Resize split height (+2) |
| `<C-Left>` | Normal | Resize split width (-2) |
| `<C-Right>` | Normal | Resize split width (+2) |

---

## Symbol Outline Dock & Trace Tools

| Key | Mode | Action |
| :--- | :--- | :--- |
| `<leader>O` | Normal | Toggle bottom symbol outline dock (`Trouble symbols`) |
| `Alt-o` (`<M-o>`) | Normal | Toggle bottom symbol outline dock |
| `<leader>tt` / `<leader>tr` | Normal | Run Forge test for hovered method and create `tx-trace-test.trace` |

### Symbol Outline Dock Keys (when dock is focused)
| Key | Action | Description |
| :--- | :--- | :--- |
| `s` | Accordion Solo | Open selected node and collapse all its siblings |
| `C` | Collapse Siblings | Collapse all sibling trees at current level |
| `S` | Expand Siblings | Expand all sibling trees at current level |
| `E` | Recursive Expand | Recursively expand all sibling trees and sub-children |
| `h` / `l` | Close / Open | Close or open selected node |
| `<Tab>` / `<Space>` / `o` | Toggle | Toggle fold state of current node |
| `zM` / `zR` | Close / Open All | Collapse or expand entire symbol hierarchy |
| `<CR>` | Jump | Jump directly to symbol in active buffer |

---

## Fuzzy Finding (Telescope)

| Key | Mode | Action |
| :--- | :--- | :--- |
| `<leader>f` | Normal | Find files in project root |
| `<leader>st` | Normal | Live grep text in project |
| `<leader>sb` | Normal | Search open buffers |
| `<leader>sr` | Normal | Search recent files |
| `<leader>sk` | Normal | Search keymaps |
| `<leader>sc` | Normal | Search colorschemes |
| `<leader>sh` | Normal | Search Neovim `:help` documentation |
| `<leader>sw` | Normal | Find word under cursor |

---

## Language Server Protocol (LSP)

These bindings are activated whenever an LSP client attaches to the current buffer:

| Key | Mode | Action |
| :--- | :--- | :--- |
| `K` | Normal | Show hover documentation (press twice to focus into popup) |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Find references via Telescope |
| `gI` | Normal | Go to implementation |
| `gl` | Normal | Show line diagnostics floating window |
| `[d` | Normal | Jump to previous diagnostic |
| `]d` | Normal | Jump to next diagnostic |
| `<leader>la` | Normal | Code actions |
| `<leader>lf` | Normal | Format document |
| `<leader>li` | Normal | LSP server info (`:LspInfo`) |
| `<leader>lj` | Normal | Next diagnostic |
| `<leader>lk` | Normal | Previous diagnostic |
| `<leader>lr` | Normal | Rename symbol under cursor |
| `<leader>ls` | Normal | Document symbols |
| `<leader>lS` | Normal | Workspace symbols |

---

## Autocompletion (nvim-cmp)

| Key | Mode | Action |
| :--- | :--- | :--- |
| `<C-Space>` | Insert | Manually trigger autocompletion popup |
| `<CR>` | Insert | Confirm selected completion item |
| `<C-e>` | Insert | Abort / dismiss completion menu |
| `<C-j>` / `<Down>` | Insert | Select next item |
| `<C-k>` / `<Up>` | Insert | Select previous item |
| `<Tab>` | Insert | Next completion item or jump to next snippet placeholder |
| `<S-Tab>` | Insert | Previous completion item or jump to previous snippet placeholder |
| `<C-d>` | Insert | Scroll documentation window down |
| `<C-f>` | Insert | Scroll documentation window up |

---

## Git Operations (Gitsigns & Neogit)

| Key | Mode | Action |
| :--- | :--- | :--- |
| `<leader>gj` | Normal | Jump to next git hunk |
| `<leader>gk` | Normal | Jump to previous git hunk |
| `<leader>gp` | Normal | Preview git hunk inline |
| `<leader>gr` | Normal | Reset current hunk |
| `<leader>gR` | Normal | Reset entire buffer |
| `<leader>gs` | Normal | Stage current hunk |
| `<leader>gu` | Normal | Undo last stage hunk |
| `<leader>gd` | Normal | View git diff |
| `<leader>gb` | Normal | Checkout git branch |
| `<leader>gc` | Normal | Git commit |

---

## Terminal (Toggleterm)

| Key | Mode | Action |
| :--- | :--- | :--- |
| `<C-\>` | Normal / Term | Toggle floating terminal |
| `<C-t>` | Normal / Term | Toggle terminal (if configured) |
| `<ESC>` / `jk` | Term | Return to Normal mode inside terminal buffer |
