#!/usr/bin/env -S v
// chmod +x ~/.local/bin/xxxx.vsh

fn sh(cmd string) string {
    return execute_or_exit(cmd).output
}

for line in sh('echo \$PATH').split(':') {
    println(line)
}
