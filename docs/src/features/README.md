# Features & Supported Languages

LunarVim delivers an IDE-grade development workflow for modern software engineering out of the box.

---

## Core Pillars

### 1. Smart Language Server (LSP) Engine
Every supported language benefits from intelligent completion, go-to-definition, hover documentation, find references, document symbols, and refactoring actions without complex manual wiring.

### 2. High-Fidelity Treesitter Parsing
Real-time abstract syntax tree analysis replaces naive regex patterns, giving you rock-solid syntax highlighting, intelligent indentation, context-aware comments, and structural text selections.

### 3. Integrated Debugging (DAP)
Interactive stepping, breakpoint management, stack inspection, and variable watch expressions directly inside Neovim without leaving your terminal.

### 4. Zero-Friction Tool Provisioning (Mason)
External LSP binaries, debug adapters, linters, and formatters are managed natively inside Neovim via `:Mason`.

---

## Language Support Highlights

LunarVim provides first-class support for modern stacks:
- **[Solidity & EVM](solidity.md)**: Native Foundry `forge lsp` integration, `trace-lsp`, compile error diagnostics, and formatter support.
- **[Rust](rust.md)**: High-speed `rust-analyzer` integration, `rustfmt`, and `codelldb` debugging.
- **[Python](python.md)**: `pyright`, `black`, `isort`, `flake8`, and `debugpy`.
- **[TypeScript & JavaScript](typescript.md)**: `tsserver` / `ts_ls`, `prettier`, `eslint_d`.
- **[Go](go.md)**: `gopls`, `gofumpt`, `golangci-lint`, and `delve`.
- **[Lua](lua.md)**: `lua_ls` with full Neovim API type annotations, `stylua`.
- **[C / C++](c_cpp.md)**: `clangd`, `clang-format`, and `codelldb`.
- **[All Supported Languages](languages-list.md)**: Complete catalog of languages supported out of the box.
