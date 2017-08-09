LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := platform
LOCAL_MODULE := SetupWraith
LOCAL_PACKAGE_NAME := com.google.android.tungsten.setupwraith
LOCAL_PRIVILEGED_MODULE := true
include $(BUILD_GAPPS_PREBUILT_APK)

