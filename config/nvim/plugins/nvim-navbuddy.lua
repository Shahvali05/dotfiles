local navbuddy = require('nvim-navbuddy')
local actions = require('nvim-navbuddy.actions')
local lspconfig = require('lspconfig')

navbuddy.setup({
  window = {
    border = "rounded", -- стиль рамки окна
    size = "60%", -- размер окна
  },
  mappings = {
    ["<esc>"] = actions.close, -- Закрыть окно
    ["q"] = actions.close,
    ["n"] = actions.next_sibling, -- Перейти к следующему элементу
    ["p"] = actions.previous_sibling, -- Перейти к предыдущему элементу
    ["h"] = actions.parent, -- Вверх по дереву
    ["l"] = actions.child, -- Вниз по дереву
  }
})

-- Настройка LSP для работы с nvim-navbuddy
lspconfig.pyright.setup{
  on_attach = function(client, bufnr)
    require('nvim-navbuddy').attach(client, bufnr)
  end
}

vim.api.nvim_set_keymap('n', '<leader>n', ':Navbuddy<CR>', { noremap = true, silent = true })

