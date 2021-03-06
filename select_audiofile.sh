#!/bin/bash
# select_audiofile.sh: lists libsndfile-compatible audiofiles using select.
#   each item is numbered and user types the number to select.
#   0 is not an option but will nullify ... interpret $selected_audiofile
#   as "do not use any audiofile"
# author: Michael Floering

source $(dirname $0)/config.cfg
source $(dirname $0)/colorize.sh

function select_audiofile {
    # focus this window; assumes currently that the name is borderlands-tools
    xdotool search --name 'borderlands-tools' windowraise

    # ask user, then use select to create a menu
    echo "#===========================================#" | colorize blue 
    echo "??? What backtrack would you like to play ???" | colorize yellow
    echo "#===========================================#" | colorize blue
    PS3="==> Enter number: " #prompt

    # we will use a glob expression to list only libsndfile-readable audiofiles.
    # this shell option will silence the output from glob that occurs from
    # non-matches (so you won't get an error message if there are no .w64 files
    # in your directory, etc.)
    shopt -s nullglob

    # change into backtracks_directory
    cd $backtracks_directory

    # the glob below is a quick transcription of the table of supported formats
    # found here: http://www.mega-nerd.com/libsndfile/
    select FILENAME in *.{wav,ogg,raw,snd,au,paf,svx,iff,sf,voc,w64,pvf,mat4,mat5,xi,htk,caf,sd2,flac};
    do
        selected_audiofile=$backtracks_directory$FILENAME
        break  
    done

    if [ -z "$selected_audiofile" ] ; then
        echo "... No backtrack" | colorize green
    else
        echo "... You picked $FILENAME (number $REPLY)." | colorize green
    fi

    cd - >/dev/null
 
} # select_audiofile. sets $selected_audiofile
