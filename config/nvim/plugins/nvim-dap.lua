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
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require"dap".run_last()<CR>', { noremap = true, silent = true })

-- Open DAP UI
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })


-- Определяем таблицу с горячими клавишами
local keymap_list = {
    "<F5>: Продолжить выполнение программы",
    "<F10>: Шагнуть через",
    "<F11>: Шагнуть внутрь",
    "<F12>: Шагнуть наружу",
    "<leader>b: Переключить точку останова",
    "<leader>dr: Открыть REPL",
    "<leader>du: Открыть/закрыть DAP UI",
    -- Добавьте сюда все свои горячие клавиши
}

-- Глобальная функция для отображения списка горячих клавиш в правом сплите
_G.show_keymaps = function()
    -- Открываем новый сплит справа
    vim.cmd('vsplit')
    
    -- Создаем новый буфер и заполняем его текстом
    local bufnr = vim.api.nvim_create_buf(false, true) -- Создаем новый пустой буфер
    vim.api.nvim_set_current_buf(bufnr) -- Активируем этот буфер в текущем окне

    -- Добавляем текст в буфер
    for _, keymap in ipairs(keymap_list) do
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { keymap })
    end

    -- Делаем буфер неизменяемым, чтобы случайно не редактировать его
    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
end

-- Привязываем функцию к кастомной команде
vim.api.nvim_set_keymap('n', '<leader>k', ':lua show_keymaps()<CR>', { noremap = true, silent = true })

