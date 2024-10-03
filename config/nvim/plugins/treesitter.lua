require('nvim-treesitter.configs').setup {
  parser_dir = vim.fn.expand("~/.local/share/nvim/treesitter"), -- Указываем пользовательский каталог

  ensure_installed = { "c", "cpp", "go", "python" },

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },
}
