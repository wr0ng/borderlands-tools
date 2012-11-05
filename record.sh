#!/bin/bash
# record.sh: Use jack_capture tor record from JACK into jack_capture_output.
# author: Michael Floering

source $(dirname $0)/colorize.sh

echo "Make directory 'jack_capture_output' and cd into it" | colorize yellow
mkdir jack_capture_output
cd jack_capture_output

echo "Starting jack-capture with meterbridge in a new terminal" | colorize yellow
# Change gnome-terminal to another terminal emulator if you need to
gnome-terminal -x jack_capture -c 2 -mb &
