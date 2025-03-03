-- If lazy.nvim is not present, install it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Plugins spec
local plugins_table = {
  -- A S T H E T I C S and UI
  {
    'ishan9299/nvim-solarized-lua',
    lazy = false,
    priority = 1000
  },
  {'nvim-lualine/lualine.nvim', lazy = false},
  {'kdheepak/tabline.nvim', lazy = false},
  {'nvim-tree/nvim-web-devicons', lazy = false},

  -- Common plugins
  {'caenrique/swap-buffers.nvim', event = "VeryLazy"},
  {'unblevable/quick-scope', keys = {'f', mode = 'n'}},
  {'yssl/QFEnter', event = "VeryLazy"},
  {'kyazdani42/nvim-tree.lua', layz = false},
  {'junegunn/vim-easy-align', event = "VeryLazy"},
  {'majutsushi/tagbar', cmd = {'TagbarToggle'}},
  {'tpope/vim-fugitive', event = "VeryLazy"},
  {'tpope/vim-surround', event = "VeryLazy"},
  {'tpope/vim-repeat', event = "VeryLazy"},
  {'wgurecky/vimSum', build = ':UpdateRemotePlugins', cmd = {'VisMath', 'VisSum', 'VisMean', 'VisMult'}},

  -- find and search
  {"junegunn/fzf", build = ":call fzf#install()", event = "VeryLazy"},
  -- 'junegunn/fzf.vim',
  -- 'mileszs/ack.vim',
  {'mhinz/vim-grepper', event = "VeryLazy"},

  -- neovim extras
  -- Run :TSUpdate to update parsers
  {'nvim-treesitter/nvim-treesitter',
    dependencies = {
    },
  },
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',

  -- dev tools
  {'tpope/vim-dispatch', ft = {'cpp', 'c', 'fortran'}, cmd = {'Make'}},
  {'lervag/vimtex', ft = {'tex'}},
  {'nvimtools/none-ls.nvim', event = "InsertEnter"},

  -- lsp diagnostic formatting
  {'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },

  -- code auto completion
  'neovim/nvim-lspconfig',
  'saghen/blink.cmp',
   {'L3MON4D3/LuaSnip', event = "VeryLazy"}
}
-- END plugin spec

-- Configure lazy.nvim options
local opts_table = {
  defaults = {
    lazy = true,
  },
}
-- END lazy.nvim config

-- Load lazy.nvim
require('lazy').setup(plugins_table, opts_table)
