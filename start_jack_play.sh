#!/bin/bash
# start_jack_play.sh: asks user which file to play then plays it using jack.play
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh 

audio_file="TODO"

# TODO: Make dir configurable
echo "==> Starting playback of audio file using jack.play" | colorize yellow
gnome-terminal -x jack.play -n backtrackplayback -u $audio_file
status=$?
if test $status -eq 0 #successful
then
    echo "... Successfully opened a new terminal running jack.play" | colorize green
fi
