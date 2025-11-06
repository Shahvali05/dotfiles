-- ============================================================================
-- Настройка плагина refactoring.nvim
-- ============================================================================


require('refactoring').setup({
  -- Включаем запрос типа возвращаемого значения функции для языков
  prompt_func_return_type = {
    go   = true,
    cpp  = true,
    c    = true,
    java = true,
    cs   = true, -- C#
  },

  -- Включаем запрос типа параметров функции для языков
  prompt_func_param_type = {
    go   = true,
    cpp  = true,
    c    = true,
    java = true,
    cs   = true, -- C#
  },

  printf_statements     = {}, -- Настройки для printf-выражений (оставлено пустым)
  print_var_statements  = {}, -- Настройки для отладки переменных (оставлено пустым)
})


-- ============================================================================
-- Привязки клавиш для визуального режима (рефакторинг)
-- ============================================================================


vim.api.nvim_set_keymap(
  "v",
  "<leader>re",
  "<Esc><Cmd>lua require('refactoring').refactor('extract function')<CR>",
  { noremap = true, silent = true, expr = false, desc = "Извлечь функцию из выбранного кода" }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>rf",
  "<Esc><Cmd>lua require('refactoring').refactor('extract_to_file')<CR>",
  { noremap = true, silent = true, expr = false, desc = "Извлечь функцию в отдельный файл" }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>rv",
  "<Esc><Cmd>lua require('refactoring').refactor('extract_var')<CR>",
  { noremap = true, silent = true, expr = false, desc = "Извлечь переменную из выражения" }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>ri",
  "<Esc><Cmd>lua require('refactoring').refactor('inline_var')<CR>",
  { noremap = true, silent = true, expr = false, desc = "Вставить переменную напрямую" }
)
