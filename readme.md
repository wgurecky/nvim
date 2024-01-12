About
=====

Wgurecky's neovim configuration files.  Useful for rust, cpp, python, and latex files.

This config depends on neovim's new lsp (language server protocol) integration.

Work in progress:

- Migrating to pure lua configuration.
- Migrating to null-ls for linting


Depends
=======

- neovim with built in lsp (neovim >=v0.5) formerly [nvim-lsp]
- [pynvim]
- clang
- clangd
- gcc
- [ack]
- [rust-analyzer]
- [jedi-language-server]
- [jedi]
- [pylint]

Neovim plugins are not listed here.  [lazy.nvim] handles installation and updates of all neovim plugins.

[lazy.nvim]: https://github.com/folke/lazy.nvim
[nvim-lsp]: https://github.com/neovim/nvim-lsp
[pynvim]: https://github.com/neovim/pynvim
[ack]: https://beyondgrep.com/
[jedi]: https://github.com/davidhalter/jedi
[pylint]: https://www.pylint.org/
[jedi-language-server]: https://github.com/pappasam/jedi-language-server
[rust-analyzer]: https://rust-analyzer.github.io/

Optional
---------

- [ripgrep]
- [clang-tidy]
- [proselint]
- [write-good]

[ripgrep]: https://github.com/BurntSushi/ripgrep
[clang-tidy]: https://clang.llvm.org/extra/clang-tidy/


Install
=====

Clone this repo into your `~/.config` dir:

    cd ~/.config && git clone https://github.com/wgurecky/nvim

On neovim startup [lazy.nvim] should try to download automatically, if not install from https://github.com/folke/lazy.nvim

Next, run `:Lazy sync` to install all plugins followed by `:Lazy show`


Config
=======

C++ / C
-------

This neovim configuration assumes that a C/C++ project is built out of the src tree and is a git repository:

```
PROJECT_BASE
+-- CMakeLists.txt
+-- README.md
+-- .git
|   +-- FETCH_HEAD
|   +-- '...'
+-- build
|   +-- do_configure.sh
|   +-- makefile
+-- src
|   +-- foo_bar.cpp
|   +-- foo_bar.hpp
```

### Build

A function present in the included `init.vim` attempts to set `makeprg` automatically.  The function might not always produce the expected result.  Check that `makeprg` is set by issuing:

    :set makeprg

To manually set makeprg:

    :set makeprg=make\ -C\ ~/path/to/project/build

Once `makeprg` is verified, run:

    :Make!

Which will launch make in the background so that you can continue to edit uninterrupted.  To view the results run:

    :Copen

Note: The designated project build folder name can be adjusted in the `./ftplugin/<c,cpp>` files.  By default it is set to `build`.


### Auto Completion

[Clangd] provides autocompletion for C/C++ projects.  Some linux distributions have a `clang-tools` package that contains Clangd.

To use Clangd you must first generate a compilation database with the cmake option:

    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=on \

If cmake is not the build system of choice one can use the tool [Bear] to generate a json compilation database instead.

[Bear]: https://github.com/rizsotto/Bear
[Clangd]: https://clang.llvm.org/extra/clangd.html

Python
------

Optional:
Place `flake8` file in `~/.config/.` to ignore some minor PEP8 violation warnings from showing up in the quickfix window.

### Auto Completion

Auto complete for python requires the `jedi-language-server` and `jedi` to be installed:

    pip install jedi-language-server jedi

### Linting

Install pylint, for ex:

    pip install pylint

### Breakpoints in Python

In normal mode `<leader> b` inserts a breakpoint on the line above the current cursor position.

Prose
------

### Linting

Install [write-good] (optional):

    npm install write-good

Install [proselint] (optional):

    pip install proselint

[proselint] is a prose checking tool for markdown and latex files.

[proselint]: https://github.com/amperser/proselint
[write-good]: https://github.com/btford/write-good

Notes
=====

Find/Replace Mappings and Shortcuts
-----------------------------------

To search and replace a word inside all files in a directory:

    :Ack {pattern} [{dir}]
    :cdo s/foo/bar/gc | update

To search and replace all instances of a word inside a project that is a git repository use:

    :vg <pattern>
    :cdo s/foo/bar/gc | update

To search and replace all instances of the current word under the cursor in the current git repo do:

    <leader>*
    :cdo s/foo/bar/gc | update

Where `<leader>` is set to `\` by default.

To find replace the current word under the cursor in the current file use:

    <leader>s

Code folding
------------

The `./ftplugin` directory provides code folding settings.
By default, folding by indentation level is on.  `za` toggles folding for the current indent level.  `zR` and `zM` unfolds and folds all respectively.
