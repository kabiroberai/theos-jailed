.PHONY: info

info:
	@$(PRINT_FORMAT_MAKING) "Generating info for $$(basename "$$IPA")";"$(INFO_SCRIPT)"
