local autopairs = require("nvim-autopairs")


-- ============================================================================
-- Настройка автопарного ввода
-- ============================================================================


autopairs.setup({
  check_ts = true,                            -- Включить поддержку treesitter
  ts_config = {
    lua = { "string" },                       -- Не добавлять пары в строковых узлах treesitter для Lua
    javascript = { "template_string" },       -- Не добавлять пары в узлах template_string для JavaScript
    java = false,                             -- Не проверять treesitter для Java
  },
})


-- ============================================================================
-- Интеграция с автодополнением
-- ============================================================================


local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- Импорт функциональности автопар для cmp
local cmp = require("cmp")                                    -- Импорт плагина nvim-cmp (автодополнение)

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()) -- Интеграция автопар с автодополнением
