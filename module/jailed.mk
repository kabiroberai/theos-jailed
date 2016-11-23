include $(THEOS_MODULE_PATH)/jailed/config.mk

# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Add jailed/lib to THEOS_LIBRARY_PATH to override stub CydiaSubstrate
THEOS_LIBRARY_PATH += -F$(THEOS_JAILED_LIB)

# Use libc++ by default - for libstdc++ use LDFLAGS += -stdlib=libstdc++
_THEOS_INTERNAL_LDFLAGS += -stdlib=libc++

ifeq ($(call __theos_bool,$(USE_FISHHOOK)),$(_THEOS_TRUE))
$(TWEAK_NAME)_FILES += $(THEOS_JAILED_LIB)/fishhook/fishhook.c
$(TWEAK_NAME)_CFLAGS += -I$(THEOS_JAILED_LIB)/fishhook
endif

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_JAILED_PATH)/rules.mk
