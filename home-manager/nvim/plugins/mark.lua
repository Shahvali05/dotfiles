local ns = vim.api.nvim_create_namespace("line_markers")

-- таблица для хранения маркеров
_G.line_marks = _G.line_marks or {}
local marks = _G.line_marks

local colors = {
  red = "DiffDelete",
  green = "DiffAdd",
  blue = "DiffChange",
  yellow = "Search",
  purple = "Statement",
}

vim.api.nvim_create_user_command("Mark", function(opts)
  local line = vim.fn.line(".") - 1
  local arg = opts.args

  -- удалить маркер
  if arg == "del" then
    if marks[line] then
      vim.api.nvim_buf_del_extmark(0, ns, marks[line])
      marks[line] = nil
    end
    return
  end

  local color = colors[arg]
  if not color then
    print("Unknown color")
    return
  end

  -- удалить старый
  if marks[line] then
    vim.api.nvim_buf_del_extmark(0, ns, marks[line])
  end

  local id = vim.api.nvim_buf_set_extmark(0, ns, line, 0, {
    line_hl_group = color,
    hl_eol = true
  })

  marks[line] = id
end, {
  nargs = 1
})

vim.api.nvim_create_user_command("MarkClear", function()
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end, {})
