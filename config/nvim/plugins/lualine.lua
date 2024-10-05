require("lualine").setup({
  options = {
    theme = 'nord',
    icons_enabled = true,
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    disabled_filetypes = {},
  },
  icons_enabled = true,
  extensions = {'fugitive', 'nvim-tree'}
})
