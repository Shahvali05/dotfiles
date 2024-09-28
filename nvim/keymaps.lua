local keymap = vim.keymap
local M = {}
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- window management

-- Перемещение по вкладкам
--keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })  -- Вперёд по вкладкам
--keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })  -- Назад по вкладкам
--keymap.set("n", "<leader>x", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- Закрывать вкладку
--keymap.set("n", "<leader>o", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- Открывать новую вкладку

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

return M
