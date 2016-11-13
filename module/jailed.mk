ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MAKE_PATH)/master/tweak.mk
else
	ifeq ($(_THEOS_CURRENT_TYPE),tweak)
		include $(THEOS_MODULE_PATH)/jailed/instance/jailed.mk
	endif
endif
