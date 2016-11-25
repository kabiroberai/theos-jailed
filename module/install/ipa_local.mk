ifeq ($(call __theos_bool,$(LLDB)),$(_THEOS_TRUE))
THEOS_DEPLOY_FLAG = d
else
THEOS_DEPLOY_FLAG = L
endif

internal-install::
	$(ECHO_INSTALLING)ios-deploy -$(THEOS_DEPLOY_FLAG)Wb "$(STAGING_DIR)"/Payload/*.app$(ECHO_END)
