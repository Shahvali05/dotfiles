local lspconfig = require("lspconfig")

-- require'lspconfig'.pyright.setup{}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{}
-- require'lspconfig'.ccls.setup{}

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
