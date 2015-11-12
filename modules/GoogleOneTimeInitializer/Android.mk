LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GoogleOneTimeInitializer
LOCAL_PACKAGE_NAME := com.google.android.onetimeinitializer
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/priv-app

include $(BUILD_GAPPS_PREBUILT_APK)
