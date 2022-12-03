#!/bin/bash

day=${1:-$(printf "" | dmenu -p 'enter date ([yy]dd):')}

[[ $day ]] || {
  >&2 echo "[ERROR] no day selected"
  exit 1
}

year=22

[[ ${#day} -gt 2 ]] && {
  year=${day:0:2}
  day=${day:2}
}

_this_dir=$(dirname "$(readlink -f "$0")")

new_file="$_this_dir/${year}_$(printf '%02d' "$day").html"
url=$(printf 'adventofcode.com/20%s/day/%s' "$year" "$day")

[[ -f $new_file ]] || {
  printf '<a href=https://%s>%s</a><br>\n' "$url" "$url" > "$new_file"
  cat "$_this_dir/_boilerplate.html" >> "$new_file"
}

sublaunch "$new_file"
browser "https://$url/input"
browser "https://$url"
browser "$new_file"
