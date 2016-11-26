# Add jailed/lib to THEOS_LIBRARY_PATH to override stub CydiaSubstrate
THEOS_LIBRARY_PATH += -F$(THEOS_JAILED_LIB)

# Use libc++ by default - for libstdc++ use TWEAK_NAME_LDFLAGS += -stdlib=libstdc++
_THEOS_INTERNAL_LDFLAGS += -stdlib=libc++

ifeq ($(call __theos_bool,$(or $(USE_FISHHOOK),$($(THEOS_CURRENT_INSTANCE)_USE_FISHHOOK))),$(_THEOS_TRUE))
__ALL_FILES += $(THEOS_JAILED_LIB)/fishhook/fishhook.c
_THEOS_INTERNAL_CFLAGS += -I$(THEOS_JAILED_LIB)/fishhook
endif
