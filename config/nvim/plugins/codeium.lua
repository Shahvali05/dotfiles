local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = './nix/store/lrmk0kkf6jwnwyw11a1drk65xr6adfif-vscode-extension-vadimcn-vscode-lldb-1.10.0/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb', -- укажи путь к бинарнику
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
