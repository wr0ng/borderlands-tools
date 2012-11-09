#!/bin/bash
# kill_moc.sh: kill all processes with moc in the title

source $(dirname $0)/colorize.sh # echo hi | colorize yellow

echo "==> Killing all processes named moc" | colorize yellow
kill -9 $(ps -A | grep [m]oc | awk '{print $1}')
