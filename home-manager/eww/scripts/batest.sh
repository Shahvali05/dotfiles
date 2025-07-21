#!/usr/bin/env bash

# Путь к папке батареи
BAT_PATH="/sys/class/power_supply/BAT1"

# Проверяем, существует ли папка батареи
if [ ! -d "$BAT_PATH" ]; then
    echo "Ошибка: Устройство батареи $BAT_PATH не найдено"
    exit 1
fi

while true; do
    # Читаем текущий заряд (μWh), мощность (μW), полную емкость (μWh) и статус
    ENERGY_NOW=$(cat "$BAT_PATH/energy_now" 2>/dev/null || echo 0)
    POWER_NOW=$(cat "$BAT_PATH/power_now" 2>/dev/null || echo 0)
    POWER_NOW=${POWER_NOW#-} # Убираем знак минус, если есть
    ENERGY_FULL=$(cat "$BAT_PATH/energy_full" 2>/dev/null || echo 0)
    STATUS=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

    # Проверяем, что POWER_NOW не равно 0, чтобы избежать деления на ноль
    if [ "$POWER_NOW" -ne 0 ]; then
        if [[ "$STATUS" == "Discharging" ]]; then
            # Время до разряда (в минутах)
            MINUTES_LEFT=$(( ENERGY_NOW * 60 / POWER_NOW ))
            HOURS=$(( MINUTES_LEFT / 60 ))
            MINS=$(( MINUTES_LEFT % 60 ))
            echo "$HOURS ч $MINS мин осталось, $STATUS"
        elif [[ "$STATUS" == "Charging" ]]; then
            # Время до полной зарядки
            DIFF=$(( ENERGY_FULL - ENERGY_NOW ))
            MINUTES_TO_FULL=$(( DIFF * 60 / POWER_NOW ))
            HOURS=$(( MINUTES_TO_FULL / 60 ))
            MINS=$(( MINUTES_TO_FULL % 60 ))
            echo "$HOURS ч $MINS мин до полной зарядки, $STATUS"
        else
            echo "0 ч 0 мин до полной зарядки, $STATUS"
        fi
    else
        echo "Ошибка: Не удалось прочитать power_now, $STATUS"
    fi
    sleep 1
done
