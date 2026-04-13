#!/bin/sh

# Feed script a url or file location.
# If an image, it will view in nsxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

if [ -z "$1" ]; then
    exit 1
else
	url="$1"
fi

notify-send --expire-time=1500 "Processing URL..."
case "$url" in
	*png|*jpg|*jpe|*jpeg|*gif|*webp|*jxl)
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && nsxiv -a "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*)
		[ -f "$url" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$url" >/dev/null 2>&1 || setsid -f "$BROWSER" "$url" >/dev/null 2>&1
esac
