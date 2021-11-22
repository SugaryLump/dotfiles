#!/bin/bash
# showVolume

# Arbitrary but unique message id
msgId="991049"

# Change the volume using alsa(might differ if you use pulseaudio)
#amixer set Master "$@"

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(amixer get Master | tail -1 | awk '{print $4}' | sed 's/[^0-9]*//g')"
mute="$(amixer get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
if [[ $volume == 0 || "$mute" == "off" ]]; then
    # Show the sound muted notification
    dunstify -a "Volume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "Volume" -u low -i audio-volume-high -r "$msgId" \
    "Volume: ${volume}%"
fi

# Play the volume changed sound
# canberra-gtk-play -i audio-volume-change -d "changeVolume"
