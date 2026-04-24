-- ============================================================================
-- selected_theme - выбор темы (catppuccin, tokyonight, custom)
-- ============================================================================


local selected_theme = "tokyonight"


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
-- gruvbox
-- ============================================================================


local function setup_gruvbox()
  require("gruvbox").setup({
    terminal_colors = true,
    contrast = "hard", -- soft, medium, hard
    transparent_mode = true,

    overrides = {
      Comment = { italic = true },
    },
  })

  vim.cmd.colorscheme("gruvbox")
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
elseif selected_theme == "gruvbox" then
  setup_gruvbox()
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
