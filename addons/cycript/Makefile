include $(CURDIR)/../addon.mk

TWEAK_NAME = Cycript
Cycript_FILES = Tweak.xm

Cycript_CFLAGS += -F.
Cycript_LDFLAGS += -F. -lsqlite3 -lc++ -stdlib=libstdc++
Cycript_FRAMEWORKS += JavaScriptCore Cycript

include $(THEOS_MAKE_PATH)/tweak.mk
