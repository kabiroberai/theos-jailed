# Module paths
THEOS_JAILED_PATH := $(THEOS_MODULE_PATH)/jailed
THEOS_JAILED_BIN := $(THEOS_JAILED_PATH)/bin
THEOS_JAILED_LIB := $(THEOS_JAILED_PATH)/lib

# Shell scripts
export MESSAGES := $(THEOS_JAILED_BIN)/messages.sh
export STAGE := $(THEOS_JAILED_BIN)/stage.sh
export INSERT_DYLIB := $(THEOS_JAILED_BIN)/insert_dylib
export INFO_TEMPLATE := $(THEOS_JAILED_BIN)/info.txt
export INFO_SCRIPT := $(THEOS_JAILED_BIN)/info.sh
export IPA_SCRIPT := $(THEOS_JAILED_BIN)/ipa.sh
export EXO_SCRIPT := $(THEOS_JAILED_BIN)/exo.sh
export INSTALL_SCRIPT := $(THEOS_JAILED_BIN)/install.sh
export UPDATE_SCRIPT := $(THEOS_JAILED_BIN)/update

# Directories
export RESOURCES_DIR ?= Resources
export STAGING_DIR = $(THEOS_STAGING_DIR)
export PACKAGES_DIR = $(THEOS_PROJECT_DIR)/$(THEOS_PACKAGE_DIR)

# Resources
export COPY_PATH ?= Frameworks
export IPA ?= $(strip $($(TWEAK_NAME)_IPA))
export DYLIB ?= $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib
export INJECT_DYLIBS = $($(TWEAK_NAME)_INJECT_DYLIBS)
export OUTPUT_NAME = $(TWEAK_NAME)$(_THEOS_INTERNAL_PACKAGE_VERSION).ipa
export EMBED_FRAMEWORKS = $(strip $($(TWEAK_NAME)_EMBED_FRAMEWORKS))
export EMBED_LIBRARIES = $(strip $($(TWEAK_NAME)_EMBED_LIBRARIES))

# Codesigning
export PROFILE ?= *
export PROFILE_FILE = $(STAGING_DIR)/profile.plist
export ENTITLEMENTS = $(STAGING_DIR)/entitlements.plist
export _CODESIGN_IPA = $(call __theos_bool,$(or $(CODESIGN_IPA),$(_THEOS_TRUE)))
export _EMBED_PROFILE = $(call __theos_bool,$(or $(EMBED_PROFILE),$(_THEOS_TRUE)))

# Cycript
export USE_CYCRIPT = $(call __theos_bool,$(or $($(TWEAK_NAME)_USE_CYCRIPT),$(DEBUG)))
export CYCRIPT ?= $(THEOS_JAILED_LIB)/Cycript.dylib

# FLEX
export USE_FLEX = $(call __theos_bool,$($(TWEAK_NAME)_USE_FLEX))
export FLEX ?= $(THEOS_JAILED_LIB)/FLEX.dylib

# Overlay
export USE_OVERLAY = $(call __theos_bool,$($(TWEAK_NAME)_USE_OVERLAY))
export OVERLAY ?= $(THEOS_JAILED_LIB)/Overlay.dylib

# CydiaSubstrate
export USE_SUBSTRATE = $(call __theos_bool,$(or $($(TWEAK_NAME)_USE_SUBSTRATE),$(_THEOS_TARGET_DEFAULT_USE_SUBSTRATE),$(_THEOS_TRUE)))
export SUBSTRATE ?= $(THEOS_JAILED_LIB)/CydiaSubstrate.framework
export STUB_SUBSTRATE_INSTALL_PATH = /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate
export SUBSTRATE_INSTALL_PATH = @rpath/CydiaSubstrate.framework/CydiaSubstrate

# Extensify Exo
export EXO_STAGING_DIR = $(STAGING_DIR)/$(TWEAK_NAME)
export EXO_RESOURCES_DIR = $(EXO_STAGING_DIR)/ExoResources
export EXO_OUTPUT_NAME = $(TWEAK_NAME)$(_THEOS_INTERNAL_PACKAGE_VERSION).zip

# Miscellaneous
export TWEAK_NAME BUNDLE_ID DEV_CERT_NAME DISPLAY_NAME PRINT_FORMAT_MAKING PRINT_FORMAT_STAGE PRINT_FORMAT_ERROR _THEOS_VERBOSE _THEOS_RSYNC_EXCLUDE_COMMANDLINE
