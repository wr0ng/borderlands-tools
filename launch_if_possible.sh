#!/bin/bash
# launch_if_possible.sh: Check if a command exists, run it detached if it does
# author: Michael Floering
#
# Example usage:
# source launch_if_possible.sh
# launch rakarrack any number of arguments

source $(dirname $0)/colorize.sh

function launch {

    echo "==> Test if $1 is installed" | colorize yellow
    # This returns exit status 0 if rakarrack is a command, 1 if not
    command -v $1 >/dev/null 2>&1
    # `$?` returns exit status of last command - set it to a var
    has_it=$?

    # next, open $1 only if they have it
    if test $has_it -eq 0
    then
        echo "==> Start $1 with arguments $@" | colorize yellow
        "$@" &
    else
        echo "==> Does not have $1; skipping" | colorize red
    fi

}
