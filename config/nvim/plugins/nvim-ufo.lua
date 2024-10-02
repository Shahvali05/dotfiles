require('ufo').setup()

-- Настройка для отображения превью свернутого кода
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

--vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
