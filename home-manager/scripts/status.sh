#!/usr/bin/env bash

# Функция для времени
get_time() {
    date +"%I:%M"
}

# Функция для даты
get_date() {
    date +"%Y-%m-%d"
}

# Функция для CPU
get_cpu() {
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
}

# Функция для памяти
get_mem() {
    # Получаем используемую и общую память в килобайтах
    local used=$(free -k | awk '/^Mem/ {print $3}')
    local total=$(free -k | awk '/^Mem/ {print $2}')
    
    # Переводим в гигабайты с одним знаком после запятой
    local used_g=$(awk "BEGIN {printf \"%.1f\", $used/1024/1024}")
    local total_g=$(awk "BEGIN {printf \"%.1f\", $total/1024/1024}")
    
    echo "${used_g}G/${total_g}G"
}

# Функция для батареи (через sysfs, без команды battery)
get_bat() {
    local battery_path="/sys/class/power_supply/BAT1"
    if [[ -d "$battery_path" ]]; then
        local battery_percentage=$(cat "$battery_path/capacity")
        local battery_state=$(cat "$battery_path/status")
        local icon

        if [[ "$battery_state" == "Charging" ]]; then
            icon="󱐋"
        elif [[ "$battery_percentage" -ge 80 ]]; then
            icon="󱊣"
        elif [[ "$battery_percentage" -ge 60 ]]; then
            icon="󱊢"
        elif [[ "$battery_percentage" -ge 40 ]]; then
            icon="󱊡"
        elif [[ "$battery_percentage" -ge 20 ]]; then
            icon="󰂎"
        else
            icon="󰂃"
        fi
        echo -n "$icon$battery_percentage%"
    else
        echo -n "N/A"
    fi
}

get_vol() {
    # Проверяем наличие wpctl
    if ! command -v wpctl &>/dev/null; then
        echo "N/A"
        return
    fi

    # Получаем вывод команды wpctl get-volume
    local volume_info
    volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

    # Извлекаем громкость в процентах
    local volume
    volume=$(echo "$volume_info" | awk '{printf "%d", $2*100}')

    # Проверяем mute
    local icon
    if [[ "$volume_info" == *"[MUTED]"* ]]; then
        icon=""
        echo -n "$icon"
        return
    elif [[ "$volume" -ge 80 ]]; then
        icon=""
    elif [[ "$volume" -ge 40 ]]; then
        icon=""
    else
        icon=""
    fi

    echo -n "$icon$volume%"
}

get_mic() {
    if ! command -v wpctl &>/dev/null; then
        echo "N/A"
        return
    fi

    # Смотрим вывод wpctl get-volume для микрофона
    local mic_status
    mic_status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

    if [[ "$mic_status" == *"[MUTED]"* ]]; then
        echo -n "󰍬"  # микрофон выключен
    else
        echo -n "󰍭"  # микрофон включен
    fi
}

get_net() {
    local connection_status wifi_icon ethernet_icon bluetooth_icon

    connection_status=$(nmcli -t -f DEVICE,TYPE,STATE dev status | grep -e 'wifi' -e 'ethernet')

    wifi_icon=""
    if [[ "$connection_status" == *"wifi:connected"* ]]; then
        wifi_strength=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*' | awk -F: '{print $2}')
        if [[ -n "$wifi_strength" ]]; then
            if (( wifi_strength > 80 )); then
                wifi_icon="󰣺"
            elif (( wifi_strength > 60 )); then
                wifi_icon="󰣸"
            elif (( wifi_strength > 40 )); then
                wifi_icon="󰣶"
            elif (( wifi_strength > 20 )); then
                wifi_icon="󰣴"
            else
                wifi_icon="󰣾"
            fi
        else
            wifi_icon="󰣼"
        fi
    fi

    ethernet_icon=""
    if [[ "$connection_status" == *"ethernet:connected"* ]]; then
        ethernet_icon="󰈀"
    fi

    bluetooth_status=$(bluetoothctl show | grep -i "Powered" | awk '{print $2}')
    bluetooth_connected=$(bluetoothctl devices Connected | wc -l)

    if [[ "$bluetooth_status" == "yes" ]]; then
        if (( bluetooth_connected > 0 )); then
            bluetooth_icon="󰂱"
        else
            bluetooth_icon=""
        fi
    else
        bluetooth_icon=""
    fi

    if [[ -z "$wifi_icon" && -z "$ethernet_icon" && -z "$bluetooth_icon" ]]; then
        echo -n "󰀝"
    else
        echo -n "$bluetooth_icon$ethernet_icon$wifi_icon"
    fi
}

# Интервалы обновления в секундах
BAT_INTERVAL=20
NET_INTERVAL=5

# Начальные значения
TIME=$(get_time)
DATE=$(get_date)
CPU=$(get_cpu)
MEM=$(get_mem)
BAT=$(get_bat)
VOL=$(get_vol)
MIC=$(get_mic)
NET=$(get_net)

# Таймеры
bat_last=0
net_last=0

while true; do
    now=$(date +%s)

      TIME=$(get_time)

    # BAT каждые 20 секунд
    if (( now - bat_last >= BAT_INTERVAL )); then
        BAT=$(get_bat)
        bat_last=$now
    fi

    # NET каждые 5 секунд
    if (( now - net_last >= NET_INTERVAL )); then
        NET=$(get_net)
        net_last=$now
    fi

    # VOL и MIC каждую итерацию
    VOL=$(get_vol)
    MIC=$(get_mic)

    # Вывод
    echo " {layout}|$BAT|$VOL|$MIC|$NET|$TIME"

    sleep 0.1
done
