require("indent-blankline").setup {
    char = '│', -- Символ для вертикальной линии
    show_trailing_blankline_indent = false, -- Не показывать отступы для пустых строк
    show_first_indent_level = true, -- Показать линию на первом уровне отступа
    use_treesitter = true, -- Использовать Treesitter для точного определения уровней отступов
    show_current_context = true, -- Показать текущий контекст (например, функцию, в которой находишься)
    show_current_context_start = true, -- Показывать начало текущего контекста
}
