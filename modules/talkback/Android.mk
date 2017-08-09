LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := talkback
LOCAL_PACKAGE_NAME := com.google.android.marvin.talkback

include $(BUILD_GAPPS_PREBUILT_APK)
