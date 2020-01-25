ifneq ($(filter 29,$(call get-allowed-api-levels)),)

LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := TrichromeLibrary
LOCAL_PACKAGE_NAME := com.google.android.trichromelibrary

include $(BUILD_GAPPS_PREBUILT_APK)

endif # API >= 29
