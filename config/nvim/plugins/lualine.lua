-- Функция для форматирования имени буфера
local function format_buffer_name(bufnr, max_width)
  local name = vim.fn.bufname(bufnr)
  if name == "" then name = "[No Name]" end
  name = vim.fn.fnamemodify(name, ":t") -- Только имя файла
  local modified = vim.bo[bufnr].modified and " ●" or ""
  local total_length = #name + #modified

  if total_length > max_width then
    return string.sub(name, 1, max_width - #modified - 1) .. "…" .. modified
  else
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
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
      function()
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        local result = {}
        local max_width = 15

        for _, buf in ipairs(buffers) do
          local formatted_name = format_buffer_name(buf.bufnr, max_width)
          if buf.bufnr == vim.api.nvim_get_current_buf() then
            table.insert(result, '%#LualineBufferActive#' .. formatted_name .. '%*')
          else
            table.insert(result, formatted_name)
          end
        end
        return table.concat(result, " ")
      end,
    },
    lualine_x = { 'diagnostics', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

-- Подсветка активного буфера
vim.api.nvim_set_hl(0, 'LualineBufferActive', { fg = '#ffffff', bg = '#363A59' })
