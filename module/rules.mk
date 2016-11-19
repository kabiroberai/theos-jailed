.PHONY: ipa info deploy lldb

PATCHAPP = $(THEOS_MODULE_PATH)/jailed/bin/patchapp

_THEOS_USE_CYCRIPT := $(call __theos_bool,$(USE_CYCRIPT))

ipa: all
	$(ECHO_NOTHING)$(PATCHAPP) patch "$($(TWEAK_NAME)_IPA)" "$(PROFILE)" "$(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib" $(_THEOS_USE_CYCRIPT)$(ECHO_END)

info:
	$(ECHO_NOTHING)$(PATCHAPP) info "$($(TWEAK_NAME)_IPA)"$(ECHO_END)

deploy:
	$(ECHO_NOTHING)$(PATCHAPP) install$(ECHO_END)

lldb:
	$(ECHO_NOTHING)$(PATCHAPP) debug$(ECHO_END)
