local hooks = require("ibl.hooks")


-- ============================================================================
-- Настройка подсветки уровней отступов
-- ============================================================================


-- Цвета для разных уровней отступа (можно добавить больше)
local highlight = {
  "IndentLow1",
  "IndentLow2",
  "IndentLow3",
  "IndentLow4",
  "IndentLow5",
  "IndentLow6",
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IndentLow1", { fg = "#3b4261" })
  vim.api.nvim_set_hl(0, "IndentLow2", { fg = "#444b6a" })
  vim.api.nvim_set_hl(0, "IndentLow3", { fg = "#4e557a" })
  vim.api.nvim_set_hl(0, "IndentLow4", { fg = "#565f89" })
  vim.api.nvim_set_hl(0, "IndentLow5", { fg = "#5e6687" })
  vim.api.nvim_set_hl(0, "IndentLow6", { fg = "#666c8d" })
end)


-- ============================================================================
-- Инициализация плагина indent-blankline
-- ============================================================================


require("ibl").setup({
  indent = {
    highlight = highlight,
    char = "│",
  },
  scope = {
    enabled = false,
  },
})
