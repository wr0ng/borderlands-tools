#!/bin/bash
# rakarrack.sh: Open rakarrack with favorite settings
# author: Michael Floering
#
# NOTE: Assumes JACK is already running. See start_jack.sh

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

echo "==> Attempt to launch rakarrack" | colorize green
launch rakarrack --Preset presets/rakarrack/factory7.rk
