#!/usr/bin/env bash
set -eu

CONF_FILE="./packages.conf"

TMP_INSTALLED="$(mktemp)"
TMP_LISTED="$(mktemp)"
TMP_MISSING="$(mktemp)"
TMP_OUT="$(mktemp)"

# Explicitly installed packages
pacman -Qe | awk '{print $1}' | sort -u > "$TMP_INSTALLED"

# All packages already listed in packages.conf
sed \
  -e 's/#.*//' \
  -e 's/[()]/ /g' \
  "$CONF_FILE" \
| awk '{for (i=1;i<=NF;i++) print $i}' \
| grep -E '^[a-zA-Z0-9@._+-]+$' \
| sort -u > "$TMP_LISTED"

# Installed but not listed
comm -23 "$TMP_INSTALLED" "$TMP_LISTED" > "$TMP_MISSING"

if [ ! -s "$TMP_MISSING" ]; then
  echo "No missing packages to add"
  rm -f "$TMP_INSTALLED" "$TMP_LISTED" "$TMP_MISSING" "$TMP_OUT"
  exit 0
fi

echo "Adding to EXTRA_PACKAGES:"
sed 's/^/  /' "$TMP_MISSING"

# Insert BEFORE the closing ')'
awk -v missing="$TMP_MISSING" '
BEGIN { in_extra = 0 }
{
  # Enter EXTRA_PACKAGES block
  if ($0 ~ /^EXTRA_PACKAGES=\(/) {
    in_extra = 1
    print
    next
  }

  # Closing parenthesis → insert packages BEFORE it
  if (in_extra && $0 ~ /^\)/) {
    while ((getline pkg < missing) > 0)
      print "  " pkg
    close(missing)
    in_extra = 0
    print
    next
  }

  print
}
' "$CONF_FILE" > "$TMP_OUT"

mv "$TMP_OUT" "$CONF_FILE"

rm -f "$TMP_INSTALLED" "$TMP_LISTED" "$TMP_MISSING"

echo "Done ✅"

