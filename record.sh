#!/bin/bash
# record.sh: Use jack_capture tor record from JACK into jack_capture_output.
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

while getopts "a" opt; do
  case $opt in
    a)
      echo "Got -a; will use audacity" | colorize blue
      audacity=true
      ;;
  esac
done

if [[ -n "${audacity}" ]]; then
    echo "... Got flag audacity" | colorize blue
    echo "==> Launch audacity" | colorize yellow
    echo "!!! Notice: Audacity does not accept arguments from the terminal so if you want to record with it, you must do this manually." | colorize red
    launch audacity
else
    echo "... Using jack_capture for recording" | colorize blue
    # Open a new terminal, in which you use launch_if_possible's launch function
    # to launch jack_capture (or print error messages if the program isn't
    # installed)
    bash start_jack_capture.sh
    # You can change gnome-terminal to another terminal emulator if you need to.
fi

#echo "==> Returning to previous directory" | colorize yellow
#cd - >/dev/null
