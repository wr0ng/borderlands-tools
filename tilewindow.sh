#!/bin/bash
# tilewindow.sh: window tiling for 2-4 windows
# source: https://sites.google.com/site/aurizanotes/bash-tilewindow

if [ $# -lt 2 ]; then
  echo "Usage: ./`basename $0` window1 window2 [window3] [window4]"
  exit 1
fi

# desktop offset (x,y) and dimension (width,height)
x_offset=`wmctrl -d | head -n 1 | cut -d ' ' -f 11 | cut -d ',' -f 1`
y_offset=`wmctrl -d | head -n 1 | cut -d ' ' -f 11 | cut -d ',' -f 2`
w_desktop=`wmctrl -d | head -n 1 | cut -d ' ' -f 12 | cut -d 'x' -f 1`
h_desktop=`wmctrl -d | head -n 1 | cut -d ' ' -f 12 | cut -d 'x' -f 2`

# [!!] you need to fine-tune this value according to your window manager setting
# window decoration (width,height)
w_decor=8
h_decor=26

# window offset (x,y)
x_zero=$x_offset
y_zero=$y_offset
x_half=`expr $w_desktop / 2 + $x_zero`
y_half=`expr $h_desktop / 2 + $y_zero`

# window inner (width,height)
w_full=`expr $w_desktop - $w_decor`
h_full=`expr $h_desktop - $h_decor`
w_half=`expr $w_full / 2`
h_half=`expr \( $h_desktop - 2 \* $h_decor \) / 2`

function unmaximize { wmctrl -r $1 -b remove,maximized_vert,maximized_horz; wmctrl -a $1; }

function half_left           { unmaximize $1; wmctrl -r $1 -e 0,$x_zero,$y_zero,$w_half,$h_full; }
function half_right          { unmaximize $1; wmctrl -r $1 -e 0,$x_half,$y_zero,$w_half,$h_full; }
function half_top            { unmaximize $1; wmctrl -r $1 -e 0,$x_zero,$y_zero,$w_full,$h_half; }
function half_bottom         { unmaximize $1; wmctrl -r $1 -e 0,$x_zero,$y_half,$w_full,$h_half; }

function quarter_topleft     { unmaximize $1; wmctrl -r $1 -e 0,$x_zero,$y_zero,$w_half,$h_half; }
function quarter_topright    { unmaximize $1; wmctrl -r $1 -e 0,$x_half,$y_zero,$w_half,$h_half; }
function quarter_bottomleft  { unmaximize $1; wmctrl -r $1 -e 0,$x_zero,$y_half,$w_half,$h_half; }
function quarter_bottomright { unmaximize $1; wmctrl -r $1 -e 0,$x_half,$y_half,$w_half,$h_half; }

#  +---+---+
#  |   |   |
#  +---+---+
function two_tile {
    half_left $1
    half_right $2
}

#  +---+---+
#  |   |---|
#  +---+---+
function three_tile {
    half_left $1
    quarter_topright $2
    quarter_bottomright $3
}

#  +---+---+
#  |---|---|
#  +---+---+
function four_tile {
    quarter_topleft $1
    quarter_topright $2
    quarter_bottomleft $3
    quarter_bottomright $4
}


if [ $# -eq 2 ]; then
    two_tile $1 $2
elif [ $# -eq 3 ]; then
    three_tile $1 $2 $3
elif [ $# -eq 4 ]; then
    four_tile $1 $2 $3 $4
fi

exit 0
