noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj

set spelllang=en_us
set spell

" deoplete vimtex integration
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

