vim.g.jukit_mappings = 0

local keymap = vim.keymap

keymap.set("n", "<leader>os", ":lua require('jukit.splits').output()<CR>", { silent = true desc = "Открыть окно вывода" })

-- Открывает новое окно вывода без выполнения команд
keymap.set("n", "<leader>ts", ":lua require('jukit.splits').term()<CR>", { silent = true desc = "Открыть окно терминала" })

-- Открывает новое окно истории вывода, где отображаются сохранённые результаты IPython
keymap.set("n", "<leader>hs", ":lua require('jukit.splits').history()<CR>", { silent = true })

-- Краткий способ открытия окна вывода и окна истории вывода одновременно
keymap.set("n", "<leader>ohs", ":lua require('jukit.splits').output_and_history()<CR>", { silent = true })

-- Закрывает окно истории вывода
keymap.set("n", "<leader>hd", ":lua require('jukit.splits').close_history()<CR>", { silent = true })

-- Закрывает окно вывода
keymap.set("n", "<leader>od", ":lua require('jukit.splits').close_output_split()<CR>", { silent = true })

-- Закрывает оба окна (вывода и истории) с запросом подтверждения
keymap.set("n", "<leader>ohd", ":lua require('jukit.splits').close_output_and_history(1)<CR>", { silent = true })

-- Показывает вывод текущей ячейки (определяется позицией курсора) в окне истории вывода
keymap.set("n", "<leader>so", ":lua require('jukit.splits').show_last_cell_output(1)<CR>", { silent = true })

-- Прокрутка вниз в окне истории вывода
keymap.set("n", "<leader>j", ":lua require('jukit.splits').out_hist_scroll(1)<CR>", { silent = true })

-- Прокрутка вверх в окне истории вывода
keymap.set("n", "<leader>k", ":lua require('jukit.splits').out_hist_scroll(0)<CR>", { silent = true })

-- Включает/выключает автопоказ сохранённого вывода при остановке курсора
keymap.set("n", "<leader>ah", ":lua require('jukit.splits').toggle_auto_hist()<CR>", { silent = true })

-- Применяет макет (см. `g:jukit_layout`) к текущим сплитам
keymap.set("n", "<leader>sl", ":lua require('jukit.layouts').set_layout()<CR>", { silent = true })

-- Отправляет код текущей ячейки в окно вывода (с сохранением вывода, если используется IPython и `g:jukit_save_output==1`)
keymap.set("n", "<leader><space>", ":lua require('jukit.send').section(0)<CR>", { silent = true })

-- Отправляет текущую строку в окно вывода
keymap.set("n", "<CR>", ":lua require('jukit.send').line()<CR>", { silent = true })

-- Отправляет визуально выделенный код в окно вывода
keymap.set("v", "<CR>", ":lua require('jukit.send').selection()<CR>", { silent = true })

-- Выполняет все ячейки до текущей
keymap.set("n", "<leader>cc", ":lua require('jukit.send').until_current_section()<CR>", { silent = true })

-- Выполняет все ячейки
keymap.set("n", "<leader>all", ":lua require('jukit.send').all()<CR>", { silent = true })

-- Создаёт новую кодовую ячейку ниже
keymap.set("n", "<leader>co", ":lua require('jukit.cells').create_below(0)<CR>", { silent = true })

-- Создаёт новую кодовую ячейку выше
keymap.set("n", "<leader>cO", ":lua require('jukit.cells').create_above(0)<CR>", { silent = true })

-- Создаёт новую текстовую ячейку ниже
keymap.set("n", "<leader>ct", ":lua require('jukit.cells').create_below(1)<CR>", { silent = true })

-- Создаёт новую текстовую ячейку выше
keymap.set("n", "<leader>cT", ":lua require('jukit.cells').create_above(1)<CR>", { silent = true })

-- Удаляет текущую ячейку
keymap.set("n", "<leader>cd", ":lua require('jukit.cells').delete()<CR>", { silent = true })

-- Разделяет текущую ячейку (сохранённый вывод будет назначен верхней результирующей ячейке)
keymap.set("n", "<leader>cs", ":lua require('jukit.cells').split()<CR>", { silent = true })

-- Объединяет текущую ячейку с ячейкой выше
keymap.set("n", "<leader>cM", ":lua require('jukit.cells').merge_above()<CR>", { silent = true })

-- Объединяет текущую ячейку с ячейкой ниже
keymap.set("n", "<leader>cm", ":lua require('jukit.cells').merge_below()<CR>", { silent = true })

-- Перемещает текущую ячейку вверх
keymap.set("n", "<leader>ck", ":lua require('jukit.cells').move_up()<CR>", { silent = true })

-- Перемещает текущую ячейку вниз
keymap.set("n", "<leader>cj", ":lua require('jukit.cells').move_down()<CR>", { silent = true })

-- Переходит к следующей ячейке ниже
keymap.set("n", "<leader>J", ":lua require('jukit.cells').jump_to_next_cell()<CR>", { silent = true })

-- Переходит к предыдущей ячейке выше
keymap.set("n", "<leader>K", ":lua require('jukit.cells').jump_to_previous_cell()<CR>", { silent = true })

-- Удаляет сохранённый вывод текущей ячейки
keymap.set("n", "<leader>ddo", ":lua require('jukit.cells').delete_outputs(0)<CR>", { silent = true })

-- Удаляет сохранённый вывод всех ячеек
keymap.set("n", "<leader>dda", ":lua require('jukit.cells').delete_outputs(1)<CR>", { silent = true })

-- Конвертирует файл из ipynb в py или наоборот и открывает результат
keymap.set("n", "<leader>np", ":lua require('jukit.convert').notebook_convert('jupyter-notebook')<CR>", { silent = true })

-- Конвертирует файл в HTML (с сохранённым выводом) и открывает его
keymap.set("n", "<leader>ht", ":lua require('jukit.convert').save_nb_to_file(0, 1, 'html')<CR>", { silent = true })

-- То же, что выше, но перевыполняет все ячейки перед конвертацией в HTML
keymap.set("n", "<leader>rht", ":lua require('jukit.convert').save_nb_to_file(1, 1, 'html')<CR>", { silent = true })

-- Конвертирует файл в PDF (с сохранённым выводом) и открывает его
keymap.set("n", "<leader>pd", ":lua require('jukit.convert').save_nb_to_file(0, 1, 'pdf')<CR>", { silent = true })

-- То же, что выше, но перевыполняет все ячейки перед конвертацией в PDF
keymap.set("n", "<leader>rpd", ":lua require('jukit.convert').save_nb_to_file(1, 1, 'pdf')<CR>", { silent = true })

-- Устанавливает позицию и размер окна überzug
keymap.set("n", "<leader>pos", ":lua require('jukit.ueberzug').set_default_pos()<CR>", { silent = true })
