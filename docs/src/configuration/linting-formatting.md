# Linting and Formatting

LunarVim integrates linters, code formatters, and diagnostics via `none-ls.nvim` (the community maintained fork of `null-ls`).

---

## Configuring Formatters

To register formatters, use `lvim.lsp.null-ls.formatters.setup`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
  { name = "black", filetypes = { "python" } },
  { name = "stylua", filetypes = { "lua" } },
  {
    name = "prettier",
    ---@usage Arguments to pass to formatter (cannot contain spaces)
    args = { "--print-width", "100", "--single-quote" },
    filetypes = { "typescript", "typescriptreact", "javascript", "json", "markdown" },
  },
  { name = "shfmt", filetypes = { "sh", "bash" } },
})
```

Installed formatters override default LSP formatting when running `<leader>lf` or formatting on save.

---

## Configuring Linters

Register linters via `lvim.lsp.null-ls.linters.setup`:

```lua
local linters = require("lvim.lsp.null-ls.linters")

linters.setup({
  { name = "flake8", filetypes = { "python" } },
  { name = "eslint_d", filetypes = { "javascript", "typescript" } },
  { name = "solhint", filetypes = { "solidity" } },
  { name = "shellcheck", filetypes = { "sh", "bash" } },
})
```

---

## Format on Save

To format buffers automatically whenever they are saved to disk:

```lua
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.rs", "*.sol" }
lvim.format_on_save.timeout = 2000
```

Alternatively, you can scope auto-formatting to specific filetypes using a custom autocommand:

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.rs" },
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})
```
