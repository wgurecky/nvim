" ~/.config/nvim/init.vim

" set plugin base dir
let s:editor_root=expand("~/.nvim")

" ========================================================== "
"                     VIM SETTINGS                           "
" ========================================================== "
"
set number relativenumber  " hybrid numbers
set nu rnu

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

" auto detect filetype
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" allow easy insertion of one character with spacebar
" source: http://vim.wikia.com/wiki/Insert_a_single_character
nnoremap <Space> :exec "normal i".nr2char(getchar())."\e"<CR>

" normal esc from terminal window
tnoremap <Esc> <C-\><C-n>

" faster buffer lookup & switching with <C-e># or <C-e><buff_name>
" and cycle buffers with <C-h> and <C-l>
nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>

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

" remap ctrl+hkjl to jump windows in normal mode
if bufwinnr(1)
    nmap <C-h> <C-W>h
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-l> <C-W>l
endif

" quick change from horizontal to vert split
map <leader>th <C-w>t<C-w>H
map <leader>tk <C-w>t<C-w>K

" default splits to bottom right
set splitbelow splitright

" incremental command live feedback
set inccommand=nosplit

" netrw settings
let g:netrw_altv=1
let g:netrw_browse_split=2
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize=18

" python provider
" let g:python3_host_prog=system('which python3')
" let g:python2_host_prog=system('which python2')
" let g:python3_host_prog='/home/wll/miniconda3/bin/python'
" let g:python2_host_prog='/home/wll/miniconda2/bin/python'

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
Plug 'unblevable/quick-scope'
Plug 'yssl/QFEnter'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/wgurecky/vimSum.git', { 'do': ':UpdateRemotePlugins' }
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
" Plug 'ojroques/nvim-lspfuzzy', {'branch': 'main'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'
" dev tools
Plug 'https://github.com/tpope/vim-dispatch.git', { 'for': ['cpp', 'c', 'fortran'] }
Plug 'https://github.com/w0rp/ale.git', {'for': ['python', 'cpp', 'c', 'fortran', 'markdown', 'tex']}
Plug 'tell-k/vim-autopep8', {'for': 'python' }
Plug 'lervag/vimtex', {'for': 'tex'}
" code completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/diagnostic-nvim'
call plug#end()

" Local vs remote logic.  Some colorscheme features do not
" reliably work over ssh.
let g:remoteSession = ($SSH_TTY != "")
if  g:remoteSession
    " Do not preview pdf over ssh connection.
    " Use sshfs+zathura to view remote pdf
    let g:vimtex_view_enabled=0
else
    set termguicolors
    " Colorscheme
    let g:airline_theme='solarized'
    colorscheme NeoSolarized
    let g:solarized_termtrans=1
    hi Normal guibg=NONE ctermbg=NONE
endif

" Vimtex settings
" Note; <leader>ll builds and <leader>le shows compile errors
" Note; install xdotool package for live previews in zathura
let g:vimtex_view_method='zathura'
" let g:vimtex_view_method='general'

" Colors.  TODO: Auto detect term bg color from Xresources?
set background=light

" Nerdtree settings
" launch nerdtree on entry if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set autochdir                " automatically change directory
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$','\.png$']
nnoremap <leader>e :NERDTreeToggle<CR>

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
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F']

" automatically set makeprg (required for large c++ and c projects)
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
    let check_clang_out = system("which clangd")
    if v:shell_error == 0
        return 'clangd'
    else
        return 'clangd-6.0'
    endif
endfunction

" get top level proj dir
let g:top_level_dir = FindTopLevelProjectDir()

" nvim-lspconfig
lua << EOF
local lspconfig = require'lspconfig'
-- nvim-compe setup
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;
    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        treesitter = true;
        spell = true;
        tags = true;
        ultisnips = true,
        vsnip = false;
        snippets_nvim = false;
    };
}
-- python language server settings
lspconfig.pylsp.setup{cmd = {'pylsp'}}
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
}
-- cpp language server settings
lspconfig.clangd.setup{
    cmd = {vim.fn.FindClangExe()},
}
-- disable all lsp diagnostic virtual text to reduce noise
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
    }
)
-- telescope.nvim setup
local actions = require('telescope.actions')
require'telescope'.setup{
}
EOF

" telescope mappings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <leader>fi <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>

" On hover show diagnostic (if any) or use <leader>di to force diagnostic popup
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
nnoremap <leader>di  <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

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

" tab complete settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" ale syntax checker settings for filetypes which do not have a lang server
" to check which linters are active run: :ALEinfo
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'fortran': ['gfortran'],
    \ 'tex': ['proselint', 'write-good'],
    \ 'markdown': ['proselint', 'write-good'],
    \ }
let g:ale_lint_on_save = 1

" vim-dispatch settings
" Run :Make! to launch background async project build.
" Results are available via :Copen
" Ensure makeprg is set properly before running

" ultisnips settings (auto integration with deoplete)
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" For project wide search/replace
" Run :Ack {pattern} [{dir}]
" :cdo s/foo/bar/gc | update
if !executable('ack')
    let g:ackprg = '~/.config/nvim/bin/ack'
endif

" automatically set project base directory ack search on `:ag `
" requires the projec to have a `.git` file in the base dir
cnoreabbrev ag Gcd <bar> Ack!

" set default grepprg to ripgrep if on $PATH
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

" vim-grepper settings
let g:grepper = {
    \ 'tools': ['rg', 'git', 'ack', 'grep', 'rgproj'],
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

" tagbar
nmap <F8> :TagbarToggle<CR>

" ========================================================== "
"                    EXTRA FUNCTIONS                         "
" ========================================================== "

" comment blocks of code
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType vim              let b:comment_leader = '" '
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

" Do not enable unless you want makeprg auto-set for all filetypes
" Set in ftplugin files each desired filetype
autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")

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
