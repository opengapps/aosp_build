LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GoogleExtShared
LOCAL_PACKAGE_NAME := com.google.android.ext.shared

include $(BUILD_GAPPS_PREBUILT_APK)
