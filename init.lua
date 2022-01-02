-- ~/.config/nvim/init.lua

------------------------------------------------------------------------------
-- NVIM SETTINGS
------------------------------------------------------------------------------

-- hybrid numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true

-- default number of spaces to use for autoindent
vim.o.shiftwidth = 4

-- auto expand tabs
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true

-- show immediately where so far a typed pattern matches
vim.o.incsearch = true

-- default splits to bottom right
vim.o.splitbelow = true
vim.o.splitright = true

-- allow easy insertion of one character with spacebar
-- source: http://vim.wikia.com/wiki/Insert_a_single_character
-- vim.cmd([[ nnoremap <Space> :exec "normal i".nr2char(getchar())."\e"<CR> ]])
vim.api.nvim_set_keymap('n', '<Space>', ':exec "normal i".nr2char(getchar())."\\e"<CR>', {noremap=true, silent=true})

-- normal esc from terminal window
-- tnoremap <Esc> <C-\><C-n>
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap=true, silent=true})

-- faster buffer lookup & switching with <C-e># or <C-e><buff_name>
-- nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>
vim.api.nvim_set_keymap('n', '<C-e>', ':set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>', {noremap=true, silent=true})

-- fast find/replace word under cursor
-- nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
vim.api.nvim_set_keymap('n', '<Leader>s', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', {noremap=true, silent=true})

-- fast escape
-- inoremap jj <ESC>
-- imap jw <ESC>
-- imap jk <ESC>
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('i', 'jw', '<ESC>', {noremap=true, silent=true})

-- fast switch between tabs created with :tabnew
-- nnoremap <C-Left> :tabprevious<CR>
-- nnoremap <C-Right> :tabnext<CR>
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprevious<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', {noremap=true, silent=true})


-- remap arrow keys to window resize
-- TODO: convert to lua
vim.cmd([[
if bufwinnr(1)
    map <Up> <C-W>2-
    map <Down> <C-W>2+
    map <Left> <C-W>2<
    map <Right> <C-W>2>
endif
]])

-- remap ctrl+hkjl to jump windows in normal mode
-- TODO: convert to lua
vim.cmd([[
if bufwinnr(1)
    nmap <C-h> <C-W>h
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-l> <C-W>l
endif
]])

-- quick change from horizontal to vert split
-- map <leader>th <C-w>t<C-w>H
-- map <leader>tk <C-w>t<C-w>K
vim.api.nvim_set_keymap('', '<leader>th', '<C-w>t<C-w>H', {noremap=true, silent=true})
vim.api.nvim_set_keymap('', '<leader>tk', '<C-w>t<C-w>K', {noremap=true, silent=true})

-- fn to automatically set makeprg (required for large c++ and c projects)
vim.cmd([[
function! g:BuildInSubDir(buildsubdir)
    " Sets makeprg base dir
    let toplevelpath = FindTopLevelProjectDir()
    let builddir = toplevelpath . a:buildsubdir
    echo builddir
    let makeprgcmd = 'make -C ' . builddir
    if builddir !=? "//build"
        let &makeprg=makeprgcmd
    endif
endfunction

function! FindTopLevelProjectDir(...)
    " Searches for a .git directory upward till root.
    let isittopdir = finddir('.git')
    if isittopdir ==? ".git"
        return getcwd()
    endif
    let gitdir = finddir('.git', ';')
    let gitdirsplit = split(gitdir, '/')
    let toplevelpath = '/' . join(gitdirsplit[:-2],'/')
    return toplevelpath
endfunction

function! FindClangExe(...)
    " Find clangd exec name
    return 'clangd'
endfunction
]])

-- Lua Plugins
require('init')

-- Auto-recompile plugins on plugins.lua change
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- Colorscheme
vim.cmd([[
set background=light
set termguicolors
colorscheme NeoSolarized
]])

-- Extra useful functions
vim.cmd([[
" comment blocks of code
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType lua              let b:comment_leader = '-- '
autocmd FileType fortran          let b:comment_leader = '! '
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" show extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remove trailing whitespace from current line
function! DelWhitespaceLine()
    :.,s/\s\+$//g
endfunction
" retain current cursor position
command! UnfuckLine execute "normal! ma" | execute DelWhitespaceLine() | execute "normal! `a"
nnoremap <leader>u :UnfuckLine<CR>

" remove all trailing whitspace and replace tabs with spaces
function! DelWhitespace()
    execute ":retab"
    :%s/\s\+$//g
endfunction
command! Unfuck execute DelWhitespace()
]])
