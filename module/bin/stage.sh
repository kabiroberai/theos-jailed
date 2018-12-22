#!/bin/bash

source "$MESSAGES"

if [[ ! -r $IPA ]]; then
	error "\"$IPA\" not found or not readable"
fi

rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

if [[ -d "$IPA" ]]; then
	# probably .app file
	mkdir -p "$STAGING_DIR/Payload"
	cp -a "$IPA" "$STAGING_DIR/Payload"
else
	log 1 "Unpacking $(basename "$IPA")"
	unzip -q "$IPA" "Payload/*" -d "$STAGING_DIR"
	if [[ $? != 0 ]]; then
		error "Failed to unzip \"$IPA\""
	fi
fi

app=$(basename "$STAGING_DIR"/Payload/*.app)
appdir="$STAGING_DIR/Payload/$app"
if [[ ! -d $appdir ]]; then
	error "\"$(basename "$IPA")\" does not contain an application"
fi

info_plist="$appdir/Info.plist"
app_bundle_id=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$info_plist")
