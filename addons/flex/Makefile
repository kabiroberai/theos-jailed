include ../addon.mk

TWEAK_NAME = FLEX
FLEX_FILES = Tweak.xm $(wildcard FLEX/*.m)

FLEX_OBJCFLAGS = -fobjc-arc -Wno-objc-property-no-attribute
FLEX_LIBRARIES = sqlite3 z

include $(THEOS_MAKE_PATH)/tweak.mk

before-all::
	@if [[ ! -d FLEX ]]; then\
		find Flipboard-FLEX/Classes \( -name "*.m" -or -name "*.h" \) -exec rsync -a "{}" FLEX/ \;;\
	fi
