require("oil").setup()

-- Открытие родительского каталога
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
