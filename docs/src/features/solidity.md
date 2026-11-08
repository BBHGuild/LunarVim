# Solidity & EVM Development

LunarVim features first-class, high-performance tooling for Ethereum and EVM smart contract engineering.

---

## Native Foundry LSP (`forge lsp`)

Instead of relying on fragile external npm packages (such as `solidity-ls` or `nomad-lsp`), this branch of LunarVim integrates directly with [Foundry's](https://github.com/foundry-rs/foundry) native language server (`forge lsp --stdio`).

### Key Benefits
- **Zero NPM Dependencies**: Eliminates `spawn solc ENOENT` errors and heavy NodeJS runtime dependencies.
- **Accurate Project Context**: Reads `foundry.toml` and `remappings.txt` natively, providing instant resolution of OpenZeppelin, Solmate, and other dependencies.
- **Position Encoding**: Fully compatible with Neovim 0.10+ and 0.11+ UTF-8/UTF-16 position encodings without telescope deprecation warnings.

### How It Works
When opening any `.sol` file inside a Foundry repository, LunarVim automatically detects the project root and starts `forge lsp`:

```lua
-- Handled automatically via ftplugin/solidity.lua
require("lvim.lsp.providers.forge_lsp").setup()
```

If `forge` is not installed on your system PATH, LunarVim warns you to install Foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

---

## EVM Trace LSP & Trace Generation

### Running Tests & Generating Traces (`:ForgeTraceMethod`)

LunarVim includes an integrated task runner replicating the Zed trace pipeline:
- **Command**: `:ForgeTraceMethod`
- **Keybindings**: `<leader>tt` or `<leader>tr`

When your cursor is positioned inside or hovering over any test function (e.g., `test_deposit()`):
1. **Context Detection**: Uses Treesitter AST to extract the active test method and enclosing contract name.
2. **Execution**: Sources `.env` (if present) and runs:
   ```bash
   forge test --mp <file> --mc <contract> --mt <test_method> -vvvvv --decode-internal 2>&1 | tee <test_dir>/tx-trace-test.trace
   ```
3. **Clipboard Sync**: Copies the test function name to your system clipboard (`+` register / `wl-copy`).
4. **Buffer Navigation**: Creates `tx-trace-test.trace` directly in the test file's folder and automatically opens it in LunarVim for immediate inspection.

### High-Contrast Hover Popups (`K`)

Hover popups (`K` on any function, contract, or trace call) are rendered with:
- **Rounded Emerald Borders**: Styled with the theme's accent color (`#7de486` in Dark, `#059669` in Light) so the popup boundary is clearly delineated.
- **Solid Window Background**: Floating window uses a distinct background (`#1b1b1b` / `#ffffff`) to ensure popup text never blends into the underlying buffer.

---

## Bottom Symbol Outline Dock

Press **`<leader>O`** or **`Alt-o`** to toggle a bottom-docked hierarchical symbol outline panel powered by Trouble.

### Tree-sitter Syntax Highlighting & Formatting
- **Tree-sitter Syntax Highlighted**: Each outline row is parsed through the active buffer's Tree-sitter grammar (`{text:ts}`), providing full keyword, type, contract, and argument colorization directly in the symbol dock.
- **De-duplicated Labels**: Eliminates redundant duplicate function names by cleanly showing the syntax-highlighted call signature and parameters without repeat identifier prefixes.

### Sibling Tree Folding Controls
When the symbol outline dock is focused:
- **`s`**: **Accordion / Solo Toggle** — opens the current symbol and collapses all its sibling trees.
- **`C`**: **Collapse Siblings** — collapses all sibling trees at the current hierarchy level.
- **`S`**: **Expand Siblings** — expands all sibling trees at the current hierarchy level.
- **`E`**: **Recursive Expand** — recursively expands all sibling trees and sub-children.
- **`h`** / **`l`**: Close / open the selected node.
- **`<Tab>`** / **`<Space>`** / **`o`**: Toggle fold open/closed.
- **`zM`** / **`zR`**: Collapse all / expand all symbols across the entire file.

---

## Syntax Highlighting (Treesitter)

Ensure Treesitter's Solidity parser is compiled and up to date:
```vim
:TSInstallSync solidity
```

If Treesitter queries ever encounter grammar version mismatches after updating Neovim:
```vim
:TSUpdateSync solidity
```

---

## Formatting & Linting

### Foundry Formatter (`forge fmt`)
To use `forge fmt` as your default formatter, add it to `lvim.lsp.null-ls.formatters`:

```lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    name = "forge_fmt",
    command = "forge",
    args = { "fmt", "--raw", "-" },
    filetypes = { "solidity" },
  },
})
```

### Solhint Linter
Install `solhint` via Mason (`:Mason`) and register in `config.lua`:

```lua
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { name = "solhint", filetypes = { "solidity" } },
})
```
