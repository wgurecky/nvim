About
=====

Wgurecky's neovim configuration files.  Useful for c, cpp, python, and latex files.

Config
=======

Python
------

Install neovim python modules:  `python-neovim`, `python3-neovim`

Place `flake8` file in `~/.config/.`

C++ / C
-------

For out of source builds remember to set `makeprg` to use the
build directory of the project ex:

    :set makeprg=make\ -C\ ~/path/to/project/build
