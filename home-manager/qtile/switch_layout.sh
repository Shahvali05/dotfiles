#!/bin/sh

# Переключение раскладки через setxkbmap
current_layout=$(cat /tmp/layout_status 2>/dev/null)

if [ "$current_layout" = "us" ]; then
    setxkbmap ru
    echo ru > ./layout_status
else
    setxkbmap us
    echo us > ./layout_status
fi
