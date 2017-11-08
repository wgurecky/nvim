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

set termguicolors
set background=light " When set to "dark", Vim will try to use colors that look good on dark backdrop

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

" auto detect filetype
filetype plugin on

" allow easy insertion of one character with spacebar
nmap <Space> i_<Esc>r

" normal esc from terminal window
tnoremap <Esc> <C-\><C-n>

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
Plug 'lifepillar/vim-solarized8'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
" common plugins
Plug 'mileszs/ack.vim'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/wgurecky/vimSum.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-repeat.git'
" dev tools
Plug 'https://github.com/tpope/vim-dispatch.git', { 'for': ['cpp', 'c', 'fortran'] }
Plug 'https://github.com/w0rp/ale.git', {'for': ['cpp', 'c', 'python', 'fortran']}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'tell-k/vim-autopep8', {'for': 'python' }
Plug 'lervag/vimtex'
" code completion
" Plug 'roxma/nvim-completion-manager'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'Rip-Rip/clang_complete', {'for': ['cpp', 'c'] }
call plug#end()

" Clang complete settings
if !empty(glob('/lib/libclang.so'))
    let g:clang_library_path='/lib/libclang.so'
elseif !empty(glob('/usr/lib/llvm-4.0/lib/libclang.so'))
    let g:clang_library_path='/usr/lib/llvm-4.0/lib/libclang.so'
elseif !empty(glob('/usr/lib/llvm-3.5/lib/libclang.so'))
    let g:clang_library_path='/usr/lib/llvm-3.5/lib/libclang.so'
endif
let g:clang_complete_auto=0
let g:clang_complete_select=0
let g:clang_omnicppcomplete_compliance=0
let g:clang_make_default_keymappings=0

" Vimtex settings
" Note; <leader>ll builds and <leader>le shows compile errors
" Note; install xdotool package for live previews in zathura
" let g:vimtex_view_method='general'
let g:vimtex_view_method='zathura'

" Nerdtree settings
" launch nerdtree on entry if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set autochdir                " automatically change directory
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$','\.png$']

" Easy align settings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ctlp settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

" ultisnips settings (auto integration with deoplete)
let g:UltiSnipsExpandTrigger="<c-e>"

" Airline settings
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ncm auto tab complete
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" ale settings
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'cpp': ['gcc', 'clangtidy'],
    \ 'c': ['gcc'],
    \ 'fortran': ['gcc'],
    \ }
" let g:ale_lint_on_save = 1

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

" automatically set project base directory ack search on `:ag `
" requires the projec to have a `.git` file in the base dir
cnoreabbrev ag Gcd <bar> Ack!

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
" colorscheme solarized8_light
" colorscheme solarized
colorscheme NeoSolarized
let g:solarized_termtrans=1
hi Normal guibg=NONE ctermbg=NONE

" Do not enable unless you want makeprg auto-set for all filetypes
" Set in ftplugin files each desired filetype
" autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")
