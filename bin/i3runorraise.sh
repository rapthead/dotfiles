#!/usr/bin/env bash

if [ $# -lt 2 ]; then
    i3-nagbar -t error -m "${0##*/} : error (wrong number of arguments)"
    exit
else
    criteria=$1
    shift
    focus_result=$(i3-msg "$criteria focus")
    if [ $focus_result != "[{\"success\":true}]" ]; then
        echo i3-msg exec "$*"
        i3-msg exec "$*"
    fi
fi
