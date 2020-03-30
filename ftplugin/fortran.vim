" call g:BuildInSubDir("/build") on open
autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")

set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set copyindent
