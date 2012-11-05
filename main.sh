#!/bin/bash
# main.sh: start a session of Borderlands Granular.
# author: Michael Floering
# 
# What it does:
# 1) start JACK (via QjackCtl)
# 2) start Borderlands
# 3) start recording

source $(dirname $0)/colorize.sh

############################
## Initialize some things ##
############################

borderlands_tools_dir=`pwd` # Need to put those quotes to evaluate right now

################
## Start JACK ##
################

echo "==> Starting JACK" | colorize yellow
bash start_jack.sh --preset=${jack_preset}

## Sleep
if [[ -z "${sleep_seconds}" ]]; then # if not --sleep_seconds set, set a default
    sleep_seconds=3
else
    sleep_seconds=${sleep_seconds}
fi
echo "... Sleeping for ${sleep_seconds} seconds while QJackCtl starts" | colorize blue

sleep $sleep_seconds

#######################
## Start Borderlands ##
#######################

echo "==> Changing into ~/Borderlands*/Borderlands directory" | colorize yellow
# Wildcard used so it is not version-contingent, but this will break
# if you have more than one folder that matches.
cd ~/Borderlands*/Borderlands/

echo "==> Starting Borderlands" | colorize yellow
./Borderlands &>$borderlands_tools_dir/log_borderlands.log &
#             ^ sends output to named log
#                                                           ^ starts it detached from terminal
status=$?
if test $status -eq 0 #successful
then
    echo "... Successfully started Borderlands" | colorize green
else
    echo "... Failed to start Borderlands" | colorize red
    echo "... (Borderlands dies if JACK has not finished initializing. If you hit an issue where Borderlands is not starting from this script, make it sleep for longer.)" | colorize red
fi

echo "==> Returning to previous directory" | colorize yellow
cd - >/dev/null

#######################
## Start extra stuff ##
#######################

if [[ -n "${rak}" ]]; then
    echo "... Got flag rak (meaning rakarrack)" | colorize blue
    echo "==> Launching rakarrack" | colorize yellow
    bash start_rakarrack.sh --preset=${rak_preset}
fi

#####################
## Start recording ##
#####################

echo "==> Starting recording" | colorize yellow
if [[ -n "${audacity}" ]]; then
    bash record.sh --audacity
else
    bash record.sh
fi
