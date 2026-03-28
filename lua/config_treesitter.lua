-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "rust", "python", "markdown", "rst", "lua", "vim", "json" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "fortran", "latex", "markdown" },
  highlight = {
    enable = true,
    disable = { "fortran", "latex", "markdown"},
    additional_vim_regex_highlighting = false,
  }
}

