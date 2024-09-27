local lspconfig = require("lspconfig")

require'lspconfig'.pyright.setup{}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{}

formatter.setup({
  logging = false,
  filetype = {
    python = {
      -- Используем black для форматирования Python
      function()
        return {
          exe = "black",
          args = { "--quiet", "-" },
          stdin = true,
        }
      end,
    },
    cpp = {
      -- Используем clang-format для форматирования C++
      function()
        return {
          exe = "clang-format",
          args = { "--style=file", "-" },
          stdin = true,
        }
      end,
    },
    go = {
      -- Используем gofmt для форматирования Go
      function()
        return {
          exe = "gofmt",
          args = {},
          stdin = true,
        }
      end,
    },
  },
})
