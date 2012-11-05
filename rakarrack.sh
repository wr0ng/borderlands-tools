#!/bin/bash
# rakarrack.sh: Open rakarrack with favorite settings
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

echo "==> Attempt to launch rakarrack" | colorize green
launch rakarrack
