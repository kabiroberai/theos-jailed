#!/bin/bash

source "$MESSAGES"

rm -rf "$STAGING_DIR"
mkdir -p "$EXO_STAGING_DIR"

log 1 "Copying .dylib dependencies"
cp "$DYLIB" "$EXO_STAGING_DIR"

if [[ -d $RESOURCES_DIR ]]; then
	log 1 "Copying resources"
	mkdir "$EXO_RESOURCES_DIR"
	cp -a "$RESOURCES_DIR"/ "$EXO_RESOURCES_DIR"
fi

log 2 "Merging $EXO_OUTPUT_NAME"
cd "$STAGING_DIR"
zip -9r "$EXO_OUTPUT_NAME" "$TWEAK_NAME" &>/dev/null
if [[ $? != 0 ]]; then
	error "Failed to compress $EXO_OUTPUT_NAME"
fi
rm -f "$PACKAGES_DIR/$OUTPUT_NAME" &>/dev/null
mv "$EXO_OUTPUT_NAME" "$PACKAGES_DIR/"
