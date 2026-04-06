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

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>*', function()
  builtin.live_grep({ default_text = vim.fn.expand('<cword>') })
end, { desc = 'Search current word' })

-- <C-q> send telescope list to quickfix
-- <C-o> go back to previous location
vim.keymap.set('n', '<leader>fg', builtin.live_grep,       { desc = 'Live grep' })
vim.keymap.set('n', '<C-f>',      builtin.live_grep,       { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,         { desc = 'Buffers' })
vim.keymap.set('n', '<C-b>',      builtin.buffers,         { desc = 'Buffers' })
vim.keymap.set('n', '<leader>ff', builtin.find_files,      { desc = 'Find files' })
vim.keymap.set('n', '<C-p>',      builtin.find_files,      { desc = 'Find files' })
vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'LSP definitions' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references,  { desc = 'LSP references' })
vim.keymap.set('n', '<leader>fi', builtin.diagnostics,     { desc = 'Diagnostics' })
