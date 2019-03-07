LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := StorageManagerGoogle
LOCAL_PACKAGE_NAME := com.google.android.storagemanager

include $(BUILD_GAPPS_PREBUILT_APK)
