LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := CalendarGooglePrebuilt
LOCAL_PACKAGE_NAME := com.google.android.calendar
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app
LOCAL_OVERRIDES_PACKAGES := GoogleCalendarSyncAdapter

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := Calendar
endif

include $(BUILD_GAPPS_PREBUILT_APK)
