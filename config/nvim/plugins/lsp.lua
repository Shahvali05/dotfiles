local lspconfig = require("lspconfig")

-- require'lspconfig'.pyright.setup{}
require'lspconfig'.pyright.setup{
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- Можно выбрать "off", "basic", или "strict"
        diagnosticMode = "openFilesOnly", -- Проверка только открытых файлов
      },
    },
  },
}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{}
-- require'lspconfig'.ccls.setup{}
