LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := SetupWraithPrebuilt
LOCAL_PACKAGE_NAME := com.google.android.tungsten.setupwraith
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
