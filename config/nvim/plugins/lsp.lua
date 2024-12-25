local lspconfig = require("lspconfig")

require'lspconfig'.jedi_language_server.setup{}
-- Включаем диагностику
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true, -- Включаем виртуальный текст (подсветка ошибок в строках)
    signs = true,        -- Включаем использование знаков (ошибки в виде иконок)
    update_in_insert = false, -- Отключаем обновление в режиме вставки
  }
)

-- Дополнительно для улучшенной подсветки ошибок
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float({ focusable = false })]])

-- require'lspconfig'.pyright.setup{}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{}
-- require'lspconfig'.ccls.setup{}
