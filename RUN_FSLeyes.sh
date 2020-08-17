#!/bin/sh

# test if blas/lapac is reachable
s=cygblas-0.dll
if ! which $s 2>/dev/null | grep "$s" >/dev/null
then
  echo "can't find $s"
  echo "this might due to a missing '/usr/lib/lapack' entry in the PATH"
  echo "close this cygwin terminal, reopen, and try again" 
  echo "if everything fails you may have to reinstall cygwin"
  echo "sorry, aborting script"
  exit -1
fi
s=cyglapack-0.dll
if ! which $s 2>/dev/null| grep "$s" >/dev/null
then
  echo "can't find $s"
  echo "this might due to a missing '/usr/lib/lapack' entry in the PATH"
  echo "close this cygwin terminal, reopen, and try again" 
  echo "if everything fails you may have to reinstall cygwin"
  echo "sorry, aborting script"  
  exit -1
fi
# test if windows OpenGL dll is reachable
s=glu32.dll 
if ! which $s 2>/dev/null| grep "$s" >/dev/null
then
  echo "can't find $s"
  echo "this might due to a missing '/cygdrive/c/Windows/system32' entry in the PATH"
  echo "close this cygwin terminal, reopen, and try again" 
  echo "if everything fails you may have to reinstall cygwin"
  echo "sorry, aborting script"  
  exit -1
fi

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
