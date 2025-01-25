" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Project: https://github.com/DepoXy/vim-clip-expand-path#👣
" License: CC0 1.0 <https://creativecommons.org/publicdomain/zero/1.0/>

" Copyright (c) © 2020-2024 Landon Bouma. All Rights Reserved.

" -------------------------------------------------------------------

" USAGE:
"
" - <leader>j — copy file path relative to .git/ base to clipboard
"
" - <leader>J — copy full file path to clipboard

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:plugin_vim_clip_expand_path_copy_file_project_path
endif

if exists('g:plugin_vim_clip_expand_path_copy_file_project_path') || &cp

  finish
endif

let g:plugin_vim_clip_expand_path_copy_file_project_path = 1

" -------------------------------------------------------------------

function! DXY_CopyFileProjectPath_NormalizeCurrentFilePath()
  let l:filepath = expand('%:p')

  let l:filepath = substitute(l:filepath, '^'.$HOME, '~', '')

  " USAGE: If you want to substitute a different path for some results,
  " you could fork this project, and then add those substitutions here.
  "
  " - E.g., if you want <Leader>J to use the symlink path you use to a
  "   mounted path, rather than the canonical path itself, you could add
  "   a rule such as this:
  "
  "     let l:filepath = substitute(l:filepath, '/Volumes/mounted/path', '~/my/symlink', '')
  "
  " INERT/2024-09-18: Use global instead so users don't have to fork,
  "   e.g., g:vim_clip_expand_path_subs = <path mappings>
  " - Though not a big deal to just fork this project, either.

  return l:filepath
endfunction

" ***

function! s:SetCurrentFilePathCopyToClipboard_Unmap()
  silent! unmap <silent> <leader>j
  silent! iunmap <silent> <leader>j

  silent! nunmap <silent> <leader>J
  silent! iunmap <silent> <leader>J
endfunction

" ***

function! s:SetCurrentFilePathCopyToClipboard_macOS()
  " REFER: ';' postfix *upward search*
  "          :help file-searching
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
    \ DXY_CopyFileProjectPath_NormalizeCurrentFilePath()
  \ )<CR>
  inoremap <silent> <leader>J <C-O>:call system(
    \ 'pbcopy',
    \ DXY_CopyFileProjectPath_NormalizeCurrentFilePath()
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
    \ DXY_CopyFileProjectPath_NormalizeCurrentFilePath()
  \ )<CR>
  inoremap <silent> <leader>J <C-O>:call system(
    \ 'xclip -i -selection c',
    \ DXY_CopyFileProjectPath_NormalizeCurrentFilePath()
  \ )<CR>
endfunction

" ***

function! s:SetCurrentFilePathCopyToClipboard()
  call s:SetCurrentFilePathCopyToClipboard_Unmap()

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

