LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := AndroidPlatformServices
LOCAL_PACKAGE_NAME := com.google.android.gms.policy_sidecar_o
GAPPS_LOCAL_OVERRIDES_PACKAGES := GoogleLoginService

include $(BUILD_GAPPS_PREBUILT_APK)
