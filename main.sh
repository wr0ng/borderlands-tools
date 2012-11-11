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
# 4-5) use audacity for backtrack and recording instead*
# 6) rearrange windows a little
# 7) wait for user to 'press any key'
# 8) close all programs opened, using wmctrl
#
# * Non-working, retired version of steps 4 & 5:
#   4) start jack.play for playback
#     a) prompt user asking them which audiofile to play
#     b) begin playing that file
#   &&
#   5) start recording with jack_capture

source $(dirname $0)/config.cfg # load user-specific configuration
source $(dirname $0)/colorize.sh # echo hi | colorize yellow
source $(dirname $0)/name_terminal.sh # name_terminal newname

############################
## Initialize some things ##
############################

# cd into borderlands-tools directory
cd $borderlands_tools_dir

# Name terminal
name_terminal borderlands-tools-messages

# Parse options
while getopts "aj:r:x:" opt; do
  case $opt in
    a)
      echo "Got -a; will record with audacity" | colorize blue
      audacity=true
      ;;
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

################
## Start JACK ##
################

# Jack should be called with a patchbay specific to each EXTRA

echo "==> Starting JACK" | colorize yellow
if [[ $extra = 'rak' ]]; then
    bash start_jack.sh -p './qjackctl_patchbays/rak.xml'
else
    bash start_jack.sh
fi

## Sleep
# Change the numbers here if you need it to sleep for longer
echo "... Sleeping for $sleep_seconds seconds while QJackCtl starts" | colorize blue
sleep $sleep_seconds

#######################
## Start Borderlands ##
#######################

echo "==> Changing into Borderlands directory set in config" | colorize yellow
# Wildcard used so it is not version-contingent, but this will break
# if you have more than one folder that matches.
cd $borderlands_directory

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
    bash start_rakarrack.sh #-p $rak_preset
fi

###########################################
## Start recording && backtrack playback ##
###########################################

echo "==> Starting recording" | colorize yellow
if ! $audacity ; then
    # if NOT audacity, run start_jack_play.sh which
    #   a) asks which file to play (halting the script) then
    #   b) starts playing it
    # && start recording -
    #    so they're as close as possible to being simultaneously started
    bash start_jack_play.sh && bash record.sh
else
    # audacity handles recording AND backtrack playback if desired.
    bash record.sh -a
fi

#######################
## Rearrange windows ##
#######################

# Tile the under-layer of windows
#bash tilewindow.sh borderlands-tools jack_capture

# Sleep a moment then order the layering of windows using xdotool windowraise
sleep 2s

#xdotool search --name 'borderlands-tools' windowraise
#xdotool search --name 'rakarrack' windowraise
#xdotool search --name 'meterbridge' windowraise
#case 
xdotool search --name 'Borderlands' windowraise

##############################################
## Wait for user command to quit everything ##
##############################################

echo "==> Press any key to quit (save your work first)" | colorize cyan

read -n 1 -s # waits for any key press

#wmctrl -F -c 'Borderlands' &>/dev/null # -F makes it exact
#wmctrl -c 'rakarrack' &>/dev/null
#wmctrl -c 'backtrackplayback' &>/dev/null
#wmctrl -c 'jack_capture' &>/dev/null

#if $audacity; then
#    echo "!!! Not closing audacity or JACK so you don't lose unsaved work" | colorize blue
#else
#    wmctrl -c 'JACK Audio Connection Kit' &>/dev/null
#fi

echo "... Good-bye!" | colorize green

#wmctrl -c 'borderlands-tools-messages'
