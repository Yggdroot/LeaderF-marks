" ============================================================================
" File:        Marks.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if leaderf#versionCheck() == 0
    finish
endif

exec g:Lf_py "import vim, sys, os.path"
exec g:Lf_py "cwd = vim.eval('expand(\"<sfile>:p:h\")')"
exec g:Lf_py "sys.path.insert(0, os.path.join(cwd, 'python'))"
exec g:Lf_py "from marksExpl import *"

function! leaderf#Marks#Maps()
    nmapclear <buffer>
    nnoremap <buffer> <silent> <CR>          :exec g:Lf_py "marksExplManager.accept()"<CR>
    nnoremap <buffer> <silent> o             :exec g:Lf_py "marksExplManager.accept()"<CR>
    nnoremap <buffer> <silent> <2-LeftMouse> :exec g:Lf_py "marksExplManager.accept()"<CR>
    nnoremap <buffer> <silent> x             :exec g:Lf_py "marksExplManager.accept('h')"<CR>
    nnoremap <buffer> <silent> v             :exec g:Lf_py "marksExplManager.accept('v')"<CR>
    nnoremap <buffer> <silent> t             :exec g:Lf_py "marksExplManager.accept('t')"<CR>
    nnoremap <buffer> <silent> q             :exec g:Lf_py "marksExplManager.quit()"<CR>
    nnoremap <buffer> <silent> i             :exec g:Lf_py "marksExplManager.input()"<CR>
    nnoremap <buffer> <silent> <F1>          :exec g:Lf_py "marksExplManager.toggleHelp()"<CR>
endfunction

function! leaderf#Marks#startExpl(win_pos, ...)
    call leaderf#LfPy("marksExplManager.startExplorer('".a:win_pos."')")
endfunction
