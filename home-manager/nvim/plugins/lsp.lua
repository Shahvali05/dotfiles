local lspconfig = require('lspconfig')

-- ============================================================================
-- Основные конфигурации LSP
-- ============================================================================

local configs = {
  -- Функция для привязки клавиш и настройки буфера при подключении LSP
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)

    -- === УБРАНО: автоформат при сохранении ===
    -- Раньше здесь создавался autocmd BufWritePre если сервер поддерживал форматирование.
    -- Мы этого не хотим — формать будет по команде :Format.

    -- Отключаем форматирование у Python LSP (basedpyright/pyright), чтобы использовать black
    if client.name == "basedpyright" or client.name == "pyright" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    -- Буферная команда :Format — предпочитает Black для python, иначе использует LSP
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
      local ft = vim.bo[bufnr].filetype

      if ft == "python" then
        -- Если установлен null-ls (рекомендовано), то он предоставит форматирование (black).
        -- В противном случае запустим внешний black на файле.
        local ok_null, _ = pcall(require, "null-ls")
        if ok_null then
          -- null-ls должен быть настроен отдельно (см. сниппет ниже).
          vim.lsp.buf.format({ bufnr = bufnr })
        else
          -- Минимальная внешняя инвокация black
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname == "" then
            vim.notify("Buffer has no name, can't run black.", vim.log.levels.ERROR)
            return
          end
          -- Сохраняем файл перед форматированием
          vim.cmd("write")
          local out = vim.fn.system({ "black", "--quiet", fname })
          local code = vim.v.shell_error
          if code == 0 then
            -- Перезагружаем буфер, чтобы увидеть изменения
            vim.cmd("edit")
            vim.notify("Black formatted " .. fname)
          else
            vim.notify("Black failed: " .. (out or "unknown error"), vim.log.levels.ERROR)
          end
        end
      else
        -- Для остальных ft — используем LSP форматирование (если есть)
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
        if #clients > 0 then
          vim.lsp.buf.format({ bufnr = bufnr })
        else
          vim.notify("No LSP client attached to format this buffer.", vim.log.levels.WARN)
        end
      end
    end, { desc = "Format buffer (Black for Python)" })
  end,

  -- Настройка возможностей автодополнения
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}


-- ============================================================================
-- Конфигурация LSP серверов
-- ============================================================================


-- Определяем путь к Python
local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = venv_path and (venv_path .. "/bin/python3") or vim.g.python3_host_prog

-- Автозапуск bash-language-server для shell-скриптов
-- Рекомендация: можно заменить на lspconfig.bashls.setup(...) для устойчивости.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

-- Устанавливаем filetype для файлов .jf
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.jf",
  callback = function()
    vim.bo.filetype = "json"
  end,
})

local lsp_servers = {
  ruff = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py'),
    }
  },

  basedpyright = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",   -- только открытые файлы
            diagnosticUpdateMode = "save",      -- проверять только при сохранении
            typeCheckingMode = "basic",         -- обычная проверка (не strict)
            pythonPath = py_path,               -- указать путь к интерпретатору
          },
        },
      },
    }
  },

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

  ts_ls = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('package.json', '.git'),
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }
  },

  eslint = {
    setup = {
      on_attach = function(client, bufnr)
        configs.on_attach(client, bufnr)
        -- у eslint включаем форматирование (Format вызовет его вручную)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json', 'package.json'),
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      settings = {
        format = { enable = true },
        lint = { enable = true },
      },
    }
  },

  html = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('package.json', '.git'),
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

  gopls = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('go.mod', '.git'),
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true,
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    },
  },

  clangd = {
    setup = {
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'compile_commands.json', 'build'),
      filetypes = { "c", "cpp", "objc", "objcpp" },
      cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--clang-tidy" },
      settings = {
        clangd = {
          fallbackFlags = { "-std=c++17" },
        },
      },
    },
  },
}


-- ============================================================================
-- Инициализация настроек LSP
-- ============================================================================


local function setup()
  -- Настройка LSP серверов
  -- lspconfig.ruff.setup(lsp_servers.ruff.setup) -- включай если нужен
  lspconfig.basedpyright.setup(lsp_servers.basedpyright.setup)
  lspconfig.jsonls.setup(lsp_servers.jsonls.setup)
  lspconfig.ts_ls.setup(lsp_servers.ts_ls.setup)
  lspconfig.eslint.setup(lsp_servers.eslint.setup)
  lspconfig.html.setup(lsp_servers.html.setup)
  lspconfig.gopls.setup(lsp_servers.gopls.setup)
  lspconfig.clangd.setup(lsp_servers.clangd.setup)

  -- Настройка отображения диагностики
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Глобальная команда :Format — сначала пытается вызвать буферную команду Format (если она есть),
  -- иначе делает fallback (для python вызывает black, для остальных сообщает).
  vim.api.nvim_create_user_command("Format", function()
    -- Попробуем выполнить буферную Format (создаётся в on_attach)
    local ok = pcall(vim.cmd, "silent! Format")
    if ok then
      return
    end

    -- fallback
    local ft = vim.bo.filetype
    if ft == "python" then
      local fname = vim.api.nvim_get_current_buf() and vim.api.nvim_buf_get_name(0) or ""
      if fname == "" then
        vim.notify("Buffer has no name, can't run black.", vim.log.levels.ERROR)
        return
      end
      vim.cmd("write")
      local out = vim.fn.system({ "black", "--quiet", fname })
      if vim.v.shell_error == 0 then
        vim.cmd("edit")
        vim.notify("Black formatted " .. fname)
      else
        vim.notify("Black failed: " .. (out or "unknown error"), vim.log.levels.ERROR)
      end
    else
      vim.notify("No formatter available (no LSP attached).", vim.log.levels.WARN)
    end
  end, { desc = "Format buffer (tries buffer-local :Format first)" })
end

-- Запуск конфигурации
setup()
