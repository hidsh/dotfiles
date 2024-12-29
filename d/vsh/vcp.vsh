#!/usr/bin/env -S v
// chmod +x ~/.local/bin/xxxx.vsh

import os

fn sh(cmd string) string {
    return execute_or_exit(cmd).output
}

type Alias = []string

fn (arr Alias) concat() string {
    mut ret := ''
    for s in arr {
        ret += s
    }
    return ret
}


args := os.args[1..]

paths := args.filter(it.starts_with('-') == false)
assert paths.len == 2       // TODO
src  := paths.first()
dest := paths.last()

opts  := Alias(args.filter(it.starts_with('-') == true).map(it.trim_left('-'))).concat()

if opts.contains('r') == false && opts.contains('r') == false {
    // println(sh('cp $args'))
    exit(0)
}




println(opts)
println('$src, $dest')
