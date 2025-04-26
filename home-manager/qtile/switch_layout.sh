#!/run/current-system/sw/bin/bash
CURRENT=$(wlrctl keyboard get-layout)
if [ "$CURRENT" = "us" ]; then
    wlrctl keyboard set-layout ru
else
    wlrctl keyboard set-layout us
fi
