LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := PrebuiltGmail
LOCAL_PACKAGE_NAME := com.google.android.gm
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := Email
endif

include $(BUILD_GAPPS_PREBUILT_APK)
