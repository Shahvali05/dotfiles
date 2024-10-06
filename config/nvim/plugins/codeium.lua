require('refactoring').setup({
  -- Включаем рефакторинг для поддерживаемых языков
  prompt_func_return_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
    cs = true, -- C#
  },
  prompt_func_param_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
    cs = true, -- C#
  },
  printf_statements = {},  -- Настройки для printf выражений
  print_var_statements = {},  -- Настройки для отладки переменных
})

vim.api.nvim_set_keymap(
  "v",
  "<leader>re",
  "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>rf",
  "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>rv",
  "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>ri",
  "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
  { noremap = true, silent = true, expr = false }
)

local refactoring = require("refactoring")
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = telescope_actions.close
      },
    },
  },
}

-- Настроим Telescope для вызова рефакторингов
local function refactoring_menu()
  local opts = {
    layout_strategy = "vertical",
    sorting_strategy = "ascending",
    prompt_title = "Select Refactoring Action",
    layout_config = {
      width = 0.4,
      height = 0.5,
    },
  }

  telescope.extensions.refactoring.refactors(opts)
end

-- Установка горячей клавиши для открытия меню выбора действий
vim.api.nvim_set_keymap(
  "v", 
  "<Space>r", 
  "<Esc><Cmd>lua refactoring_menu()<CR>", 
  { noremap = true, silent = true, expr = false }
)
