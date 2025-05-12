" Отключение стандартных привязок vim-jukit
let g:jukit_mappings = 0

" Установка команды для окна вывода
let g:jukit_shell_cmd = 'conda activate MyCondaEnv && ipython'

" Привязки клавиш
nnoremap <leader>os :call jukit#splits#output()<cr>
"   - Открывает новое окно вывода и выполняет команду, указанную в `g:jukit_shell_cmd`
nnoremap <leader>ts :call jukit#splits#term()<cr>
"   - Открывает новое окно вывода без выполнения команд
nnoremap <leader>hs :call jukit#splits#history()<cr>
"   - Открывает новое окно истории вывода, где отображаются сохранённые результаты IPython
nnoremap <leader>ohs :call jukit#splits#output_and_history()<cr>
"   - Краткий способ открытия окна вывода и окна истории вывода одновременно
nnoremap <leader>hd :call jukit#splits#close_history()<cr>
"   - Закрывает окно истории вывода
nnoremap <leader>od :call jukit#splits#close_output_split()<cr>
"   - Закрывает окно вывода
nnoremap <leader>ohd :call jukit#splits#close_output_and_history(1)<cr>
"   - Закрывает оба окна (вывода и истории) с запросом подтверждения
nnoremap <leader>so :call jukit#splits#show_last_cell_output(1)<cr>
"   - Показывает вывод текущей ячейки (определяется позицией курсора) в окне истории вывода
nnoremap <leader>j :call jukit#splits#out_hist_scroll(1)<cr>
"   - Прокрутка вниз в окне истории вывода
nnoremap <leader>k :call jukit#splits#out_hist_scroll(0)<cr>
"   - Прокрутка вверх в окне истории вывода
nnoremap <leader>ah :call jukit#splits#toggle_auto_hist()<cr>
"   - Включает/выключает автопоказ сохранённого вывода при остановке курсора
nnoremap <leader>sl :call jukit#layouts#set_layout()<cr>
"   - Применяет макет (см. `g:jukit_layout`) к текущим сплитам
nnoremap <leader><space> :call jukit#send#section(0)<cr>
"   - Отправляет код текущей ячейки в окно вывода
nnoremap <cr> :call jukit#send#line()<cr>
"   - Отправляет текущую строку в окно вывода
vnoremap <cr> :<C-U>call jukit#send#selection()<cr>
"   - Отправляет визуально выделенный код в окно вывода
nnoremap <leader>cc :call jukit#send#until_current_section()<cr>
"   - Выполняет все ячейки до текущей
nnoremap <leader>all :call jukit#send#all()<cr>
"   - Выполняет все ячейки
nnoremap <leader>co :call jukit#cells#create_below(0)<cr>
"   - Создаёт новую кодовую ячейку ниже
nnoremap <leader>cO :call jukit#cells#create_above(0)<cr>
"   - Создаёт новую кодовую ячейку выше
nnoremap <leader>ct :call jukit#cells#create_below(1)<cr>
"   - Создаёт новую текстовую ячейку ниже
nnoremap <leader>cT :call jukit#cells#create_above(1)<cr>
"   - Создаёт новую текстовую ячейку выше
nnoremap <leader>cd :call jukit#cells#delete()<cr>
"   - Удаляет текущую ячейку
nnoremap <leader>cs :call jukit#cells#split()<cr>
"   - Разделяет текущую ячейку
nnoremap <leader>cM :call jukit#cells#merge_above()<cr>
"   - Объединяет текущую ячейку с ячейкой выше
nnoremap <leader>cm :call jukit#cells#merge_below()<cr>
"   - Объединяет текущую ячейку с ячейкой ниже
nnoremap <leader>ck :call jukit#cells#move_up()<cr>
"   - Перемещает текущую ячейку вверх
nnoremap <leader>cj :call jukit#cells#move_down()<cr>
"   - Перемещает текущую ячейку вниз
nnoremap <leader>J :call jukit#cells#jump_to_next_cell()<cr>
"   - Переходит к следующей ячейке ниже
nnoremap <leader>K :call jukit#cells#jump_to_previous_cell()<cr>
"   - Переходит к предыдущей ячейке выше
nnoremap <leader>ddo :call jukit#cells#delete_outputs(0)<cr>
"   - Удаляет сохранённый вывод текущей ячейки
nnoremap <leader>dda :call jukit#cells#delete_outputs(1)<cr>
"   - Удаляет сохранённый вывод всех ячеек
nnoremap <leader>np :call jukit#convert#notebook_convert("jupyter-notebook")<cr>
"   - Конвертирует файл из ipynb в py или наоборот
nnoremap <leader>ht :call jukit#convert#save_nb_to_file(0,1,'html')<cr>
"   - Конвертирует файл в HTML и открывает его
nnoremap <leader>rht :call jukit#convert#save_nb_to_file(1,1,'html')<cr>
"   - То же, что выше, но перевыполняет все ячейки перед конвертацией в HTML
nnoremap <leader>pd :call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>
"   - Конвертирует файл в PDF и открывает его
nnoremap <leader>rpd :call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>
"   - То же, что выше, но перевыполняет все ячейки перед конвертацией в PDF
