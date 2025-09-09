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
            icon="󰂄"
        elif [[ "$battery_percentage" -ge 80 ]]; then
            icon="󰁹"
        elif [[ "$battery_percentage" -ge 70 ]]; then
            icon="󰂀"
        elif [[ "$battery_percentage" -ge 60 ]]; then
            icon="󰁿"
        elif [[ "$battery_percentage" -ge 50 ]]; then
            icon="󰁾"
        elif [[ "$battery_percentage" -ge 40 ]]; then
            icon="󰁽"
        elif [[ "$battery_percentage" -ge 30 ]]; then
            icon="󰁼"
        elif [[ "$battery_percentage" -ge 20 ]]; then
            icon="󰁻"
        elif [[ "$battery_percentage" -ge 10 ]]; then
            icon="󰁺"
        else
            icon="󰂎"
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
        icon="󰎊"
        echo -n "$icon"
        return
    elif [[ "$volume" -ge 80 ]]; then
        icon="󰎇"
    elif [[ "$volume" -ge 40 ]]; then
        icon="󰎋"
    else
        icon="󰎉"
    fi

    # 󰎋 󰎇

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
        echo -n "󰍭"  # микрофон выключен
    else
        echo -n "󰍬"  # микрофон включен
    fi
}

get_net() {
    local wifi_icon="" ethernet_icon="" bluetooth_icon=""
    local has_wifi=0

    # ---- Ethernet (по имени интерфейса, + fallback по наличию /device) ----
    for path in /sys/class/net/*; do
        iface=${path##*/}
        [[ "$iface" == "lo" ]] && continue

        case "$iface" in
            virbr*|docker*|br-*|veth*|vmnet*|tun*|tap* ) continue ;;
        esac

        # wireless будет обработан отдельно
        [[ -d "/sys/class/net/$iface/wireless" ]] && { has_wifi=1; continue; }

        if [[ "$iface" =~ ^(en|eth|eno|ens|enx)[0-9a-zA-Z:\._-]*$ ]]; then
            state=$(</sys/class/net/"$iface"/operstate 2>/dev/null || echo down)
            if [[ "$state" == "up" ]]; then
                ethernet_icon="󰈀"
                break
            fi
        else
            # fallback: физическое устройство (PCI/USB) скорее всего — сетевой контроллер
            if [[ -d "/sys/class/net/$iface/device" ]]; then
                state=$(</sys/class/net/"$iface"/operstate 2>/dev/null || echo down)
                if [[ "$state" == "up" ]]; then
                    ethernet_icon="󰈀"
                    break
                fi
            fi
        fi
    done

    # ---- Wi-Fi: сначала пробуем считать уровень из /proc/net/wireless ----
    if [[ $has_wifi -eq 1 ]]; then
        for wifacepath in /sys/class/net/*/wireless; do
            [[ -d "$wifacepath" ]] || continue
            wiface=${wifacepath%%/wireless}
            wiface=${wiface##*/}

            # состояние интерфейса
            state=$(</sys/class/net/"$wiface"/operstate 2>/dev/null || echo down)
            # в /proc/net/wireless 3-я колонка — качество (может быть пусто, если не ассоциирован)
            wifi_strength=$(awk -v iface="$wiface" '$1 ~ iface":" {print int($3)}' /proc/net/wireless 2>/dev/null)

            if [[ -n "$wifi_strength" && "$wifi_strength" -ge 0 ]]; then
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
                break
            fi
        done

        # Если уровня нет, но аппаратная часть Wi-Fi есть — проверить состояние радиомодулей через rfkill
        if [[ -z "$wifi_icon" ]]; then
            if command -v rfkill &>/dev/null; then
                # ищем блоки с упоминанием wlan|wifi|wireless и проверяем, есть ли среди них Soft blocked: no
                if rfkill list all | grep -i -E 'wlan|wifi|wireless' -A1 | grep -q 'Soft blocked: no'; then
                    # радио включено, но нет ассоциации -> показываем "Wi-Fi включён, не подключён"
                    wifi_icon="󰣼"
                fi
            else
                # rfkill недоступен — если есть беспроводной интерфейс, показываем fallback-иконку
                wifi_icon="󰣼"
            fi
        fi
    fi

    # ---- Bluetooth: показываем, если радио включено (через rfkill) ----
    if command -v rfkill &>/dev/null; then
        if rfkill list all | grep -i -E 'bluetooth' -A2 | grep -q 'Soft blocked: no'; then
            bluetooth_icon=""
        fi
    fi

    # ---- Итоговый вывод ----
    if [[ -z "$wifi_icon" && -z "$ethernet_icon" && -z "$bluetooth_icon" ]]; then
        echo -n "󰀝"   # ничего не включено / авиарежим
    else
        echo -n "$bluetooth_icon$ethernet_icon$wifi_icon"
    fi
}

# Интервалы обновления в секундах
BAT_INTERVAL=20
NET_INTERVAL=3

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
    echo "({layout})|$BAT|$VOL|$MIC|$NET|$TIME"

    sleep 0.1
done
