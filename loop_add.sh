#!/bin/bash
# loop_add.sh: copy provided .wav or .aiff files to Borderlands' loops dir
# author: Michael Floering

source $(dirname $0)/config.cfg
source $(dirname $0)/colorize.sh

echo "==> Making link to file in $borderlands_directory/loops" | colorize green
ln -s $1 $borderlands_directory/loops/$(basename "$1")
#     ^ first argument
#                                  ^ get just filename from first arg



# TO DEBUG, ENABLE:
#echo "$@" $borderlands_directory/loops/$(basename "$1")
#
#sleep 10s
