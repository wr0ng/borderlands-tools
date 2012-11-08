#!/bin/bash
# start_mocp.sh: starts moc/mocp (music on console player) to play audio 
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh
 
# TODO: Make dir configurable
echo "==> Starting mocp (music on console) in ~/Music" | colorize yellow
gnome-terminal -x mocp --sound-driver JACK --music-dir ~/Music
status=$?
if test $status -eq 0 #successful
then
    echo "... Successfully started mocp" | colorize green
fi
