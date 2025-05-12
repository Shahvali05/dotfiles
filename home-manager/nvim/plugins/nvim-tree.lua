local nvimtree = require("nvim-tree")


-- ============================================================================
-- Настройка nvim-tree (файловый менеджер)
-- ============================================================================


-- Рекомендуемые настройки (отключение netrw)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Основная конфигурация
nvimtree.setup({
  view = {
    width = 35,
    relativenumber = true,
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
  actions = {
    open_file = {
      window_picker = {
        enable = false, -- Отключить выбор окна при открытии файла
      },
    },
  },
  filters = {
    custom = { ".DS_Store" }, -- Скрыть определённые файлы
  },
  git = {
    ignore = false, -- Показывать файлы, игнорируемые git
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- Привязка Enter для открытия файла
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  end,
})

-- ============================================================================
-- Горячие клавиши
-- ============================================================================


local keymap = vim.keymap
keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Открыть NvimTree" })
