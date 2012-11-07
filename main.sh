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

# Parse options
while getopts "aj:r:x:" opt; do
  case $opt in
    a)
      echo "Got -a; will record with audacity" | colorize blue
      audacity=true
      ;;
#    j)
#      echo "Got -j $OPTARG - will use qjackctl preset $OPTARG" | colorize blue
#      qjackctl_preset=$OPTARG
#      ;;
    r)
      echo "Got -r $OPTARG - will use rakarrack preset $OPTARG" | colorize blue
      rakarrack_preset=$OPTARG
      ;;
    x)
      echo "Got -x $OPTARG - will launch extra $OPTARG" | colorize blue
      extra=$OPTARG
      ;;
  esac
done

# evaluate pwd (hence `quotes`) and save
borderlands_tools_dir=`pwd`

################
## Start JACK ##
################

echo "==> Starting JACK" | colorize yellow
if [[ $extra = 'rak' ]]; then
    bash start_jack.sh -p #'presets/jack/rak/'
else
    bash start_jack.sh
fi

## Sleep
# Change the numbers here if you need it to sleep for longer
echo "... Sleeping for 3 seconds while QJackCtl starts" | colorize blue
sleep 3s

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
cd $borderlands_tools_dir

#######################
## Start extra stuff ##
#######################

if [[ $extra = 'rak' ]]; then
    echo "==> Launching rakarrack" | colorize yellow
    bash start_rakarrack.sh -p $rakarrack_preset
fi

#####################
## Start recording ##
#####################

echo "==> Starting recording" | colorize yellow
if [[ -n "$audacity" ]]; then
    bash record.sh -a
else
    bash record.sh
fi
