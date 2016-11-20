.PHONY: ipa info deploy lldb

PATCHAPP = $(THEOS_JAILED_PATH)/bin/patchapp

ipa: all
	$(ECHO_NOTHING)$(PATCHAPP) patch "$($(TWEAK_NAME)_IPA)" "$(PROFILE)" "$(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib" $(_THEOS_USE_CYCRIPT)$(ECHO_END)

info:
	$(ECHO_NOTHING)$(PATCHAPP) info "$($(TWEAK_NAME)_IPA)"$(ECHO_END)

deploy:
	$(ECHO_NOTHING)$(PATCHAPP) install$(ECHO_END)

lldb:
	$(ECHO_NOTHING)$(PATCHAPP) debug$(ECHO_END)
