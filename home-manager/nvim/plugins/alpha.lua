local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")


-- ============================================================================
-- Настройка заголовка
-- ============================================================================


dashboard.section.header.val = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
}


-- ============================================================================
-- Настройка кнопок меню
-- ============================================================================


dashboard.section.buttons.val = {
  dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
  dashboard.button("Ctrl + n", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
  dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
  dashboard.button("SPC lg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
  dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
}


-- ============================================================================
-- Инициализация и дополнительные настройки
-- ============================================================================


alpha.setup(dashboard.opts)  -- Применение конфигурации к alpha

-- Отключение сворачивания для буфера alpha
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
