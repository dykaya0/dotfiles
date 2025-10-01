#!/usr/bin/env bash

DMBROWSER="zen-browser"

declare -a options=(
    "google - https://www.google.com/search?q="
    "qwant - https://www.qwant.com/?q="
    "wikipedia - https://en.wikipedia.org/w/index.php?search="
    "wiktionary - https://en.wiktionary.org/w/index.php?search="
    "reddit - https://www.reddit.com/search/?q="
    "youtube - https://www.youtube.com/results?search_query="
    "archaur - https://aur.archlinux.org/packages/?O=0&K="
    "archwiki - https://wiki.archlinux.org/index.php?search="
    "github - https://github.com/search?q="
    "stackoverflow - https://stackoverflow.com/search?q="
)

while [ -z "$engine" ];
 do
 enginelist=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 8 -p 'Choose search engine: ' )|| exit
 engineurl=$(echo "$enginelist" | awk '{print $NF}')
 engine=$(echo "$enginelist" | awk '{print $1}')
done

while [ -z "$query" ]; 
 do
 query=$(rofi -dmenu -i -l 1 -p "Searching on $engine: ") || exit
done

$DMBROWSER "$engineurl""$query"


