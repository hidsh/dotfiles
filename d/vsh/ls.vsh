#!/usr/bin/env -S v
// chmod +x ~/.local/bin/03-args.vsh

import os

args := os.args[1..]

if args
println(args)
