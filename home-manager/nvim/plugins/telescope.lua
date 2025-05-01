-- ============================================================================
-- Настройка плагина telescope.nvim и его расширений
-- ============================================================================


require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy                   = true,   -- Включить нечеткий поиск
      override_generic_sorter = true,   -- Переопределить общий сортировщик
      override_file_sorter    = true,   -- Переопределить сортировщик файлов
      case_mode               = "smart_case", -- Умный учёт регистра
    },
  },
})

-- Загрузка расширения fzf
require('telescope').load_extension('fzf')

-- Загрузка расширения dap
require('telescope').load_extension('dap')


-- ============================================================================
-- Привязки клавиш для Telescope
-- ============================================================================


local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Поиск файлов" })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = "Глобальный поиск" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Открытые буферы"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Справка" })
vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = "Найти TODO" })
