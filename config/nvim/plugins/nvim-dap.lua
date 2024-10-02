local dap = require('dap')
local dapui = require('dapui')
local dap_virt_text = require("nvim-dap-virtual-text")

-- nvim-dap-ui setup
dapui.setup()

-- Virtual text setup
dap_virt_text.setup()

-- Python adapter
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python') -- change the path to your python interpreter

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

