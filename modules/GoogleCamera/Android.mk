LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GoogleCamera
LOCAL_PACKAGE_NAME := com.google.android.googlecamera

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := Camera Camera2 MotCamera
endif

include $(BUILD_GAPPS_PREBUILT_APK)
