#!/bin/bash
# main.sh: start a session of Borderlands Granular.
# author: Michael Floering
#
# TODO: document arguments
#
# What it does:
# 1) start JACK (via QjackCtl)
# 1.5) sleep while JACK initializes
# 2) start Borderlands
# 3) start extras (currently, rakarrack is the only option)
# 4) start recording - with jack_capture or audacity
# 5) start moc (music on console: a command-line based media player)
# 6) rearrange windows into a really usable arrangement
# 7) wait for user to 'press any key'
# 8) close all programs opened, using wmctrl


source $(dirname $0)/colorize.sh # echo hi | colorize yellow
source $(dirname $0)/name_terminal.sh # name_terminal newname

############################
## Initialize some things ##
############################

# Name terminal
name_terminal borderlands-tools

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
    bash start_jack.sh -p './qjackctl_patchbays/rak.xml'
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
#                                                          ^ starts it detached from terminal
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
    bash start_rakarrack.sh #-p $rak_preset
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


########################
## Start audio player ##
########################

# Happens last with the hope that it will create this window in FRONT of Borderlands, since usually you'll want to start audio playing, first thingy

# If NOT audacity -- i.e. starting audacity and starting mocp are exclusive,
# because it would be redundant to use both (and require a different config to
# do so)
if [[ -z "$audacity" ]]; then
    bash start_mocp.sh
fi

mocp -v 80 # Set volume a little lower

#######################
## Rearrange windows ##
#######################

# Tile the under-layer of windows
bash tilewindow.sh borderlands-tools jack_capture meterbridge

# Need to sleep a bit before we can ...
sleep 2s
# ... Bring MOC to the front (so you can start playing a song)

wmctrl -a 'Borderlands'
wmctrl -a 'MOC'

##############################################
## Wait for user command to quit everything ##
##############################################

echo "==> Press any key to quit all programs opened by this script" | colorize cyan

read -n 1 -s

wmctrl -F -c 'Borderlands' # -F makes it exact
wmctrl -c 'MOC'
wmctrl -c 'rakarrack'
wmctrl -c 'jack_capture'
wmctrl -c 'JACK Audio Connection Kit'

echo "... Good-bye!" | colorize green
