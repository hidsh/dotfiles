#!/bin/bash
#
# keybinding on pop!_os 22.04:
#   settings > keyboard > view and customize shrotcuts > custom shortcuts > +
#       name:       toggle-window-title
#       command:    /home/xxx/dotfiles/d/toggle-window-title.sh (needs absolute path)
#       shortcut:   ctrl + alt + t
#
# https://www.reddit.com/r/pop_os/comments/v0tj1b/hide_window_titles_keybind_and_or_terminal_command/?rdt=43900

class=org.gnome.shell.extensions.pop-shell
name=show-title
status=$(gsettings get "$class" "$name")
status=${status,,} # normalize to lower case; this is a modern bash extension
if [[ $status = true ]]; then
  new_status=false
else
  new_status=true
fi
gsettings set "$class" "$name" "$new_status"
