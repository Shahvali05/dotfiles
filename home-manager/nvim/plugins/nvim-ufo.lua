-- ============================================================================
-- Настройка плагина UFO для работы со сворачиванием кода
-- ============================================================================


require('ufo').setup()

-- Отображение превью свернутого кода под курсором при нажатии 'K'
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor() -- Получаем ID окна предпросмотра
  if not winid then
    vim.lsp.buf.hover() -- Если окно не открыто — вызываем стандартную подсказку LSP
  end
end)


-- ============================================================================
-- Настройки сворачивания кода
-- ============================================================================


-- vim.o.foldcolumn = '1'      -- Отображать колонку со значками сворачивания (можно включить при необходимости)
vim.o.foldlevel       = 99     -- Уровень сворачивания по умолчанию
vim.o.foldlevelstart  = 99     -- Начальный уровень при открытии файла
vim.o.foldenable      = true   -- Включить сворачивание кода
