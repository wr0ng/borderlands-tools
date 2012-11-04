#!/bin/bash
# borederlands.sh: start a session of Borderlands Granular.
# author: Michael Floering
# 
# What it does:
# 1) start JACK (via QjackCtl)
# 2) start Borderlands

echo "==> Starting JACK"
bash start_jack.sh

echo "Sleeping for 2 seconds while QJackCtl starts"
echo "(In this script, Borderlands will silently die if JACK has not"
echo "yet started. So if Borderlands is not launching, make this longer.)" 
sleep 2s

echo "Changing into Borderlands directory"
# Wildcard used so it is not version-contingent, but this will break
# if you have more than one folder that matches.
cd ~/Borderlands*/Borderlands/

echo "Starting Borderlands"
./Borderlands &

echo "Returning to previous directory"
cd -
