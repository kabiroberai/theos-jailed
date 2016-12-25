#!/bin/bash

source "$STAGE"

if [[ -d $RESOURCES_DIR ]]; then
	log 2 "Copying resources"
	rsync -a "$RESOURCES_DIR"/ "$appdir" --exclude "/Info.plist"
fi

if [[ -n $BUNDLE_ID ]]; then
	log 2 "Setting bundle ID"
	/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BUNDLE_ID" "$info_plist"
fi

if [[ -n $DISPLAY_NAME ]]; then
	log 2 "Setting display name"
	/usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string" "$info_plist" 
	/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $DISPLAY_NAME" "$info_plist" 
fi

if [[ -f $RESOURCES_DIR/Info.plist ]]; then
	log 2 "Merging Info.plist"
	cp "$RESOURCES_DIR/Info.plist" "$STAGING_DIR"
	/usr/libexec/PlistBuddy -c "Merge $info_plist" "$STAGING_DIR/Info.plist"
	mv "$STAGING_DIR/Info.plist" "$appdir"
fi

log 2 "Copying dependencies"
inject_files=("$DYLIB" $ADDITIONAL_DYLIBS)
[[ $USE_CYCRIPT = 1 ]] && inject_files+=("$CYCRIPT")
[[ $USE_FLEX = 1 ]] && inject_files+=("$FLEX")
[[ $USE_SUBSTRATE = 1 ]] && copy_files+=("$SUBSTRATE")

mkdir -p "$appdir/$COPY_PATH"
for file in "${inject_files[@]}" "${copy_files[@]}"; do
	cp -a "$file" "$appdir/$COPY_PATH"
done

log 3 "Injecting dependencies"
app_binary="$appdir/$(/usr/libexec/PlistBuddy -c "Print :CFBundleExecutable" "$info_plist")"
install_name_tool -add_rpath "@executable_path/$COPY_PATH" "$app_binary"
for file in "${inject_files[@]}"; do
	"$INSERT_DYLIB" --inplace --all-yes "@rpath/$(basename "$file")" "$app_binary"
	if [[ $? != 0 ]]; then
		error "Failed to inject $(basename "$file") into $app"
	fi
done

if [[ $_CODESIGN_IPA = 1 ]]; then
	log 4 "Signing $app"
	codesign_name=$(security find-certificate -c "$DEV_CERT_NAME" login.keychain | grep alis | cut -f4 -d\" | cut -f1 -d\")
	if [[ $? != 0 ]]; then
		error "Failed to get codesign name"
	fi
	
	if [[ ! -r $PROFILE ]]; then
		bundleprofile=$(grep -Fl "<string>iOS Team Provisioning Profile: $PROFILE</string>" ~/Library/MobileDevice/Provisioning\ Profiles/* | head -1)
		if [[ ! -r $bundleprofile ]]; then
			error "Failed to find profile for '$PROFILE'"
		fi
		PROFILE="$bundleprofile"
	fi
	
	profile=$(security cms -Di "$PROFILE")
	if [[ $? != 0 ]]; then
		error "Failed to generate entitlements"
	fi
	
	entitlements=$(/usr/libexec/PlistBuddy -x -c "Print :Entitlements" /dev/stdin <<< "$profile")
	if [[ $? != 0 ]]; then
		error "Failed to generate entitlements"
	fi
	
	find "$appdir" \( -name "*.framework" -or -name "*.dylib" -or -name "*.appex" \) -not -path "*.framework/*" -print0 | xargs -0 codesign -fs "$codesign_name"
	if [[ $? != 0 ]]; then
		error "Codesign failed"
	fi
	
	codesign -fs "$codesign_name" --deep --entitlements /dev/stdin "$appdir" <<< "$entitlements"
	if [[ $? != 0 ]]; then
		error "Failed to sign $app"
	fi
fi

log 4 "Repacking $app"
cd "$STAGING_DIR"
zip -yqr$COMPRESSION "$OUTPUT_NAME" Payload/
if [[ $? != 0 ]]; then
	error "Failed to repack $app"
fi
rm -f "$PACKAGES_DIR"/*.ipa
mv "$OUTPUT_NAME" "$PACKAGES_DIR/"
