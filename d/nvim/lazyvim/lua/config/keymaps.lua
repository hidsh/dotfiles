-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("n", ";", ":", { desc = "; acts as :" })
vim.keymap.set("n", ":", ";", { desc = ": acts as ;" })

vim.keymap.set("n", "H", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "L", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<C-x>k", "<cmd>tabclose<cr>", { desc = "Close Tab" })

