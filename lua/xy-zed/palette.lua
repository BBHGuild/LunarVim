local M = {}

M.dark = {
  name = "xy-zed",
  appearance = "dark",

  -- Base
  bg = "#121212",
  bg_dark = "#0a0a0a",
  bg_highlight = "#202e21", -- active line (#7de48622 blended with #121212)
  bg_surface = "#1b1b1b",
  bg_popup = "#1b1b1b",
  bg_statusline = "#0a0a0a",
  bg_visual = "#283d2a", -- selection (#7de48635 blended with #121212)
  bg_search = "#442d1e", -- search match (#975c3250 blended)
  float_bg = "#1b1b1b",

  fg = "#f7f7f8",
  fg_dark = "#aca8ae",
  fg_gutter = "#56565e",
  fg_sidebar = "#aca8ae",
  fg_inactive = "#6b6b73",

  -- Signature XY-Zed Accent (Emerald Green)
  accent = "#7de486",
  accent_dim = "#7ce184",

  border = "#2a2a2a",
  border_highlight = "#7de486",

  dark3 = "#3a3c44",
  dark5 = "#7de486",

  -- Syntax Elements
  keyword = "#c678dd",
  ["function"] = "#DCDCAA",
  type = "#08e7c5",
  string = "#CD9069",
  number = "#B4CDA8",
  boolean = "#22c942",
  constant = "#FF5858",
  constructor = "#FF5858",
  property = "#9cdcfe",
  variable = "#7cc6f8",
  operator = "#ffd866",
  punctuation = "#9a9aa3",
  comment = "#6A9955",
  attribute = "#4788CC",
  tag = "#7ce184",
  link = "#2f81f7",
  title = "#85b8ff",

  -- General Palette mapping
  blue = "#7cc6f8",
  blue1 = "#4788CC",
  blue2 = "#2f81f7",
  blue5 = "#9cdcfe",
  cyan = "#08e7c5",
  teal = "#10a793",
  magenta = "#c678dd",
  magenta2 = "#c74cec",
  purple = "#c678dd",
  orange = "#CD9069",
  yellow = "#ffd866",
  green = "#96df71",
  green1 = "#7ce184",
  green2 = "#22c942",
  red = "#f82871",
  red1 = "#FF5858",

  -- Diagnostics
  error = "#f82871",
  warning = "#fee56c",
  info = "#10a793",
  hint = "#618399",
  bg_vtext_hint = "#132a26",
  bg_vtext_info = "#162635",
  bg_vtext_warn = "#2e2a1d",
  bg_vtext_error = "#2d1a22",

  -- Git
  git_add = "#96df71",
  git_change = "#fee56c",
  git_delete = "#f82871",
  gitsigns_add = "#96df71",
  gitsigns_change = "#fee56c",
  gitsigns_delete = "#f82871",
  diff_add = "#184618",
  diff_change = "#2a3948",
  diff_delete = "#54051b",
  diff_text = "#395873",

  black = "#0a0a0a",
  terminal_black = "#1e2025",

  -- Terminal ANSI colors
  terminal = {
    black = "#1e2025",
    bright_black = "#6b6b73",
    red = "#f82871",
    bright_red = "#ffa3b5",
    green = "#96df71",
    bright_green = "#cef0b9",
    yellow = "#fee56c",
    bright_yellow = "#fef1b7",
    blue = "#10a793",
    bright_blue = "#9cd4c7",
    magenta = "#c74cec",
    bright_magenta = "#e7abf7",
    cyan = "#08e7c5",
    bright_cyan = "#a9f4e1",
    white = "#dcdcdf",
    bright_white = "#ffffff",
  },
}

M.light = {
  name = "xy-zed-light",
  appearance = "light",

  -- Base
  bg = "#fafbfc",
  bg_dark = "#eceef1",
  bg_highlight = "#e2f1ee", -- active line (#05966918 on #fafbfc)
  bg_surface = "#f1f3f5",
  bg_popup = "#ffffff",
  bg_statusline = "#eceef1",
  bg_visual = "#d3ebe4", -- selection (#05966928)
  bg_search = "#fcf5c2", -- search match (#fef08a80)
  float_bg = "#ffffff",

  fg = "#24292f",
  fg_dark = "#57606a",
  fg_gutter = "#8c959f",
  fg_sidebar = "#57606a",
  fg_inactive = "#8c959f",

  -- Signature XY-Zed Light Accent (Deep Emerald Green)
  accent = "#059669",
  accent_dim = "#10b981",

  border = "#d0d7de",
  border_highlight = "#059669",

  dark3 = "#d0d7de",
  dark5 = "#059669",

  -- Syntax Elements
  keyword = "#8250df",
  ["function"] = "#953800",
  type = "#007a8c",
  string = "#a31515",
  number = "#1a7f37",
  boolean = "#1a7f37",
  constant = "#cf222e",
  constructor = "#cf222e",
  property = "#0550ae",
  variable = "#0a3069",
  operator = "#24292f",
  punctuation = "#57606a",
  comment = "#6e7781",
  attribute = "#0969da",
  tag = "#059669",
  link = "#0550ae",
  title = "#0969da",

  -- General Palette mapping
  blue = "#0a3069",
  blue1 = "#0969da",
  blue2 = "#0550ae",
  blue5 = "#0969da",
  cyan = "#007a8c",
  teal = "#007a8c",
  magenta = "#8250df",
  magenta2 = "#a475f9",
  purple = "#8250df",
  orange = "#953800",
  yellow = "#9a6700",
  green = "#1a7f37",
  green1 = "#059669",
  green2 = "#1a7f37",
  red = "#cf222e",
  red1 = "#cf222e",

  -- Diagnostics
  error = "#cf222e",
  warning = "#9a6700",
  info = "#0969da",
  hint = "#007a8c",
  bg_vtext_hint = "#e6f7f3",
  bg_vtext_info = "#e6f0fa",
  bg_vtext_warn = "#fcf4db",
  bg_vtext_error = "#fde8e8",

  -- Git
  git_add = "#1a7f37",
  git_change = "#9a6700",
  git_delete = "#cf222e",
  gitsigns_add = "#1a7f37",
  gitsigns_change = "#9a6700",
  gitsigns_delete = "#cf222e",
  diff_add = "#dafbe1",
  diff_change = "#ddf4ff",
  diff_delete = "#ffebe9",
  diff_text = "#b6e3ff",

  black = "#24292f",
  terminal_black = "#6e7781",

  -- Terminal ANSI colors
  terminal = {
    black = "#24292f",
    bright_black = "#6e7781",
    red = "#cf222e",
    bright_red = "#e5534b",
    green = "#1a7f37",
    bright_green = "#2da44e",
    yellow = "#9a6700",
    bright_yellow = "#bf8700",
    blue = "#0969da",
    bright_blue = "#218bff",
    magenta = "#8250df",
    bright_magenta = "#a475f9",
    cyan = "#007a8c",
    bright_cyan = "#087ea4",
    white = "#6e7781",
    bright_white = "#8c959f",
  },
}

function M.get(variant)
  if variant == "light" then
    return M.light
  elseif variant == "dark" then
    return M.dark
  else
    return vim.o.background == "light" and M.light or M.dark
  end
end

return M
