DEBUG=0
include @@THEOS@@/makefiles/common.mk

TWEAK_NAME = @@PROJECTNAME@@
@@PROJECTNAME@@_FILES = Tweak.xm

@@PROJECTNAME@@_LDFLAGS += -lsqlite3 -lc++
@@PROJECTNAME@@_FRAMEWORKS += UIKit JavaScriptCore Cycript

include $(THEOS_MODULE_PATH)/jailed/jailed.mk
