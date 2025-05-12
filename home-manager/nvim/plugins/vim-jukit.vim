" Отключение стандартных привязок vim-jukit
let g:jukit_mappings = 0

" Установка команды для окна вывода
let g:jukit_shell_cmd = 'conda activate MyCondaEnv && ipython'

" Привязки клавиш с описаниями для which-key.nvim
nnoremap <leader>os :call jukit#splits#output()<cr>
\ :call which_key#register('<leader>os', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['os'] = 'Открыть окно вывода и выполнить команду'<cr>
"   - Открывает новое окно вывода и выполняет команду, указанную в `g:jukit_shell_cmd`

nnoremap <leader>ts :call jukit#splits#term()<cr>
\ :call which_key#register('<leader>ts', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ts'] = 'Открыть окно вывода без команд'<cr>
"   - Открывает новое окно вывода без выполнения команд

nnoremap <leader>hs :call jukit#splits#history()<cr>
\ :call which_key#register('<leader>hs', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['hs'] = 'Открыть окно истории вывода'<cr>
"   - Открывает новое окно истории вывода, где отображаются сохранённые результаты IPython

nnoremap <leader>ohs :call jukit#splits#output_and_history()<cr>
\ :call which_key#register('<leader>ohs', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ohs'] = 'Открыть окно вывода и истории'<cr>
"   - Краткий способ открытия окна вывода и окна истории вывода одновременно

nnoremap <leader>hd :call jukit#splits#close_history()<cr>
\ :call which_key#register('<leader>hd', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['hd'] = 'Закрыть окно истории'<cr>
"   - Закрывает окно истории вывода

nnoremap <leader>od :call jukit#splits#close_output_split()<cr>
\ :call which_key#register('<leader>od', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['od'] = 'Закрыть окно вывода'<cr>
"   - Закрывает окно вывода

nnoremap <leader>ohd :call jukit#splits#close_output_and_history(1)<cr>
\ :call which_key#register('<leader>ohd', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ohd'] = 'Закрыть окна вывода и истории'<cr>
"   - Закрывает оба окна (вывода и истории) с запросом подтверждения

nnoremap <leader>so :call jukit#splits#show_last_cell_output(1)<cr>
\ :call which_key#register('<leader>so', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['so'] = 'Показать вывод текущей ячейки'<cr>
"   - Показывает вывод текущей ячейки (определяется позицией курсора) в окне истории вывода

nnoremap <leader>j :call jukit#splits#out_hist_scroll(1)<cr>
\ :call which_key#register('<leader>j', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['j'] = 'Прокрутка вниз в истории'<cr>
"   - Прокрутка вниз в окне истории вывода

nnoremap <leader>k :call jukit#splits#out_hist_scroll(0)<cr>
\ :call which_key#register('<leader>k', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['k'] = 'Прокрутка вверх в истории'<cr>
"   - Прокрутка вверх в окне истории вывода

nnoremap <leader>ah :call jukit#splits#toggle_auto_hist()<cr>
\ :call which_key#register('<leader>ah', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ah'] = 'Переключить автопоказ истории'<cr>
"   - Включает/выключает автопоказ сохранённого вывода при остановке курсора

nnoremap <leader>sl :call jukit#layouts#set_layout()<cr>
\ :call which_key#register('<leader>sl', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['sl'] = 'Применить макет сплитов'<cr>
"   - Применяет макет (см. `g:jukit_layout`) к текущим сплитам

nnoremap <leader><space> :call jukit#send#section(0)<cr>
\ :call which_key#register('<leader><space>', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['<space>'] = 'Отправить код ячейки в вывод'<cr>
"   - Отправляет код текущей ячейки в окно вывода

nnoremap <cr> :call jukit#send#line()<cr>
\ :call which_key#register('<cr>', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['<cr>'] = 'Отправить строку в вывод'<cr>
"   - Отправляет текущую строку в окно вывода

vnoremap <cr> :<C-U>call jukit#send#selection()<cr>
\ :call which_key#register('<cr>', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['<cr>'] = 'Отправить выделение в вывод'<cr>
"   - Отправляет визуально выделенный код в окно вывода

nnoremap <leader>cc :call jukit#send#until_current_section()<cr>
\ :call which_key#register('<leader>cc', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cc'] = 'Выполнить ячейки до текущей'<cr>
"   - Выполняет все ячейки до текущей

nnoremap <leader>all :call jukit#send#all()<cr>
\ :call which_key#register('<leader>all', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['all'] = 'Выполнить все ячейки'<cr>
"   - Выполняет все ячейки

nnoremap <leader>co :call jukit#cells#create_below(0)<cr>
\ :call which_key#register('<leader>co', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['co'] = 'Создать кодовую ячейку ниже'<cr>
"   - Создаёт новую кодовую ячейку ниже

nnoremap <leader>cO :call jukit#cells#create_above(0)<cr>
\ :call which_key#register('<leader>cO', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cO'] = 'Создать кодовую ячейку выше'<cr>
"   - Создаёт новую кодовую ячейку выше

nnoremap <leader>ct :call jukit#cells#create_below(1)<cr>
\ :call which_key#register('<leader>ct', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ct'] = 'Создать текстовую ячейку ниже'<cr>
"   - Создаёт новую текстовую ячейку ниже

nnoremap <leader>cT :call jukit#cells#create_above(1)<cr>
\ :call which_key#register('<leader>cT', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cT'] = 'Создать текстовую ячейку выше'<cr>
"   - Создаёт новую текстовую ячейку выше

nnoremap <leader>cd :call jukit#cells#delete()<cr>
\ :call which_key#register('<leader>cd', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cd'] = 'Удалить текущую ячейку'<cr>
"   - Удаляет текущую ячейку

nnoremap <leader>cs :call jukit#cells#split()<cr>
\ :call which_key#register('<leader>cs', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cs'] = 'Разделить текущую ячейку'<cr>
"   - Разделяет текущую ячейку

nnoremap <leader>cM :call jukit#cells#merge_above()<cr>
\ :call which_key#register('<leader>cM', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cM'] = 'Объединить с ячейкой выше'<cr>
"   - Объединяет текущую ячейку с ячейкой выше

nnoremap <leader>cm :call jukit#cells#merge_below()<cr>
\ :call which_key#register('<leader>cm', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cm'] = 'Объединить с ячейкой ниже'<cr>
"   - Объединяет текущую ячейку с ячейкой ниже

nnoremap <leader>ck :call jukit#cells#move_up()<cr>
\ :call which_key#register('<leader>ck', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ck'] = 'Переместить ячейку вверх'<cr>
"   - Перемещает текущую ячейку вверх

nnoremap <leader>cj :call jukit#cells#move_down()<cr>
\ :call which_key#register('<leader>cj', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['cj'] = 'Переместить ячейку вниз'<cr>
"   - Перемещает текущую ячейку вниз

nnoremap <leader>J :call jukit#cells#jump_to_next_cell()<cr>
\ :call which_key#register('<leader>J', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['J'] = 'Перейти к следующей ячейке'<cr>
"   - Переходит к следующей ячейке ниже

nnoremap <leader>K :call jukit#cells#jump_to_previous_cell()<cr>
\ :call which_key#register('<leader>K', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['K'] = 'Перейти к предыдущей ячейке'<cr>
"   - Переходит к предыдущей ячейке выше

nnoremap <leader>ddo :call jukit#cells#delete_outputs(0)<cr>
\ :call which_key#register('<leader>ddo', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ddo'] = 'Удалить вывод текущей ячейки'<cr>
"   - Удаляет сохранённый вывод текущей ячейки

nnoremap <leader>dda :call jukit#cells#delete_outputs(1)<cr>
\ :call which_key#register('<leader>dda', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['dda'] = 'Удалить вывод всех ячеек'<cr>
"   - Удаляет сохранённый вывод всех ячеек

nnoremap <leader>np :call jukit#convert#notebook_convert("jupyter-notebook")<cr>
\ :call which_key#register('<leader>np', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['np'] = 'Конвертировать в ipynb/py'<cr>
"   - Конвертирует файл из ipynb в py или наоборот

nnoremap <leader>ht :call jukit#convert#save_nb_to_file(0,1,'html')<cr>
\ :call which_key#register('<leader>ht', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['ht'] = 'Конвертировать в HTML'<cr>
"   - Конвертирует файл в HTML и открывает его

nnoremap <leader>rht :call jukit#convert#save_nb_to_file(1,1,'html')<cr>
\ :call which_key#register('<leader>rht', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['rht'] = 'Конвертировать в HTML с перезапуском'<cr>
"   - То же, что выше, но перевыполняет все ячейки перед конвертацией в HTML

nnoremap <leader>pd :call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>
\ :call which_key#register('<leader>pd', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['pd'] = 'Конвертировать в PDF'<cr>
"   - Конвертирует файл в PDF и открывает его

nnoremap <leader>rpd :call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>
\ :call which_key#register('<leader>rpd', 'g:which_key_localmap')<cr>
\ :let g:which_key_localmap['rpd'] = 'Конвертировать в PDF с перезапуском'<cr>
"   - То же, что выше, но перевыполняет все ячейки перед конвертацией в PDF
