LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GooglePartnerSetup
LOCAL_PACKAGE_NAME := com.google.android.partnersetup
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
