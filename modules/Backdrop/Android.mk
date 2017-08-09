LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := Backdrop
LOCAL_PACKAGE_NAME := com.google.android.backdrop.leanback
include $(BUILD_GAPPS_PREBUILT_APK)

