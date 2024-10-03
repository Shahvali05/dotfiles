local keymap = vim.keymap
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- window management

-- Перемещение по вкладкам
keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Go to next tab" })  -- Вперёд по вкладкам
keymap.set("n", "<S-Tab>", "<cmd>bNext<CR>", { desc = "Go to previous tab" })  -- Назад по вкладкам
keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current tab" }) -- Закрывать вкладку
keymap.set("n", "<leader>n", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- Открывать новую вкладку

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab


-- Определяем таблицу с горячими клавишами
local keymap_list = {
  "jk: Выход из режима ввода",
  "<leader>nh: Очистить подсветку поиска",
  "<Tab>: Вперёд по вкладкам",
  "<S-Tab>: Назад по вкладкам",
  "<leader>x: Закрыть вкладку",
  "<leader>n: Открыть новую вкладку",
  "<leader>sv: Разделить окно по вертикали",
  "<leader>sh: Разделить окно по горизонтали",
  "<leader>se: Сохранить размер окна",
  "<leader>sx: Закрыть текущее окно",
  "<leader>tf: Открыть текущий буфер в новом вкладке",
  "<leader>wr: Восстановить сеанс для текущего каталога",
  "<leader>ws: Сохранить сеанс для текущего каталога",
  "<F5>: Продолжить выполнение программы",
  "<F10>: Шагнуть через",
  "<F11>: Шагнуть внутрь",
  "<F12>: Шагнуть наружу",
  "<leader>b: Переключить точку останова",
  "<leader>B: Установить точку останова",
  "<leader>lp: Установить точку логирования",
  "<leader>du: Открыть/закрыть DAP UI",
  "<C-n>: Открыть/закрыть NvimTree",
  "K: Посмотреть на реализацию",
  "<leader>ff: Поиск файлов",
  "<leader>lg: Поиск по содержанию",
  "<leader>fb: Поиск в буфере",
  "<leader>fh: Поиск по справочным страницам Neovim",
  "<leader>ft: Поиск комментариев в TODO",
  "<leader>]t: Слудующий TODO комент",
  "<leader>[t: Предыдущий TODO комент",
  -- Добавьте сюда все свои горячие клавиши
}

-- Глобальная функция для отображения списка горячих клавиш в правом сплите
_G.show_keymaps = function()
  -- Открываем новый сплит справа
  vim.cmd('vsplit')
  
  -- Создаем новый буфер и заполняем его текстом
  local bufnr = vim.api.nvim_create_buf(false, true) -- Создаем новый пустой буфер
  vim.api.nvim_set_current_buf(bufnr) -- Активируем этот буфер в текущем окне

  -- Добавляем текст в буфер
  for _, keymap in ipairs(keymap_list) do
      vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { keymap })
  end

  -- Делаем буфер неизменяемым, чтобы случайно не редактировать его
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
end

-- Привязываем функцию к кастомной команде
vim.api.nvim_set_keymap('n', '<leader>k', ':lua show_keymaps()<CR>', { noremap = true, silent = true })
