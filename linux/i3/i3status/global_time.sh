#!/bin/bash

format_time() {
  local timezone="$1"
  TZ="${timezone}" date "+%H:%M"
}

echo -n "🌏 HKG $(format_time "Asia/Hong_Kong")"
echo -n " "
echo -n "🌎 "
echo -n "$(format_time "America/Los_Angeles") / "
echo -n "$(format_time "America/New_York")"
echo -n " "
echo -n "🌍 $(format_time "Europe/Dublin")"
