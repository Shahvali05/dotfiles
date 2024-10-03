require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "go", "python" },

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },
}
