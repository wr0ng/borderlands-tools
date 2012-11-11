#!/bin/bash
# setup.sh: template for shell scripts
# author: Michael Floering

source $(dirname $0)/colorize.sh
source $(dirname $0)/launch_if_possible.sh
 
echo "==> Replacing all occurences of \$HOME in .desktop files with $HOME" | colorize yellow

function render_with_real_home {

# Example: given arg 'Borderlands.desktop' it will read in 'Borderlands.desktop.template', replace all instances of string $HOME with the actual $HOME var, then output to Borderlands.desktop

    _home="$HOME"
    _home="${_home//\//\\/}"

    cat $1.template | sed -e "s/\$HOME/$_home/g" > $1

} # render_with_real_home

# do that for both .desktop files
render_with_real_home BorderlandsLauncher.desktop
render_with_real_home BorderlandsLoopManager.desktop

echo "==> Making everything executable" | colorize yellow

# chmod everything all .sh files and .desktop files in directory
chmod 755 *.sh
chmod 755 *.desktop

echo "==> Moving .desktop files to ~/.local/share/applications" | colorize yellow

# move the .desktop files to the magical place
cp BorderlandsLauncher.desktop ~/.local/share/applications/BorderlandsLauncher.desktop
cp BorderlandsLoopManager.desktop ~/.local/share/applications/BorderlandsLoopManager.desktop

# open folder there
nautilus ~/.local/share/applications

echo "!!! Now, drag BorderlandsLauncher and BorderlandsLoopsManager onto your launcher panel. Then right click each icon and click 'Keep in Launcher' if you want to keep them there. Press any key to finish." | colorize red

read -n 1 -s # waits for any key press
