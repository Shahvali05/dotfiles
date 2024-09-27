local lspconfig = require('lspconfig')

-- Настройка LSP для нужных языков
lspconfig.pyright.setup{} -- для Python
lspconfig.clangd.setup{} -- для C++
lspconfig.gopls.setup{} -- для Go
-- Добавьте другие языки по необходимости

