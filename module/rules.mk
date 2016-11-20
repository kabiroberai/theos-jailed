.PHONY: ipa info deploy lldb

PATCHAPP = $(THEOS_JAILED_PATH)/bin/patchapp

ipa: all
	$(ECHO_NOTHING)$(PATCHAPP) patch$(ECHO_END)

info:
	$(ECHO_NOTHING)$(PATCHAPP) info$(ECHO_END)

deploy:
	$(ECHO_NOTHING)$(PATCHAPP) install$(ECHO_END)

lldb:
	$(ECHO_NOTHING)$(PATCHAPP) debug$(ECHO_END)
