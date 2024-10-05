require('lualine').setup({
  options = {
    theme = 'dracula', -- Выбираем тему, можно попробовать 'dracula', 'nord', 'solarized'
    icons_enabled = true,
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {
      'encoding', 
      'fileformat', 
      'filetype', 
      {
        function()
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return 'No LSP'
          end
          local lsp_names = {}
          for _, client in ipairs(clients) do
            table.insert(lsp_names, client.name)
          end
          return table.concat(lsp_names, ', ') -- Если активен несколько LSP, они будут отображены через запятую
        end,
        icon = ' LSP:', -- Иконка LSP
        color = { fg = '#ffffff', gui = 'bold' }, -- Можно настроить цвет
      },
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive', 'nvim-tree'}
})
