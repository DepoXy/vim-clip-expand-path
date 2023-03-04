" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Project: https://github.com/DepoXy/vim-clip-expand-path#👣
" License: CC0 1.0 <https://creativecommons.org/publicdomain/zero/1.0/>

" Copyright (c) © 2020-2023 Landon Bouma. All Rights Reserved.

if exists("g:plugin_vim_clip_expand_path_copy_file_project_path") || &cp
  finish
endif
let g:plugin_vim_clip_expand_path_copy_file_project_path = 1

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" USAGE:
"
" - <leader>j — copy file path relative to .git/ base to clipboard
"
" - <leader>J — copy full file path to clipboard

" ***

" REFER: ';' postfix *upward search*
"          :help file-searching

" ***

function! s:SetCurrentFilePathCopyToClipboard_macOS()
  nnoremap <silent> <leader>j :call system(
    \ 'pbcopy',
    \ substitute(expand('%:p'), finddir('.git/..', expand('%:p:h').';').'/', '', '')
  \ )<CR>
  inoremap <silent> <leader>j <C-O>:call system(
    \ 'pbcopy',
    \ substitute(expand('%:p'), finddir('.git/..', expand('%:p:h').';').'/', '', '')
  \ )<CR>

  nnoremap <silent> <leader>J :call system(
    \ 'pbcopy',
    \ substitute(expand('%:p'), '^'.$HOME, '~', '')
  \ )<CR>
  inoremap <silent> <leader>J <C-O>:call system(
    \ 'pbcopy',
    \ substitute(expand('%:p'), '^'.$HOME, '~', '')
  \ )<CR>
endfunction

" ***

function! s:SetCurrentFilePathCopyToClipboard_X11()
  nnoremap <silent> <leader>j :call system(
    \ 'xclip -i -selection c',
    \ substitute(expand('%:p'), finddir('.git/..', expand('%:p:h').';').'/', '', '')
  \ )<CR>
  inoremap <silent> <leader>j <C-O>:call system(
    \ 'xclip -i -selection c',
    \ substitute(expand('%:p'), finddir('.git/..', expand('%:p:h').';').'/', '', '')
  \ )<CR>

  nnoremap <silent> <leader>J :call system(
    \ 'xclip -i -selection c',
    \ substitute(expand('%:p'), '^'.$HOME, '~', '')
  \ )<CR>
  inoremap <silent> <leader>J <C-O>:call system(
    \ 'xclip -i -selection c',
    \ substitute(expand('%:p'), '^'.$HOME, '~', '')
  \ )<CR>
endfunction

" ***

function! s:SetCurrentFilePathCopyToClipboard()
  if ! has("gui_running") | return | endif

  if has("macunix")
    call s:SetCurrentFilePathCopyToClipboard_macOS()
  elseif has("x11")
    call s:SetCurrentFilePathCopyToClipboard_X11()
  elseif has("gui_gtk2") || has("gui_gtk3")
    call s:SetCurrentFilePathCopyToClipboard_X11()
  " elseif has("gui_photon")
  " elseif has("gui_kde")
  endif
endfunction

call s:SetCurrentFilePathCopyToClipboard()

