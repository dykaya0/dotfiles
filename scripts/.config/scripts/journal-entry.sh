#!/usr/bin/env bash

BASE_DIR="$HOME/notes/journal"
JOURNAL_NAME=$(date +%Y-%m-%d)
JOURNAL_DIR="$BASE_DIR/$JOURNAL_NAME"

mkdir -p "$JOURNAL_DIR" || {
    echo "Error: Failed to create directory $JOURNAL_DIR" >&2
    exit 1
}

TEMPLATE_FILE="$BASE_DIR/TEMPLATE.md"

# Check if the template file exists
if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: Template file $TEMPLATE_FILE does not exist" >&2
    exit 1
fi

# Copy the template file to the new journal directory
if cp -r "$TEMPLATE_FILE" "$JOURNAL_DIR/quicknote.md"; then
    echo "quicknote.md > $JOURNAL_DIR"
else
    echo "Error: Failed to copy $TEMPLATE_FILE to $JOURNAL_DIR" >&2
    exit 1
fi
