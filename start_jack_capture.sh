#!/bin/bash
# start_jack_capture.sh: template for shell scripts
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

borderlands_tools_dir=`pwd`

echo "==> Making directory 'recorded' and cd'ing into it" | colorize yellow
mkdir -p recorded # -p makes it not throw error if it exists already
cd recorded

echo "==> Starting jack_capture in this terminal" | colorize yellow
jack_capture -c 2 -mb

echo "==> Returning to borderlands-tools directory" | colorize yellow
cd $borderlands_tools_dir
