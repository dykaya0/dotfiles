#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.config/scripts/bookmarks-menu"

[ -d "$SCRIPT_DIR" ] || {
    notify-send "Script directory not found" "$SCRIPT_DIR"
    exit 1
}

entries=""

while IFS= read -r script; do
    file=$(basename "$script")

    # Remove .sh, replace _ and - with spaces, capitalize words
    name=$(basename "$file" .sh | tr '_-' ' ' | sed 's/\b\(.\)/\u\1/g')

    # Pick an icon (greedy)
    case "$file" in
        *searchAndReplace*) icon="󰛔" ;;
        *searchSpecificSite*) icon="󰦄" ;;
        *search*) icon="" ;;
        *) icon="󰆍" ;;  # default script icon
    esac

    entries+="$icon  $name::$file"$'\n'
done < <(find "$SCRIPT_DIR" -maxdepth 1 \( -type f -o -type l \) -name "*.sh" | sort)

chosen=$(printf "%s" "$entries" | rofi -dmenu -i -p "Run script:")

[ -z "$chosen" ] && exit 0

script=$(printf "%s" "$chosen" | awk -F'::' '{print $2}')

exec "$SCRIPT_DIR/$script"

