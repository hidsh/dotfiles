#!/usr/bin/bash
#
# Usage: ping-scan.sh
#
# Notes: This script can only be executed on WSL2/Windows.
#        You can specify $SUBNET variable.

SUBNET='192.168'

my_ip() {
        ipconfig.exe | rg 'IPv4' | rg $SUBNET | cut -f 2 -d :
}

get_prefix() {
        echo $1 | cut -f 1,2,3 -d .
}

get_suffix() {
        echo $1 | cut -f 4 -d .
}

s_strip() {
  echo ${1//[$'\t\r\n ']}
}

print_if_alive() {
  ping -c 1 $1 > /dev/null
  [ $? -eq 0 ] && echo $1 is up.
}


MY_IP=$(my_ip)
MY_IP=`s_strip $MY_IP`
#echo $MY_IP

PREFIX=`get_prefix $MY_IP`
PREFIX=`s_strip $PREFIX`
#echo $PREFIX

SUFFIX=`get_suffix $MY_IP`                      # str
SUFFIX=`s_strip $SUFFIX`
#echo $SUFFIX

echo "$MY_IP (MyIP) --> $PREFIX.1 .. 254"

for i in $PREFIX.{1..254}; do           # exclude 255 because it means broadcasting
  if [ "$i" != "$MY_IP" ]; then
#       echo $i
    print_if_alive $i & disown
  fi
done
