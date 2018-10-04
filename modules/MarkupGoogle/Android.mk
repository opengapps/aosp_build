LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := MarkupGoogle
LOCAL_PACKAGE_NAME := com.google.android.markup

include $(BUILD_GAPPS_PREBUILT_APK)
