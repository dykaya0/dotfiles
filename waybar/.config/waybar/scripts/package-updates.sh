#!/usr/bin/env bash

tmpfile=$(mktemp)

# Get repo updates
checkupdates 2>/dev/null > "$tmpfile"

# Get AUR updates
paru -Qu 2>/dev/null >> "$tmpfile"

updates=$(cat "$tmpfile")
count=$(wc -l < "$tmpfile")

rm -f "$tmpfile"

if [ "$count" -eq 0 ]; then
  jq -cn '{"text":"","tooltip":"System is up to date"}'

elif [ "$count" -lt 15 ]; then
  jq -cn --arg u "$updates" --arg c "$count" \
    '{"text":" \($c)","class":"low","tooltip":$u}'

elif [ "$count" -lt 50 ]; then
  jq -cn --arg u "$updates" --arg c "$count" \
    '{"text":" \($c)","class":"mid","tooltip":$u}'

else
  jq -cn --arg u "$updates" --arg c "$count" \
    '{"text":" \($c)","class":"high","tooltip":$u}'
fi

