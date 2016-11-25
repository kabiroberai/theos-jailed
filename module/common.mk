include $(THEOS_MODULE_PATH)/jailed/config.mk

# Add jailed/lib to THEOS_LIBRARY_PATH to override stub CydiaSubstrate
THEOS_LIBRARY_PATH += -F$(THEOS_JAILED_LIB)

# Use libc++ by default - for libstdc++ use TWEAK_NAME_LDFLAGS += -stdlib=libstdc++
_THEOS_INTERNAL_LDFLAGS += -stdlib=libc++

# Don't require TWEAK_NAME.plist
$(TWEAK_NAME)_INSTALL = 0

ifeq ($(call __theos_bool,$(USE_FISHHOOK)),$(_THEOS_TRUE))
$(TWEAK_NAME)_FILES += $(THEOS_JAILED_LIB)/fishhook/fishhook.c
$(TWEAK_NAME)_CFLAGS += -I$(THEOS_JAILED_LIB)/fishhook
endif
