#!/bin/bash
#
# /usr/lib/systemd/system-sleep/xmodmap-at-resume.sh
#
# https://unix.stackexchange.com/questions/505350/xmodmap-lost-after-sleep

# config:
#   U     <-- paste a result of `whoami`
#   XAUTH <-- paste a result of `echo $XAUTHORITY`
U=g
XAUTH=/run/user/1000/gdm/Xauthority

TIMEST=$(date +'%F %T')
LOGFILE='/tmp/xmodmap-at-resume.log'

# entry point
echo $TIMEST "Running xmodmap-at-resume.sh with argument: $1" >> $LOGFILE

if [ "${1}" == "pre" ]; then
    # echo $TIMEST "pre" >> $LOGFILE
    # Nothing to do for pre-sleep
elif [ "${1}" == "post" ]; then
    # echo $TIMEST "post" >> $LOGFILE
    export DISPLAY=:0  # Set the DISPLAY variable
    export XAUTHORITY=$XAUTH
    echo $TIMEST' ' >> $LOGFILE
    /usr/bin/sh -c "sleep 7 && xmodmap /home/$U/.Xmodmap" >> $LOGIFLE 2>&1
fi
