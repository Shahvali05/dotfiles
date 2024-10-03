require('nvim-treesitter.configs').setup {
  ensure_installed = {},

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },

  rainbow = {
    enable = true, -- Включите цветные скобки
    extended_mode = true, -- Цветные скобки для больших и вложенных выражений
    max_file_lines = nil, -- Не ограничивайте количество строк файла
    colors = { "Red", "Green", "Blue", "Magenta", "Cyan", "Yellow" }, -- Цвета для скобок
  },
}
