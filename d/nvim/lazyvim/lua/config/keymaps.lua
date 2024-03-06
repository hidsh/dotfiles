-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Note: This file will be loaded after `plugins.lua`
vim.keymap.set("n", "<C-x>k", "<cmd>bd<cr>", { desc = "Close Tab" })
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "; acts as :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = ": acts as ;" })
vim.keymap.set({ "n", "v" }, "3", "#", { desc = "3 acts as #" })
vim.keymap.set({ "n", "v" }, "4", "$", { desc = "4 acts as $" })
vim.keymap.set({ "n", "v" }, "8", "*", { desc = "8 acts as *" })
vim.keymap.set({ "n", "v" }, "a", "A", { desc = "a acts as A" })
vim.keymap.set({ "n", "v" }, "m", "<c-f>", { desc = "Page Down" })
vim.keymap.set({ "n", "v" }, "M", "<c-b>", { desc = "Page Up" })
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "redo" })

function toggle_linum()
  vim.opt.number = not vim.opt.number
end
vim.cmd("command! Linum lua toggle_linum()")

function toggle_wrap()
  vim.opt.wrap = not vim.opt.wrap
end
vim.cmd("command! TruncateLines lua toggle_wrap()")
