#!/bin/sh

# Установите путь к вашей папке с музыкой
music_folder="/home/laraeter/Music"

# Запустите MOC с указанием пути к папке с музыкой и включенным случайным воспроизведением
mocp -S
mocp -a "$music_folder"
mocp -o shuffle

# Начните воспроизведение
mocp --play
