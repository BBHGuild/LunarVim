local M = {}

if vim.fn.has "nvim-0.10" ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Lunarvim requires v0.10+", vim.log.levels.WARN)
  vim.wait(5000, function()
    ---@diagnostic disable-next-line: redundant-return-value
    return false
  end)
  vim.cmd "cquit"
end

local uv = vim.uv or vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

_G.require_clean = require("lvim.utils.modules").require_clean
_G.require_safe = require("lvim.utils.modules").require_safe
_G.reload = require("lvim.utils.modules").reload

---Get the full path to `$LUNARVIM_RUNTIME_DIR`
---@return string|nil
function _G.get_runtime_dir()
  local lvim_runtime_dir = os.getenv "LUNARVIM_RUNTIME_DIR"
  if not lvim_runtime_dir then
    -- when nvim is used directly
    return vim.call("stdpath", "data")
  end
  return lvim_runtime_dir
end

---Get the full path to `$LUNARVIM_CONFIG_DIR`
---@return string|nil
function _G.get_config_dir()
  local lvim_config_dir = os.getenv "LUNARVIM_CONFIG_DIR"
  if not lvim_config_dir then
    return vim.call("stdpath", "config")
  end
  return lvim_config_dir
end

---Get the full path to `$LUNARVIM_CACHE_DIR`
---@return string|nil
function _G.get_cache_dir()
  local lvim_cache_dir = os.getenv "LUNARVIM_CACHE_DIR"
  if not lvim_cache_dir then
    return vim.call("stdpath", "cache")
  end
  return lvim_cache_dir
end

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init(base_dir)
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_dir = get_cache_dir()
  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.lazy_install_dir = join_paths(self.pack_dir, "lazy", "opt", "lazy.nvim")

  -- Neovim 0.10/0.11+ compatibility layer for third-party plugins
  local type_aliases = {
    b = "boolean",
    c = "callable",
    f = "function",
    n = "number",
    s = "string",
    t = "table",
  }
  local orig_validate = vim.validate
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.validate = function(name, value, validator, optional, message)
    if validator ~= nil then
      return orig_validate(name, value, validator, optional, message)
    elseif type(name) == "table" then
      for k, spec in pairs(name) do
        if type(spec) == "table" then
          local v_type = spec[2]
          if type(v_type) == "string" then
            v_type = type_aliases[v_type] or v_type
          elseif type(v_type) == "table" then
            local mapped = {}
            for i, t in ipairs(v_type) do
              mapped[i] = type_aliases[t] or t
            end
            v_type = mapped
          end
          orig_validate(k, spec[1], v_type, spec[3], spec[4])
        end
      end
      return
    end
    return orig_validate(name, value, validator, optional, message)
  end
  if vim.islist then
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.tbl_islist = vim.islist
  end
  if vim.iter then
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.tbl_flatten = function(t)
      return vim.iter(t):flatten(math.huge):totable()
    end
  end
  if vim.lsp and vim.lsp.get_clients then
    if vim.lsp.start then
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.lsp.start_client = function(config)
        return vim.lsp.start(config, {
          attach = false,
          reuse_client = function()
            return false
          end,
        })
      end
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.get_active_clients = vim.lsp.get_clients
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf_get_clients = function(bufnr)
      local result = {}
      for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr or vim.api.nvim_get_current_buf() }) do
        result[client.id] = client
      end
      return result
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.for_each_buffer_client = function(bufnr, fn)
      for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        fn(client, client.id, bufnr)
      end
    end
  end
  if vim.diagnostic and vim.diagnostic.is_enabled then
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.diagnostic.is_disabled = function(opts, namespace)
      if type(opts) == "number" then
        return not vim.diagnostic.is_enabled { bufnr = opts, ns_id = namespace }
      elseif type(opts) == "table" then
        return not vim.diagnostic.is_enabled(opts)
      else
        return not vim.diagnostic.is_enabled()
      end
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.diagnostic.disable = function(bufnr, namespace)
      vim.diagnostic.enable(false, { bufnr = bufnr, ns_id = namespace })
    end
  end

  ---@meta overridden to use LUNARVIM_CACHE_DIR instead, since a lot of plugins call this function internally
  ---NOTE: changes to "data" are currently unstable, see #2507
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.stdpath = function(what)
    if what == "cache" then
      return _G.get_cache_dir()
    end
    return vim.call("stdpath", what)
  end

  ---Get the full path to LunarVim's base directory
  ---@return string
  function _G.get_lvim_base_dir()
    return base_dir
  end

  if os.getenv "LUNARVIM_RUNTIME_DIR" then
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site"))
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site", "after"))
    -- vim.opt.rtp:prepend(join_paths(self.runtime_dir, "site"))
    vim.opt.rtp:append(join_paths(self.runtime_dir, "lvim", "after"))
    vim.opt.rtp:append(join_paths(self.runtime_dir, "site", "after"))

    vim.opt.rtp:remove(vim.call("stdpath", "config"))
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "config"), "after"))
    vim.opt.rtp:prepend(self.config_dir)
    vim.opt.rtp:append(join_paths(self.config_dir, "after"))

    vim.opt.packpath = vim.opt.rtp:get()
  end

  require("lvim.plugin-loader").init {
    package_root = self.pack_dir,
    install_path = self.lazy_install_dir,
  }

  require("lvim.config"):init()

  require("lvim.core.mason").bootstrap()

  return self
end

---Update LunarVim
---pulls the latest changes from github and, resets the startup cache
function M:update()
  require("lvim.core.log"):info "Trying to update LunarVim..."

  vim.schedule(function()
    reload("lvim.utils.hooks").run_pre_update()
    local ret = reload("lvim.utils.git").update_base_lvim()
    if ret then
      reload("lvim.utils.hooks").run_post_update()
    end
  end)
end

return M
