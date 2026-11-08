local palette = require("xy-zed.palette")
local c = palette.dark

return {
  normal = {
    a = { fg = c.bg, bg = c.accent, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_surface },
    c = { fg = c.fg_sidebar, bg = c.bg_statusline },
  },
  insert = {
    a = { fg = c.bg, bg = c.green, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_surface },
    c = { fg = c.fg_sidebar, bg = c.bg_statusline },
  },
  visual = {
    a = { fg = c.bg, bg = c.keyword, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_surface },
    c = { fg = c.fg_sidebar, bg = c.bg_statusline },
  },
  command = {
    a = { fg = c.bg, bg = c.yellow, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_surface },
    c = { fg = c.fg_sidebar, bg = c.bg_statusline },
  },
  replace = {
    a = { fg = c.bg, bg = c.red, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_surface },
    c = { fg = c.fg_sidebar, bg = c.bg_statusline },
  },
  inactive = {
    a = { fg = c.fg_gutter, bg = c.bg_statusline },
    b = { fg = c.fg_gutter, bg = c.bg_statusline },
    c = { fg = c.fg_inactive, bg = c.bg_statusline },
  },
}
