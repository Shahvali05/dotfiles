-- ============================================================================
-- Команда вставки изображения из буфера обмена
-- ============================================================================


-- Функция вставки изображения, скопированного в буфер обмена
local function insert_image_from_clipboard()
  vim.fn.mkdir('./.photos', 'p') -- Создать папку .photos, если её нет

  local filename = './.photos/' .. os.date('%Y%m%d%H%M%S') .. '.png' -- Уникальное имя файла по текущему времени

  -- Сохраняем изображение из буфера обмена (xclip должен быть установлен)
  local handle = io.popen('xclip -selection clipboard -t image/png -o > ' .. filename)
  if handle ~= nil then
    handle:close()
  end

  -- Проверяем, удалось ли сохранить изображение
  if vim.fn.filereadable(filename) == 1 then
    local link = string.format('![Image](%s)', filename) -- Формируем ссылку на изображение в формате Markdown
    vim.api.nvim_put({ link }, 'l', true, true)          -- Вставляем ссылку в текущую строку
  else
    vim.notify('Не удалось вставить изображение. Убедитесь, что установлен xclip и буфер обмена содержит изображение.', vim.log.levels.ERROR)
  end
end


-- ============================================================================
-- Регистрация пользовательской команды
-- ============================================================================


vim.api.nvim_create_user_command('InsertImage', insert_image_from_clipboard, { desc = "Вставить изображение из буфера обмена" })
