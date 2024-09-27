-- Настройка темы Catppuccin
require("catppuccin").setup({
  flavour = "mocha",  -- или можно выбрать "latte", "frappe", "macchiato"
  term_colors = true,
  transparent_background = false,
  integrations = {
    nvimtree = true,
    lsp = true,
    treesitter = true,
    gitsigns = true,
    telescope = true,
  },
})

-- Установка темы по умолчанию
vim.cmd.colorscheme "catppuccin"
