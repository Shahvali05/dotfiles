#!/usr/bin/env bash

# Проверяем, доступен ли hyprctl
if ! command -v hyprctl &> /dev/null; then
    echo "Ошибка: hyprctl не найден. Убедитесь, что вы используете Hyprland."
    exit 1
fi

# Получаем текущую раскладку с помощью hyprctl
CURRENT_LAYOUT=$(hyprctl devices | grep -A 10 "Keyboards" | grep "active keymap" | awk '{print $NF}')

# Проверяем, удалось ли получить раскладку
if [ -z "$CURRENT_LAYOUT" ]; then
    echo "Ошибка: Не удалось определить текущую раскладку клавиатуры."
    exit 1
fi

# Выводим текущую раскладку
echo "$CURRENT_LAYOUT"
