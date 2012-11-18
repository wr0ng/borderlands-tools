#!/bin/bash
# start_rakarrack.sh: Open rakarrack with favorite settings
# author: Michael Floering
#
# NOTE: Assumes JACK is already running. See start_jack.sh

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh

while getopts "p:" opt; do
  case $opt in
    p)
      echo "Got -p $OPTARG; will use this preset for rakarrack" | colorize blue
      preset=$OPTARG
      ;;
    \?)
      echo "Invalid option: $OPTARG" | colorize red
      ;;
  esac
done

## Use default preset unless over-ridden - -z kind of means "not"
if [[ -z $preset ]]; then
    preset=./rak_presets/default.rkr
fi

echo "==> Attempting to launch rakarrack" | colorize yellow
launch rakarrack --Load $preset --Bank ./rak_presets/bank.rkrb
