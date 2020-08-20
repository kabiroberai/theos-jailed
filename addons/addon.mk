FINALPACKAGE = 1
MODULES = jailed
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE = 0
MAKEFILE_LIST = Makefile

# Omit arm64e for now, as it isn't ABI stable yet
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

after-all::
	@cp $(DYLIB) ../../module/lib
	@../../install
