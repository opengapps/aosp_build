LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := CloudPrint2
LOCAL_PACKAGE_NAME := com.google.android.apps.cloudprint
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_GAPPS_PREBUILT_APK)
