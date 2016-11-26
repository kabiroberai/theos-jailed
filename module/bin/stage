#!/bin/bash

source "$MESSAGES" "$1"

codesign_name="$(security find-certificate -c "$DEV_CERT_NAME" login.keychain | grep alis | cut -f4 -d\" | cut -f1 -d\")"

if [[ $? != 0 ]]; then
	error "Failed to get codesign name"
fi

if [[ ! -r $PROFILE ]]; then
	bundleprofile="$(grep -Fl "<string>iOS Team Provisioning Profile: $PROFILE</string>" ~/Library/MobileDevice/Provisioning\ Profiles/* | head -1)"
	if [[ ! -r $bundleprofile ]]; then
		error "Failed to find profile for '$PROFILE'"
	fi
	PROFILE="$bundleprofile"
fi

if [[ ! -r $IPA ]]; then
	error "\"$IPA\" not found or not readable"
fi

log 1 "Unpacking $(basename "$IPA")"
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"
unzip -d "$STAGING_DIR" "$IPA" >/dev/null 2>&1
if [[ $? != 0 ]]; then
	error "Failed to unzip \"$IPA\""
fi

app="$(basename "$STAGING_DIR"/Payload/*.app)"
appdir="$STAGING_DIR/Payload/$app"
if [[ ! -d $appdir ]]; then
	error "\"$(basename "$IPA")\" does not contain an application"
fi

bundle_id="$(defaults read "$appdir/Info.plist" CFBundleIdentifier)-patched"
app_binary="$(defaults read "$appdir/Info.plist" CFBundleExecutable)"
