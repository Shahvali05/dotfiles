require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "go", "lua", "rust", "typescript", "javascript", "html", "css", "scss", "markdown", "markdown_inline" },

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },
}
