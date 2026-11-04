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

## EVM Trace LSP (`trace-lsp`)

LunarVim also supports `trace-lsp` for navigating and inspecting EVM execution traces, call stacks, and reverts when debugging transactions and smart contract test failures.

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
