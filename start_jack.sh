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
    p)
      echo "Got -p $OPTARG; will use this preset for qjackctl" | colorize blue
      preset=$OPTARG
      ;;
  esac
done

echo "==> Opening qjackctl and immediately starting JACK server" | colorize yellow
if [[ -n "$preset" ]]; then
    echo "... Got preset" | colorize blue
    launch qjackctl --start --preset=$preset &
else
    launch qjackctl --start &
fi
