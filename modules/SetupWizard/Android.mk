LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := SetupWizard
LOCAL_PACKAGE_NAME := com.google.android.setupwizard
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/priv-app

include $(BUILD_GAPPS_PREBUILT_APK)
