#!/bin/sh
mpdcron -n >> /home/noname/.mpdcron/mpdcron.log 2>&1 &
mpdcron_pid=$!
trap "/home/noname/.mpdcron/hooks/exit; kill $mpdcron_pid" SIGINT
wait $mpdcron_pid
