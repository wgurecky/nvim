-- If packer.nvim is not present, install it
local fn = vim.fn
-- On Ubuntu defaults to ~/.local/share/nvim/site/pack/packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Plugins config
return require('packer').startup(
{ function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A S T H E T I C S
  use 'iCyMind/NeoSolarized'
  use 'hoob3rt/lualine.nvim'
  use 'kdheepak/tabline.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Common plugins
  use 'unblevable/quick-scope'
  use 'yssl/QFEnter'
  use 'kyazdani42/nvim-tree.lua'
  use 'junegunn/vim-easy-align'
  -- use 'terryma/vim-multiple-cursors'
  use {'majutsushi/tagbar', cmd = {'TagbarToggle'}}
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use {'wgurecky/vimSum', run = ':UpdateRemotePlugins', cmd = {'VisMath', 'VisSum', 'VisMean', 'VisMult'}}

  -- find and search
  use {"junegunn/fzf", run = ":call fzf#install()"}
  -- use 'junegunn/fzf.vim'
  -- use 'mileszs/ack.vim'
  use 'mhinz/vim-grepper'

  -- neovim extras
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-telescope/telescope.nvim'

  -- dev tools
  use {'tpope/vim-dispatch', ft = {'cpp', 'c', 'fortran'}, cmd = {'Make'}}
  use {'lervag/vimtex', ft = {'tex'}}
  -- use {'w0rp/ale', ft = {'python', 'cpp', 'c', 'fortran'}}
  use {'jose-elias-alvarez/null-ls.nvim'}

  -- code auto completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  end,

  -- Override packer settings defaults
  config = {
    {
      git = { subcommands = {  submodules = 'submodule update --init --recursive' } }
    }
  }
}
)
