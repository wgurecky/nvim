" autocmd BufWritePost * Neomake
map <silent> <leader>b Oimport pdb; pdb.set_trace()<esc>
nmap <silent> \l :lopen<CR>

" code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" rename me to self
map <F3> :%s/\<me\>/self/g<CR>
