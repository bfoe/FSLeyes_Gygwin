#!/bin/sh

# start XWin server if not running already
if ps | grep XWin >/dev/null
then
    XWin_was_running=1
else
    echo "starting X server"
    XWin_was_running=0
    startxwin 2>/dev/null & 
    sleep 2
fi

# start FSLeyes
export DISPLAY=:0
if [[ ! -v FSLDIR ]];  then export FSLDIR=~; fi
fsleyes 1>/dev/null 2>/dev/null
# for debuging use the below instead
#fsleyes_unfiltered

# leave XWin as before
if [[ $XWin_was_running == 0 ]]; then
    echo "stopping X server"
    killall XWin 2>/dev/null
    killall dbus-daemon 2>/dev/null
    killall gam_server 2>/dev/null
fi
