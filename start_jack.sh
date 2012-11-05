#!/bin/bash
# start_jack.sh: Start JACK audio server using QjackCtl.
# author: Michael Floering

# Extremely simple!
# Open QjackCtl and immediately start (the -s arg does this).
#
# Does not use launch like the other scripts do, because
# JACK is a requirement. QjackCtl doesn't necessarily have to be used;
# modify this file accordingly if you wish to launch jack differently,
# for example launching it directly.

echo "==> Open qjackctl and immediately start JACK server" | colorize yellow
qjackctl -s &
