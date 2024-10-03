require('nvim-treesitter.configs').setup {
  ensure_installed = {},

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },

  rainbow = {
    enable = true,
    extended_mode = true,  -- Включите, если хотите окрашивать больше типов скобок
    max_file_lines = nil,  -- Не ограничивайте количество строк
  },
}
