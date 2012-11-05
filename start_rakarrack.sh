#!/bin/bash
# start_rakarrack.sh: Open rakarrack with favorite settings
# author: Michael Floering
#
# NOTE: Assumes JACK is already running. See start_jack.sh

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

## Use default preset unless over-ridden
if [ -z ${preset}]; then
    preset=presets/rakarrack/factory7.rk
else
    preset=${preset}
fi

echo "==> Attempting to launch rakarrack" | colorize yellow
launch rakarrack --Preset $preset
