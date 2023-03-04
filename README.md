# vim-clip-expand-path 👣

Two commands to copy current file's path to system clipboard.

### Requirements

None. Uses ``pbcopy`` on macOS, and ``xclip`` on Linux.

## Commands

Use `<leader>j` and `<leader>J` to copy the current file path:

- `<leader>j` — Copies path relative to Git project root

  - E.g., `doc/vim-clip-expand-path.txt`

- `<leader>J` — Copies full path, using tilde for user home

  - E.g., `~/.vim/pack/DepoXy/start/vim-clip-expand-path/doc/vim-clip-expand-path.txt`

## INSTALL

Installation is easy using Vim's packages feature (see ``:help packages``).

If you want the plugin to load automatically on Vim startup,
use a ``start/`` directory, e.g.,

  ```shell
  mkdir -p ~/.vim/pack/landonb/start
  ```

And then clone the project to that path:

  ```shell
  cd ~/.vim/pack/landonb/start
  git clone https://github.com/landonb/vim-clip-expand-path.git
  ```

If you want to test the package first, make it optional instead
(see ``:help pack-add``):

  ```shell
  mkdir -p ~/.vim/pack/landonb/opt
  cd ~/.vim/pack/landonb/opt
  git clone https://github.com/landonb/vim-clip-expand-path.git

  " When ready, load the [opt]ional plugin (or is it [opt]-in?).
  :packadd! vim-clip-expand-path
  ```

To build the help, ensure the plugin is loaded, and then
run the following command just one time from within Vim:

  ```shell
  :Helptags
  ```

Or, you can build the help from the terminal instead. Run:

  ```shell
  vim -u NONE -c "helptags vim-clip-expand-path/doc" -c q
  ```

And then to view the help from within Vim, run:

  ```shell
  :help vim-clip-expand-path
  ```

## SEE ALSO

  DepoXy Development Environment Orchestrator

  https://github.com/DepoXy/depoxy#🍯

## AUTHOR

**vim-clip-expand-path** is Copyright (c) 2020-2023 Landon Bouma &lt;depoxy@tallybark.com&gt;

This software is released under the MIT license (see `LICENSE` file for more)

## REPORTING BUGS

&lt;https://github.com/DepoXy/vim-clip-expand-path/issues&gt;

