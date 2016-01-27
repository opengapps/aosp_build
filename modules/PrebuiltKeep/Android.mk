LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := PrebuiltKeep
LOCAL_PACKAGE_NAME := com.google.android.keep

include $(BUILD_GAPPS_PREBUILT_APK)
