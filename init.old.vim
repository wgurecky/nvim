" ~/.config/nvim/init.vim

" ========================================================== "
"                     VIM SETTINGS                           "
" ========================================================== "
"
set number relativenumber  " hybrid numbers

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
" filetype plugin on
" set omnifunc=syntaxcomplete#Complete

" allow easy insertion of one character with spacebar
" source: http://vim.wikia.com/wiki/Insert_a_single_character
nnoremap <Space> :exec "normal i".nr2char(getchar())."\e"<CR>

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
" syntax on

" fast switch between tabs created with :tabnew
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

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
" let g:netrw_altv=1
" let g:netrw_browse_split=2
" let g:netrw_liststyle=3
" let g:netrw_banner=0
" let g:netrw_winsize=18

" python provider
" let g:python3_host_prog=system('which python3')
" let g:python2_host_prog=system('which python2')
" let g:python3_host_prog='/home/wll/miniconda3/bin/python'
" let g:python2_host_prog='/home/wll/miniconda2/bin/python'

" ========================================================== "
"                    PLUGIN SETTINGS                         "
" ========================================================== "
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
    return 'clangd'
endfunction

" get top level proj dir
" let g:top_level_dir = FindTopLevelProjectDir()

" Load lua config
lua require('init')

" Auto-recompile plugins on plugins.lua change
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

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
nnoremap <leader>fi <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>

" On hover show diagnostic (if any) or use <leader>di to force diagnostic popup
autocmd CursorHold * lua vim.diagnostic.open_float()
nnoremap <leader>di  <cmd>lua vim.diagnostic.open_float()<CR>

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

" tagbar
nnoremap <leader>tt :TagbarToggle<CR>

" ========================================================== "
"                    EXTRA FUNCTIONS                         "
" ========================================================== "

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

" Do not enable unless you want makeprg auto-set for all filetypes
" Set in ftplugin files each desired filetype
" autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")

" Colors.  TODO: Auto detect term bg color from Xresources?
" Colorscheme
set background=light
set termguicolors
colorscheme NeoSolarized
" let g:solarized_termtrans=1
" hi Normal guibg=NONE ctermbg=NONE
