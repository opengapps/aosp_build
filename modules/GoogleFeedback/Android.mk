LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GoogleFeedback
LOCAL_PACKAGE_NAME := com.google.android.feedback
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
