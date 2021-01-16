ifneq ($(call __executable,ios-deploy),$(_THEOS_TRUE))
internal-install::
	@$(PRINT_FORMAT_ERROR) "$(MAKE) requires ios-deploy: https://github.com/phonegap/ios-deploy#installation" >&2; exit 1
endif

internal-install::
	$(ECHO_NOTHING)"$(INSTALL_SCRIPT)"$(ECHO_END)
