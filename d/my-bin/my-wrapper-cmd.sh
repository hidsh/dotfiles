#!/usr/bin/zsh
#
# my-wrapper-cmd.sh

my-systemctl () {
  echo $#
  echo $0
  echo $*
  local help="Usage: systemctl service [enabled|disabled]"

# ** This program is my wrapper command **
# List services whether enabled|disabled."
  # return 0

  [[ "$#" -eq 0 ]] && \systemctl --help
  [ "$1" != "service" ] && \systemctl $*

  [ "$2" = "" ] || [ ! "$2" = "enabled" ] || [ ! "$2" = "disbled" ] && echo $help; return 1

  echo 'systemctl list-unit-files -t service | grep $2'
}

alias systemctl=my-systemctl
