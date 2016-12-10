FINALPACKAGE = 1
MODULES += jailed
_THEOS_TARGET_DEFAULT_USE_SUBSTRATE = 0
MAKEFILE_LIST = Makefile

include $(THEOS)/makefiles/common.mk

after-all::
	@cp $(DYLIB) ../../module/lib
	@../../install
