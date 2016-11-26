#!/bin/bash

source "$STAGE"

# copy resources into the .app folder
if [[ -d $RESOURCES_DIR ]]; then
	log 2 "Copying resources"
	cp -a "$RESOURCES_DIR"/ "$appdir"
fi

# copy .dylib files into the .app folder
copy_files=("$DYLIB")
inject_files=("$DYLIB")
if [[ $USE_CYCRIPT = 1 ]]; then
	copy_files+=("$CYCRIPT")
	inject_files+=("$CYCRIPT")
fi
if [[ $USE_SUBSTRATE = 1 ]]; then
	copy_files+=("$SUBSTRATE")
fi

log 2 "Copying .dylib dependencies"
mkdir -p "$appdir/Frameworks"
for file in "${copy_files[@]}"; do
	cp -a "$file" "$appdir/Frameworks"
done

# inject the tweak .dylib and optionally Cycript
log 3 "Injecting .dylib dependencies"
for file in "${inject_files[@]}"; do
	optool install -c load -p "@executable_path/Frameworks/$(basename "$file")" -t "$appdir/$app_binary" >& /dev/null
	if [[ $? != 0 ]]; then
		error "Failed to inject $file into $app"
	fi
done

# generate the correct entitlements
log 4 "Generating entitlements"
profile_ent="$(strings "$PROFILE" | sed -e '1,/<key>Entitlements<\/key>/d' -e '/<\/dict>/,$d')"
cat <<XML > "$ENTITLEMENTS"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
$profile_ent
</dict>
</plist>
XML

# re-sign dependencies and the .app
log 5 "Codesigning frameworks"
for file in $(ls -1 "$appdir/Frameworks" 2>/dev/null); do
	codesign -fs "$codesign_name" "$appdir/Frameworks/$file" >& /dev/null
	if [[ $? != 0 ]]; then
		error "Codesign failed"
	fi
done

log 5 "Codesigning $app"
codesign -fs "$codesign_name" --deep --entitlements "$ENTITLEMENTS" "$appdir" 2>/dev/null
if [[ $? != 0 ]]; then
	error "Failed to sign $app with entitlements $ENTITLEMENTS"
fi

# repack the .ipa
log 6 "Repacking $app"
cd "$STAGING_DIR"
zip -9r "$OUTPUT_NAME" Payload/ >/dev/null 2>&1
if [[ $? != 0 ]]; then
	error "Failed to compress the app into a .ipa file"
fi
rm -f "$PACKAGES_DIR/$OUTPUT_NAME" >/dev/null 2>&1
mv "$OUTPUT_NAME" "$PACKAGES_DIR/"
