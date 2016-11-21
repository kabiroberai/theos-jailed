export IPA ?= $($(TWEAK_NAME)_IPA)
export DYLIB ?= $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib

export CYCRIPT ?= $(THEOS_JAILED_PATH)/lib/Cycript.dylib
export USE_CYCRIPT := $(call __theos_bool,$(USE_CYCRIPT))

export DEV_CERT_NAME ?= iPhone Developer
export ENTITLEMENTS ?= .entitlements.xml
export PROFILE ?= *

export RESDIR ?= Resources
export STAGING_DIR ?= .patchapp.cache
export PACKAGES_DIR ?= .
