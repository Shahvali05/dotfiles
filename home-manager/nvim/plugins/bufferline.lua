vim.opt.termguicolors = true

require("bufferline").setup({
  options = {
    -- Появляется только если >1 буфера
    always_show_bufferline = false,

    -- Отдельная секция для nvim-tree
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      }
    },

    -- Иконки и стиль
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    separator_style = "slant", -- можно менять: "thin", "thick", "slant"

    -- Индикация активного буфера
    indicator = {
      style = 'underline', -- можно: 'icon', 'underline', 'none'
    },
  },

  -- Цвета
  highlights = {
    fill = {
      bg = "#3a3a3a", -- серый фон там, где нет буферов
    },
    background = {
      bg = "#3a3a3a", -- серый фон для неактивных буферов
    },
    buffer_selected = {
      bg = "#4a4a4a",
      fg = "#ffffff",
      bold = true,
    },
    separator = {
      fg = "#3a3a3a",
      bg = "#3a3a3a",
    },
    separator_selected = {
      fg = "#3a3a3a",
      bg = "#4a4a4a",
    },
  },
})
