local api = require('nvim-tree.api')

-- Функция для переключения на другой буфер при закрытии текущего
local function switch_to_other_buffer()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Проверяем, открыт ли nvim-tree
  if api.tree.is_tree_buf(current_buf) then
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

