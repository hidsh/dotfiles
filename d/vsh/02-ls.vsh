#!/usr/bin/env -S v
// chmod +x ~/.local/bin/shutdown.vsh

fn sh(cmd string) {
    print(execute_or_exit(cmd).output)
}

sh('ls -la')
