#!/bin/bash
# loops_clear.sh: rm all loops from borderlands loops dir
# author: Michael Floering

source $(dirname $0)/config.cfg
source $(dirname $0)/colorize.sh

if $ask_before_clearing_loops; then
    echo "==> Remove all files in $borderlands_directory/loops" | colorize cyan
    gnome-terminal -x rm -i $1 $borderlands_directory/loops/* 
else
    echo "==> Remove all files in $borderlands_directory/loops" | colorize cyan
    gnome-terminal -x rm $1 $borderlands_directory/loops/* 
fi
