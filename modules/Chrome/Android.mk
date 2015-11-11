# Auto-generated Makefile from OpenGapps. Do not modify.
LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := Chrome
LOCAL_PACKAGE_NAME := com.android.chrome
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite Browser if stock/super
LOCAL_OVERRIDES_PACKAGES := Browser
endif

include $(BUILD_GAPPS_PREBUILT_APK)
