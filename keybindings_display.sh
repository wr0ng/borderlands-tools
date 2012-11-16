#!/bin/bash
# keybindings_display.sh: display Borderlands keybindings to the user
# author: Michael Floering
 
source $(dirname $0)/config.cfg # load user-specific configuration

zenity --info --text="`cat $borderlands_tools_dir/texts/keybindings.txt`"
