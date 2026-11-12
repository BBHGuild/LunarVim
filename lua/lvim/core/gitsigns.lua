local M = {}

M.config = function()
  lvim.builtin.gitsigns = {
    active = true,
    on_config_done = nil,
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = lvim.icons.ui.BoldLineLeft,
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = lvim.icons.ui.BoldLineLeft,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = lvim.icons.ui.Triangle,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = lvim.icons.ui.Triangle,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = lvim.icons.ui.BoldLineLeft,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      status_formatter = nil, -- Use default
      update_debounce = 200,
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = { enable = false },
    },
  }
end

M.setup = function()
  local gitsigns = reload "gitsigns"

  gitsigns.setup(lvim.builtin.gitsigns.opts)
  if lvim.builtin.gitsigns.on_config_done then
    lvim.builtin.gitsigns.on_config_done(gitsigns)
  end
end

M.close_diff = function()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local gitsigns_wins = {}
  local other_diff_wins = {}
  local other_normal_wins = {}

  for _, w in ipairs(wins) do
    if vim.api.nvim_win_is_valid(w) and vim.api.nvim_win_get_config(w).relative == "" then
      local b = vim.api.nvim_win_get_buf(w)
      local bname = vim.api.nvim_buf_get_name(b)
      local ft = vim.bo[b].filetype
      local bt = vim.bo[b].buftype
      if bname:find "^gitsigns://" or (vim.wo[w].diff and (bt == "nowrite" or bt == "acwrite")) then
        table.insert(gitsigns_wins, w)
      else
        if vim.wo[w].diff then
          table.insert(other_diff_wins, w)
        end
        if ft ~= "NvimTree" and ft ~= "trouble" and ft ~= "qf" and ft ~= "lir" and ft ~= "Outline" and bt == "" then
          table.insert(other_normal_wins, w)
        end
      end
    end
  end

  if #gitsigns_wins == 0 then
    return false
  end

  local cur_win = vim.api.nvim_get_current_win()
  if vim.tbl_contains(gitsigns_wins, cur_win) then
    if #other_diff_wins > 0 and vim.api.nvim_win_is_valid(other_diff_wins[1]) then
      vim.api.nvim_set_current_win(other_diff_wins[1])
    elseif #other_normal_wins > 0 and vim.api.nvim_win_is_valid(other_normal_wins[1]) then
      vim.api.nvim_set_current_win(other_normal_wins[1])
    else
      local bname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(cur_win))
      local relpath = bname:match "^gitsigns://.-/.+:(.*)$"
      vim.cmd "diffoff"
      if relpath and relpath ~= "" and vim.fn.filereadable(relpath) == 1 then
        vim.cmd("edit " .. vim.fn.fnameescape(relpath))
        return true
      end
      return false
    end
  end

  for _, w in ipairs(gitsigns_wins) do
    if vim.api.nvim_win_is_valid(w) and #vim.api.nvim_tabpage_list_wins(0) > 1 then
      pcall(vim.api.nvim_win_close, w, true)
    end
  end

  for _, w in ipairs(other_diff_wins) do
    if vim.api.nvim_win_is_valid(w) then
      pcall(vim.api.nvim_win_call, w, function()
        vim.cmd "diffoff"
      end)
    end
  end

  return true
end

M.toggle_diff = function(base)
  if M.close_diff() then
    return
  end
  vim.cmd("Gitsigns diffthis " .. (base or "HEAD"))
end

return M
