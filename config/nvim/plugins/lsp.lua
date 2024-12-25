local lspconfig = require("lspconfig")

require'lspconfig'.jedi_language_server.setup{}
-- require'lspconfig'.pyright.setup{}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{}
-- require'lspconfig'.ccls.setup{}

-- Включаем диагностику, но отключаем обновление в режиме вставки
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,        -- Включаем виртуальный текст
    signs = true,               -- Используем знаки для ошибок
    update_in_insert = true,   -- Отключаем обновление ошибок в режиме вставки
  }
)

-- Дополнительно для улучшенной подсветки ошибок
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float({ focusable = false })]])

-- Подключение null-ls
local null_ls = require("null-ls")

-- Настройка null-ls для использования mypy
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy.with({
            extra_args = {"--ignore-missing-imports"}, -- Опционально
        }),
    },
})
