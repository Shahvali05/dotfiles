require('nvim-treesitter.configs').setup {
  ensure_installed = {},

  auto_install = false,

  highlight = { enable = true },

  indent = { enable = true },
}

-- ============================================================================
-- Сворачивание кода с помощью встроенного Treesitter
-- ============================================================================

-- Включаем treesitter-фолдинг
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"  -- Используем встроенную функцию Neovim
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- По желанию можно добавить колонку слева со значками фолдов:
vim.o.foldcolumn = "1"
