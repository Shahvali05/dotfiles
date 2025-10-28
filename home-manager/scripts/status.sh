#!/usr/bin/env bash

# Function for time (HH:MM)
get_time() {
    date +"%I:%M"
}

# Efficient CPU usage using /proc/stat (avoids top)
get_cpu() {
    local cpu_prev=($(awk '/^cpu / {print $2+$4, $2+$4+$5}' /proc/stat))
    sleep 0.1
    local cpu_now=($(awk '/^cpu / {print $2+$4, $2+$4+$5}' /proc/stat))
    echo "$(( (100 * (${cpu_now[0]} - ${cpu_prev[0]})) / (${cpu_now[1]} - ${cpu_prev[1]}) ))%"
}

# Memory in GB
get_mem() {
    local used=$(free -k | awk '/^Mem/ {print $3}')
    local total=$(free -k | awk '/^Mem/ {print $2}')
    local used_g=$(awk "BEGIN {printf \"%.1f\", $used/1024/1024}")
    local total_g=$(awk "BEGIN {printf \"%.1f\", $total/1024/1024}")
    echo "${used_g}G/${total_g}G"
}

# Battery via sysfs
get_bat() {
    local battery_path="/sys/class/power_supply/BAT0"
    if [[ -d "$battery_path" ]]; then
        local battery_percentage=$(cat "$battery_path/capacity" 2>/dev/null || echo 0)
        local battery_state=$(cat "$battery_path/status" 2>/dev/null || echo "Unknown")
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

# Volume (wpctl if available)
get_vol() {
    if ! command -v wpctl &>/dev/null; then
        echo "N/A"
        return
    fi
    local volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    local volume=$(echo "$volume_info" | awk '{printf "%d", $2*100}')
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
    echo -n "$icon$volume%"
}

# Mic status
get_mic() {
    if ! command -v wpctl &>/dev/null; then
        echo "N/A"
        return
    fi
    local mic_status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)
    if [[ "$mic_status" == *"[MUTED]"* ]]; then
        echo -n "󰍭"
    else
        echo -n "󰍬"
    fi
}

# Streamlined network status
get_net() {
    local wifi_icon="" ethernet_icon="" bluetooth_icon=""
    local has_wifi=0

    # Ethernet check (prioritize common interfaces)
    for path in /sys/class/net/e*; do
        iface=${path##*/}
        [[ "$iface" == "lo" ]] && continue
        if [[ -d "$path/wireless" ]]; then has_wifi=1; continue; fi
        state=$(cat "$path/operstate" 2>/dev/null)
        if [[ "$state" == "up" ]]; then
            ethernet_icon="󰈀"
            break
        fi
    done

    # Wi-Fi strength if available
    if [[ $has_wifi -eq 1 ]]; then
        wifi_strength=$(awk 'NR==3 {print int($3)}' /proc/net/wireless 2>/dev/null)
        if [[ -n "$wifi_strength" ]]; then
            if (( wifi_strength > 80 )); then wifi_icon="󰣺"
            elif (( wifi_strength > 60 )); then wifi_icon="󰣸"
            elif (( wifi_strength > 40 )); then wifi_icon="󰣶"
            elif (( wifi_strength > 20 )); then wifi_icon="󰣴"
            else wifi_icon="󰣾"
            fi
        elif command -v rfkill &>/dev/null && rfkill list wifi | grep -q 'Soft blocked: no'; then
            wifi_icon="󰣼"
        fi
    fi

    # Bluetooth if rfkill available
    if command -v rfkill &>/dev/null && rfkill list bluetooth | grep -q 'Soft blocked: no'; then
        bluetooth_icon=""
    fi

    if [[ -z "$wifi_icon$ethernet_icon$bluetooth_icon" ]]; then
        echo -n "󰀝"
    else
        echo -n "$bluetooth_icon$ethernet_icon$wifi_icon"
    fi
}

# Update and print if changed
update() {
    local CPU=$(get_cpu)
    local MEM=$(get_mem)
    local BAT=$(get_bat)
    local VOL=$(get_vol)
    local MIC=$(get_mic)
    local NET=$(get_net)
    local TIME=$(get_time)

    local new_output="$CPU $MEM |$BAT|$VOL|$MIC|$NET|$TIME"
    if [[ "$new_output" != "$prev_output" ]]; then
        echo "$new_output"
        prev_output="$new_output"
    fi
}

# Trap for updates
trap 'update' USR1

# Initial values
prev_output=""
update

# Background monitors
# Time: every minute
( while true; do
    sleep $((60 - $(date +%S) % 60))
    kill -USR1 $$
done ) &

# Audio (volume/mic) via pactl subscribe (PipeWire compatible)
( pactl subscribe 2>/dev/null | while read -r line; do
    if [[ "$line" =~ change.*(sink|source) ]]; then
        kill -USR1 $$
    fi
done ) &

# Battery via UPower dbus-monitor
if command -v dbus-monitor &>/dev/null; then
    ( dbus-monitor --system "type='signal',path='/org/freedesktop/UPower/devices/battery_BAT0',member='PropertiesChanged'" | while read -r; do
        kill -USR1 $$
    done ) &
else
    # Fallback poll every 30s if no dbus-monitor
    ( while true; do sleep 30; kill -USR1 $$; done ) &
fi

# Network via ip monitor
if command -v ip &>/dev/null; then
    ( ip monitor all 2>/dev/null | while read -r; do
        kill -USR1 $$
    done ) &
else
    # Fallback poll every 10s
    ( while true; do sleep 10; kill -USR1 $$; done ) &
fi

# For CPU/MEM periodic update (every 5s, optional for live stats)
#( while true; do sleep 5; kill -USR1 $$; done ) &

# Main loop: sleep forever, interrupted by traps
while true; do sleep 86400; done
