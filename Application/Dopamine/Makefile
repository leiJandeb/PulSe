include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Dopamine

Dopamine_FILES = main.m AppDelegate.m RootViewController.m PulseBridge.m
Dopamine_FRAMEWORKS = UIKit
Dopamine_CFLAGS = -I./include -Wno-unguarded-availability-new
Dopamine_LDFLAGS = -L. -ljailbreak
Dopamine_ENTITLEMENTS = entitlements.plist
ARCHS = arm64

include $(THEOS_MAKE_PATH)/application.mk
