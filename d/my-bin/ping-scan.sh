#!/usr/bin/bash
#
# Usage: ping-scan.sh
#
# Notes:  This script can only be executed on Linux,
#         and treats only IPv4.
# Tested: Linux 6.13.8-arch1-1
#         ip (ip utility, iproute2-6.13.0, libbpf 1.5.0)
#         jq-1.7.1

my_ip() {
    ip -j a | jq -r '.[].addr_info.[] | select(.family == "inet" and .scope == "global") | .local'
}

get_subnet() {
        echo $1 | cut -f 1,2,3 -d .
}

# get_host() {
#         echo $1 | cut -f 4 -d .
# }
#
# s_strip() {
#   echo ${1//[$'\t\r\n ']}
# }

print_if_alive() {
  ping -c 1 $1 > /dev/null
  [ $? -eq 0 ] && printf "%-14s %s\n" $1 "is UP"
}


MY_IP=$(my_ip)
# MY_IP=`s_strip $MY_IP`
# echo \"$MY_IP\"

SUBNET=`get_subnet $MY_IP`
# SUBNET=`s_strip $SUBNET`
# echo $SUBNET

# HOST=`get_host $MY_IP`                      # str
# HOST=`s_strip $HOST`
# echo $HOST

echo "$MY_IP (MyIP) --> $SUBNET.1 .. 254"
echo '---------------------------------------------'
for i in $SUBNET.{1..254}; do           # exclude 255 because it means broadcasting
  if [ "$i" != "$MY_IP" ]; then
    # echo $i
    print_if_alive $i & disown
  fi
done
sleep 0.5                               # prevent prefetch for lazy prompt
