#!/bin/bash
#
# xmodmap-apply.sh
#

TIMEST=$(date +'%F %T')
LOGFILE='/tmp/xmodmap-apply.log'

# entry point
touch "$LOGFILE"
echo $TIMEST "Running xmodmap-apply.sh" >> "$LOGFILE"

echo $TIMEST' ' >> "$LOGFILE"
/usr/bin/sh -c "xmodmap ~/.Xmodmap" >> "$LOGFILE" 2>&1
