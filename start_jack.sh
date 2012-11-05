#!/bin/bash
# start_jack.sh: Start JACK audio server using QjackCtl.
# author: Michael Floering
#
# Open QjackCtl and immediately start, loading the specified preset if set.
# Accepts named parameter jack_preset - should be path to a qjackctl preset

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

echo "==> Open qjackctl and immediately start JACK server" | colorize yellow
if [ -z "${preset}" ]; then
    echo "... Got preset" | colorize blue
    launch qjackctl --start --preset=${preset} &
else
    launch qjackctl --start &
fi
