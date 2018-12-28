" ============================================================================
" File:        leaderf.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

command! -bar -nargs=0 LeaderfMarks call leaderf#Marks#startExpl(g:Lf_WindowPosition)

" In order to be listed by :LeaderfSelf
call g:LfRegisterSelf("LeaderfMarks", "navigate the marks")

let s:extension = {
            \   "name": "marks",
            \   "help": "navigate the marks",
            \   "registerFunc": "leaderf#Marks#register",
            \   "arguments": [
            \   ]
            \ }
call g:LfRegisterPythonExtension(s:extension.name, s:extension)
