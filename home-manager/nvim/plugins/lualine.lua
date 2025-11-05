-- ============================================================================
-- Настройка lualine (строка состояния)
-- ============================================================================


require('lualine').setup({
  options = {
    theme                = 'auto',             -- Автоматическая тема
    component_separators = { left = '│', right = '│' }, -- Тонкие разделители
    section_separators   = { left = '', right = '' }, -- Скругленные края
    globalstatus         = true,               -- Единая строка состояния для всех окон
  },

  sections = {
    -- Левая часть строки состояния
    lualine_a = {
      {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end, -- Только первая буква режима (N, I, V)
      },
    },

    lualine_b = {
      {
        'branch',
        icon = '',
        fmt = function(str)
          return str:sub(1, 10) .. ' '
        end, -- Укороченное имя ветки Git
      },
    },

    -- Центральная часть строки состояния
    -- lualine_c = {
    --   {
    --     'buffers',
    --     show_filename_only      = true,  -- Показывать только имя файла
    --     hide_filename_extension = false, -- Не скрывать расширение файла
    --     show_modified_status    = true,  -- Показывать символ изменения файла (*)
    --     max_length              = vim.o.columns * 2 / 3, -- Ограничение длины секции
    --     mode                    = 0,     -- Простой список буферов

    --     symbols = {
    --       modified       = ' ●',   -- Символ изменения
    --       alternate_file = '',     -- Без символа альтернативного файла
    --       directory      = '',    -- Иконка для директорий
    --     },

    --     buffers_color = {
    --       active   = { fg = '#ffffff', bg = '#363A59' }, -- Активный буфер: белый текст, синий фон
    --       inactive = { fg = '#999999', bg = '#1c1c1c' }, -- Неактивный: серый текст, тёмный фон
    --     },
    --   },
    -- },

    -- Правая часть строки состояния
    lualine_x = { 'diagnostics', 'filetype' }, -- Диагностика и тип файла

    lualine_y = {
      {
        'progress',
        fmt = function()
          return '%P'
        end, -- Процент текущей позиции в файле
      },
    },

    lualine_z = { 'location' }, -- Позиция курсора
  },
})

-- Автоматически обновлять lualine при входе/выходе из командного режима
vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  callback = function(event)
    -- когда входим в командный режим, обновляем lualine
    require('lualine').refresh()
  end,
})

-- require('lualine').setup{}
