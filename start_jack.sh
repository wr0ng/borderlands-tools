#!/bin/bash
# start_jack.sh: Start JACK audio server using QjackCtl.
# author: Michael Floering

# Extremely simple!
# Open QjackCtl and immediately start (the -s arg does this).

echo "==> Open qjackctl and immediately start JACK server" | colorize yellow
qjackctl -s &
