" ============================================================================
" File:        leaderf.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

command! -bar -nargs=0 LeaderfMarks call leaderf#Marks#startExpl(g:Lf_WindowPosition)

call g:LfRegisterSelf("LeaderfMarks", "navigate the marks")
