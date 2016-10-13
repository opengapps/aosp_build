LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GoogleHome
LOCAL_PACKAGE_NAME := com.google.android.launcher

GAPPS_LOCAL_OVERRIDES_MIN_VARIANT := stock
GAPPS_LOCAL_OVERRIDES_PACKAGES := Home Launcher2 Launcher3 Fluctuation PixelHome Trebuchet

include $(BUILD_GAPPS_PREBUILT_APK)
