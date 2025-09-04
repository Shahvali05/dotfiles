local nvimtree = require("nvim-tree")


-- ============================================================================
-- Настройка nvim-tree (файловый менеджер)
-- ============================================================================


-- Рекомендуемые настройки (отключение netrw)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Основная конфигурация
nvimtree.setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = false,
  },
  view = {
    width = 35,
    relativenumber = true,
    adaptive_size = true,
  },
  renderer = {
    indent_markers = {
      enable = true, -- Вертикальные направляющие между папками
    },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- Иконка закрытой папки
          arrow_open   = "", -- Иконка открытой папки
        },
      },
    },
  },
  -- actions = {
  --   open_file = {
  --     window_picker = {
  --       enable = false, -- Отключить выбор окна при открытии файла
  --     },
  --   },
  -- },
  filters = {
    custom = { ".DS_Store" "__pycache__" ".git" ".venv" }, -- Скрыть определённые файлы
  },
  git = {
    ignore = false, -- Показывать файлы, игнорируемые git
  },
})

-- ============================================================================
-- Горячие клавиши
-- ============================================================================


local keymap = vim.keymap
keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Открыть NvimTree" })


