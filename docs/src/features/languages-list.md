# All Supported Languages Catalog

Below is the technical matrix of supported language servers, formatters, and Treesitter parsers available out of the box in LunarVim.

---

| Language | Primary LSP Server | Formatters | Linters | Treesitter Parser |
| :--- | :--- | :--- | :--- | :--- |
| **Ansible** | `ansiblels` | `ansible-lint` | `ansible-lint` | `:TSInstall yaml` |
| **Bash / Shell** | `bashls` | `shfmt`, `beautysh` | `shellcheck` | `:TSInstall bash` |
| **C / C++** | `clangd`, `ccls` | `clang-format` | `cppcheck`, `clang-tidy` | `:TSInstall cpp` |
| **C#** | `omnisharp`, `csharp_ls` | `csharpier` | — | `:TSInstall c_sharp` |
| **CSS / SCSS** | `cssls`, `tailwindcss` | `prettier`, `stylelint` | `stylelint` | `:TSInstall css` |
| **Docker** | `dockerls` | — | `hadolint` | `:TSInstall dockerfile` |
| **Go** | `gopls` | `gofumpt`, `goimports` | `golangci-lint` | `:TSInstall go` |
| **GraphQL** | `graphql` | `prettier` | — | `:TSInstall graphql` |
| **HTML** | `html` | `prettier` | `htmlhint` | `:TSInstall html` |
| **Java** | `jdtls` | `google-java-format` | `checkstyle` | `:TSInstall java` |
| **JavaScript / JSX** | `ts_ls`, `eslint` | `prettier`, `biome` | `eslint_d` | `:TSInstall javascript` |
| **JSON** | `jsonls` | `prettier`, `fixjson` | `jsonlint` | `:TSInstall json` |
| **Julia** | `julials` | — | — | `:TSInstall julia` |
| **Lua** | `lua_ls` | `stylua` | `luacheck` | `:TSInstall lua` |
| **Markdown** | `marksman` | `prettier`, `markdownlint` | `markdownlint` | `:TSInstall markdown` |
| **PowerShell** | `powershell_es` | — | `psscriptanalyzer` | — |
| **Python** | `pyright`, `pylsp` | `black`, `isort`, `yapf` | `flake8`, `mypy`, `pylint` | `:TSInstall python` |
| **Ruby** | `solargraph`, `sorbet` | `rubocop` | `rubocop` | `:TSInstall ruby` |
| **Rust** | `rust_analyzer` | `rustfmt` | `clippy` | `:TSInstall rust` |
| **Scala** | `metals` | `scalafmt` | — | `:TSInstall scala` |
| **Solidity** | `forge lsp` (native) | `forge fmt` | `solhint` | `:TSInstallSync solidity` |
| **Swift** | `sourcekit` | `swiftformat` | `swiftlint` | `:TSInstall swift` |
| **Terraform / HCL** | `terraformls`, `tflint` | `terraform_fmt` | `tflint` | `:TSInstall terraform` |
| **TypeScript / TSX** | `ts_ls`, `eslint` | `prettier`, `biome` | `eslint_d` | `:TSInstall typescript` |
| **YAML** | `yamlls` | `prettier` | `yamllint` | `:TSInstall yaml` |
