#!/bin/bash

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${BASE_DIR}"

i3status -c "${BASE_DIR}/config" | while :
do
  read line
  echo "${line} $(${BASE_DIR}/battery_status.py) ▏$(${BASE_DIR}/today.py) $(${BASE_DIR}/global_time.sh)"
done
