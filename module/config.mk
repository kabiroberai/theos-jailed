# Module paths
THEOS_JAILED_PATH = $(THEOS_MODULE_PATH)/jailed
THEOS_JAILED_BIN = $(THEOS_JAILED_PATH)/bin
THEOS_JAILED_LIB = $(THEOS_JAILED_PATH)/lib

# Shell scripts
export MESSAGES = $(THEOS_JAILED_BIN)/messages
export INIT = $(THEOS_JAILED_BIN)/init
export INFO_TEMPLATE = $(THEOS_JAILED_BIN)/info.txt

# Directories
export RESOURCES_DIR ?= Resources
export STAGING_DIR = $(THEOS_STAGING_DIR)
export PACKAGES_DIR = $(THEOS_PROJECT_DIR)/$(THEOS_PACKAGE_DIR_NAME)

# Resources
export IPA ?= $($(TWEAK_NAME)_IPA)
export DYLIB ?= $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib
export OUTPUT_NAME = $(TWEAK_NAME).ipa

# Codesigning
export DEV_CERT_NAME ?= iPhone Developer
export ENTITLEMENTS ?= $(STAGING_DIR)/entitlements.xml
export PROFILE ?= *

# Cycript
export USE_CYCRIPT := $(call __theos_bool,$(or $(USE_CYCRIPT),$(DEBUG)))
export CYCRIPT ?= $(THEOS_JAILED_LIB)/Cycript.dylib

# CydiaSubstrate
export USE_SUBSTRATE := $(call __theos_bool,$(or $($(TWEAK_NAME)_USE_SUBSTRATE),$(_THEOS_TARGET_DEFAULT_USE_SUBSTRATE),$(_THEOS_TRUE)))
export SUBSTRATE ?= $(THEOS_JAILED_LIB)/CydiaSubstrate.framework

# Miscellaneous
export TWEAK_NAME
