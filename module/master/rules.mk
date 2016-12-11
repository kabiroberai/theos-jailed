.PHONY: info update-jailed troubleshoot-jailed

info::
	@$(PRINT_FORMAT_MAKING) "Generating info for $$(basename "$$IPA")";"$(INFO_SCRIPT)"

update-jailed::
	@$(PRINT_FORMAT_MAKING) "Updating theos-jailed";"$(UPDATE_SCRIPT)"

update-theos:: update-jailed

troubleshoot-jailed::
ifeq ($(call __executable,ghost),$(_THEOS_TRUE))
	@$(PRINT_FORMAT) "Creating a Ghostbin containing the output of \`make clean package messages=yes\`…"
	$(MAKE) -f $(_THEOS_PROJECT_MAKEFILE_NAME) --no-print-directory --no-keep-going clean package messages=yes FORCE_COLOR=yes 2>&1 | ghost -x 2w - ansi
else
	@$(PRINT_FORMAT_ERROR) "You don't have ghost installed. For more information, refer to https://github.com/theos/theos/wiki/Installation#prerequisites." >&2; exit 1
endif
