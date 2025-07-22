#!/usr/bin/env bash

if ! command -v hyprctl &> /dev/null; then
    echo "Ошибка: hyprctl не найден. Убедитесь, что вы используете Hyprland."
    exit 1
fi

while true; do
  CURRENT_LAYOUT=$(hyprctl devices | grep -B 5 "main: yes" | grep "active keymap" | awk '{print $NF}')

  if [ "$CURRENT_LAYOUT" == "(US)" ]; then
      CURRENT_LAYOUT="US"
  elif [ "$CURRENT_LAYOUT" == "Russian" ]; then
      CURRENT_LAYOUT="RU"
  fi

  if [ -z "$CURRENT_LAYOUT" ]; then
      echo "Ошибка: Не удалось определить текущую раскладку клавиатуры."
      exit 1
  fi

  echo "$CURRENT_LAYOUT"
  sleep 0.1
done
