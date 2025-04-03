local keymap = vim.keymap
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- Buffer navigation
keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>bNext<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" }) -- Изменено: просто закрывает буфер
keymap.set("n", "<leader>o", "<cmd>tabnew<CR>", { desc = "New tab" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buffer to new tab" })

-- Commentary
keymap.set("n", "<F3>", "<cmd>Commentary<CR>", { desc = "Toggle comment" })
keymap.set("v", "<F3>", ":Commentary<CR>", { desc = "Toggle comment" })

-- Tagbar
keymap.set("n", "<F8>", "<cmd>Tagbar<CR>", { desc = "Open Tagbar" })

-- Terminal
map("n", "<leader>c", ":botright split | resize 15 | terminal<CR>", opts)
map("t", "<Esc>", [[<C-\><C-n>:bd!<CR>]], opts)

-- Show keymaps in right split
_G.show_keymaps = function()
  vim.cmd('vsplit')
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, keymap_list)
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
end

-- Bind show_keymaps
map("n", "<leader>k", ":lua show_keymaps()<CR>", opts)
