#!/bin/bash
# Start a session of Borderlands.
# More specifically,
# 1) start JACK (via QjackCtl)
# 2) start Borderlands
# 3) start recording with jack-capture

qjackctl -s &
echo "Sleeping for 2 seconds while QJackCtl starts"
sleep 2s
echo "Changing into Borderlands directory"
cd ~/Borderlands/Borderlands/
echo "Starting Borderlands"
./Borderlands &
echo "Returning to previous directory"
cd -
echo "Making and cding into directory for recording: jack_capture_output"
mkdir jack_capture_output
cd jack_capture_output
echo "Starting jack-capture with meterbridge in a new terminal"
gnome-terminal -x jack_capture -c 2 -mb &
