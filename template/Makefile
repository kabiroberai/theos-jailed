include @@THEOS@@/makefiles/common.mk

TWEAK_NAME = @@PROJECTNAME@@
@@PROJECTNAME@@_FILES = Tweak.xm

@@PROJECTNAME@@_CFLAGS += -F.
@@PROJECTNAME@@_LDFLAGS += -F. -lsqlite3 -lc++
@@PROJECTNAME@@_FRAMEWORKS += JavaScriptCore Cycript

include $(THEOS_MODULE_PATH)/jailed/jailed.mk
