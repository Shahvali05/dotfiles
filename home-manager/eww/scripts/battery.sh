#!/usr/bin/env bash

BATTERY_PATH="/sys/class/power_supply/BAT1"

if [[ ! -r "$BATTERY_PATH/capacity" || ! -r "$BATTERY_PATH/status" ]]; then
    echo "(box :class \"bat-bar\" \"⚠ Battery info not found\")"
    exit 1
fi

battery_percent=$(cat "$BATTERY_PATH/capacity")
status=$(cat "$BATTERY_PATH/status")

echo "(box :class \"bat-bar\" (circular-progress :value ${battery_percent} :hexpand false (eventbox :class \"bat-icon\" :tooltip \"Battery : ${battery_percent}%\" :wrap false \"🔋\")))"
