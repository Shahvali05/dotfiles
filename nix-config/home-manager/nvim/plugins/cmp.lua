local cmp     = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")


-- ============================================================================
-- Настройка плагина vim-dadbod
-- ============================================================================


vim.g.db_ui_auto_execute_table_helpers = 1                     -- Автоматически выполнять вспомогательные функции таблиц
vim.g.db_ui_use_nerd_fonts             = 1                     -- Использовать Nerd Fonts в интерфейсе
vim.g.db_ui_save_location              = '~/.config/nvim/db_ui' -- Путь к папке для сохранения настроек интерфейса

-- Загрузка сниппетов в стиле VSCode
require("luasnip.loaders.from_vscode").lazy_load()


-- ============================================================================
-- Настройка автодополнения с помощью nvim-cmp
-- ============================================================================


cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",             -- Поведение меню автодополнения
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)                            -- Раскрытие сниппета через luasnip
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<S-Tab>"]   = cmp.mapping.select_prev_item(),            -- Предыдущее предложение
    ["<Tab>"]     = cmp.mapping.select_next_item(),            -- Следующее предложение
    ["<C-k>"]     = cmp.mapping.scroll_docs(-4),               -- Прокрутка документации вверх
    ["<C-j>"]     = cmp.mapping.scroll_docs(4),                -- Прокрутка документации вниз
    ["<C-Space>"] = cmp.mapping.complete(),                    -- Показать меню автодополнения
    ["<C-e>"]     = cmp.mapping.abort(),                       -- Закрыть меню автодополнения
    ["<CR>"]      = cmp.mapping.confirm({ select = false }),   -- Подтвердить выбор
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },               -- Языковые серверы
    { name = "luasnip" },                -- Сниппеты
    { name = "buffer" },                 -- Буфер (текущий файл)
    { name = "path" },                   -- Пути к файлам
    { name = "vim-dadbod-completion" },  -- Источник для vim-dadbod
  }),

  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,                     -- Максимальная ширина меню
      ellipsis_char = "...",            -- Символ для обрезанных строк
    }),
  },
})


-- ============================================================================
-- Автоопределение типа файла для расширения .tpp
-- ============================================================================


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tpp",
  command = "setfiletype cpp",           -- Установить тип файла cpp для .tpp файлов
})
