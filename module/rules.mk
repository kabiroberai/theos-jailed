.PHONY: ipa info deploy lldb

ipa: all
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp patch "$(PROFILE)" "$(THEOS_OBJ_DIR)"/*.dylib$(ECHO_END)

info:
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp info$(ECHO_END)

deploy:
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp install$(ECHO_END)

lldb:
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp debug$(ECHO_END)
