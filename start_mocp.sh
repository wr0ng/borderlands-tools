#!/bin/bash
# start_moc.sh: starts moc/mocp (music on console player) to play audio 
# author: Michael Floering
#
# NOTE: even though the program is called 'moc' it is invoked with the command
# 'mocp'

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh 

# TODO: Make dir configurable
echo "==> Starting mocp (music on console) in ~/Music" | colorize yellow
#mocp --server --sound-driver JACK &
gnome-terminal -x mocp -v 80 --sound-driver JACK --music-dir ~/Music &
status=$?
if test $status -eq 0 #successful
then
    echo "... Successfully started mocp" | colorize green
fi
