LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := SetupWizard
ifeq ($(filter 21,$(call get-allowed-api-levels)),)
  # kitkat
  LOCAL_PACKAGE_NAME := com.google.android.setupwizard
else
  # LP and newer
  ifneq ($(filter tablet,$(PRODUCT_CHARACTERISTICS)),)
    LOCAL_PACKAGE_NAME := com.google.android.setupwizard.tablet
  else 
    LOCAL_PACKAGE_NAME := com.google.android.setupwizard.default
  endif
endif

LOCAL_PRIVILEGED_MODULE := true
LOCAL_OVERRIDES_PACKAGES := Provision

include $(BUILD_GAPPS_PREBUILT_APK)
