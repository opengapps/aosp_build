ifneq ($(filter arm64, $(TARGET_ARCH)),)
LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := AndroidPlatformServices
LOCAL_PACKAGE_NAME := com.google.android.gms.policy_sidecar_o
GAPPS_LOCAL_OVERRIDES_PACKAGES := GoogleLoginService
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
endif
