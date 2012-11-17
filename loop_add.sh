#!/bin/bash
# loop_add.sh: copy provided .wav or .aiff files to Borderlands' loops dir
# author: Michael Floering

source $(dirname $0)/config.cfg
source $(dirname $0)/colorize.sh

for f in "$@"
do 
    echo "==> Making link to file in $borderlands_directory/loops" | colorize green
    ln -s $f $borderlands_directory/loops/$(basename "$f")
    #     ^ full path
    #                                     ^ get just filename
done

# TO DEBUG, ENABLE:
#echo "$@" $borderlands_directory/loops/$(basename "$1")
#
#sleep 10s
