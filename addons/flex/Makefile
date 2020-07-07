include ../addon.mk

TWEAK_NAME = FLEX
FLEX_FILES = Tweak.xm $(wildcard FLEX/*.m FLEX/*.mm FLEX/*.c)

FLEX_OBJCFLAGS = -fobjc-arc -Wno-objc-property-no-attribute -Wno-unsupported-availability-guard
FLEX_LIBRARIES = sqlite3 z

include $(THEOS_MAKE_PATH)/tweak.mk

before-all::
	@if [[ ! -d FLEX ]]; then\
		find Flipboard-FLEX/Classes \( -name "*.m" -or -name "*.h" -or -name "*.mm" -or -name "*.c" \) -exec rsync -a "{}" FLEX/ \;;\
	fi

clean::
	@rm -rf FLEX
