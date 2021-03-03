" call g:BuildInSubDir("/build") on open
autocmd BufNewFile,BufRead * call g:BuildInSubDir("/build")

set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set copyindent

autocmd BufNewFile,BufRead g:SetCtfTab()


let cwd = getcwd()
if cwd =~ "CTF"
  set shiftwidth=3
  set tabstop=3
  set softtabstop=3
endif
if cwd =~ "COBRA-TF"
  set shiftwidth=3
  set tabstop=3
  set softtabstop=3
endif


" override grepper settings to allow for mixed case matches
if executable('rg')
    let g:grepper.rgproj = { 'grepprg': 'rg -ni $* -- `git rev-parse --show-toplevel`' }
else
    let g:grepper.rgproj = { 'grepprg': 'git grep -ni $* -- `git rev-parse --show-toplevel`' }
endif
