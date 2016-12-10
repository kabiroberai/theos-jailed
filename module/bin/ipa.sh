#!/bin/bash

source "$STAGE"

# copy resources into the .app folder
if [[ -d $RESOURCES_DIR ]]; then
	log 2 "Copying resources"
	rsync -a "$RESOURCES_DIR"/ "$appdir" --exclude "/Info.plist"
	if [[ -f "$RESOURCES_DIR/Info.plist" ]]; then
		log 2 "Merging Info.plist"
		cp "$RESOURCES_DIR/Info.plist" "$STAGING_DIR"
		/usr/libexec/PlistBuddy -c "Merge $appdir/Info.plist" "$STAGING_DIR/Info.plist" &>/dev/null
		mv "$STAGING_DIR/Info.plist" "$appdir"
	fi
fi

# copy .dylib files
log 2 "Copying dependencies"
inject_files=("$DYLIB" $ADDITIONAL_DYLIBS)
[[ $USE_CYCRIPT = 1 ]] && inject_files+=("$CYCRIPT")
[[ $USE_FLEX = 1 ]] && inject_files+=("$FLEX")
[[ $USE_SUBSTRATE = 1 ]] && copy_files+=("$SUBSTRATE")

mkdir -p "$appdir/$COPY_PATH"
for file in "${inject_files[@]}" "${copy_files[@]}"; do
	cp -a "$file" "$appdir/$COPY_PATH"
done

# inject the tweak .dylib and optionally Cycript
log 3 "Injecting dependencies"
app_binary="$appdir/$(/usr/libexec/PlistBuddy -c "Print :CFBundleExecutable" "$appdir/Info.plist")"
install_name_tool -add_rpath "@executable_path/$COPY_PATH" "$app_binary" &>/dev/null
for file in "${inject_files[@]}"; do
	"$INSERT_DYLIB" --inplace --all-yes "@rpath/$(basename "$file")" "$app_binary" &>/dev/null
	if [[ $? != 0 ]]; then
		error "Failed to inject $(basename "$file") into $app"
	fi
done

# re-sign dependencies and the .app
log 4 "Signing $app"
entitlements=$(/usr/libexec/PlistBuddy -x -c "Print :Entitlements" /dev/stdin <<< $(security cms -Di "$PROFILE" 2>/dev/null))
if [[ $? != 0 ]]; then
	error "Failed to generate entitlements"
fi

find "$appdir" \( -name "*.framework" -or -name "*.dylib" \) -not -path "*.framework/*" -print0 | xargs -0 codesign -fs "$codesign_name" &>/dev/null
if [[ $? != 0 ]]; then
	error "Codesign failed"
fi

codesign -fs "$codesign_name" --deep --entitlements /dev/stdin "$appdir" <<< "$entitlements"
if [[ $? != 0 ]]; then
	error "Failed to sign $app"
fi

# repack the .ipa
log 4 "Repacking $app"
cd "$STAGING_DIR"
zip -9r "$OUTPUT_NAME" Payload/ &>/dev/null
if [[ $? != 0 ]]; then
	error "Failed to compress the app into a .ipa file"
fi
rm -f "$PACKAGES_DIR"/*.ipa &>/dev/null
mv "$OUTPUT_NAME" "$PACKAGES_DIR/"
