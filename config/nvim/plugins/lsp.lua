-- Установка плагина
require('lsp-endhints').setup({
  inlay_hints = {
    parameter_hints = true,  -- Включить подсказки для параметров
    type_hints = true,       -- Включить подсказки типов
    other_hints = true,      -- Включить прочие подсказки
    only_current_line = false,  -- Подсказки будут отображаться во всех строках, а не только в текущей
  },
  -- Использовать под капотом тот же LSP клиент, что и вы настроили
  enabled_clients = { 'pyright', 'nil_ls', 'marksman', 'rust_analyzer', 'yamlls', 'bashls', 'clangd', 'gopls' },
})

-- Включить подсказки при старте для каждого LSP-сервера
local function on_attach(client)
  if client.server_capabilities.inlayHintProvider then
    require('lsp-endhints').on_attach(client)
  end
end

-- Настройка LSP с on_attach
require'lspconfig'.pyright.setup{ on_attach = on_attach }
require'lspconfig'.nil_ls.setup{ on_attach = on_attach }
require'lspconfig'.marksman.setup{ on_attach = on_attach }
require'lspconfig'.rust_analyzer.setup{ on_attach = on_attach }
require'lspconfig'.yamlls.setup{ on_attach = on_attach }
require'lspconfig'.bashls.setup{ on_attach = on_attach }
require'lspconfig'.clangd.setup{ on_attach = on_attach }
require'lspconfig'.gopls.setup{ on_attach = on_attach }

