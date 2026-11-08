describe("xy-zed colorscheme", function()
  it("should load xy-zed auto-detect theme successfully", function()
    vim.o.background = "dark"
    vim.cmd("colorscheme xy-zed")
    assert.equal("xy-zed", vim.g.colors_name)
    assert.equal("dark", vim.o.background)

    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    assert.equal(1184274, normal.bg)
  end)

  it("should load xy-zed dark theme successfully", function()
    vim.cmd("colorscheme xy-zed-dark")
    assert.equal("xy-zed-dark", vim.g.colors_name)
    assert.equal("dark", vim.o.background)

    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    assert.is_not_nil(normal.bg)
    assert.is_not_nil(normal.fg)
    -- Check that Normal background matches #121212 (decimal 1184274)
    assert.equal(1184274, normal.bg)

    local cursor_nr = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
    -- Signature emerald green #7de486 (decimal 8250502)
    assert.equal(8250502, cursor_nr.fg)
  end)

  it("should load xy-zed light theme successfully", function()
    vim.cmd("colorscheme xy-zed-light")
    assert.equal("xy-zed-light", vim.g.colors_name)
    assert.equal("light", vim.o.background)

    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    assert.is_not_nil(normal.bg)
    assert.is_not_nil(normal.fg)
    -- Check that Normal background matches #fafbfc (decimal 16448508)
    assert.equal(16448508, normal.bg)

    local cursor_nr = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
    -- Signature emerald green light #059669 (decimal 366185)
    assert.equal(366185, cursor_nr.fg)
  end)

  it("should load lualine themes properly", function()
    local xy_zed = require("lualine.themes.xy-zed")
    assert.is_table(xy_zed.normal)
    assert.is_table(xy_zed.insert)
    assert.is_table(xy_zed.visual)

    local xy_zed_dark = require("lualine.themes.xy-zed-dark")
    assert.is_table(xy_zed_dark.normal)

    local xy_zed_light = require("lualine.themes.xy-zed-light")
    assert.is_table(xy_zed_light.normal)
  end)
end)
