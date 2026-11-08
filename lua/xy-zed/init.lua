local M = {}
local theme = require("xy-zed.theme")
local palette = require("xy-zed.palette")

---Set ANSI terminal colors based on current palette variant
---@param c table
local function set_terminal_colors(c)
  local term = c.terminal
  if not term then
    return
  end
  vim.g.terminal_color_0 = term.black
  vim.g.terminal_color_1 = term.red
  vim.g.terminal_color_2 = term.green
  vim.g.terminal_color_3 = term.yellow
  vim.g.terminal_color_4 = term.blue
  vim.g.terminal_color_5 = term.magenta
  vim.g.terminal_color_6 = term.cyan
  vim.g.terminal_color_7 = term.white
  vim.g.terminal_color_8 = term.bright_black
  vim.g.terminal_color_9 = term.bright_red
  vim.g.terminal_color_10 = term.bright_green
  vim.g.terminal_color_11 = term.bright_yellow
  vim.g.terminal_color_12 = term.bright_blue
  vim.g.terminal_color_13 = term.bright_magenta
  vim.g.terminal_color_14 = term.bright_cyan
  vim.g.terminal_color_15 = term.bright_white
end

---Load the xy-zed colorscheme
---@param variant? "dark"|"light"
function M.load(variant)
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  local colors_name
  if variant == "light" then
    vim.o.background = "light"
    colors_name = "xy-zed-light"
  elseif variant == "dark" then
    vim.o.background = "dark"
    colors_name = "xy-zed-dark"
  else
    -- If variant unspecified, determine by existing vim.o.background
    colors_name = "xy-zed"
    variant = vim.o.background == "light" and "light" or "dark"
  end

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = colors_name

  local c = palette.get(variant)
  set_terminal_colors(c)
  theme.set_highlights(variant)
end

---Setup function compatible with standard plugin managers
---@param opts? table
function M.setup(opts)
  opts = opts or {}
  local variant = opts.variant or (vim.o.background == "light" and "light" or "dark")
  M.load(variant)
end

return M
