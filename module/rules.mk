.PHONY: ipa info deploy

ifeq ($(call __theos_bool,$(LLDB)),$(_THEOS_TRUE))
THEOS_DEPLOY_FLAG = d
else
THEOS_DEPLOY_FLAG = L
endif

ipa: all
	$(ECHO_NOTHING)$(THEOS_JAILED_BIN)/ipa$(ECHO_END)

info:
	$(ECHO_NOTHING)$(THEOS_JAILED_BIN)/info$(ECHO_END)

deploy:
	$(ECHO_NOTHING)ios-deploy -$(THEOS_DEPLOY_FLAG)Wb "$(STAGING_DIR)"/Payload/*.app$(ECHO_END)
