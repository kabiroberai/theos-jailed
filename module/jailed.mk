# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Use the internal generator instead of CydiaSubstrate
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE := 0

# Add Cycript
CYPORT ?= 0
ifneq ($(CYPORT),0)
	_THEOS_INTERNAL_LDFLAGS += -F. -lsqlite3 -lc++ -framework JavaScriptCore -framework Cycript
	CFLAGS += -F. -DCYPORT=$(CYPORT)
endif

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MODULE_PATH)/jailed/rules.mk
