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
