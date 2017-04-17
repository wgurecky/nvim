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

set background=dark " When set to "dark", Vim will try to use colors that look good on dark backdrop

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

" fast dub j escape
inoremap jj <ESC>

" syntax highlight
syntax on

" netrw tree style by default
let g:netrw_liststyle=3
let g:netrw_winsize=20

" ========================================================== "
"                    PLUGIN SETTINGS                         "
" ========================================================== "

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

" Notes. vim-flake8 requires the python package flake8 to be
" installed.  TODO: fix ultisnips auto complete issue.  Is
" ultisnips compatible with deoplete?
call plug#begin('~/.nvim/plugged')
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
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/Shougo/deoplete.nvim.git', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/tpope/vim-dispatch.git', { 'for': ['cpp', 'c', 'fortran'] }
Plug 'https://github.com/w0rp/ale.git', {'for': ['cpp', 'c', 'python', 'fortran']}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'Rip-Rip/clang_complete', {'for': ['cpp', 'c'] }
Plug 'lervag/vimtex'
Plug 'zchee/deoplete-jedi', {'for': 'python' }
call plug#end()

" Clang complete settings
let g:clang_library_path='/lib/libclang.so'
let g:clang_complete_auto=0
let g:clang_complete_select=0
let g:clang_omnicppcomplete_compliance=0
let g:cland_make_default_keymappings=0

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

" Easy align settings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ctlp settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ultisnips settings (auto integration with deoplete)
let g:UltiSnipsExpandTrigger="<c-@>"

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" deoplete settings
let g:deoplete#enable_at_startup=1
" let g:deoplete#sources = {}
" let g:deoplete#sources.c = ['omni', 'buffer', 'member', 'ultisnips', 'tag', 'file']
" let g:deoplete#sources.cpp = ['omni', 'buffer', 'member', 'ultisnips', 'tag', 'file']
" let g:deoplete#sources.python = ['omni', 'jedi', 'ultisnips', 'file']
" let g:deoplete#sources.tex = ['omni', 'file']
" let g:deoplete#omni#input_patterns = {}
" let g:deoplete#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:deoplete#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" let g:deoplete#omni#input_patterns.tex = '\\(?:'
"     \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
"     \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
"     \ . '|hyperref\s*\[[^]]*'
"     \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"     \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
"     \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
"     \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
"     \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
"     \ .')'

" deoplete tab complete
inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction "}}}

" ale settings
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'cpp': ['gcc'],
    \ 'c': ['gcc'],
    \ 'fortran': ['gcc'],
    \ }
let g:ale_lint_on_save = 1

" vim-dispatch settings
" Run :Make! to launch background async project build.
" Results are available via :Copen
" Ensure makeprg is set properly before running

" ========================================================== "
"                    EXTRA FUNCTIONS                         "
" ========================================================== "

" show extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
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

" Do not enable unless you want makeprg auto-set for all filetypes
" Set in ftplugin files each desired filetype
" autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")
