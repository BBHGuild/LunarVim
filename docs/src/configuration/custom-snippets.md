# Custom Snippets

LunarVim uses `LuaSnip` as its snippet engine, populated out of the box with community snippets from `friendly-snippets`.

---

## Defining Lua Snippets

Create custom snippet files inside `~/.config/lvim/luasnippets/` named after the target `filetype`:

```text
~/.config/lvim/
└── luasnippets/
    ├── lua.lua
    ├── python.lua
    ├── rust.lua
    └── solidity.lua
```

### Example: `luasnippets/solidity.lua`
```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Prefix: "customerror"
  s("customerror", {
    t("error "),
    i(1, "Unauthorized"),
    t("("),
    i(2, "address caller"),
    t(");"),
  }),

  -- Prefix: "revertwith"
  s("revertwith", {
    t("if ("),
    i(1, "condition"),
    t(") revert "),
    i(2, "CustomError"),
    t("();"),
  }),
}
```

LuaSnip automatically reloads Lua snippet files on save.

---

## Defining VSCode-Style JSON Snippets

Alternatively, you can provide standard VSCode JSON format snippets:

1. Create a `package.json` inside `~/.config/lvim/snippets/package.json`:
```json
{
  "name": "lvim-custom-snippets",
  "engines": { "vscode": "^1.11.0" },
  "contributes": {
    "snippets": [
      {
        "language": "python",
        "path": "./python.json"
      }
    ]
  }
}
```

2. Create the language definition file `~/.config/lvim/snippets/python.json`:
```json
{
  "main_block": {
    "prefix": "ifmain",
    "body": [
      "if __name__ == \"__main__\":",
      "    ${1:main()}"
    ],
    "description": "Standard Python __main__ guard"
  }
}
```

---

## Expanding & Navigating Snippets

In Insert mode:
- Type the prefix (e.g. `customerror` or `ifmain`) and press `<CR>` or `<Tab>` in the autocompletion menu to expand.
- Press `<Tab>` to jump forward to the next placeholder `${1}`, `${2}`, etc.
- Press `<S-Tab>` to jump backward to previous placeholders.
