local dap = require('dap')
local dapui = require('dapui')
local dap_virt_text = require("nvim-dap-virtual-text")

-- nvim-dap-ui setup
dapui.setup()

-- Virtual text setup
dap_virt_text.setup()

-- Python adapter
require('dap-python').setup('/run/current-system/sw/bin/python3.11') -- change the path to your python interpreter

-- Go adapter
require('dap-go').setup()

-- cpp adapter
dap.adapters.lldb = {
  type = 'executable',
  command = '/home/laraeter/Downloads/extension/adapter/codelldb',
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

-- Automatically open and close dap-ui on dap events
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Nvim-dap
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require"dap".run_last()<CR>', { noremap = true, silent = true })

-- Open DAP UI
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
