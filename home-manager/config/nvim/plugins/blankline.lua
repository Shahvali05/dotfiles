local highlight = {
    "RainbowBlack",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowBlack", { fg = "#101117" })
end)

require("ibl").setup{
  scope = { highlight = highlight },
}
