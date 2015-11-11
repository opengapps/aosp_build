LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := PrebuiltNewsWeather
LOCAL_PACKAGE_NAME := com.google.android.apps.genie.geniewidget
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app

include $(BUILD_GAPPS_PREBUILT_APK)
