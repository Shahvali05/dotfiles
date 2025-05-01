local dap             = require('dap')
local dapui           = require('dapui')
local dap_virt_text   = require("nvim-dap-virtual-text")


-- ============================================================================
-- Настройка отладки через nvim-dap, nvim-dap-ui и адаптеров
-- ============================================================================


-- UI для dap
dapui.setup()

-- Виртуальный текст (переменные прямо в коде)
dap_virt_text.setup()

-- Python adapter (укажи свой путь до интерпретатора)
require('dap-python').setup()

-- Go adapter
require('dap-go').setup()

-- C++ / Rust / C adapter (через codelldb)
dap.adapters.codelldb = function(on_adapter)
  local tcp  = vim.loop.new_tcp()
  tcp:bind('127.0.0.1', 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()

  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local opts = {
    stdio = { nil, stdout, stderr },
    args  = { '--port', tostring(port) },
  }

  local handle, pid_or_err
  handle, pid_or_err = vim.loop.spawn('/usr/local/bin/codelldb', opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)

  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end

  vim.notify('codelldb started. pid=' .. pid_or_err)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)

  local adapter = {
    type = 'server',
    host = '127.0.0.1',
    port = port,
  }

  -- Подождать запуска codelldb
  vim.defer_fn(function() on_adapter(adapter) end, 1000)
end

-- Конфигурации отладки для C++, C, Rust, Header файлов
dap.configurations.cpp = {
  {
    name    = "runit",
    type    = "codelldb",
    request = "launch",

    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,

    args = function()
      local input_args = vim.fn.input('Arguments: ')
      return vim.split(input_args, " ")
    end,

    cwd         = "${workspaceFolder}",
    stopOnEntry = false,
    terminal    = 'integrated',

    pid = function()
      local handle = io.popen('pgrep hw$')
      local result = handle:read()
      handle:close()
      return result
    end,
  },
}

-- Наследуем конфигурации для других языков
dap.configurations.c     = dap.configurations.cpp
dap.configurations.h     = dap.configurations.cpp
dap.configurations.rust  = dap.configurations.cpp

-- Автооткрытие и закрытие dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- ============================================================================
-- Горячие клавиши отладки
-- ============================================================================

vim.api.nvim_set_keymap('n', '<F5>', ':Telescope dap configurations<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<F5>',     ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>',    ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>',    ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>',    ':lua require"dap".step_out()<CR>',  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>b',  ':lua require"dap".toggle_breakpoint()<CR>',                      { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>B',  ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require"dap".run_last()<CR>',                               { noremap = true, silent = true })

-- Открыть/закрыть UI
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
