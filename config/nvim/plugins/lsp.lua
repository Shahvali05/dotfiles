local lspconfig = require("lspconfig")

require'lspconfig'.jedi_language_server.setup{
  settings = {
    jedi = {
      useLibraryCodeForTypes = true,
    },
  }
}
-- Включаем диагностику, но отключаем обновление в режиме вставки
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,        -- Включаем виртуальный текст
    signs = true,               -- Используем знаки для ошибок
    update_in_insert = false,   -- Отключаем обновление ошибок в режиме вставки
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,  -- Сортировать ошибки по серьезности
    display_diagnostics = true,
  }
)

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
