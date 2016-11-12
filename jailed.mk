# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Prioritise the lib directory over THEOS_VENDOR_LIBRARY_PATH
THEOS_LIBRARY_PATH += -Llib

# Use the internal generator instead of CydiaSubstrate
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE = 0

include $(THEOS_MAKE_PATH)/tweak.mk
