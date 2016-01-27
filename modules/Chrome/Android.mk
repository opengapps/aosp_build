LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := Chrome
LOCAL_PACKAGE_NAME := com.android.chrome

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite Browser if stock/super
LOCAL_OVERRIDES_PACKAGES := Browser BrowserProviderProxy Chromium
endif

include $(BUILD_GAPPS_PREBUILT_APK)
