-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Note: This file will be loaded after `plugins.lua`
vim.keymap.set("n", ";", ":", { desc = "; acts as :" })
vim.keymap.set("n", ":", ";", { desc = ": acts as ;" })

vim.keymap.set("n", "<C-x>k", "<cmd>bd<cr>", { desc = "Close Tab" })
