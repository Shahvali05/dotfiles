require('lualine').setup {
  options = {
    theme = 'auto', -- Автоматическая тема
    component_separators = { left = '│', right = '│' }, -- Тонкие разделители
    section_separators = { left = '', right = '' }, -- Скругленные края
    globalstatus = true, -- Единая строка состояния для всех окон
  },
  sections = {
    lualine_a = { 
      { 'mode', fmt = function(str) return str:sub(1,1) end }, -- Только первая буква режима (N, I, V)
    },
    lualine_b = { 
      { 'branch', icon = '', fmt = function(str) return str:sub(1,10)..' ' end }, -- Укороченная ветка Git
    },
    lualine_c = { 
      { 
        'buffers', 
        show_filename_only = true, -- Только имя файла
        hide_filename_extension = false, -- Показывать расширения
        show_modified_status = true, -- Показывать статус изменения (*)
        max_length = vim.o.columns * 2 / 3, -- Ограничение длины секции
        mode = 0, -- Простой список буферов
        symbols = {
          modified = ' ●', -- Индикатор изменения
          alternate_file = '', -- Без альтернативных файлов
          directory = '', -- Иконка для директорий
        },
        buffers_color = {
          active = { fg = '#ffffff', bg = '#363A59' }, -- Активный буфер: белый текст, синий фон
          inactive = { fg = '#999999', bg = '#1c1c1c' }, -- Неактивный: серый текст, темный фон
        },
      },
    },
    lualine_x = { 'diagnostics', 'filetype' }, -- Диагностика и тип файла
    lualine_y = { 
      { 'progress', fmt = function() return '%P' end }, -- Процент в файле
    },
    lualine_z = { 'location' }, -- Позиция курсора
  },
}
