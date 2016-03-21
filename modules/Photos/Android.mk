LOCAL_PATH := .
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := Photos
LOCAL_PACKAGE_NAME := com.google.android.apps.photos

GAPPS_LOCAL_OVERRIDES_MIN_VARIANT := stock
GAPPS_LOCAL_OVERRIDES_PACKAGES := Gallery Gallery2 MotGallery MediaShortcuts

include $(BUILD_GAPPS_PREBUILT_APK)
