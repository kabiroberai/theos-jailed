ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MODULE_PATH)/jailed/master/jailed.mk
else
	ifeq ($(_THEOS_CURRENT_TYPE),tweak)
		include $(THEOS_MODULE_PATH)/jailed/instance/jailed.mk
	endif
endif
