require('cokeline').setup({
  rendering = {
    max_buffer_width = 30,
  },
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and '#ffffff' or '#999999'
    end,
    bg = function(buffer)
      return buffer.is_focused and '#363A59' or '#1c1c1c'
    end,
  },
  fill_hl = 'CokelineFill',  -- Настройка фона для пустых мест
})

-- Определение серого фона для пустых участков
vim.api.nvim_set_hl(0, 'CokelineFill', { bg = '#0F1217' })  -- Серый цвет фона

