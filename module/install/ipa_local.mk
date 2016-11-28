ifeq ($(call __theos_bool,$(LLDB)),$(_THEOS_TRUE))
THEOS_DEPLOY_FLAG = d
else
THEOS_DEPLOY_FLAG = L
endif

ifneq ($(call __executable,ios-deploy),$(_THEOS_TRUE))
internal-install-check::
	@$(PRINT_FORMAT_ERROR) "$(MAKE) requires ios-deploy: https://github.com/phonegap/ios-deploy#installation" >&2; exit 1
endif

internal-install:: internal-install-check
	$(ECHO_INSTALLING)IPA="$(_THEOS_PACKAGE_LAST_FILENAME)" source "$(STAGE)";ios-deploy -$(THEOS_DEPLOY_FLAG)Wb "$$appdir"$(ECHO_END)
