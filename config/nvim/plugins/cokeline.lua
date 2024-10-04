local nvim_tree = require('nvim-tree.api')

-- Настраиваем функцию, которая переключается на другой буфер, если закрывается текущий
local function switch_to_other_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  -- Если текущий буфер - nvim-tree, переключаемся на следующий
  if nvim_tree.is_visible() then
    -- Закрываем файл, если текущий буфер nvim-tree
    vim.cmd("bnext")
  end
end

-- Вызов функции при закрытии буфера
vim.api.nvim_create_autocmd("BufDelete", {
  callback = switch_to_other_buffer
})

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

