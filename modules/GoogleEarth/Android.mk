LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GoogleEarth
LOCAL_PACKAGE_NAME := com.google.earth

include $(BUILD_GAPPS_PREBUILT_APK)
