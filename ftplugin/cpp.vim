" remember to set makeprg to the build directory of the project ex:
" :set makeprg=make\ -C\ ~/path/to/project/make
autocmd BufWritePost * Neomake!
nmap <silent> \l :copen<CR>

" call g:BuildInSubDir("/build") on open
autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")
