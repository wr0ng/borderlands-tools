#!/bin/bash
# start_jack_capture.sh: template for shell scripts
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh
 
echo "==> Making directory 'recorded' and cd'ing into it" | colorize yellow
mkdir -p recorded # -p makes it not throw error if it exists already
cd recorded

# Start jack capture
launch jack_capture -c 2 -m
