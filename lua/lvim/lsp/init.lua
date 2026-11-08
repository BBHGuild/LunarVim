local M = {}
local Log = require "lvim.core.log"
local utils = require "lvim.utils"
local autocmds = require "lvim.core.autocmds"

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(lvim.lsp.buffer_options) do
    vim.api.nvim_set_option_value(k, v, { buf = bufnr })
  end
end

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(lvim.lsp.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.common_on_exit(_, _)
  if lvim.lsp.document_highlight then
    autocmds.clear_augroup "lsp_document_highlight"
  end
  if lvim.lsp.code_lens_refresh then
    autocmds.clear_augroup "lsp_code_lens_refresh"
  end
end

function M.common_on_init(client, bufnr)
  if lvim.lsp.on_init_callback then
    lvim.lsp.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end
end

function M.common_on_attach(client, bufnr)
  if client and not client._lvim_wrapped then
    client._lvim_wrapped = true
    for _, method in ipairs { "request", "notify", "cancel_request", "stop", "is_stopped", "supports_method" } do
      local orig = client[method]
      if type(orig) == "function" then
        client[method] = function(arg1, ...)
          if arg1 == client then
            return orig(arg1, ...)
          end
          return orig(client, arg1, ...)
        end
      end
    end
  end
  if lvim.lsp.on_attach_callback then
    lvim.lsp.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_attach_callback"
  end
  local lu = require "lvim.lsp.utils"
  if lvim.lsp.document_highlight then
    lu.setup_document_highlight(client, bufnr)
  end
  if lvim.lsp.code_lens_refresh then
    lu.setup_codelens_refresh(client, bufnr)
  end
  add_lsp_buffer_keybindings(bufnr)
  add_lsp_buffer_options(bufnr)
  lu.setup_document_symbols(client, bufnr)
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

function M.setup()
  Log:debug "Setting up LSP support"

  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  if lvim.use_icons then
    local severity_map = {
      DiagnosticSignError = vim.diagnostic.severity.ERROR,
      DiagnosticSignWarn = vim.diagnostic.severity.WARN,
      DiagnosticSignHint = vim.diagnostic.severity.HINT,
      DiagnosticSignInfo = vim.diagnostic.severity.INFO,
    }
    local signs_text = {}
    local signs_texthl = {}
    local signs_numhl = {}
    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
      local sev = severity_map[sign.name]
      if sev then
        signs_text[sev] = sign.text
        signs_texthl[sev] = sign.name
        signs_numhl[sev] = sign.name
      end
    end
    if not vim.tbl_isempty(signs_text) then
      local current_signs = vim.tbl_get(vim.diagnostic.config(), "signs")
      local signs_cfg = type(current_signs) == "table" and vim.deepcopy(current_signs) or {}
      signs_cfg.text = vim.tbl_extend("keep", signs_cfg.text or {}, signs_text)
      signs_cfg.texthl = vim.tbl_extend("keep", signs_cfg.texthl or {}, signs_texthl)
      signs_cfg.numhl = vim.tbl_extend("keep", signs_cfg.numhl or {}, signs_numhl)
      vim.diagnostic.config { signs = signs_cfg }
    end
  end

  if not utils.is_directory(lvim.lsp.templates_dir) then
    require("lvim.lsp.templates").generate_templates()
  end

  pcall(function()
    require("nlspsettings").setup(lvim.lsp.nlsp_settings.setup)
  end)

  require("lvim.lsp.null-ls").setup()

  autocmds.configure_format_on_save()

  local function set_handler_opts_if_not_set(name, handler, opts)
    if debug.getinfo(vim.lsp.handlers[name], "S").source:find(vim.env.VIMRUNTIME, 1, true) then
      vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
    end
  end

  set_handler_opts_if_not_set("textDocument/hover", vim.lsp.handlers.hover, { border = "rounded" })
  set_handler_opts_if_not_set("textDocument/signatureHelp", vim.lsp.handlers.signature_help, { border = "rounded" })

  -- Enable rounded borders in :LspInfo window.
  require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
