include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Dopamine
TARGET = iphone:clang:latest:15.0

Dopamine_FILES = main.swift AppDelegate.swift ContentView.swift PulseView.swift RootViewController.m PulseBridge.m
Dopamine_FRAMEWORKS = UIKit SwiftUI
Dopamine_CFLAGS = -I./include -Wno-unguarded-availability-new
Dopamine_LDFLAGS = -L. -ljailbreak
Dopamine_ENTITLEMENTS = entitlements.plist
ARCHS = arm64

include $(THEOS_MAKE_PATH)/application.mk
