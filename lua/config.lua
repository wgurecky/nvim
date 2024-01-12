-- lspconfig
local lspconfig = require('lspconfig')

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "python", "markdown", "rst", "lua", "vim", "latex", "json" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "fortran" },
  highlight = {
    enable = true,
    disable = { "fortran" },
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
  },
}

-- nvim-tree setup
require'nvim-tree'.setup {}

-- trouble setup
require'trouble'.setup{}

-- telescope.nvim setup
local actions = require('telescope.actions')
require'telescope'.setup{}

--- lualine settings
require'lualine'.setup{
    options = {
        theme = 'auto',
        icons_enabled = true,
        }
}

--- tabline settings
require("tabline").setup{
    enable = true,
    tabline_show_devicons = true,
}

--- Window switch swap-buffers settings
require('swap-buffers').setup({
  ignore_filetypes = {'NvimTree'}
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- python language server settings
lspconfig.jedi_language_server.setup{capabilities = capabilities}
-- lspconfig.pyright.setup{capabilities = capabilities}
-- fortran language server settings
lspconfig.fortls.setup{
    cmd = {
        'fortls',
        '--autocomplete_name_only',
        '--incrmental_sync'
    },
    settings = {
        ["fortran-ls"] = {
            variableHover = false
        },
    },
    root_dir = vim.fn.FindTopLevelProjectDir,
    capabilities = capabilities,
}
-- cpp language server settings
lspconfig.clangd.setup{
    cmd = {vim.fn.FindClangExe()},
    capabilities = capabilities,
}
-- rust
lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
}

-- signature help config
local lsp_signature_cfg = {doc_lines = 0,}
require"lsp_signature".setup(lsp_signature_cfg)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.pumheight = 15

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").load(
    {paths={'~/.config/nvim/my_lsp_snips'}}
)

-- nvim-cmp setup
local cmp = require 'cmp'
local cmp_buffer = require 'cmp_buffer'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'path'},
    {name = 'buffer'},
  },
--   sorting = {
--     comparators = {
--       function(...) return cmp_buffer:compare_locality(...) end,
--     },
--   },
})

-- null-ls for adapting lang linters into language servers
local null_ls = require("null-ls")
local null_ls_sources = {
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.flake8,
}
null_ls.setup({sources = null_ls_sources})

-- disable all lsp diagnostic virtual text to reduce noise
vim.diagnostic.config(
  {
    virtual_text = false,
    underline = false,
    float = { source = true },
  }
)
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false,
--         signs = true,
--     }
-- )

-- Extra legacy vim plugin settings
-- TODO: convert to lua settings
vim.cmd([[
" Vimtex settings
" Note; <leader>ll builds and <leader>le shows compile errors
" Note; install xdotool package for live previews in zathura
" let g:vimtex_view_method='zathura'
" let g:vimtex_view_method='general'

" NvimTree settings
nnoremap <leader>e :NvimTreeToggle<CR>
let g:nvim_tree_auto_open = 1
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

" Easy align settings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" QFEnter settings
let g:qfenter_keymap = {}
let g:qfenter_keymap.hopen = ['<Leader><Space>', '<C-x>']
let g:qfenter_keymap.vopen = ['<Leader><CR>', '<C-v>']

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F']

" telescope mappings
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <C-b>      <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <C-p>      <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <C-f>      <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <leader>fi <cmd>lua require('telescope.builtin').diagnostics()<CR>

" On hover show diagnostic (if any) or use <leader>di to force diagnostic popup
autocmd CursorHold * lua vim.diagnostic.open_float()
nnoremap <leader>di  <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <leader>xd  <cmd>TroubleToggle document_diagnostics<cr>

" nvim-lsp mappings
" note: <C-o> go back previous pos, <C-i> forward to last pos
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gI    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gT   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" alias to check loaded lsp client status
cnoreabbrev lspstat lua print(vim.inspect(vim.lsp.buf_get_clients()))

" ale syntax checker settings for filetypes which do not have a lang server
" to check which linters are active run: :ALEinfo
" let g:ale_linters = {
"    \ 'python': ['pylint'],
"    \ 'cpp': ['clangd'],
"    \ 'c': ['clangd'],
"    \ 'fortran': ['gfortran'],
"    \ 'tex': ['proselint', 'write-good'],
"    \ 'markdown': ['proselint', 'write-good'],
"    \ }
"let g:ale_lint_on_save = 1

" vim-dispatch settings
" Run :Make! to launch background async project build.
" Results are available via :Copen
" Ensure makeprg is set properly before running

" For project wide search/replace
" Run :Ack {pattern} [{dir}]
" :cdo s/foo/bar/gc | update
"if !executable('ack')
"    let g:ackprg = '~/.config/nvim/bin/ack'
"endif

" automatically set project base directory ack search on `:ag `
" requires the projec to have a `.git` file in the base dir
" cnoreabbrev ag Gcd <bar> Ack!

" set default grepprg to ripgrep if on $PATH
if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" vim-grepper settings
let g:grepper = {
    \ 'tools': ['rg', 'git', 'grep', 'rgproj'],
    \ 'rgproj': {
    \   'grepprg':    'rg -n $* -- `git rev-parse --show-toplevel`',
    \ }}
if executable('rg')
    let g:grepper.rgproj = { 'grepprg': 'rg -n $* -- `git rev-parse --show-toplevel`' }
else
    let g:grepper.rgproj = { 'grepprg': 'git grep -nI $* -- `git rev-parse --show-toplevel`' }
endif
" Project wide search with <leader>*
nnoremap <leader>* :Grepper -tool rgproj -cword -noprompt<cr>
" Project wide search with :vg <cr>
cnoreabbrev vg Grepper -tool rgproj <cr>

" swap-buffers
nnoremap <C-Left> <cmd>lua require('swap-buffers').swap_buffers('h')<CR>
nnoremap <C-Down> <cmd>lua require('swap-buffers').swap_buffers('j')<CR>
nnoremap <C-Up> <cmd>lua require('swap-buffers').swap_buffers('k')<CR>
nnoremap <C-Right> <cmd>lua require('swap-buffers').swap_buffers('l')<CR>

" tagbar
nnoremap <leader>tt :TagbarToggle<CR>
]])
