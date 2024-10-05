require('lualine').setup({
  options = {
    theme = 'dracula', -- Выбираем тему, можно попробовать 'dracula', 'nord', 'solarized'
    icons_enabled = true,
    section_separators = { left = '', right = ''}, -- Добавляем стильные разделители секций
    component_separators = { left = '', right = ''},
    disabled_filetypes = {}, -- Можем отключить lualine для определённых типов файлов
  },
  sections = {
    lualine_a = {'mode'}, -- Отображение текущего режима (например, Normal, Insert)
    lualine_b = {'branch', 'diff', 'diagnostics'}, -- Ветка Git, изменения и диагностика LSP
    lualine_c = {{'filename', path = 1}}, -- Имя файла с полным путём
    lualine_x = {'encoding', 'fileformat', 'filetype'}, -- Кодировка, формат файла, тип файла
    lualine_y = {'progress'}, -- Прогресс по документу
    lualine_z = {'location'} -- Текущая строка и столбец
  },
  inactive_sections = { -- Для неактивных окон
    lualine_a = {mode},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {}, -- Если нужна отдельная панель с буферами/табами
  extensions = {'fugitive', 'nvim-tree'} -- Расширения для интеграции с nvim-tree и Fugitive
})

