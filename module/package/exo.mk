ifeq ($(_THEOS_PACKAGE_FORMAT_LOADED),)
_THEOS_PACKAGE_FORMAT_LOADED := 1
endif

internal-package::
	$(ECHO_NOTHING)$(THEOS_JAILED_BIN)/exo.sh$(ECHO_END)

after-package:: __THEOS_LAST_PACKAGE_FILENAME = $(THEOS_PACKAGE_DIR)/$(EXO_OUTPUT_NAME)
