local auto_session = require("auto-session")

auto_session.setup({
  auto_restore = false, -- Не восстанавливать автоматически при запуске
  auto_save = true, -- Автоматически сохранять при выходе
  suppressed_dirs = { "~/", "~/Downloads", "/" },
})

-- Горячие клавиши для управления сессиями
local keymap = vim.keymap

keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Восстановить сессию для текущей директории" })
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Сохранить сессию" })
keymap.set("n", "<leader>wl", "<cmd>SessionSearch<CR>", { desc = "Список сессий (поиск)" })
keymap.set("n", "<leader>wd", "<cmd>SessionDelete<CR>", { desc = "Удалить сессию для текущей директории" })
