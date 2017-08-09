LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := Wallet
LOCAL_PACKAGE_NAME := com.google.android.apps.walletnfcrel

include $(BUILD_GAPPS_PREBUILT_APK)
