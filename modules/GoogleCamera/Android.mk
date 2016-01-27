LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GoogleCamera
LOCAL_PACKAGE_NAME := com.google.android.googlecamera
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := Camera Camera2 MotCamera Snap
endif

include $(BUILD_GAPPS_PREBUILT_APK)
