LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := SetupWizard
ifneq ($(filter $(PRODUCT_CHARACTERISTICS),tablet),)
	LOCAL_PACKAGE_NAME := com.google.android.setupwizard.tablet
else
	LOCAL_PACKAGE_NAME := com.google.android.setupwizard.default
endif

LOCAL_PRIVILEGED_MODULE := true
LOCAL_OVERRIDES_PACKAGES := Provision

include $(BUILD_GAPPS_PREBUILT_APK)
