#!/bin/bash

volume=$(wpctl get-volume @DEFAULT_SINK@)

case "$volume" in
*MUTED*) mute='MUTED ' ;;
esac

volume=${volume%% \[MUTED\]}

case "$volume" in
*0.0*) volume="${volume##* 0.0}" ;;
*0.*) volume="${volume##* 0.}" ;;
*1.*) volume="${volume##* }" && volume="${volume//./}" ;;
esac

# notify-send \
#   -h int:value:$volume \
#   -h string:x-canonical-private-synchronous:volume_notif \
#   -u low \
#   -t 2000 \
#   "${mute}${volume}"
