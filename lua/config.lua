-- nvim-tree setup
require'nvim-tree'.setup {}

-- trouble setup
require'trouble'.setup{}

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

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").load(
    {paths={'~/.config/nvim/my_lsp_snips'}}
)

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

" vim-dispatch settings
" Run :Make! to launch background async project build.
" Results are available via :Copen
" Ensure makeprg is set properly before running

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
" nnoremap <leader>* :Grepper -tool rgproj -cword -noprompt<cr>
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
