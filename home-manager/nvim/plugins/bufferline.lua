vim.opt.termguicolors = true

require("bufferline").setup({
  options = {
    always_show_bufferline = false,
    separator_style = "thin", -- без лишних жирных разделителей
    show_buffer_close_icons = true,
    show_close_icon = false,
    indicator = {
      style = 'none', -- убираем подчеркивание
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = false, -- без разрыва линии
        highlight = "BufferLineOffset", -- фон будет как у всей ленты
      }
    },
  },
  highlights = {
    fill = { bg = "#3f4a5a" }, -- цвет всей ленты
    background = { bg = "#3f4a5a", fg = "#c0c8d6" }, -- цвет неактивных вкладок
    buffer_selected = { bg = "#4b5a6e", fg = "#ffffff", bold = true }, -- активная вкладка
    buffer_visible = { bg = "#3f4a5a", fg = "#d0d8e0" }, -- видимая, но не активная
    separator = { fg = "#3f4a5a", bg = "#3f4a5a" },
    separator_selected = { fg = "#4b5a6e", bg = "#4b5a6e" },
    separator_visible = { fg = "#3f4a5a", bg = "#3f4a5a" },
    offset_separator = { fg = "#3f4a5a", bg = "#3f4a5a" }, -- чтобы File Explorer входил в ленту
  }
})
