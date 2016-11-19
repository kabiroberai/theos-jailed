# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Use the internal generator instead of CydiaSubstrate
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE := 0

# Use libc++ by default
_THEOS_INTERNAL_LDFLAGS += -stdlib=libc++

ifeq ($(call __theos_bool,$(USE_FISHHOOK)),$(_THEOS_TRUE))
$(TWEAK_NAME)_FILES += $(THEOS_MODULE_PATH)/jailed/fishhook/fishhook.c
$(TWEAK_NAME)_CFLAGS += -I$(THEOS_MODULE_PATH)/jailed/fishhook
endif

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MODULE_PATH)/jailed/rules.mk
