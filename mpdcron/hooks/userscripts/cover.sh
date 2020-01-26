#!/bin/bash
if [ ! -z "$MPD_SONG_URI" ]
then
    #rm /home/noname/.config/conky/cover.jpg && sleep 2
    ln -sf "$( dirname /home/noname/MUSIC/lossless/"$MPD_SONG_URI" )/cover.jpg" /home/noname/.config/conky
fi
