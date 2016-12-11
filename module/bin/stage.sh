#!/bin/bash

source "$MESSAGES"

if [[ ! -r $IPA ]]; then
	error "\"$IPA\" not found or not readable"
fi

log 1 "Unpacking $(basename "$IPA")"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"
unzip -q "$IPA" "Payload/*" -d "$STAGING_DIR"
if [[ $? != 0 ]]; then
	error "Failed to unzip \"$IPA\""
fi

app=$(basename "$STAGING_DIR"/Payload/*.app)
appdir="$STAGING_DIR/Payload/$app"
if [[ ! -d $appdir ]]; then
	error "\"$(basename "$IPA")\" does not contain an application"
fi
