# Autocommands

Autocommands execute Lua functions or Vim commands automatically in response to editor events (such as opening a file, switching buffers, or saving).

---

## LunarVim Helper: `lvim.autocommands`

LunarVim exposes `lvim.autocommands`, which automatically registers autocommand tables:

```lua
lvim.autocommands = {
  -- Enable soft wrapping for markdown and text files
  {
    "BufEnter",
    {
      pattern = { "*.md", "*.txt" },
      command = "setlocal wrap",
    },
  },
  -- Custom callback on entering C/C++ files
  {
    "BufWinEnter",
    {
      pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
      callback = function()
        vim.cmd("setlocal tabstop=4 shiftwidth=4")
      end,
    },
  },
}
```

---

## Native Neovim API: `nvim_create_autocmd`

You can also use Neovim's built-in API directly inside `config.lua`:

### Highlighting Yanked Text
```lua
local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})
```

### Auto-formatting Before Save
```lua
local format_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.lua", "*.rs", "*.sol" },
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})
```

### Clean Up Trailing Whitespace
```lua
local clean_group = vim.api.nvim_create_augroup("CleanWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = clean_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
```

---

## Event Reference

Commonly used events in LunarVim:
- `BufEnter` / `BufLeave`: Entering or leaving a buffer
- `BufReadPost`: Triggered immediately after reading a file into a buffer
- `BufWritePre`: Triggered right before writing/saving a buffer
- `FileType`: Triggered when Neovim detects or sets the buffer's filetype
- `VimResized`: Triggered when the terminal window changes dimensions
