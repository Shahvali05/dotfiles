-- nvim-scrollbar.lua

require("scrollbar").setup({
  show = true,
  handle = {
    color = "#6c71c4",
  },
  marks = {
    Search = { color = "#ff8700" },
    Error = { color = "#ff0000" },
    Warn  = { color = "#f9e000" },
    Info  = { color = "#00ffcc" },
    Hint  = { color = "#9e00ff" },
    Misc  = { color = "#aaaaaa" },
  },
})
