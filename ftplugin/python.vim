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

" convert doxygen to reST, sphinx-compat doc style
" to apply to entire project do
" :args `find . -name \*.py`
" :argdo execute Undoxygen() | update
function! Undoxygen()
    :%s/@param\s\(\w\+\)/:param \1:/g
    :%s/@returns\?/:return:/g
    :%s/@brief \?//g
    :%s/@note/.. note::/g
    :%s/"""!/"""/g
endfunction
command! Undox execute Undoxygen()

" convert doxygen to reST, sphinx-compat doc style
function! SphinxSpace()
    :%s/\(\s\+\):param/\r\1:param/g
    :%s/\(\s\+\):return/\r\1:return/g
endfunction
command! SSpace execute SphinxSpace()
