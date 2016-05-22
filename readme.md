About
=====

Wgurecky's neovim configuration files.  Useful for c, cpp, python, and latex files.


Depends
=======

- python3-neovim
- python2-neovim

Config
=======

Python
------

Optional:
Place `flake8` file in `~/.config/.` to ignore some minor PEP8 violation warnings from showing up in the quickfix window.

C++ / C
-------

This neovim configuration assumes that C++ projects will be built out of the src tree:

PROJECT_BASE
+-- CMakeLists.txt
+-- README.md
+-- .git
+-- build
|   +-- do_configure.sh
|   +-- makefile
+-- src
|   +-- foo_bar.cpp
|   +-- foo_bar.hpp

In order for the neomake plugin to automatically compile the project (async make on write) `makeprg` should be pointed at a folder which includes the project's make file.  Ex:

    :set makeprg=make\ -C\ ~/path/to/project/build

A function present in the included `init.vim` attempts to set `makeprg` automatically.  The function might not always produce the expected result.  Check that `makeprg` is set correctly by issuing:

    :set makeprg


Notes
=====

Code folding
------------

Code folding settings are provided in the `./ftplugin` directory.  By default, folding by indentation level is ON.  `za` toggles folding for the current indent level.  `zR` and `zM` unfolds and folds all respectively.

Breakpoints in Python
----------------------

In normal mode `<leader> b` inserts a breakpoint on the line above the current cursor position.

Plugin Choices
--------------

Neomake was adopted because it integrates with Neovim's job-control functionality providing asynchronous project build and syntax check capability.  In the current configuration only a `makefile` residing in the project's `build` directory is required for automatic building and syntax checking.

Neomake also supports vim-flake8 for automatic python syntax checking.
