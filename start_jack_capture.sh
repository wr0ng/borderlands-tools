#!/bin/bash
# start_jack_capture.sh: template for shell scripts
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

borderlands_tools_dir=`pwd`

echo "==> Changing into 'recorded' (and running mkdir if needed)" | colorize yellow
mkdir -p recorded # -p makes it not throw error if it exists already
cd recorded

echo "==> Starting jack_capture in this terminal" | colorize yellow
gnome-terminal -t jack_capture -x jack_capture -c 3 -mb &
status=$?
if test $status -eq 0 #successful
then
    echo "... Successfully started jack_capture" | colorize green
fi

echo "==> Returning to borderlands-tools directory" | colorize yellow
cd $borderlands_tools_dir
