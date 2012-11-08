#!/bin/bash
# set_terminal.sh: set terminal title
# author: Freddy Vulto
# source: http://www.fvue.nl/wiki/Bash:_How_to_change_tab_and_window_title_of_console

# @param string $1  Tab/window title
# DISABLED BY MIKE: @param string $2  (optional) Separate window title
#    (was causing exit status to be 'unsuccessful', even though it worked)
# The latest version of this software can be obtained here:
# http://fvue.nl/wiki/NameTerminal
 
function name_terminal() {
    [ "${TERM:0:5}" = "xterm" ]   && local ansiNrTab=0
    [ "$TERM"       = "rxvt" ]    && local ansiNrTab=61
    [ "$TERM"       = "konsole" ] && local ansiNrTab=30 ansiNrWindow=0
        # Change tab title
    [ $ansiNrTab ] && echo -n $'\e'"]$ansiNrTab;$1"$'\a'
        # If terminal support separate window title, change window title as well
    #[ $ansiNrWindow -a "$2" ] && echo -n $'\e'"]$ansiNrWindow;$2"$'\a'
} # name_terminal()
