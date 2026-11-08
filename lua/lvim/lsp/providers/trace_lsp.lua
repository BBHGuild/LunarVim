local configs = require "lspconfig.configs"
local util = require "lspconfig.util"

local cmd = { "trace-lsp", "--stdio" }
local cargo_bin = vim.fn.expand "~/.cargo/bin/trace-lsp"
if vim.fn.executable "trace-lsp" ~= 1 and vim.fn.executable(cargo_bin) == 1 then
  cmd[1] = cargo_bin
end

if not configs.trace_lsp then
  configs.trace_lsp = {
    default_config = {
      cmd = cmd,
      filetypes = { "evm_trace", "trace" },
      root_dir = function(fname)
        return util.root_pattern(".git", "foundry.toml")(fname)
          or vim.fs.dirname(fname)
          or vim.fn.getcwd()
      end,
      settings = {},
    },
  }
end

local opts = {
  cmd = cmd,
  filetypes = { "evm_trace", "trace" },
  root_dir = function(fname)
    return util.root_pattern(".git", "foundry.toml")(fname)
      or vim.fs.dirname(fname)
      or vim.fn.getcwd()
  end,
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    if client.server_capabilities.semanticTokensProvider then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) and vim.lsp.buf_is_attached(bufnr, client.id) then
          pcall(vim.lsp.semantic_tokens.start, bufnr, client.id)
        end
      end)
    end
  end,
}

return opts
