#!/bin/bash
# borderlands.sh: start a session of Borderlands Granular.
# author: Michael Floering
# 
# What it does:
# 1) start JACK (via QjackCtl)
# 2) start Borderlands

source $(dirname $0)/colorize.sh
 
echo "==> Starting JACK" | colorize green
bash start_jack.sh

echo "==> Sleeping for 2 seconds while QJackCtl starts." | colorize yellow
echo "==> (Borderlands will silently die if JACK has finished initializing. If you hit an issue where Borderlands is not starting from this script, make this sleep longer.)" | colorize yellow
sleep 2s

echo "==> Changing into Borderlands directory" | colorize yellow
# Wildcard used so it is not version-contingent, but this will break
# if you have more than one folder that matches.
cd ~/Borderlands*/Borderlands/

echo "==> Starting Borderlands" | colorize yellow
./Borderlands &

echo "==> Returning to previous directory" | colorize yellow
cd -
