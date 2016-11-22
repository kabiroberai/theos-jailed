# Shell scripts
THEOS_JAILED_BIN = $(THEOS_JAILED_PATH)/bin
export MESSAGES = $(THEOS_JAILED_BIN)/messages
export SETUP_ENVIRONMENT = $(THEOS_JAILED_BIN)/setup-environment

# Directories
export RESOURCES_DIR ?= Resources
export STAGING_DIR = $(_THEOS_LOCAL_DATA_DIR)/jailed
export PACKAGES_DIR = $(THEOS_PROJECT_DIR)/$(THEOS_PACKAGE_DIR_NAME)

# Resources
export IPA ?= $($(TWEAK_NAME)_IPA)
export DYLIB ?= $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib

# Codesigning
export DEV_CERT_NAME ?= iPhone Developer
export ENTITLEMENTS ?= $(STAGING_DIR)/entitlements.xml
export PROFILE ?= *

# Cycript
USE_CYCRIPT ?= $(DEBUG)
export USE_CYCRIPT := $(call __theos_bool,$(USE_CYCRIPT))
export CYCRIPT ?= $(THEOS_JAILED_PATH)/lib/Cycript.dylib

# Miscellaneous
export TWEAK_NAME
