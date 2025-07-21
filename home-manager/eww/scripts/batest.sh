#!/usr/bin/env bash

while true; do
    CHARGE_NOW=$(cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)
    CURRENT_NOW=$(cat /sys/class/power_supply/BAT0/current_now 2>/dev/null)
    CHARGE_FULL=$(cat /sys/class/power_supply/BAT0/charge_full 2>/dev/null)
    STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

    # Пропускаем, если данные не получены
    if [[ -z "$CHARGE_NOW" || -z "$CURRENT_NOW" || -z "$CHARGE_FULL" || -z "$STATUS" ]]; then
        echo "Battery info not available"
        sleep 5
        continue
    fi

    CURRENT_NOW=${CURRENT_NOW#-}  # Убираем минус, если есть

    if [ "$CURRENT_NOW" -ne 0 ]; then
        if [[ "$STATUS" == "Discharging" ]]; then
            MINUTES_LEFT=$(( CHARGE_NOW * 60 / CURRENT_NOW ))
            HOURS=$(( MINUTES_LEFT / 60 ))
            MINS=$(( MINUTES_LEFT % 60 ))
            echo "$HOURS h $MINS min left, $STATUS"
        elif [[ "$STATUS" == "Charging" ]]; then
            DIFF=$(( CHARGE_FULL - CHARGE_NOW ))
            MINUTES_TO_FULL=$(( DIFF * 60 / CURRENT_NOW ))
            HOURS=$(( MINUTES_TO_FULL / 60 ))
            MINS=$(( MINUTES_TO_FULL % 60 ))
            echo "$HOURS h $MINS min to full, $STATUS"
        else
            echo "0 h 0 min to full, $STATUS"
        fi
    else
        echo "Battery usage unknown"
    fi

    sleep 1
done
