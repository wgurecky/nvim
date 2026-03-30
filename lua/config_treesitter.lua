-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "rust", "python", "markdown", "rst", "json" },
  sync_install = true,
  auto_install = true,
  -- ignore_install = { "fortran", "latex", "vim", "lua" },
  highlight = {
    enable = true,
    disable = { "fortran", "latex", "vim", "lua" },
    -- additional_vim_regex_highlighting = false,
  }
}
