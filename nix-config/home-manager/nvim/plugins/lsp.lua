local lspconfig = require('lspconfig')


-- ============================================================================
-- Основные конфигурации LSP
-- ============================================================================


local configs = {
  -- Функция для привязки клавиш и настройки буфера при подключении LSP
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,    bufopts)
    vim.keymap.set('n', 'K',          vim.lsp.buf.hover,         bufopts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename,        bufopts)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action,   bufopts)
    vim.keymap.set('n', '<leader>e',  vim.diagnostic.open_float, bufopts)

    -- Автоформат при сохранении
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,

  -- Настройка возможностей автодополнения
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}


-- ============================================================================
-- Конфигурация LSP серверов
-- ============================================================================

local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.jf",
  callback = function()
    vim.bo.filetype = "json"
  end,
})

local lsp_servers = {
  ruff = {
    setup = {
      on_attach    = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir     = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py') or vim.fn.getcwd(),
    }
  },

  pyright = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py') or vim.fn.getcwd(),
      settings = {
        pyright = {
          -- Отключаем линтерские проверки, которые пересекаются с Ruff
          disableOrganizeImports = true, -- Ruff сам сортирует импорты
          disableTaggedHints = true, -- Отключаем подсказки для аннотаций
        },
        python = {
          analysis = {
            -- Отключаем диагностику, которая дублируется Ruff
            ignore = { '*' }, -- Игнорируем все правила линтера Pyright
            typeCheckingMode = "basic", -- Режим проверки типов: "off", "basic", "strict"
            diagnosticMode = "openFilesOnly", -- Проверять только открытые файлы
            pythonPath = py_path, -- Указываем путь к интерпретатору Python
          },
        },
      },
    }
  },

  -- pylsp = {
  --   setup = {
  --     on_attach    = configs.on_attach,
  --     capabilities = configs.capabilities,
  --     settings     = {
  --       pylsp = {
  --         plugins = {
  --           pycodestyle = { enabled = false }, -- Отключить pycodestyle
  --           pyflakes    = { enabled = false }, -- Отключить pyflakes
  --           pylsp_mypy  = {
  --             enabled    = true,               -- Включить mypy
  --             live_mode  = false,              -- Не запускать в реальном времени
  --             strict     = false,              -- Не включать строгий режим
  --             overrides  = { "--python-executable", py_path, true }, -- Определяем путь к python
  --             report_progress = true,
  --           },
  --         },
  --       },
  --     },
  --     root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py') or vim.fn.getcwd(),
  --   }
  -- },

  jsonls = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      settings = {
        json = {
          validate = { enable = true },
          schemas = require('schemastore').json.schemas(),
          schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
        },
      },
    },
  },

  tsserver = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('package.json', '.git') or vim.fn.getcwd(),
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }
  },

  eslint = {
    setup = {
      on_attach = function(client, bufnr)
        configs.on_attach(client, bufnr)
        -- Отключаем форматирование через tsserver, если используем eslint
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json', 'package.json') or vim.fn.getcwd(),
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      settings = {
        format = { enable = true }, -- Включаем форматирование через ESLint
        lint = { enable = true },
      },
    }
  },

  html = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('package.json', '.git') or vim.fn.getcwd(),
      filetypes = { "html" },
      init_options = {
        provideFormatter = true,
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true
        }
      }
    }
  },
}


-- ============================================================================
-- Инициализация настроек LSP
-- ============================================================================


local function setup()
  -- Настройка LSP серверов
  lspconfig.ruff.setup(lsp_servers.ruff.setup)
  lspconfig.pyright.setup(lsp_servers.pyright.setup)
  -- lspconfig.pylsp.setup(lsp_servers.pylsp.setup)
  lspconfig.jsonls.setup(lsp_servers.jsonls.setup)
  lspconfig.tsserver.setup(lsp_servers.tsserver.setup)
  lspconfig.eslint.setup(lsp_servers.eslint.setup)
  lspconfig.html.setup(lsp_servers.html.setup)

  -- Настройка отображения диагностики
  vim.diagnostic.config({
    virtual_text       = true,     -- Отображать текст прямо в коде
    signs              = true,     -- Показывать знаки в колонке слева
    underline          = true,     -- Подчеркивать проблемный код
    update_in_insert   = false,    -- Не обновлять во время вставки
    severity_sort      = true,     -- Сортировка по уровню серьёзности
  })
end


-- Запуск конфигурации
setup()
