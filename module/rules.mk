.PHONY: ipa info deploy lldb

_THEOS_USE_CYCRIPT := $(call __theos_bool,$(USE_CYCRIPT))

ipa: all
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp patch "$($(TWEAK_NAME)_IPA)" "$(PROFILE)" "$(THEOS_OBJ_DIR)"/*.dylib $(_THEOS_USE_CYCRIPT)$(ECHO_END)

info:
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp info "$($(TWEAK_NAME)_IPA)"$(ECHO_END)

deploy:
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp install$(ECHO_END)

lldb:
	$(ECHO_NOTHING)$(THEOS_MODULE_PATH)/jailed/patchapp debug$(ECHO_END)
