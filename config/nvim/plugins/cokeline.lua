require('cokeline').setup({
  rendering = {
    max_buffer_width = 30,
  },
})

-- Определение серого фона для пустых участков
vim.api.nvim_set_hl(0, 'CokelineFill', { bg = '#182F40' })  -- Серый цвет фона

