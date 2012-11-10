#!/bin/bash
# start_jack_play.sh: asks user which file to play then plays it using jack.play
# author: Michael Floering

source $(dirname $0)/colorize.sh

# use select_audiofile.sh to prompt use and ask which file to play
source $(dirname $0)/select_audiofile.sh
select_audiofile # sets $selected_audiofile

if [ $selected_audiofile ] ; then
    echo "==> Starting playback of audio file using jack.play" | colorize yellow
    gnome-terminal -t backtrackplayback -x jack.play -n backtrackplayback -u $selected_audiofile &
    status=$?
    if test $status -eq 0 #successful
    then
        echo "... Successfully opened a new terminal running jack.play" | colorize green
    fi
else
    echo "==> Continuing without backtrack" | colorize green
fi
