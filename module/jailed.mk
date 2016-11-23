# Set THEOS_JAILED_PATH to the current directory
export THEOS_JAILED_PATH = $(THEOS_MODULE_PATH)/jailed

# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Add jailed/lib to THEOS_LIBRARY_PATH to override stub CydiaSubstrate
THEOS_LIBRARY_PATH += -F$(THEOS_MODULE_PATH)/jailed/lib

# Use libc++ by default - for libstdc++ use LDFLAGS += -stdlib=libstdc++
_THEOS_INTERNAL_LDFLAGS += -stdlib=libc++

ifeq ($(call __theos_bool,$(USE_FISHHOOK)),$(_THEOS_TRUE))
$(TWEAK_NAME)_FILES += $(THEOS_JAILED_PATH)/lib/fishhook/fishhook.c
$(TWEAK_NAME)_CFLAGS += -I$(THEOS_JAILED_PATH)/lib/fishhook
endif

include $(THEOS_JAILED_PATH)/config.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_JAILED_PATH)/rules.mk
