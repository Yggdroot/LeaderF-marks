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
    nnoremap <buffer> <silent> p             :exec g:Lf_py "marksExplManager._previewResult(True)"<CR>
    nnoremap <buffer> <silent> q             :exec g:Lf_py "marksExplManager.quit()"<CR>
    nnoremap <buffer> <silent> i             :exec g:Lf_py "marksExplManager.input()"<CR>
    nnoremap <buffer> <silent> <F1>          :exec g:Lf_py "marksExplManager.toggleHelp()"<CR>
    if has_key(g:Lf_NormalMap, "Marks")
        for i in g:Lf_NormalMap["Marks"]
            exec 'nnoremap <buffer> <silent> '.i[0].' '.i[1]
        endfor
    endif
endfunction

function! leaderf#Marks#managerId()
    " pyxeval() has bug
    if g:Lf_PythonVersion == 2
        return pyeval("id(marksExplManager)")
    else
        return py3eval("id(marksExplManager)")
    endif
endfunction
