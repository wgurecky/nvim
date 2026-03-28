-- telescope.nvim setup
local actions = require('telescope.actions')
require'telescope'.setup{
  defaults = {
    preview = {
      treesitter = {
        enable = false
      }
    },
    file_ignore_patterns = { "^build/", "build/", "/build/", "/target/", "target/" }
  }
}

