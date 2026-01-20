#!/bin/sh
set -eu

# Files
PERS_FILE="${PERS_FILE:-$HOME/.config/bookmarks/search/personal.txt}"
WORK_FILE="${WORK_FILE:-$HOME/.config/bookmarks/search/work.txt}"

ROFI="rofi -dmenu -p 'Sites:'"

LIBREWOLF="$(command -v librewolf || true)"
QUTEBROWSER="$(command -v qutebrowser || true)"
FALLBACK="$(command -v xdg-open || echo librewolf)"

emit() {
  tag="$1"; file="$2"
  [ -f "$file" ] || return 0
  grep -vE '^\s*(#|$)' "$file" | while IFS= read -r line; do
    case "$line" in
      *"::"*)
        lhs="${line%%::*}"
        rhs="${line#*::}"
        lhs="$(printf '%s' "$lhs" | sed 's/[[:space:]]*$//')"
        rhs="$(printf '%s' "$rhs" | sed 's/^[[:space:]]*//')"
        printf '[%s] %s :: %s\n' "$tag" "$lhs" "$rhs"
        ;;
    esac
  done
}

choice="$({
  emit personal "$PERS_FILE"
  emit work "$WORK_FILE"
} | sort | eval "$ROFI" || true)"

[ -n "$choice" ] || exit 0

tag="${choice%%]*}"; tag="${tag#\[}"
raw="${choice##* :: }"

# Extract domain
domain="$(printf '%s' "$raw" \
  | sed -E 's#^[a-z]+://##; s#/.*##; s/^www\.//')"

# Ask for search query
query="$(printf '' | rofi -dmenu -p 'Search:' || true)"
[ -n "$query" ] || exit 0

search="https://duckduckgo.com/?q=$(printf '%s site:%s' "$query" "$domain" | jq -s -R -r @uri)"

open_personal() {
  [ -n "$LIBREWOLF" ] && nohup "$LIBREWOLF" --new-tab "$search" >/dev/null 2>&1 &
}

open_work() {
  [ -n "$QUTEBROWSER" ] && nohup "$QUTEBROWSER" "$search" >/dev/null 2>&1 &
}

case "$tag" in
  personal) open_personal ;;
  work)     open_work ;;
  *)        nohup $FALLBACK "$search" >/dev/null 2>&1 & ;;
esac

