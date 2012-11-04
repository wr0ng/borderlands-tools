#!/bin/bash
# colorize.sh: Pipe text into here to have it echoed in color.
# original author: eljunior http://askubuntu.com/users/36349/eljunior
# source: http://askubuntu.com/questions/135214/pipable-command-to-print-in-color
# modified by: Michael Floering

# colorize stdin according to parameter passed (GREEN, CYAN, BLUE, YELLOW)
colorize(){
    green="\033[0;32m"
    cyan="\033[0;36m"
    gray="\033[0;37m"
    blue="\033[0;34m"
    yellow="\033[0;33m"
    NORMAL="\033[m"
    color=\$${1:-NORMAL}
    # activate color passed as argument
    echo -ne "`eval echo ${color}`"
    # read stdin (pipe) and print from it:
    cat
    # Note: if instead of reading from the pipe, you wanted to print
    # the additional parameters of the function, you could do:
    # shift; echo $*
    # back to normal (no color)
    echo -ne "${NORMAL}"
}

# example:
# echo hi | colorize green
