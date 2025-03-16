local function format_buffer_name(bufnr, max_width)
  local name = vim.fn.bufname(bufnr)
  if name == "" then name = "[No Name]" end
  name = vim.fn.fnamemodify(name, ":t") -- Только имя файла
  local modified = vim.bo[bufnr].modified and " ●" or ""
  local total_length = #name + #modified

  if total_length > max_width then
    -- Обрезаем с троеточием
    return string.sub(name, 1, max_width - #modified - 1) .. "…" .. modified
  else
    -- Заполняем пробелами
    return name .. modified .. string.rep(" ", max_width - total_length)
  end
end

-- Настройка lualine
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = { left = '│', right = '│' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 
      { 'mode', fmt = function(str) return str:sub(1,1) end },
    },
    lualine_b = { 
      { 'branch', icon = '', fmt = function(str) return str:sub(1,10)..'…' end },
    },
    lualine_c = { 
      function()
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        local result = {}
        local max_width = 15 -- Фиксированная ширина для каждого буфера

        for _, buf in ipairs(buffers) do
          local formatted_name = format_buffer_name(buf.bufnr, max_width)
          table.insert(result, formatted_name)
        end

        return table.concat(result, " ")
      end,
      color = function()
        return { fg = '#999999', bg = '#1c1c1c' } -- Цвет по умолчанию
      end,
      on_click = function(_, _, _, bufnr)
        vim.api.nvim_set_current_buf(bufnr) -- Переключение по клику
      end,
    },
    lualine_x = { 'diagnostics', 'filetype' },
    lualine_y = { 
      { 'progress', fmt = function() return '%P' end },
    },
    lualine_z = { 'location' },
  },
  -- Переопределение подсветки для активного буфера
  extensions = {
    function()
      local current_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_hl(0, 'LualineBufferActive', { fg = '#ffffff', bg = '#363A59' })
      for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if buf.bufnr == current_buf then
          vim.api.nvim_buf_add_highlight(buf.bufnr, 0, 'LualineBufferActive', 0, 0, -1)
        end
      end
    end
  }
}
