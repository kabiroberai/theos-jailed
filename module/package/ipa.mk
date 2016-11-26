ifeq ($(_THEOS_PACKAGE_FORMAT_LOADED),)
_THEOS_PACKAGE_FORMAT_LOADED := 1
endif

ifeq ($(shell command -v optool 2> /dev/null),)
internal-package-check::
	@$(PRINT_FORMAT_ERROR) "Install optool and add it to your PATH: https://github.com/alexzielenski/optool" >&2; exit 1
endif

internal-package::
	$(ECHO_NOTHING)$(THEOS_JAILED_BIN)/ipa.sh$(ECHO_END)

after-package:: __THEOS_LAST_PACKAGE_FILENAME = $(THEOS_PACKAGE_DIR)/$(OUTPUT_NAME)
