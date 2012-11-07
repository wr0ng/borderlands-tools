#!/bin/bash
# start_jack.sh: Start JACK audio server using QjackCtl.
# author: Michael Floering
#
# Open QjackCtl and immediately start, loading the specified preset if set.
# Accepts named parameter jack_preset - should be path to a qjackctl preset

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

while getopts "p:" opt; do
  case $opt in
    p) # to qjackctl -p means preset, and -a means patchbay;
       # but to us -a means audacity, so -p is gonna mean patchbay
      echo "Got -p $OPTARG; will use this patchbay for qjackctl" | colorize blue
      patchbay=$OPTARG
      ;;
  esac
done

echo "==> Opening qjackctl and immediately starting JACK server" | colorize yellow
if [[ -n "$patchbay" ]]; then
    echo "... Got patchbay" | colorize blue
    launch qjackctl --start --active-patchbay=$patchbay &
else
    launch qjackctl --start &
fi
