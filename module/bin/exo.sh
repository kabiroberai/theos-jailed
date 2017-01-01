#!/bin/bash

source "$MESSAGES"

rm -rf "$STAGING_DIR"
mkdir -p "$EXO_STAGING_DIR"

log 1 "Copying dependencies"
cp "$DYLIB" "$EXO_STAGING_DIR"

copy_files=($EMBED_FRAMEWORKS $EMBED_LIBRARIES)

for file in "${copy_files[@]}"; do
	mkdir -p "$EXO_RESOURCES_DIR"
	cp -a "$file" "$EXO_RESOURCES_DIR"
done

if [[ -d $RESOURCES_DIR ]]; then
	log 1 "Copying resources"
	mkdir -p "$EXO_RESOURCES_DIR"
	cp -a "$RESOURCES_DIR"/ "$EXO_RESOURCES_DIR"
fi

log 2 "Packaging $EXO_OUTPUT_NAME"
cd "$STAGING_DIR"
zip -yqr$COMPRESSION "$EXO_OUTPUT_NAME" "$TWEAK_NAME"
if [[ $? != 0 ]]; then
	error "Failed to compress $EXO_OUTPUT_NAME"
fi
rm -f "$PACKAGES_DIR"/*.zip
mv "$EXO_OUTPUT_NAME" "$PACKAGES_DIR/"
