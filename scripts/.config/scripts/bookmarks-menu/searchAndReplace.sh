#!/bin/sh
set -eu

# Files
# Put your files in .config/bookmarks/.
PERS_FILE="${PERS_FILE:-$HOME/.config/bookmarks/searchandreplace/personal.txt}"
WORK_FILE="${WORK_FILE:-$HOME/.config/bookmarks/searchandreplace/work.txt}"

# Rofi command
ROFI="rofi -dmenu -p 'Bookmarks(Replace):'"

# Browsers
# Choose your browsers accordingly
LIBREWOLF="$(command -v librewolf || true)"
QUTEBROWSER="$(command -v qutebrowser || true)"
FALLBACK="$(command -v xdg-open || echo librewolf)"

# Ensure files exist
mkdir -p "$(dirname "$PERS_FILE")"
[ -f "$PERS_FILE" ] || cat >"$PERS_FILE" <<'EOF'
# personal
tonybtw :: https://tonybtw.com
https://youtube.com
EOF
[ -f "$WORK_FILE" ] || cat >"$WORK_FILE" <<'EOF'
# work
[docs] NixOS Manual :: https://nixos.org/manual/
EOF

emit() {
  tag="$1"; file="$2"
  [ -f "$file" ] || return 0
  # Output: "[tag] <display> :: <url or raw>"
  # We keep the whole line after '::' as the raw RHS, or the entire line if no '::'
  grep -vE '^\s*(#|$)' "$file" | while IFS= read -r line; do
    case "$line" in
      *"::"*)
        lhs="${line%%::*}"; rhs="${line#*::}"
        lhs="$(printf '%s' "$lhs" | sed 's/[[:space:]]*$//')"
        rhs="$(printf '%s' "$rhs" | sed 's/^[[:space:]]*//')"
        printf '[%s] %s :: %s\n' "$tag" "$lhs" "$rhs"
        ;;
      *)
        printf '[%s] %s :: %s\n' "$tag" "$line" "$line"
        ;;
    esac
  done
}

# Build combined list
choice="$({
  emit personal "$PERS_FILE"
  emit work     "$WORK_FILE"
} | sort | eval "$ROFI" || true)"

[ -n "$choice" ] || exit 0

# Parse tag and raw URL
tag="${choice%%]*}"; tag="${tag#\[}"
raw="${choice##* :: }"

# Strip inline comments and trim
raw="$(printf '%s' "$raw" \
  | sed -e 's/[[:space:]]\+#.*$//' -e 's/[[:space:]]\/\/.*$//' \
        -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

# Ensure scheme
case "$raw" in
  http://*|https://*|file://*|about:*|chrome:*) url="$raw" ;;
  *) url="https://$raw" ;;
esac

# Pick browser by tag and focus.
open_with_personal() {
  cmd="$1"
  if [ -n "$cmd" ]; then
    nohup "$cmd" --new-tab "$url" >/dev/null 2>&1 & \
    hyprctl dispatch focuswindow class:librewolf ; \
    exit 0
  fi
}

open_with_work() {
  cmd="$1"
  if [ -n "$cmd" ]; then
    nohup "$cmd" "$url" >/dev/null 2>&1 & \
    hyprctl dispatch focuswindow class:org.qutebrowser.qutebrowser ; \
    exit 0
  fi
}

urlencode() {
  # POSIX-safe URL encoder
  printf '%s' "$1" | jq -s -R -r @uri
}

# Detect search template
if printf '%s' "$url" | grep -q '{{}}'; then
  query="$(printf '' | rofi -dmenu -p 'Search:' || true)"
  [ -n "$query" ] || exit 0
  encoded="$(urlencode "$query")"
  url="${url//\{\{\}\}/$encoded}"
fi

case "$tag" in
  personal) open_with_personal "$LIBREWOLF" ;;
  work)     open_with_work "$QUTEBROWSER" ;;
esac

# Fallback if specific browser not found
nohup $FALLBACK "$url" >/dev/null 2>&1 &

