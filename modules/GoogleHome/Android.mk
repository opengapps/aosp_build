LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GoogleHome
LOCAL_PACKAGE_NAME := com.google.android.launcher

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := Launcher2 Launcher3
endif

include $(BUILD_GAPPS_PREBUILT_APK)
