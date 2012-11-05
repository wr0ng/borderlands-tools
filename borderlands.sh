#!/bin/bash
# borderlands.sh: start a session of Borderlands Granular.
# author: Michael Floering
# 
# What it does:
# 1) start JACK (via QjackCtl)
# 2) start Borderlands

source $(dirname $0)/colorize.sh

echo "==> Starting JACK" | colorize yellow
bash start_jack.sh --preset=${jack_preset}

## Sleep
if [ -z "${sleep_seconds}" ]; then
    sleep_seconds=3
fi
echo "... Sleeping for ${sleep_seconds} seconds while QJackCtl starts." | colorize yellow
sleep ${sleep_seconds}s

echo "==> Changing into Borderlands directory" | colorize yellow
# Wildcard used so it is not version-contingent, but this will break
# if you have more than one folder that matches.
cd ~/Borderlands*/Borderlands/

echo "==> Starting Borderlands" | colorize yellow
./Borderlands &
status=$?
if test $status -eq 0 #successful
then
    echo "... Successfully started Borderlands" | colorize green
else
    echo "... Failed to start Borderlands" | colorize red
    echo "... (Borderlands dies if JACK has not finished initializing. If you hit an issue where Borderlands is not starting from this script, make it sleep for longer.)" | colorize red
fi

echo "==> Returning to previous directory" | colorize yellow
cd -

echo "==> Start recording" | colorize yellow
bash record.sh
