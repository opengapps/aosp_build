ifneq ($(filter 29,$(call get-allowed-api-levels)),)
ifneq ($(TARGET_ARCH),arm)

LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := TrichromeLibraryGoogle
LOCAL_PACKAGE_NAME := com.google.android.trichromelibrary

include $(BUILD_GAPPS_PREBUILT_APK)
endif #arm
endif # API >= 29
