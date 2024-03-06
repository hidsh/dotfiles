-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

--opt.nostartofline = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.relativenumber = false

-- disable auto-comments on new line
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

function toggle_linum()
  opt.number = not opt.number
end
vim.cmd("command! Linum lua toggle_linum()")

function toggle_wrap()
  opt.wrap = not opt.wrap
end
vim.cmd("command! TrancateLines lua toggle_wrap()")
