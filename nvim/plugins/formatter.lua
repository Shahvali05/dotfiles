local formatter = require("formatter")

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

-- Вызов форматтера на сохранение
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.py", "*.cpp", ".h", "*.go" },  -- Расширения файлов, для которых выполнять форматирование
  callback = function()
    vim.cmd("Format")
  end,
})

