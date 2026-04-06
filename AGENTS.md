# AGENTS.md — Neovim Config Repo

Personal Neovim configuration. No shell build system, CI, or test framework.

## Entry point

`init.lua` (root) — loads options, keymaps, then requires `lua/plugins.lua` and `lua/config*.lua` files.  
`lua/init.lua` is an **empty stub** — not the entry point.

## Plugin manager

`lazy.nvim` — auto-bootstraps on first launch. Pinned versions in `lazy-lock.json`.  
After cloning, start Neovim; plugins install automatically.

Key in-editor commands:
- `:Lazy sync` — install/update plugins
- `:TSUpdate` — update Treesitter parsers
- `:UpdateRemotePlugins` — required once after installing `vimSum`

## Directory map

```
init.lua                  root entry point
lua/plugins.lua           all lazy.nvim plugin specs
lua/config.lua            nvim-tree, lualine, LSP keymaps, diagnostics, luasnip loader
lua/config_lsp.lua        LSP server configs (ty, ruff, fortls, clangd, rust_analyzer)
lua/config_blink.lua      blink.cmp completion setup
lua/config_telescope.lua  Telescope setup + keymaps
lua/config_codecompanion.lua  CodeCompanion AI setup
lua/config_copilot.lua    Copilot (adapter-only, no inline suggestions)
lua/config_treesitter.lua empty stub — parsers need manual :TSInstall
lua/config_opencode.lua   TODO stub — not functional yet
ftplugin/                 per-filetype overrides (indent, makeprg, compiler)
my_lsp_snips/             active VSCode-format snippets loaded by LuaSnip
UltiSnips/                legacy, not loaded
init.old.vim              legacy vimscript reference, not sourced
autoload/get-vim-plug.sh  historical artifact, not used
```

## Non-obvious conventions

**Indentation** — global default is 4 spaces; `ftplugin/` overrides:
- `c`, `cpp`, `lua`, `fortran`: **2 spaces**

**Diagnostics** — `virtual_text` and `underline` are both **off**. Diagnostics appear as a float on `CursorHold` or via `<leader>di`.

**Mouse** — explicitly disabled (`set mouse=`).

**Trailing whitespace** — highlighted red; `<leader>u` strips current line, `:Unfuck` strips whole file.

**Arrow keys (normal mode)** — remapped to window resize, not cursor movement.

**Comma `,`** — remapped to `@@` (repeat last macro), not reverse-find.

## AI / CodeCompanion

- The entire AI block (CodeCompanion + Copilot) only loads when `ANTHROPIC_API_KEY` **or** `ENABLE_COPILOT` env var is set.
- Copilot inline suggestions and panel are **disabled** — Copilot is wired as an LLM adapter for CodeCompanion only.
- Chat adapter: `opencode`, model `claude-haiku-4`; inline adapter: `anthropic`, model `claude-haiku-4-5`.
- `config_opencode.lua` is a TODO stub; the `opencode` adapter is referenced but not yet configured.
- Drop a `.cc_context.md` file at a git repo root (one file path per line) and use `/context_file` inside the CodeCompanion buffer to inject context.
