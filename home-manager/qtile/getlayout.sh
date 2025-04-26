#!/bin/sh

layout=$(cat ./layout_status 2>/dev/null)

if [ "$layout" = "ru" ]; then
    echo "[🇷🇺]"
else
    echo "[🇺🇸]"
fi
