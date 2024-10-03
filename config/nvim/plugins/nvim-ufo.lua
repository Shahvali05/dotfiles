require('ufo').setup()

-- Настройка для отображения превью свернутого кода
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Настройка символов для колонки сворачивания
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '', -- символ для открытого фолда (стрелка вниз)
  foldsep = ' ', -- разделитель фолдов
  foldclose = '' -- символ для закрытого фолда (стрелка вправо)
}
