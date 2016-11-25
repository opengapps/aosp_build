LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := SetupWizard
ifeq ($(filter $(call get-allowed-api-levels),21),)
  # kitkat
  LOCAL_PACKAGE_NAME := com.google.android.setupwizard
else
  # LP and newer
  ifneq ($(filter $(PRODUCT_CHARACTERISTICS),tablet),)
    LOCAL_PACKAGE_NAME := com.google.android.setupwizard.tablet
  else 
    LOCAL_PACKAGE_NAME := com.google.android.setupwizard.default
  endif
endif

LOCAL_PRIVILEGED_MODULE := true
LOCAL_OVERRIDES_PACKAGES := Provision

include $(BUILD_GAPPS_PREBUILT_APK)
