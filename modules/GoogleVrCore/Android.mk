LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GoogleVrCore
LOCAL_PACKAGE_NAME := com.google.vr.vrcore

include $(BUILD_GAPPS_PREBUILT_APK)
