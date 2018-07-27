" ~/.config/nvim/init.vim

" set plugin base dir
let s:editor_root=expand("~/.nvim")

" ========================================================== "
"                     VIM SETTINGS                           "
" ========================================================== "
"
set relativenumber  " Relative line numbers rock

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set autoindent      " Copy indent from current line when starting a new line

" Colors.  TODO: Auto detect term bg color from Xresources?
set termguicolors
set background=light

" auto detect filetype
filetype plugin on

" allow easy insertion of one character with spacebar
nmap <Space> i_<Esc>r

" normal esc from terminal window
tnoremap <Esc> <C-\><C-n>

" faster buffer lookup & switching with <C-e># or <C-e><buff_name>
nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

" fast find/replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" fast escape
inoremap jj <ESC>
imap jw <ESC>
imap jk <ESC>

" syntax highlight
syntax on

" remap arrow keys to window resize
if bufwinnr(1)
    map <Up> <C-W>2-
    map <Down> <C-W>2+
    map <Left> <C-W>2<
    map <Right> <C-W>2>
endif

" incremental command live feedback
set inccommand=nosplit

" netrw tree style by default
let g:netrw_liststyle=3
let g:netrw_winsize=20

" ========================================================== "
"                    PLUGIN SETTINGS                         "
" ========================================================== "

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.nvim/plugged')
" A S T H E T I C S
Plug 'iCyMind/NeoSolarized'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
" common plugins
Plug 'yssl/QFEnter'
Plug 'unblevable/quick-scope'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/wgurecky/vimSum.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-repeat.git'
" find/search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-grepper'
" dev tools
Plug 'https://github.com/tpope/vim-dispatch.git', { 'for': ['cpp', 'c', 'fortran'] }
Plug 'https://github.com/w0rp/ale.git', {'for': ['python', 'cpp', 'c', 'fortran', 'markdown', 'tex']}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'tell-k/vim-autopep8', {'for': 'python' }
Plug 'lervag/vimtex'
" code completion
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-ultisnips'
call plug#end()

" Vimtex settings
" Note; <leader>ll builds and <leader>le shows compile errors
" Note; install xdotool package for live previews in zathura
let g:remoteSession = ($SSH_TTY != "")
if  g:remoteSession
    " Do not preview pdf over ssh connection.
    " Use sshfs+zathura to view remote pdf
    let g:vimtex_view_enabled=0
endif
" let g:vimtex_view_method='general'
let g:vimtex_view_method='zathura'

" Nerdtree settings
" launch nerdtree on entry if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set autochdir                " automatically change directory
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$','\.png$']
nmap <C-o> :NERDTreeToggle<CR>

" Easy align settings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" QFEnter settings
let g:qfenter_keymap = {}
let g:qfenter_keymap.hopen = ['<Leader><Space>', '<C-x>']
let g:qfenter_keymap.vopen = ['<Leader><CR>', '<C-v>']

" fzf.vim settings
nnoremap <C-b> :Buffers<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-g>g :Ag<CR>

" Airline settings
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F']

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" LanguageClient auto completion for cpp and python
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
" Ensure clangd >= 6.0.0 and python-language-server are installed
" Note clangd can read compile_commands.json from CMake
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ }
" open help doc with 'K' close help window with command :pc
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" ale syntax checker settings (deprecated for python, cpp due to LanguageClient
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'cpp': ['clangtidy'],
    \ 'c': ['gcc'],
    \ 'fortran': ['gcc'],
    \ 'tex': ['proselint', 'write-good'],
    \ 'markdown': ['proselint', 'write-good'],
    \ }
" let g:ale_lint_on_save = 1
" to check which linters are active run: :ALEinfo

" vim-dispatch settings
" Run :Make! to launch background async project build.
" Results are available via :Copen
" Ensure makeprg is set properly before running

" For project wide search/replace
" Run :Ack {pattern} [{dir}]
" :cdo s/foo/bar/gc | update
if !executable('ack')
    let g:ackprg = '~/.config/nvim/bin/ack'
endif

" ultisnips settings (auto integration with deoplete)
let g:UltiSnipsExpandTrigger="<C-j>"

" automatically set project base directory ack search on `:ag `
" requires the projec to have a `.git` file in the base dir
cnoreabbrev ag Gcd <bar> Ack!

" vim-grepper settings
let g:grepper = {}
let g:grepper.tools = ['git', 'ack']
let g:grepper.git = { 'grepprg': 'git grep -nI $* -- `git rev-parse --show-toplevel`' }
" Project wide search with <leader>*
nnoremap <leader>* :Grepper -tool git -cword -noprompt<cr>
" Project wide search with :vg <cr>
cnoreabbrev vg Grepper -tool git<cr>

" tagbar
nmap <F8> :TagbarToggle<CR>

" ========================================================== "
"                    EXTRA FUNCTIONS                         "
" ========================================================== "

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
nnoremap <leader>e :UnfuckLine<CR>

" remove all trailing whitspace and replace tabs with spaces
function! DelWhitespace()
    execute ":retab"
    :%s/\s\+$//g
endfunction
command! Unfuck execute DelWhitespace()

" automatically set makeprg (required for large c++ and c projects)
function! g:BuildInSubDir(buildsubdir)
    " Sets makeprg base dir
    let toplevelpath = FindTopLevelProjectDir()
    let builddir = toplevelpath . a:buildsubdir
    let makeprgcmd = 'make -C ' . builddir
    if builddir !=? "//build"
        let &makeprg=makeprgcmd
    endif
endfunction

function! FindTopLevelProjectDir()
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

" Colorscheme
colorscheme NeoSolarized
let g:solarized_termtrans=1
hi Normal guibg=NONE ctermbg=NONE

" Do not enable unless you want makeprg auto-set for all filetypes
" Set in ftplugin files each desired filetype
" autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")
"

" customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
