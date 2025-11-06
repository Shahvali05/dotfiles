-- ============================================================================
-- selected_theme - выбор темы (catppuccin, tokyonight, custom)
-- ============================================================================


local selected_theme = "custom"


-- ============================================================================
-- tokyonight
-- ============================================================================


local function setup_tokyonight()
  require("tokyonight").setup({
    style = "storm",
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
  })
  vim.cmd.colorscheme("tokyonight")
end


-- ============================================================================
-- catppuccin
-- ============================================================================


local function setup_catppuccin()
  require("catppuccin").setup({
    flavour = "mocha",
    term_colors = true,
    transparent_background = false,
    integrations = {
      nvimtree = true,
      lsp = false,
      treesitter = true,
      gitsigns = true,
      telescope = true,
    },
  })
  vim.cmd.colorscheme("catppuccin")
end


-- ============================================================================
-- custom
-- ============================================================================


local function setup_custom()
  -- Сначала установим базовую тему (например, default)
  vim.cmd.colorscheme("default")

  -- Настройка кастомных цветов
  vim.api.nvim_set_hl(0, 'LineNr',       { fg = '#3B4261' })
  vim.api.nvim_set_hl(0, 'LineNrAbove',  { fg = '#3B4261' })
  vim.api.nvim_set_hl(0, 'LineNrBelow',  { fg = '#3B4261' })
end


-- ============================================================================
-- Примениние выбранной темы
-- ============================================================================


if selected_theme == "tokyonight" then
  setup_tokyonight()
elseif selected_theme == "catppuccin" then
  setup_catppuccin()
elseif selected_theme == "custom" then
  setup_custom()
else
  vim.notify("Неизвестная тема: " .. selected_theme, vim.log.levels.WARN)
end


-- ============================================================================
-- Дополнительные настройки
-- ============================================================================


-- Подсвечивать 80-й столбец
vim.opt.colorcolumn = "80"

-- цвет столбца
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd('highlight ColorColumn ctermbg=red guibg=#38374F')
    end,
})
