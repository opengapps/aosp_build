LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := platform
LOCAL_MODULE := GamepadPairingService
LOCAL_PACKAGE_NAME := com.google.android.tv.remotepairing
LOCAL_PRIVILEGED_MODULE := true
include $(BUILD_GAPPS_PREBUILT_APK)

