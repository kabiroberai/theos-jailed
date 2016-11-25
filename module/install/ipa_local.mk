ifeq ($(call __theos_bool,$(LLDB)),$(_THEOS_TRUE))
THEOS_DEPLOY_FLAG = d
else
THEOS_DEPLOY_FLAG = L
endif

ifeq ($(shell command -v ios-deploy 2> /dev/null),)
internal-install-check::
	@$(PRINT_FORMAT_ERROR) "Install ios-deploy and add it to your PATH: https://github.com/phonegap/ios-deploy#installation" >&2; exit 1
endif

internal-install:: internal-install-check
	$(ECHO_INSTALLING)ios-deploy -$(THEOS_DEPLOY_FLAG)Wb "$(STAGING_DIR)"/Payload/*.app$(ECHO_END)
