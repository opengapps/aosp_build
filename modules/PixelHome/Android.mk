LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := PixelHome
LOCAL_PACKAGE_NAME := com.google.android.apps.nexuslauncher

GAPPS_LOCAL_OVERRIDES_PACKAGES := Home GoogleHome Launcher2 Launcher3 Fluctuation Trebuchet

include $(BUILD_GAPPS_PREBUILT_APK)
