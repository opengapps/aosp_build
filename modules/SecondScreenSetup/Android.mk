LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := SecondScreenSetup
LOCAL_PACKAGE_NAME := com.google.android.sss

include $(BUILD_GAPPS_PREBUILT_APK)
