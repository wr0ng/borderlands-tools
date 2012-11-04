#!/bin/bash
# record.sh: Use jack_capture tor record from JACK into jack_capture_output.
# author: Michael Floering

echo "Making and cding into directory for recording: jack_capture_output"
mkdir jack_capture_output
cd jack_capture_output

echo "Starting jack-capture with meterbridge in a new terminal"
echo "(Change gnome-terminal to another terminal emulator if you need to)"
gnome-terminal -x jack_capture -c 2 -mb &
