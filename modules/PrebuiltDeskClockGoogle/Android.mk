LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := PrebuiltDeskClockGoogle
LOCAL_PACKAGE_NAME := com.google.android.deskclock

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := DeskClock
endif

include $(BUILD_GAPPS_PREBUILT_APK)
