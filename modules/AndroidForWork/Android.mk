LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := AndroidForWork
LOCAL_PACKAGE_NAME := com.google.android.androidforwork
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/priv-app

include $(BUILD_GAPPS_PREBUILT_APK)
