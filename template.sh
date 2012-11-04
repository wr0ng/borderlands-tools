#!/bin/bash
# template.sh: template for shell scripts
# author: Michael Floering
# 
# What it does:
# 1) Act as an example
#
# Example usage:
# Just duplicate it to stub out new scripts, like:
# cp template.sh new_shell_script_name.sh

source $(dirname $0)/colorize.sh
 
echo "==> I am green in this area" | colorize green
# some command
