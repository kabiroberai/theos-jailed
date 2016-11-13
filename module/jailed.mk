# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Use the internal generator instead of CydiaSubstrate
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE = 0

include $(THEOS_MAKE_PATH)/tweak.mk

# Symlink dylib to product/dylib
internal-tweak-all_::
	$(ECHO_NOTHING)ln -fs "$(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).dylib" "$(_THEOS_LOCAL_DATA_DIR)/latest.dylib"$(ECHO_END)
