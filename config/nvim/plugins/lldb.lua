local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/home/laraeter/Downloads/extension/lldb/bin', -- укажи путь к бинарнику
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- Для других языков можно скопировать и изменить конфигурацию
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
