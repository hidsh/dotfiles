#!/bin/sh
#
# prerequisite | arch-package
# -------------+--------------
# netstat      | net-tools
# awk          | gawk
#
# install:
#      sudo ln -s PATH-TO-THIS-sh /etc
#      sudo sh -c "sudo echo 'session   optional  pam_exec.so quiet /etc/pam_session.sh' >> /etc/pam.d/sshd"
#
# This script runs when an ssh session opens/closes, and masks/unmasks
# systemd sleep and hibernate targets, respectively.
#
# Inspired by: https://unix.stackexchange.com/a/136552/84197 and
#              https://askubuntu.com/a/954943/388360
# Refer to: https://askubuntu.com/questions/521620/prevent-machine-from-sleeping-when-ssh-connections-are-on

num_ssh=$(netstat -nt | awk '$4 ~ /:22$/ && $6 == "ESTABLISHED"' | wc -l)

case "$PAM_TYPE" in
    open_session)
        if [ "${num_ssh}" -gt 1 ]; then
            exit
        fi
        command=mask
        ;;

    close_session)
        if [ "${num_ssh}" -ne 0 ]; then
            exit
        fi
        command=unmask
        ;;

    *)
        exit
esac

logger "${command}ing sleep and suspend targets (num_ssh=${num_ssh})"
sudo systemctl ${command} sleep.target suspend.target
