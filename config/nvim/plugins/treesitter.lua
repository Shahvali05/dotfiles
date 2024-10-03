require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "go", "python" },  -- Укажите языки, которые хотите установить

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },

  parser_dir = "~/.local/share/nvim/treesitter",  -- Указываем пользовательский каталог

  rainbow = {
    enable = true,
    extended_mode = true,  -- Включите, если хотите окрашивать больше типов скобок
    max_file_lines = nil,  -- Не ограничивайте количество строк
  },
}
