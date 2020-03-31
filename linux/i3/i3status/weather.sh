#!/bin/bash

CACHE="/tmp/weather"
touch "${CACHE}"

LOCATION="Hong_Kong"
WEATHER=$(curl -s "https://wttr.in/${LOCATION}?m&format=%c+%t+%h" || cat "${CACHE}")
echo "${WEATHER}" | tee "${CACHE}" | sed "s/+//"
