ifneq ($(call __executable,ios-deploy),$(_THEOS_TRUE))
internal-install-check::
	@$(PRINT_FORMAT_ERROR) "$(MAKE) requires ios-deploy: https://github.com/phonegap/ios-deploy#installation" >&2; exit 1
endif

internal-install:: internal-install-check
	$(ECHO_NOTHING)IPA="$(_THEOS_PACKAGE_LAST_FILENAME)" "$(INSTALL_SCRIPT)"$(ECHO_END)
