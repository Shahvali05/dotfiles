vim.opt.termguicolors = true

require("bufferline").setup({
  options = {
    always_show_bufferline = false,
    separator_style = "slant", -- трапеция
    show_buffer_close_icons = false, -- убираем крестики
    show_close_icon = false,
    indicator = {
      style = 'none', -- без подчеркиваний
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = false,
        highlight = "BufferLineOffset",
      }
    },
  },
  highlights = {
    fill = { bg = "#3f4a5a" },
    background = { bg = "#3f4a5a", fg = "#c0c8d6" },
    buffer_selected = { bg = "#4b5a6e", fg = "#ffffff", bold = true },
    buffer_visible = { bg = "#3f4a5a", fg = "#d0d8e0" },

    -- разделители
    separator = { fg = "#3f4a5a", bg = "#3f4a5a" },
    separator_selected = { fg = "#4b5a6e", bg = "#4b5a6e" },
    separator_visible = { fg = "#3f4a5a", bg = "#3f4a5a" },
    offset_separator = { fg = "#3f4a5a", bg = "#3f4a5a" },

    -- 🟢 индикатор "modified"
    modified = { bg = "#3f4a5a", fg = "#a6e3a1" },
    modified_selected = { bg = "#4b5a6e", fg = "#a6e3a1" },
    modified_visible = { bg = "#3f4a5a", fg = "#a6e3a1" },

    -- Добавляем для дубликатов (когда показывается путь из-за одинаковых имен файлов)
    duplicate = { bg = "#3f4a5a", fg = "#c0c8d6", italic = true },
    duplicate_selected = { bg = "#4b5a6e", fg = "#ffffff", bold = true, italic = true },
    duplicate_visible = { bg = "#3f4a5a", fg = "#d0d8e0", italic = true },
  }
})
