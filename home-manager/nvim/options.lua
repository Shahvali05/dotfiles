local opt = vim.opt


-- ============================================================================
-- Основные настройки редактора
-- ============================================================================


opt.number = true              -- Показывать номера строк
opt.relativenumber = true      -- Относительные номера строк
opt.tabstop = 2                -- Ширина табуляции
opt.shiftwidth = 2             -- Ширина отступа при сдвиге
opt.expandtab = true           -- Преобразовывать табы в пробелы
opt.autoindent = true          -- Автоматический отступ
opt.ignorecase = true          -- Игнорировать регистр при поиске
opt.smartcase = true           -- Учитывать регистр, если в запросе есть заглавные
opt.termguicolors = true       -- Поддержка 24-битных цветов
opt.background = "dark"        -- Темный фон
opt.mouse = "a"                -- Включить мышь во всех режимах
opt.cursorline = true          -- Подсвечивать текущую строку
opt.backspace = "indent,eol,start" -- Поведение backspace
opt.clipboard:append("unnamedplus") -- Интеграция с системным буфером обмена
opt.swapfile = false           -- Отключить swap-файлы
opt.undofile = true            -- Включить постоянное сохранение undo
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Папка для undo-файлов
vim.opt.cmdheight = 0          -- Отключить строку команд


-- ============================================================================
-- Дополнительные настройки
-- ============================================================================

-- Отключить буфер в терминале
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- Настройка PATH для NixOS
-- vim.env.PATH = vim.env.PATH .. ":/run/current-system/sw/bin:/home/laraeter/.local/bin"

-- Закомментированные настройки (оставлены для примера)
-- opt.wrap = false            -- Отключить перенос строк
-- opt.signcolumn = "yes"      -- Показывать колонку знаков
-- opt.splitright = true       -- Новые окна справа
-- opt.splitbelow = true       -- Новые окна снизу
-- vim.o.foldmethod = 'indent' -- Сворачивание по отступам
-- vim.cmd('autocmd BufReadPost * normal! zR') -- Разворачивать все при открытии
-- vim.api.nvim_set_hl(0, 'LineNr', { fg = '#3B4261' })       -- Цвет номеров строк
-- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#3B4261' })  -- Цвет номеров выше курсора
-- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#3B4261' })  -- Цвет номеров ниже курсора
-- vim.cmd([[ set noemoji ]])  -- Отключить эмодзи (для macOS)
