LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GoogleEars
LOCAL_PACKAGE_NAME := com.google.android.ears

include $(BUILD_GAPPS_PREBUILT_APK)
