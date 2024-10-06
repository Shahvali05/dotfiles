require('lsp-inlayhints').setup({
  -- Общие настройки
  inlay_hints = {
    parameter_hints = {
      show = true, -- Показывать подсказки для параметров функции
      prefix = "<- ", -- Префикс для параметров
    },
    type_hints = {
      show = true, -- Показывать подсказки для типов
      prefix = "", -- Префикс для типа
      separator = ", ", -- Разделитель для типов
    },
    only_current_line = false, -- Показывать подсказки только для текущей строки
    labels_separator = "  ", -- Разделитель между подсказками
    highlight = "Comment", -- Группа подсветки для подсказок
  },
  -- Автоматическое включение подсказок для всех LSP серверов
  enabled_at_startup = true,
})
