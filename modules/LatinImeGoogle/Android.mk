LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := LatinImeGoogle
LOCAL_PACKAGE_NAME := com.google.android.inputmethod.latin

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := LatinIME
endif

include $(BUILD_GAPPS_PREBUILT_APK)
