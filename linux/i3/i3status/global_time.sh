#!/bin/bash

format_time() {
  local timezone="$1"
  TZ="${timezone}" date "+%H:%M"
}

echo -n "🌏 HKG $(format_time "Asia/Hong_Kong")"
echo -n " "
echo -n "🌎 MTV $(format_time "America/Los_Angeles")"
echo -n " "
echo -n "🌍 DUB $(format_time "Europe/Dublin")"
