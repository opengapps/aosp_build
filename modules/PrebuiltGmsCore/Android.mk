LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := PrebuiltGmsCore
LOCAL_PACKAGE_NAME := com.google.android.gms
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
