require('lualine').setup {
  options = {
    theme = 'auto', -- или ваша тема
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = { 'buffers' }, -- Отображение буферов в верхней строке
    lualine_z = { 'tabs' },    -- Опционально: вкладки справа
  },
}
