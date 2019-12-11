#!/usr/bin/env python
# -*- coding: utf-8 -*-

import vim
import os
import os.path
from leaderf.utils import *
from leaderf.explorer import *
from leaderf.manager import *


#*****************************************************
# MarksExplorer
#*****************************************************
class MarksExplorer(Explorer):
    def __init__(self):
        pass

    def getContent(self, *args, **kwargs):
        result = lfEval("execute('marks', 'silent')")
        return result.splitlines()[2:]

    def getStlCategory(self):
        return "Marks"

    def getStlCurDir(self):
        return escQuote(lfEncode(os.getcwd()))


#*****************************************************
# MarksExplManager
#*****************************************************
class MarksExplManager(Manager):
    def __init__(self):
        super(MarksExplManager, self).__init__()

    def _getExplClass(self):
        return MarksExplorer

    def _defineMaps(self):
        lfCmd("call leaderf#Marks#Maps()")

    def _acceptSelection(self, *args, **kwargs):
        if len(args) == 0:
            return
        line = args[0]
        cmd = line.split(None, 1)[0]
        lfCmd("norm! `" + cmd)
        lfCmd("norm! zz")
        lfCmd("setlocal cursorline! | redraw | sleep 100m | setlocal cursorline!")

    def _getDigest(self, line, mode):
        """
        specify what part in the line to be processed and highlighted
        Args:
            mode: 0, 1, 2, return the whole line
        """
        if not line:
            return ''
        return line[1:]

    def _getDigestStartPos(self, line, mode):
        """
        return the start position of the digest returned by _getDigest()
        Args:
            mode: 0, 1, 2, return 1
        """
        return 1

    def _createHelp(self):
        help = []
        help.append('" <CR>/<double-click>/o : execute command under cursor')
        help.append('" x : open file under cursor in a horizontally split window')
        help.append('" v : open file under cursor in a vertically split window')
        help.append('" t : open file under cursor in a new tabpage')
        help.append('" i : switch to input mode')
        help.append('" p : preview the result')
        help.append('" q : quit')
        help.append('" <F1> : toggle this help')
        help.append('" ---------------------------------------------------------')
        return help

    def _afterEnter(self):
        super(MarksExplManager, self)._afterEnter()
        if self._getInstance().getWinPos() == 'popup':
            lfCmd("""call win_execute(%d, 'let matchid = matchadd(''Lf_hl_marksTitle'', ''^mark line .*$'')')"""
                    % self._getInstance().getPopupWinId())
            id = int(lfEval("matchid"))
            self._match_ids.append(id)
            lfCmd("""call win_execute(%d, 'let matchid = matchadd(''Lf_hl_marksLineCol'', ''^\s*\S\+\s\+\zs\d\+\s\+\d\+'')')"""
                    % self._getInstance().getPopupWinId())
            id = int(lfEval("matchid"))
            self._match_ids.append(id)
            lfCmd("""call win_execute(%d, 'let matchid = matchadd(''Lf_hl_marksText'', ''^\s*\S\+\s\+\d\+\s\+\d\+\s*\zs.*$'')')"""
                    % self._getInstance().getPopupWinId())
            id = int(lfEval("matchid"))
            self._match_ids.append(id)
        else:
            id = int(lfEval('''matchadd('Lf_hl_marksTitle', '^mark line .*$')'''))
            self._match_ids.append(id)
            id = int(lfEval('''matchadd('Lf_hl_marksLineCol', '^\s*\S\+\s\+\zs\d\+\s\+\d\+')'''))
            self._match_ids.append(id)
            id = int(lfEval('''matchadd('Lf_hl_marksText', '^\s*\S\+\s\+\d\+\s\+\d\+\s*\zs.*$')'''))
            self._match_ids.append(id)

    def _beforeExit(self):
        super(MarksExplManager, self)._beforeExit()

    def _previewInPopup(self, *args, **kwargs):
        if len(args) == 0:
            return

        line = args[0]
        cmd = "silent! norm! `" + line.split(None, 1)[0]

        saved_eventignore = vim.options['eventignore']
        vim.options['eventignore'] = 'BufWinEnter'
        try:
            self._createPopupPreview("", self._getInstance().getOriginalPos()[2].number, 0, jump_cmd=cmd)
        finally:
            vim.options['eventignore'] = saved_eventignore


#*****************************************************
# marksExplManager is a singleton
#*****************************************************
marksExplManager = MarksExplManager()

__all__ = ['marksExplManager']
