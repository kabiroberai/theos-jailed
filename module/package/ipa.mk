ifeq ($(_THEOS_PACKAGE_FORMAT_LOADED),)
_THEOS_PACKAGE_FORMAT_LOADED := 1

ifneq ($(call __executable,optool),$(_THEOS_TRUE))
internal-package-check::
	@$(PRINT_FORMAT_ERROR) "$(MAKE) requires optool: https://github.com/alexzielenski/optool" >&2; exit 1
endif

internal-package::
	$(ECHO_NOTHING)"$(IPA_SCRIPT)"$(ECHO_END)

after-package:: __THEOS_LAST_PACKAGE_FILENAME = $(THEOS_PACKAGE_DIR)/$(OUTPUT_NAME)
endif
