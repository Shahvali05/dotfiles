require("noice").setup({
  -- Здесь идут настройки плагина
  lsp = {
    override = {
      -- Поддержка прогресса для LSP
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- Настройки для уведомлений
  messages = {
    view = "mini",
    view_error = "mini",
    view_warn = "mini",
    view_history = "split",
    view_search = "virtualtext",
  },
  -- Настройки командной строки
  cmdline = {
    view = "cmdline",
  },
})
