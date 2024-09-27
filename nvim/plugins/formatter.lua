
local formatter = require("formatter")

formatter.setup({
  logging = false,
  filetype = {
    python = {
      function()
        return {
          exe = "black",
          args = { "--quiet", "-" },
          stdin = true,
        }
      end,
    },
    cpp = {
      function()
        return {
          exe = "clang-format",
          args = { "--style=file", "-" },
          stdin = true,
        }
      end,
    },
    go = {
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

-- Форматируем и сохраняем файл после форматирования
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.cpp", ".c", ".h", "*.go" },
  callback = function()
    vim.cmd("Format")          -- Выполняем форматирование
    vim.cmd("silent! update")  -- Сохраняем файл после форматирования
  end,
})
