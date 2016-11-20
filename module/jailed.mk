# Set THEOS_JAILED_PATH to the current directory
THEOS_JAILED_PATH = $(THEOS_MODULE_PATH)/jailed

# Disable codesigning (we'll sign the dylib later)
TARGET_CODESIGN =

# Use the internal generator instead of CydiaSubstrate
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE := 0

# Use libc++ by default
_THEOS_INTERNAL_LDFLAGS += -stdlib=libc++

# Use Xcode's iOS Wildcard App ID by default
PROFILE ?= *

# Truthy USE_CYCRIPT
_THEOS_USE_CYCRIPT := $(call __theos_bool,$(USE_CYCRIPT))

ifeq ($(call __theos_bool,$(USE_FISHHOOK)),$(_THEOS_TRUE))
$(TWEAK_NAME)_FILES += $(THEOS_JAILED_PATH)/lib/fishhook/fishhook.c
$(TWEAK_NAME)_CFLAGS += -I$(THEOS_JAILED_PATH)/lib/fishhook
endif

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_JAILED_PATH)/rules.mk
