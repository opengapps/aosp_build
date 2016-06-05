LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := SetupWizard
ifneq ($(filter $(call get-allowed-api-levels),19),)
        LOCAL_PACKAGE_NAME := com.google.android.setupwizard
else 
ifneq ($(filter $(PRODUCT_CHARACTERISTICS),tablet),)
	LOCAL_PACKAGE_NAME := com.google.android.setupwizard.tablet
else
	LOCAL_PACKAGE_NAME := com.google.android.setupwizard.default
endif

LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
