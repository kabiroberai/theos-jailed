.PHONY: info update-jailed

info:
	@$(PRINT_FORMAT_MAKING) "Generating info for $$(basename "$$IPA")";"$(INFO_SCRIPT)"

update-jailed:
	@$(PRINT_FORMAT_MAKING) "Updating theos-jailed";"$(UPDATE_SCRIPT)"
