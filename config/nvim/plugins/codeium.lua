-- neodev-nvim setup
require("neodev").setup({
  -- Add any settings you need here
  library = {
    enabled = true, -- Enable library
    runtime = true, -- Enable runtime libraries
    types = true,   -- Enable types for Lua
    plugins = true, -- Add installed Neovim plugins as libraries
  },
  -- Other options you might want to configure
  lspconfig = {
    -- If using nvim-lspconfig, configure Lua Language Server settings here
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" } -- Recognize `vim` as a global variable
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- Add Neovim runtime files to the library
          checkThirdParty = false, -- Disable third-party library checks
        },
      }
    }
  }
})

