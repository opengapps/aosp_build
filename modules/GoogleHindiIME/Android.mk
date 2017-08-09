LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := GoogleHindiIME
LOCAL_PACKAGE_NAME := com.google.android.apps.inputmethod.hindi

include $(BUILD_GAPPS_PREBUILT_APK)
