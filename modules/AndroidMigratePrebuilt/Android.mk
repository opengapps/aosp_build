LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := AndroidMigratePrebuilt
# aka Data Transfer Tool
LOCAL_PACKAGE_NAME := com.google.android.apps.pixelmigrate
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
