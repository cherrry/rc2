#!/bin/bash

TOUCHPAD=$(xinput list --name-only | grep Touchpad)

xinput --set-prop "${TOUCHPAD}" "libinput Tapping Enabled" 1
xinput --set-prop "${TOUCHPAD}" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "${TOUCHPAD}" "libinput Accel Speed" 0.6
xinput --set-button-map "${TOUCHPAD}" 1 1 3 4 5 6 7
