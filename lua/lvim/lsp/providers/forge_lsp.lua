local configs = require "lspconfig.configs"
local util = require "lspconfig.util"

local cmd = { "forge", "lsp", "--stdio" }
local cargo_bin = vim.fn.expand "~/.cargo/bin/forge"
if vim.fn.executable "forge" ~= 1 and vim.fn.executable(cargo_bin) == 1 then
  cmd[1] = cargo_bin
end

local function get_root_dir(fname)
  return util.root_pattern("foundry.toml", "hardhat.config.js", "hardhat.config.ts", "remappings.txt", ".git")(fname)
    or vim.fs.dirname(fname)
    or vim.fn.getcwd()
end

if not configs.forge_lsp then
  configs.forge_lsp = {
    default_config = {
      cmd = cmd,
      filetypes = { "solidity" },
      root_dir = get_root_dir,
      settings = {},
    },
  }
end

local opts = {
  cmd = cmd,
  filetypes = { "solidity" },
  root_dir = get_root_dir,
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
