require('cokeline').setup({
  show_if_buffers_are_at_least = 1,  -- Показывать, если хотя бы 1 буфер
  buffers = {
    new_buffers_position = 'last',   -- Новые буферы появляются в конце
  },
  rendering = {
    max_buffer_width = 30,           -- Максимальная ширина буфера
  },
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and '#ffffff' or '#999999'  -- Цвет текста
    end,
    bg = function(buffer)
      return buffer.is_focused and '#005f87' or '#1c1c1c' -- Цвет фона
    end,
  },
  components = {
    {
      text = '▎',                    -- Разделитель в виде вертикальной полоски
      fg = function(buffer)
        return buffer.is_focused and '#00ff00' or '#444444'  -- Цвет полоски
      end,
    },
    {
      text = function(buffer) 
        return buffer.devicon.icon   -- Иконка файла
      end,
      fg = function(buffer) 
        return buffer.devicon.color  -- Цвет иконки файла
      end,
    },
    {
      text = function(buffer)
        return ' ' .. buffer.unique_prefix .. buffer.filename .. ' '  -- Имя файла
      end,
      style = function(buffer)
        return buffer.is_focused and 'bold' or nil   -- Жирный текст для активного буфера
      end,
    },
    {
      text = '',  -- Иконка закрытия
      delete_buffer_on_left_click = true,  -- Удалить буфер при клике
      fg = '#ff0000',  -- Красный цвет иконки
    },
  },
  sidebar = {
    filetype = 'NvimTree',  -- Интеграция с nvim-tree
    components = {
      {
        text = '  File Explorer',  -- Текст в сайдбаре
        fg = '#999999',
        bg = '#1c1c1c',
        style = 'bold',
      },
    }
  }
})

