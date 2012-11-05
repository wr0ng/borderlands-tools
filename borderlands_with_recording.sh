#!/bin/bash
# borderlands_with_recording.sh: start Borderlands and record its output
# author: Michael Floering

source $(dirname $0)/colorize.sh

echo "==> Starting a Borderlands session" | colorize green
bash borderlands.sh

echo "==> Start recording" | colorize green
bash record.sh
