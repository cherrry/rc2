#!/bin/bash

CACHE="/tmp/weather"
touch "${CACHE}"

LOCATION="Hong_Kong"
WEATHER=$(curl -m 10 -s "https://wttr.in/${LOCATION}?m&format=%c+%t+%h" || cat "${CACHE}")
echo "${WEATHER:0:15}" | tee "${CACHE}" | sed "s/+//"
