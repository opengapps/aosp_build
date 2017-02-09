LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := Wallet
LOCAL_PACKAGE_NAME := com.google.android.apps.walletnfcrel
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_GAPPS_PREBUILT_APK)
